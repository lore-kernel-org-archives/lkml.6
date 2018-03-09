Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-26780-1520582973-2-5102807240519173286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520582973; b=e7LA67Yk+PQhPre9kcgMShlIkpBQBaWJGeKVoFnDiZF5rqc
    3UV2mpLAZOsSNiFj5WhCp8TDJI2O9yEF+KkZwGOf8Cc+1dUmVs44Zo1kgelEdbaB
    IbeobrnKqtzeGt8WNs9l1Le9W1bTCHkBlaYDMy6QtWu8W5Amrp4MMttD5DaYf8NC
    UpuUwIg/yEONUsSKc2Z+r4gdJGgHuB1tSOAvY9zK+lxGAOJRWytyFUzu06tFrY2a
    Q5nJRKdAFSjbtU8ZrJ69mONQtdltJv6BX9QKRZL6PKFjJtIj+xtcosc6qQ+8o2E0
    5/tFrOzdTobDkGw7SpJgGDacf+H4fLqQXJjFIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520582973; bh=P7b8IJQ3RJu2Gn+n1bDZQmDyjp
    0dvjIFVoHZEamTi+A=; b=n6rP2Sx1gk2Ie65JnsWK4YjzmThjA0Ve4VOkYXXZeJ
    Q09NsrdGxKBudi6211qnlReRkSkJKdxOb8ylHmviVN9hfBPj9u1lurFzNjH2mEJb
    XrmbENSV3GadUSNzoXXy0LQZj6BIXmZ6e2zZlM7PgC7PbJsUyqdgKQ82poIu+P23
    bwudvUVOGteVcB9ZPvUyN595ivSZy2hp7N/xiphAXvvFkZ1Rftue0AyNqtEDLvkC
    Z+b4q44NkrZalr4SMB1DFQOIjQDlLvpz4cxQCuyz7NbmJ/xnaZi/nocviAoe69HS
    IxJeKthKreIHJXKVf1oj7JR3ctbdZFr0O7q2/jf4TONQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cVGCMbqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=140 state=1;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sybRnYxL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cVGCMbqH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=140 state=1;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sybRnYxL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeCIIJ3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 03:09:29 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45446 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeCIIJO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 03:09:14 -0500
X-Google-Smtp-Source: AG47ELvQZnI4uw3Z0x3i6iau6JOkgO9o5DaCjAGXDr03EH4vUnsW76a1xv9jvx+KWOm0PJ6lSNGHwQ==
Date: Fri, 9 Mar 2018 09:09:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v7 4/4] soc/tegra: pmc: Use the new reset APIs to manage
 reset controllers
Message-ID: <20180309080909.GA13841@ulmo>
References: <1500479948-29988-1-git-send-email-p.zabel@pengutronix.de>
 <1500479948-29988-5-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1500479948-29988-5-git-send-email-p.zabel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 05:59:08PM +0200, Philipp Zabel wrote:
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
>=20
> Make use of of_reset_control_array_get_exclusive() to manage
> an array of reset controllers available with the device.
>=20
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> [p.zabel@pengutronix.de: switch to hidden reset control array]
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> No changes since v6.
> ---
>  drivers/soc/tegra/pmc.c | 82 ++++++++++++-------------------------------=
------
>  1 file changed, 20 insertions(+), 62 deletions(-)

I've applied this with the static inline change that Jon suggested.

Thanks,
Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqiQR4ACgkQ3SOs138+
s6HXTQ//e+zFt1s0RGOWduEZR2kzsTApj7UqF/XklL/8F/SS2DGCx7Irq6TcuDpk
d/RrsCmms8A8qbJ1oHEITgevQFP6APOfB6gE9x0hF+K10IXGKw5JI/PsHM0HgUWK
wVX0sg36SIDixwAd8YdQcTD7L2UqQ0OQipklfNqsOfvSXsfoNO/f8I6EdocCQcXJ
WvBPg0Rst32Lmky1z1Ap8svn2yHUQMC1Tdpi77VPc+SeEckhd7btOEWOj0fw8xyW
Hl2XRdTmcizsIk3wIC5hSfHHVuq9m3BpeouqxheYJbot8kH7JmlNpTaWS8bjNSDM
+G8QkK2jYY1dJ4re434oiiGFdLauyRgxZsqybthPErXCxXN3g2Gp5/UdOiNTZoJ/
fG2qz+DUInhS0/6xznT24Nuu4Jpv2Z+NrpJrWSefxACZsz5ecLhlNGOHph5i6qOp
WWeGTLAj7hk8KCurBK7yMWmpw6bftXXsm5PCIZWsmoLD2SYIktM/hAv9MzVKNtJi
RIPOpS87eRzr++C8+p1GE7qH8LDMx70Pq3amkwlTfFazcwSm9NdOB12StlNXHV1W
M1dNbCaqctYVQUyKsqdCSVMnw2K7wnBG8w3GIEeO3olnn62B1ziPnM3wuQHoCN8b
rBpN5n0ps4Xmb4hw+bMMhUFiEn5WueIE+2LIXpS9hqAmbHrqNIg=
=wa/y
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
