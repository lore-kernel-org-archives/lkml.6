Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163683-2-10179962045366406344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163682; b=hJNX7GhVaeNo+Y/01WKcTmG1U3H4G2em6A4ry4VeVES3bnlicr
    gRHObs4GfthdrIuIJTn9fNUJ0FX8L2XnNxyd0HTReTwVKRc7/iZtxiDE7m1vr7Ci
    iziaHu3JcOcwHf9IOpGBygiyFgGEx5Tu5c41iFSUAqqZ3uKUYGXkLJhy2txpz6q2
    65mS0uDYVcCYoYBfnU+NFhCZ6sW46AaKy1l6Y2g0OE0Mv4W+b2hwWSfj2PsKpISn
    KlM2i8UfMOD2Fw4pBsIVE2/EbRtVgKjUa0XDCYylG93NJMIZTUQ8f0Dokh9K1eX/
    LRoPEZSerq7Gdh/4xSp7Xjdo1yiMw48BrtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527163682; bh=MYEEWmNwjXT//WMpjpbgGbNnKeq/nz
    Zp781VhKoiyaA=; b=P9cpGLXJkNX0UOy8/bGS6sqCJNxUv3IMQZIMGakHdEPUBu
    WxJ+oDVUBJ1iBdpCxmM2YbDtxfLs+POf3wlHNBXmNFGN1Puj2bt4a/ijIwU2ASY5
    KHuwIOVivvLY/MuFwazIJ7zpSBCr4W/U5XFqRN9EzGRliY/HXGGqL0JAH/WnnYr4
    q7pIB5C3qG6dA4StKczNJmYWjYTUZXWLaH88V2AfnDS8ZubmSaTqRvxirXsUQo0+
    TxABTYEViih8ZH/uNmll9ODgJkdWqElj6H0yoxHPH2ktrt4wJMfR5l4HPzwqj/V2
    KIyvH5UOf8pLDzLt/zoRrSohsU2UkWdhflptV9gQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tfEQcXl8 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tfEQcXl8 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHNhyvIIDBjcuo+vk5y+nhI1A/SQsu2Kj03mgjAQosIm/FClRMH4JBMJ0oicwFCKuwHqa0r3Vaq8Wjd/aCSuF/RWGfwbv8JfftZFG7pX6fEA4TFDW+oU
    a/KyhP6nhfP4asLvQMht+pLtNBOoS240uS5PotgwE/Xpw+LUvVgiKJTMYc9q2CL63JlfxmmZymCwC9csz6o77m0Vw+lEhdPeJHqJ2vnOJuVLquYb0mR2pHi5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Tr_tI3BEr9LyCZSfXdAA:9 a=QEXdDO2ut3YA:10 a=JIll5Bbe9D-mmYcC9FsA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966769AbeEXMHn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966620AbeEXMHj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 08:07:39 -0400
Date: Thu, 24 May 2018 13:07:34 +0100
From: James Hogan <jhogan@kernel.org>
To: Mathias Kresin <dev@kresin.me>
Cc: john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Message-ID: <20180524120733.GA24269@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
 <20180521163932.GA12779@jamesdev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180521163932.GA12779@jamesdev>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 05:39:32PM +0100, James Hogan wrote:
> On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
> > While doing a global software reset, these bits are not cleared and let
> > some bootloader fail to initialise the GPHYs. The bootloader don't
> > expect the GPHYs in reset, as they aren't during power on.
> >=20
> > The asserts were a workaround for a wrong syscon-reboot mask. With a
> > mask set which includes the GPHY resets, these resets aren't required
> > any more.
> >=20
> > Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RC=
U syscon-mfd")
> > Cc: stable@vger.kernel.org # 4.14+
> > Signed-off-by: Mathias Kresin <dev@kresin.me>
>=20
> Applied for 4.17. Thanks for the acks/reviews folk!

drivers/soc/lantiq/gphy.c: In function =E2=80=98xway_gphy_remove=E2=80=99:
drivers/soc/lantiq/gphy.c:198:6: warning: unused variable =E2=80=98ret=E2=
=80=99 [-Wunused-variable]
  int ret;
      ^~~
drivers/soc/lantiq/gphy.c:196:17: warning: unused variable =E2=80=98dev=E2=
=80=99 [-Wunused-variable]
  struct device *dev =3D &pdev->dev;
                 ^~~

Easily fixed, I can drop those two lines:

diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
index 8c31ae750987..feeb17cebc25 100644
--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -193,9 +193,7 @@ static int xway_gphy_probe(struct platform_device *pdev)

 static int xway_gphy_remove(struct platform_device *pdev)
 {
-	struct device *dev =3D &pdev->dev;
	struct xway_gphy_priv *priv =3D platform_get_drvdata(pdev);
-	int ret;

	iowrite32be(0, priv->membase);

However it does raise the question, it sounds like a fix, but was this
patch tested and the warning just overlooked?

Cheers
James

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwarBAAKCRA1zuSGKxAj
8jdfAQDtnf7symakcWD4AS3WzH47QVijebMTfKH00E6gisIwBgD+LwAIaWipyGiS
eMh14y1Gq1rNYFesjlI+TGlrdRrzhw4=
=b82W
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
