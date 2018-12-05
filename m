Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD702082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD702082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeLELxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:53:02 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:47298 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeLELxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:53:01 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 06:52:58 EST
Received: from [129.217.43.49] (limnos.cs.uni-dortmund.de [129.217.43.49])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id wB5Bj6En005802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 5 Dec 2018 12:45:16 +0100 (CET)
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: [PATCH] Fix sync. in inode_has_no_xattr()
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Message-ID: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
Date:   Wed, 5 Dec 2018 12:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lUG5BSCwUXEwncyBYfUst9oArZgCQCsg9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lUG5BSCwUXEwncyBYfUst9oArZgCQCsg9
Content-Type: multipart/mixed; boundary="OxKepGG7RbPVFq5CjQuDBKKCBa89UYKPx";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.cz>
Message-ID: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
Subject: [PATCH] Fix sync. in inode_has_no_xattr()

--OxKepGG7RbPVFq5CjQuDBKKCBa89UYKPx
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable


inode.i_flags might be altered without proper
synchronisation when the inode belongs to devtmpfs.
The following stacktrace shows how to get there:
13: entry_SYSENTER_32:460
12: do_fast_syscall_32:410
11: _static_cpu_has:146
10: do_syscall_32_irqs_on:322
09: SyS_pwrite64:636
08: SYSC_pwrite64:650
07: fdput:38
06: vfs_write:560
05: __vfs_write:512
04: new_sync_write:500
03: blkdev_write_iter:1977
02: __generic_file_write_iter:2897
01: file_remove_privs:1818
00: inode_has_no_xattr:3163

Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
Spinczyk)

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 include/linux/fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..40722678d741 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3443,10 +3443,14 @@ static inline int check_sticky(struct inode
*dir, struct inode *inode)
 	return __check_sticky(dir, inode);
 }

+/*
+ * blkdev_write_iter() can call this without i_rwsem, need to be
+ * careful with i_flags update.
+ */
 static inline void inode_has_no_xattr(struct inode *inode)
 {
 	if (!is_sxid(inode->i_mode) && (inode->i_sb->s_flags & SB_NOSEC))
-		inode->i_flags |=3D S_NOSEC;
+		inode_set_flags(inode, S_NOSEC, S_NOSEC);
 }

 static inline bool is_root_inode(struct inode *inode)
--=20
2.19.1


--OxKepGG7RbPVFq5CjQuDBKKCBa89UYKPx--

--lUG5BSCwUXEwncyBYfUst9oArZgCQCsg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAlwHukIACgkQWT7tBbw+
9v0PuA//Zlht7tlQfVo9ncg1dcbzg5MCsH8053B0Fum6G/ee9CH6kPAQVuvEtd9Y
ymP5LMcc2Ps68AlksH9wP55MdYqNky5G0+SQn/u/oPKiWMMsVQ2vtY1+74+fP7hI
fmd3cUknWOb2rlTL8316YlazYFLQTXmMtLxbnXC3Y4EKMngbydCV9KvuASIYiEHc
f2+gbX4YVq3oB/XO98ZUuFdvU/vHhBp//I1k3kus0p3fdVvYBDQ5Mw/U3OHosEfL
m0YJT8eispYT4psDTYtIu/JiG3Dxa2qND5GQngweiK4chFsaTdZ2JFIMa1oCJCoK
KcaNlV8UqZW8v7MxMishjUHeTP4aNpjyW7tMyifD3qUuJe7UCpNoW2Nj9aXyeJ+c
JR/g1VE8RPmn1fTa7FzkhKTWwAPBZ4HmXFP3d73HUr3GfsMrNWmaj7no7eVleFCt
wi8xQv5IBZTPTgJrepiq7+GTqIsyfuUx8L7U9OgmGQT3vzzX6yMb/F/DFdChKvcc
nK3e2FRCQOidG5eE8C8t6qzEPD/BrHzCg+lYD3KwEENZ16TXL0iBSZR0O0uTJrtQ
gcRBRa5hKFNsnayJhFDoKO/HIAY/zGJagCBZETWVG8iNavCu+a+2xrVY0aVgcJp7
987vgEQuSR8eZfKdXMveDuaKZ2r7SCXqNsvsItmzotB+Uq1f/Fw=
=ZsIs
-----END PGP SIGNATURE-----

--lUG5BSCwUXEwncyBYfUst9oArZgCQCsg9--
