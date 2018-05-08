Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825552-1525786867-2-7997998906849708874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01,
  UNPARSEABLE_RELAY 0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='utf-8', plain='iso-8859-1'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525786866; b=fPrqv6KYAvg1qFrTMuoxa/14fuDjNNg9bNo1lxlSovOl8Pvx9+
    smdzoUZMpkB6coNxDaVktQZQ8W4LsawV4PLjJyS4Qax5ZadhuqqmCd+hrF9Vqhds
    +DCIK7NpinPMIBo28K5DM/nRyBFrj8NE8H8IN8Mn9AHg4MU/4eoQnccmonXt1475
    mEov0GF6UQqw5KUscCS4ZdPzBK7CPo0hPu9oButFlkdtoFItFXYW56jOrMeeXVko
    65uNoim0oP80zipwdXedAT/X6fDNoF8t8hBBifuVCh28YL+geD6poWuTIUCGI25A
    mbVhs3Kv+50Z64B2EK3k7Q0Ui9t5D8rXZvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525786866; bh=rfP4z+XcapglNQtHNaEvkrQ8Vy6f9B
    7wqKLQv2EW00Q=; b=OS8I/5xY0yRVsvTzUEzz/MVpzg0nmyPzaGW9SVHQgTawex
    rpuSjRbIs3pzOGkDTPzRAPkZ1xHtYSNsP7Z61H/QwTF56EHnwoju5FdbNAcQJxWn
    xXJxSiw4Ktb7kcJE90vSUXoUyAldlq5hYaI43I9cNRpuPw19oXQ9fmwMLidA6IZv
    AJod6wKAXt045pO2ly2yTSrBcHLhyRnpDYiq/PsR6GmdQW5/LI+W5mUdowbNNjKF
    Npbhqynj85NQvCL7BocIQXKJtBRre+EoIj5+BhdDjnVGx6IKCy5tjSaVbIup7jPw
    ReXp2+lj3OiQIHQmEnIUJ+LnvUhNoRB9uoXjOtcg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=collabora.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=collabora.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH04XdKti/Dr0hQLvuIWgWIZ965V6x1IKrK/Se56cdPX67G7McGaK9/TStxgVYC8wPmp8SUp4tvkR1RmbqYkmg30FQEhD6Dr0Q8WdJIDMNO4H38DLZpe
    1cbMsHa4twKucxTsuZWFZ8laHnogSWO8Xx6Otq4LKLV+Dwm0OJdtnbc1NXl5+Bt9TNgzHHKpveQg7gXkbLBOcl9ZUAeOrEDcJnBYsufncZfVB+19TN2ZFzeA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8
    a=gvl4HP8tAAAA:8 a=wbodq_ipQBRBlcrDyz8A:9 a=wPNLvfGTeEIA:10
    a=pSU7amThuGSEST0a0HkA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=X7_D5SgixhGjaE2bLVSS:22
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeEHNkx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 09:40:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48758 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeEHNkw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 09:40:52 -0400
Date: Tue, 8 May 2018 15:40:47 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Message-ID: <20180508134047.zocurxwelw3a24ti@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wb2m4rdd5yi7wpt"
Content-Disposition: inline
In-Reply-To: <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--6wb2m4rdd5yi7wpt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > This properly unmaps DMA SG on device shutdown.
> >=20
> > Reported-by: Nandor Han <nandor.han@ge.com>
> > Suggested-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/tty/serial/imx.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 3ca767b1162a..6c53e74244ec 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port =
*port)
> >  	u32 ucr1, ucr2;
> > =20
> >  	if (sport->dma_is_enabled) {
> > -		sport->dma_is_rxing =3D 0;
> > -		sport->dma_is_txing =3D 0;
> >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > +		if (sport->dma_is_txing) {
> > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > +			sport->dma_is_txing =3D 0;
> > +		}
>=20
> did you find this because the kernel crashed or consumed more and more
> memory, or is this "only" a finding of reading the source code? If the
> former it would be great to point out in the commit log, if the latter,
> I wonder if this is a real problem that warrants a stable backport.

A bit of both. One of Collabora's customers had a (scarce) kernel crash
in imx-serial and modified multiple things in the driver. The crash is
gone, but it's not clear which change fixed it. I could not
reproduce the crash so far and I'm currently rebasing and splitting
their changes into upstreamable portions with proper patch
descriptions. From reading the source this looked like a real issue.

-- Sebastian

--6wb2m4rdd5yi7wpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrxqN0ACgkQ2O7X88g7
+poWCxAApwb98MM1VPGr5cibDrJ6pXjGtIPTfVz+WOsUW48kopVs1HHs4p+o6LZm
GB6j/4WvDQ6oG37WX+9b2URX+w76GzfDSpivNQw2b1nX/8m9tSn09vrGTfz2nFN+
j76CldlfNH9UYcz0ejUd2lcO0ESVji55H6YeFCRdBa3vrboN4Oh1eoMPZI+hOoI5
AX97Cjt/TEzYVpl+/F3SPvneRMrKfc81SDHL0f5NLMt4NXTx7qWh7ekRnjzDyjTs
axm/Trh5hrMuYQmo32IKMafBYJuw2bPLQFc748VtU19AoZt3Y7yX0U6cGpWyM9RF
WDMvEnotr3IEhw8Et041ReLMlPClOfO6e+6xUTjZnIuPMhzBsw+tI5z5x25tAGx+
GHEXihMsjysVptFLHWq/eyOxi5LC9DywMtzHa2ayYAZudiKIUbVjRlM+Fdziv00W
TfLnx8b6ry1bpENooOzTY5k3Cb9u0UL81aHqM4ZdVhiMiaLY9cOpFPMv5D8SV7S5
HjtpDpeonXnbNPk1zkBfTNGp6RNtMZ3E1zbIUjX5N5vyO6d+k1UOAEUxFYbFhzGt
HFjJx+iLTCGF/NLOp9QY0u13NDNYgmYBCkMTqGKZcsRYP/2qlR+QY9rHwilsLBnR
NKCoIMV+qNLYtWoUE6l98HpuVmBadpGNLoPgGeohtg5t2ztnyos=
=wYO1
-----END PGP SIGNATURE-----

--6wb2m4rdd5yi7wpt--
