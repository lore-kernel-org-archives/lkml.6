Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2688196-1525778861-2-352286007841546111
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
    1525778861; b=G4vd/dInjzNsFcvPisfhIm0sivO258QGqtGSbRFSbl7gxEEVhr
    Oq1PxFKGo710erNiNOL44JVUFkzA4HR4tkBAp7eYcelv+AfOamlVQUr4MJVBXAG0
    LpkP1yRCK/7viYKF3bhePvikpMRodaDtOW2BQ01zr8YpgDC1b7cp2nZZnytFdwwf
    PyTFxcV7iR1BpCjxQMVzFhyyzQF2BHuLqdZSrunnN016NV07nMuL3LoTxRSZpTOP
    Y4o84MBLq/DEinNwZv3yNfprYBDICPAFqihypd1XHHErJqb2ax0eadhCpqZwd1zY
    cEFkJ4fl8xerk9AgpKrOfm1GqtsQuGMQpCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525778861; bh=H5zAaM3HxOVYk5AX3l40VTt7+xbpj3
    OAz68ORupz8Hk=; b=EsHjbxDSQKLi1IH9EuvV60CB+AB872WnDpU+JwWG9kzyWj
    NtWZ6cwEQEfo+bGBqxOHm5OWzwhpohOPYsSlv7cWooXcAOZ+BsxrCYPtQwunJEBy
    Ab8gVkR+t/wNMGUg6Y2syJrDK6i9oID7yXNKspQjGL0eOjQpF5iOqj3jZ3dBsoFj
    hpxAqOH6BbcukmopK0ItWyEy5w+U9YwhxIhv798w4fMvaT74f65SoUJEiQDltn+O
    nQHx/0KbCobJd5K6WPOsqvEGmdZ0LyGN1z1agVCExoe8HUeP3QZUza+A1YW030Av
    I0HSO1JW+39XjvLv4VJImKNIuOYXsixWHla1Zh9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfBBKTs1l9u7Qn+rcIgdXCAD7/bNcysUAFanVA4/PtxhATXu7dvP7VI3PXe1Ozb9WnisGYBhAe+fRxFAL3IBCp54k4ZX/7jHxa+ZzeprCwow2IMfYdg6u
    CIru94SBWIpEU0YWtnbz/KuaWmvYqEcexMIiZJJy28tPPH6OHYrUN9tFP8yyPbzExFHbdb4O5nGNlyj48TyluGwUxBGIRMg61rFdyTWuADokQMcbDw6LCyvL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8
    a=gvl4HP8tAAAA:8 a=mdlK15DMS1IgFMbIYgMA:9 a=wPNLvfGTeEIA:10
    a=8PuYA7KgI3u8WY-0hsAA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=X7_D5SgixhGjaE2bLVSS:22
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeEHL1b (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 07:27:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754540AbeEHL1a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 07:27:30 -0400
Date: Tue, 8 May 2018 13:27:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: cleanup imx_uart_disable_dma()
Message-ID: <20180508112726.nyxrebcuwwdq5npy@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
 <20180508064047.v7wz7b4t5ta55hv7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hldlbuxw4kvqlosc"
Content-Disposition: inline
In-Reply-To: <20180508064047.v7wz7b4t5ta55hv7@pengutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--hldlbuxw4kvqlosc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 08:40:47AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, May 07, 2018 at 11:36:09PM +0200, Sebastian Reichel wrote:
> > Remove unrelated CTSC/CTS disabling from imx_uart_disable_dma() and
> > move it to imx_uart_shutdown(), which is the only user of the DMA
> > disabling function. This should not change the driver's behaviour,
> > but improves readability. After this change imx_uart_disable_dma()
> > does the reverse thing of imx_uart_enable_dma().
> >=20
> > Suggested-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/tty/serial/imx.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index c2fc6bef7a6f..3ca767b1162a 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1291,18 +1291,13 @@ static void imx_uart_enable_dma(struct imx_port=
 *sport)
> > =20
> >  static void imx_uart_disable_dma(struct imx_port *sport)
> >  {
> > -	u32 ucr1, ucr2;
> > +	u32 ucr1;
> > =20
> >  	/* clear UCR1 */
> >  	ucr1 =3D imx_uart_readl(sport, UCR1);
> >  	ucr1 &=3D ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
> >  	imx_uart_writel(sport, ucr1, UCR1);
> > =20
> > -	/* clear UCR2 */
> > -	ucr2 =3D imx_uart_readl(sport, UCR2);
> > -	ucr2 &=3D ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> > -	imx_uart_writel(sport, ucr2, UCR2);
> > -
> >  	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> > =20
> >  	sport->dma_is_enabled =3D 0;
> > @@ -1447,7 +1442,7 @@ static void imx_uart_shutdown(struct uart_port *p=
ort)
> > =20
> >  	spin_lock_irqsave(&sport->port.lock, flags);
> >  	ucr2 =3D imx_uart_readl(sport, UCR2);
> > -	ucr2 &=3D ~(UCR2_TXEN | UCR2_ATEN);
> > +	ucr2 &=3D ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> >  	imx_uart_writel(sport, ucr2, UCR2);
> >  	spin_unlock_irqrestore(&sport->port.lock, flags);
>=20
> While this doesn't change behaviour (which is of course good and
> intended here) I wonder if changing RTS is right here.
>=20
> According to Documentation/serial/driver it is not.

Yes, looks like it should be removed completly. I suggest to keep
this in two different patches (move UCR2 handling first, then remove
RTS handling), so that we end up with simple and comprehensible patches.

-- Sebastian

--hldlbuxw4kvqlosc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrxiZsACgkQ2O7X88g7
+poXtg//egmX9sHgOFQsEbqhN3iiif0GU620EGZbtomR7qc21ZeQIa8EqUtmiXDS
ewuMWpAI/Ew0zWGv+BytTXOAtlaWE4P2oSK24jjVudhnoCm/ouBLrJWTKCrnIbYw
gYpxmpz9gKKfKseRjESy7b9DPAgS9KywabtS8/bNCcwvkEhiakgbSeUn5Uax+GaE
H/d21E6FqU10uLnQqCGfFoezksXG5mrMxlrC9/Wy+mvzfctmBPwmZJ4MLnaeFEdo
I6jktQ7kbxDwI9Lw5Tcs2RBNlZuNMh6DhvQrtYcUxjdyis4Z6+rIY761Znat4mwK
7Yz9e/k2kMawuk2ODEXXhEzHDdF0rKk4Tt5wxIDEmv8f7N1g2tQgx0zTzgj3JWT1
tWJy8sBT7Lh4DVxynm8BsFNPCi81yO0rH3hKMjnR19LsDtTIRhfoufXAmEKorbM7
W8acLGCSaNT0ZDEqCzKZGdPMvsq+o/CJ6iZiiUC9K2ZjXAav7m3p5TEbjXbL3GHU
sTDxdvK2MGqJG2Vj2dAG2VfuLyyTO/uegp9jT2jxSSvfgndJovp0IgMxAsvoLuyQ
4f4nuMOx491Z1TOPAhszcKfExw73Ak36Zoc5dm73XrfvWRwq1XtK+38igIHvuG6V
Z8xThKK+OeIU24ktiD2Fv6wIwsM9J6Y7ciGrjAxhYpEOxAIAIlw=
=9R1O
-----END PGP SIGNATURE-----

--hldlbuxw4kvqlosc--
