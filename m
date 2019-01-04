Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CA2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZCF+pIvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfADT5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:57:23 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:50324 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iA6N/AtSYaHhvS+C0cYvEnbPRyBjDBCnf7Dl1B5pYkk=; b=ZCF+pIvTcNvk5rC7jMjovU+k+
        q8a3b3YjTA1XP9opptKJ/1sk/XaSh4RzAMB0lY7JdZjjkmJNZY40Md4ceSZ/A9aYG9lnq4vN56KFt
        id6WR79Zd/fKSaCwRIZoFZcVpYfbChTHG+kaD7DTtMZjm6OLlto8wZE8btg5RebzaIO/E=;
Received: from pd9e2f2c8.dip0.t-ipconnect.de ([217.226.242.200] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gfVan-00050j-Es; Fri, 04 Jan 2019 20:57:17 +0100
Date:   Fri, 4 Jan 2019 20:57:10 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20190104205600.3e6b31c9@aktux>
In-Reply-To: <B5CEA49A-0F54-40C5-BCEA-7875BE1358E3@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
        <20181111024648.7rt7rlhaqihtqecv@earth.universe>
        <20181112215812.18ebca35@aktux>
        <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
        <20181112222726.73m2oca7hankvcjs@earth.universe>
        <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
        <20181113170128.0f59ef0e@kemnade.info>
        <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
        <20181116204601.4e1aa0de@kemnade.info>
        <09AFE47C-D188-4397-A2CD-C70FFAC3B677@holtmann.org>
        <20190104064403.325771fd@kemnade.info>
        <B5CEA49A-0F54-40C5-BCEA-7875BE1358E3@holtmann.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k.3xD97g07g2Scmu0iHJy5M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k.3xD97g07g2Scmu0iHJy5M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, 4 Jan 2019 10:07:34 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
>=20
> >>>> Btw. I see nothing standing in the way of merging btuart.c driver an=
d then go from there. Either I dig this out and submit or someone else does.
> >>>>  =20
> >>> Do you mean this?
> >>> https://patchwork.kernel.org/patch/10490651/   =20
> >>=20
> >> yes, that one.
> >>  =20
> > Hmm, there seemed to be nothing in the pull requests regarding btuart.
> > Did you change plans? =20
>=20
> because I only submitted it as RFC. We can easily merge that one upstream=
 since it is rather trivial. The main problem is how you want to do the dev=
ice matching. Do you have a DT entry for your really simple devices?
>=20
Hmm, in that link it is non-rfc. So someone picked you rfc patch up and
submitted it?

You might see what we are already doing here:
http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dblobdiff;f=3Darch/arm/bo=
ot/dts/omap3-gta04.dtsi;h=3D4d2bac4293938de4a15a59979616909cf8842524;hp=3Db=
fced960d63ec40cf9db4901374b331737a9a168;hb=3Df78bf51754e35010de40518b9a8a14=
8d0269bbc8;hpb=3Db6805813a9ab5b0d66b44cc54a0059eca4dd0a98

We are using compatible=C2=A0=3D=C2=A0"wi2wi,w2cbw003-bluetooth"

But I think we should also add a generic device string like
bluetooth,h4
So if people dig out older hardware, they can just add that to their
device trees and have bluetooth

The full patchset we are currently using is here:
http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dshortlog;h=3Drefs/heads/=
letux/bluetooth-h4-serdev

Regards,
Andreas

--Sig_/k.3xD97g07g2Scmu0iHJy5M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwvupYACgkQfb1qx03i
kyQCMA//UcuhECwYbxbjrGLdMxqjvgo452MgX/hSy9bN/NTFmq2g09u1g5nv5MkV
b76cfWGRkMw+Zn6Sui2dE7gJUgHNHpyrt7IfmLiHYGHGOnG3S9q89lStD7+XQyrR
ox8sE4N/vpIfc2OFwu3QLDeTH33ZxsA1ICpDsnuCiikl7gAkRGh5FzFaOvAKprCC
htWcq2BvpMp8HkoFcWAUi/ucjswO2qk7s66zVJW7ssfw4yhnrRJDrlLUnv1EF+K0
J8/MT/TydjHRklISPA5gXG1HhMZa3m+gyMt9Kx85W7aLnbY/bEp44gtR+IKteKNO
FnOR23XwwBK+/nG+GJ7R55R0Gg5vbR0JpF/caglux2gpEQM2tS4HM8kaW0Hvhuwd
O8FBOQiVg1z0bNwd111H6/R2j0+REE1gYW80iLJjHVKqRzMYF5J7ayO/OT0sKYKD
LVBlUcDsDTumjuwcyFWbJ/Zk6Z8F3u9RMOv+1GCL3JNJKthYDj3JN6MAMcEINA0n
Y1JuGj++4jK1R5z2H0dd1a3TTuy/lVGoySxrVU6U5CgobwRuMxhN3YBdWHDMC9qo
t9/RnAkI/xj8ScNeAsZEYJe9ZDwWgWZ3lygols7QvqApSMtQjB8h6Ci/yD5Vbzss
KXKyrPayXyPO2HRrsFxBoLX/CRAscvGlwvKeN2uyNUWCG/Tt4Uo=
=N5bk
-----END PGP SIGNATURE-----

--Sig_/k.3xD97g07g2Scmu0iHJy5M--
