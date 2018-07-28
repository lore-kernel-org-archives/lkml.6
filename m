Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF7C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF44120841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF44120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeG1OZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:25:55 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:39182 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeG1OZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:25:55 -0400
Received: from pd9e2fa68.dip0.t-ipconnect.de ([217.226.250.104] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fjOog-0006FW-6W
        for linux-kernel@vger.kernel.org; Sat, 28 Jul 2018 14:59:26 +0200
Date:   Sat, 28 Jul 2018 14:59:06 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linux-kernel@vger.kernel.org
Subject: bloated defconfigs
Message-ID: <20180728145906.52c68e91@aktux>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pMXUeonhY/UfTr1gf7PVmMB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pMXUeonhY/UfTr1gf7PVmMB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I just stumbled upon our defconfigs.

andi@aktux:~/gta04/gta04-kernel$ ls -l arch/arm/configs/ -Sr | tail -n
10 -rw-r--r-- 1 andi andi   9524 Apr  7 14:53 imote2_defconfig
-rw-r--r-- 1 andi andi   9985 Jul 28 13:34 imx_v6_v7_defconfig
-rw-r--r-- 1 andi andi  10118 Apr  7 14:53 ezx_defconfig
-rw-r--r-- 1 andi andi  10665 Apr  7 14:53 s3c2410_defconfig
-rw-r--r-- 1 andi andi  13161 May 29 18:14 omap2plus_defconfig
-rw-r--r-- 1 andi andi  17834 May 29 18:14 pxa_defconfig
-rw-r--r-- 1 andi andi  24624 Jul 28 13:34 multi_v7_defconfig
-rw-r--r-- 1 andi andi 157222 Jul 28 13:34 letux_udoo_defconfig
-rw-r--r-- 1 andi andi 157271 Jul 28 13:34 letux_lpae_defconfig
-rw-r--r-- 1 andi andi 157352 Jul 28 13:34 letux_defconfig


So we are bloated somehow. So I am wondering how these defconfigs are creat=
ed.
AFAIK the tool is

make ARCH=3Darm CROSS_COMPILE=3D... savedefconfig

the file can then be used as a defconfig. I just did it and copied it over =
to
.config and used
make ARCH=3Darm CROSS_COMPILE=3D... olddefconfig

The result is the same. But the defconfig created by savedefconfig is only =
20KB.
Well, what is the advantage? We have a better overview where we have
non-default values.

Regards,
Andreas

--Sig_/pMXUeonhY/UfTr1gf7PVmMB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAltcaJoACgkQfb1qx03i
kyT6SQ//V0SlfPMRpNk3qLFoKuKH/7zXMIRt1tVYV7Ev03srr0UsWiOQUklC/g9E
7dJdyJx06ckRZTu4y2sFAauIMFBxW3ob7hbPrG8j4dsXnCE+aWRsGKt7x4a57vUI
/ecU9SpRwUhLs5SrQpa067ZZ7YxNPl7jD9MY75z1Q+PIeojHp91fSkwBB75N9KRG
FJjXX26wsjQDwLRJWMmPkrG3ZBmb6MGyi23D0U37JD9UqxONEO9SbdzEsdEROHxc
o3n9Ot19KmdVII3oUhe+zV3qlR/77eoJECwnzaTchQ9LEAfYk1B199cT6wBoWxH0
Txk3s9EOPdUUHhtV9ejRzw6AD7pQo15r2+Lg4BU5P4QMR3sAO+9gFMI+Rct//bHY
LRxxUOvQCD9XLxsbCk+QnwHh87DfJ6Tnl3RKPKFh2EGSLOd1WfNgr3JlZ7dBwwu0
sSBl4D0NmdYNuvjp9wp08cO65A7pHSRnzbaAzBFO8YLEVa3t2w4CbDZsbqSs1Rpb
y6Pk3lGTmPFSH+oVxjXyUVBjbyfLItORmjgCepGioYdn4Z/d0CMe3rJ9CWDYbXRw
W0hfEVwiyjNBpNLnib8r5yLodMAxgGFYF3nOzNYQMeBx3VDZOr6Vw4prH9SPagV0
Q+8gw9zO9/LfGBfRtzgoQ6FiF2ukmyFb+RAJrNcoVL7B/3Vluv8=
=z/kn
-----END PGP SIGNATURE-----

--Sig_/pMXUeonhY/UfTr1gf7PVmMB--
