Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A34C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D496C20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D496C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG1OaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:30:20 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:39258 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeG1OaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:30:20 -0400
Received: from pd9e2fa68.dip0.t-ipconnect.de ([217.226.250.104] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fjOsy-0006Nu-2V; Sat, 28 Jul 2018 15:03:52 +0200
Date:   Sat, 28 Jul 2018 15:03:51 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bloated defconfigs
Message-ID: <20180728150351.467c46ae@aktux>
In-Reply-To: <CAHp75VcVGJqoVN5-R4HbTdG-ANpj-bTHh9dFAtQ+dKMSxesE4A@mail.gmail.com>
References: <20180728145906.52c68e91@aktux>
        <CAHp75VcVGJqoVN5-R4HbTdG-ANpj-bTHh9dFAtQ+dKMSxesE4A@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gFRHdQCMzx9Cr/TRMgXEcxy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gFRHdQCMzx9Cr/TRMgXEcxy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 28 Jul 2018 16:01:41 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jul 28, 2018 at 3:59 PM, Andreas Kemnade <andreas@kemnade.info> w=
rote:
> > Hi,
> >
> > I just stumbled upon our defconfigs.
> >
> > andi@aktux:~/gta04/gta04-kernel$ ls -l arch/arm/configs/ -Sr | tail -n
> > 10 -rw-r--r-- 1 andi andi   9524 Apr  7 14:53 imote2_defconfig
> > -rw-r--r-- 1 andi andi   9985 Jul 28 13:34 imx_v6_v7_defconfig
> > -rw-r--r-- 1 andi andi  10118 Apr  7 14:53 ezx_defconfig
> > -rw-r--r-- 1 andi andi  10665 Apr  7 14:53 s3c2410_defconfig
> > -rw-r--r-- 1 andi andi  13161 May 29 18:14 omap2plus_defconfig
> > -rw-r--r-- 1 andi andi  17834 May 29 18:14 pxa_defconfig
> > -rw-r--r-- 1 andi andi  24624 Jul 28 13:34 multi_v7_defconfig
> > -rw-r--r-- 1 andi andi 157222 Jul 28 13:34 letux_udoo_defconfig
> > -rw-r--r-- 1 andi andi 157271 Jul 28 13:34 letux_lpae_defconfig
> > -rw-r--r-- 1 andi andi 157352 Jul 28 13:34 letux_defconfig
> >
> >
> > So we are bloated somehow. So I am wondering how these defconfigs are c=
reated.
> > AFAIK the tool is
> >
> > make ARCH=3Darm CROSS_COMPILE=3D... savedefconfig
> >
> > the file can then be used as a defconfig. I just did it and copied it o=
ver to
> > .config and used
> > make ARCH=3Darm CROSS_COMPILE=3D... olddefconfig
> >
> > The result is the same. But the defconfig created by savedefconfig is o=
nly 20KB.
> > Well, what is the advantage? We have a better overview where we have
> > non-default values. =20
>=20
> So, why not to send patches?
>=20
sorry for the noise, wrong list, these bloated letux*defconfigs are not
mainline.

Regards,
Andreas

--Sig_/gFRHdQCMzx9Cr/TRMgXEcxy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAltcabcACgkQfb1qx03i
kyR5Sw/9HJpCxdkOs8EYgXkRkfxd0YouyyPQq0hYP7x+J6kpFCasQ1iTl4qbdWxl
cPVtQxfmfNBSEcCbl5EHD7oLa0gVd/FIWxQxbSGlEmPQuexP2NLHKUaFX/rILw1d
jxjKKsL2H5OQVCWTPBxMZ78+NkPV4d48DAWQl1FLnrELnXBOCToNehAVq4arZ1Rv
zvF4HceMkcWlUL5sBW13gEEPEldGpbKagkmrWJG5rfVAV6z005oXU1+pl9n3LMjy
aa7Q8q8CEvxBSx71yiyGgflTU0myjVKj5gk8Ja3hD7D5yUNJ+ybPGZVutRYl+AS+
LC/T+HIZkCU53rG/Il1pPmqzdEtHPnqiZ5frDQBn1Pt+LjMkhdygzVqHpgancW4l
YShqUth2b9LlaBPuge0JwMKI/n9TdEY3mQG/mViZ3XpIqPc7M9HVcF4DR/E+uwzZ
+cYzpCEr5L4iHzo3UVzh1IgK5qPGz+tx0V4vE2QXgy/JmJ8LsOHy1nwY9w6Dwpyd
pf27YI3Y8eWjuhhTMi3c204wYC+qUoSa2pmAWrKFkJELTqLZB3zKFR3uuCbsbNeu
iC15pSXsH7Y0TNSviOkybWMTvbHxnbaB0GOA8/RwZlEA/6LNn32vL41zZCQIJwkv
Oipp4bQ81Uw2UyYFd9nLSMlo+/kdRqsnMrVGRuILJuu4/OshU4I=
=8riK
-----END PGP SIGNATURE-----

--Sig_/gFRHdQCMzx9Cr/TRMgXEcxy--
