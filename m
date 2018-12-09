Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5091C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AB720837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SLQ7c4tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AB720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLITLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:11:44 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40470 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLITLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qwhez8KNA6+160PKXUxQh35797RHr4GlnAv6v5ACwVE=; b=SLQ7c4tnL8n75LkdqYUWasEdo
        2lb3IUibdB+YDohOO/caLyM+NRkz2t/ovPXqbXN7OKUjiVBE5pn/VJcuejA+6akjJckaVoUwS7LNH
        R7uiuvo/9s5YgAigxT41CFGFyzB3+Fpb3jf0xrLZkTWTta7HYUtivFMDU5kemJmAr14cI=;
Received: from p5dc588d6.dip0.t-ipconnect.de ([93.197.136.214] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW4UN-0007nZ-TX; Sun, 09 Dec 2018 20:11:40 +0100
Date:   Sun, 9 Dec 2018 20:11:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20181209201134.52c16a71@aktux>
In-Reply-To: <20181205150939.GI15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
        <20181118215801.12280-6-andreas@kemnade.info>
        <20181205150939.GI15689@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3qDgqbcb4MN5ObIRVUBdrTh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3qDgqbcb4MN5ObIRVUBdrTh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Dec 2018 16:09:39 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Sun, Nov 18, 2018 at 10:58:01PM +0100, Andreas Kemnade wrote:
> > Add lna-supply property.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Docu=
mentation/devicetree/bindings/gnss/sirfstar.txt
> > index 1be7597ae884..9614774d14bc 100644
> > --- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
> > +++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> > @@ -30,6 +30,7 @@ Optional properties:
> >  - sirf,wakeup-gpios	: GPIO used to determine device power state
> >  			  (pin name: RFPWRUP, WAKEUP)
> >  - timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
> > +- lna-supply		: Separate supply for a LNA =20
>=20
> "Supply for external LNA"?
>=20
"External" might be misleading:
- not part of the gps chip itself: yes
- but might also be inside of the device.

In case of the GTA04 this includes power supply for an antenna switch
(operates by plug detection) + internal or external antenna.

Regards,
Andreas

--Sig_/3qDgqbcb4MN5ObIRVUBdrTh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwNaOYACgkQfb1qx03i
kyRcmhAAuC7k3S9ti4oqnnu8eO00xAeL9wp66vofIRmQbMb6ONYcoJkMQRuPw1Nn
6F0mCiLwSKqWOMoST/Wk2MFiwTjhwQK4ZBjm5S+VHhIBhVAL17fU/wIluiwM/+1R
4RDJdFL7Qhy7f2lofdlbe2UpQzp2cxXVDHkzK/BYGBuXZM8qRMm4hikYRIUqqsxo
1Z13LhaYtsq4mbwMJh/AFvQBN6/3mcBXQ1fgNRJR9dyXQTtlSWTco0Uhs1dskwOQ
CKaA8vAKzM+THL3y4+N43AZIN4LPDqKESkHTRbHZ84OCHbkJiqWn7SBh9S++OR9h
NKXe5WVmjeLoxcEpCqV5V3j2EQyDTaP3PwEN/sO56pboiG1OKtFs5bycxT2ih+8i
LIk1zPxdcQ1s2aM/RckBznkUDdL2OvT79r1y/Dc35VAfK2qxG6H60OdUbdNvP4WO
9cbyMuNmX4NLQmFAPbPOpO9o/3MxSYWA0SmxodIpVM0/bVgzMla98cJi/gkICxQ/
mez8wvDeFUAkMdN7Nv/0WM2+TsqM7ry4FtONoE9rYMzZDyaQA09jjQ//VqknrsJL
QCZJQ/SKdFDdmZ4+6KLPPBYls1WtF6Bbo55ULtGvleeKFhxiUGHChWsOSRoZAUbP
eSfPITAojXKS8GnbwEVFv0lyshLIcXDMKiZnfJwk21lAN5Ssh6E=
=Wbat
-----END PGP SIGNATURE-----

--Sig_/3qDgqbcb4MN5ObIRVUBdrTh--
