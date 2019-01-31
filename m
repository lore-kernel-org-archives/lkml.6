Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32273C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090320857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XLJirbex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfAaFBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:01:41 -0500
Received: from ozlabs.org ([203.11.71.1]:34365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfAaFBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:01:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qp406C0jz9sBb;
        Thu, 31 Jan 2019 16:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548910898;
        bh=IjJV29n5nv2WrFCPjj7ygqYY88Mvh573ttnS2ebd+yo=;
        h=Date:From:To:Cc:Subject:From;
        b=XLJirbex1sEvN0PcO5ZN3yv8UcUEgzSi27qoHpBv1QUJqX2i53dB+raf0pdPEsYAC
         zKu48p0MBg77Lhm4N803NV5d7IJmFPDuiW5Zd/WBQu3kDyyYUy3cFYjpJB0Pk41XWt
         iiZA3QqAComn7c0D5zZdqYDaVhJFDTL5IMIKCbic5s1hEKhfCn3Y3uRXIRzaZtI8CV
         Rr0L/jQ8b6vtoInuaHjv521I7mUTIkzeGLGxgRqasm4rXb+1hWRg5UZ9oNmp0w6/QA
         W4Zs5Pi//4fRr9lK5n0NOXbA+RnJlqXwrIcfq3kIT4YzVyLY4Zwke82UZnNLjEQ7dO
         m5Hbgjd8UTwoA==
Date:   Thu, 31 Jan 2019 16:01:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190131160135.4a8ae70b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_XKVVmyKvVxz5fOvB+koE+H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_XKVVmyKvVxz5fOvB+koE+H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from arch/x86/include/asm/percpu.h:45,
                 from arch/x86/include/asm/current.h:6,
                 from include/linux/sched.h:12,
                 from include/linux/uaccess.h:5,
                 from fs/proc/base.c:51:
fs/proc/base.c: In function 'proc_smack_attr_dir_lookup':
include/linux/kernel.h:73:25: warning: passing argument 4 of 'proc_pident_l=
ookup' makes pointer from integer without a cast [-Wint-conversion]
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(=
arr))
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
fs/proc/base.c:2602:7: note: in expansion of macro 'ARRAY_SIZE'
       ARRAY_SIZE(LSM##_attr_dir_stuff)); \
       ^~~~~~~~~~
fs/proc/base.c:2615:1: note: in expansion of macro 'LSM_DIR_OPS'
 LSM_DIR_OPS(smack);
 ^~~~~~~~~~~
fs/proc/base.c:2454:31: note: expected 'const struct pid_entry *' but argum=
ent is of type 'long unsigned int'
       const struct pid_entry *end)
       ~~~~~~~~~~~~~~~~~~~~~~~~^~~

Introduced by commit

  f6e3521a4c5b ("proc: calculate end pointer for /proc/*/* lookup at compil=
e time")

interacting with commit

  6d9c939dbe4d ("procfs: add smack subdir to attrs")

from the security tree.

I have applied the following merge fix patch

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 31 Jan 2019 15:56:56 +1100
Subject: [PATCH] proc: merge fix for proc_pident_lookup() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4ac7f32c1929..3daca4367d29 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2599,7 +2599,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(st=
ruct inode *dir, \
 { \
 	return proc_pident_lookup(dir, dentry, \
 				  LSM##_attr_dir_stuff, \
-				  ARRAY_SIZE(LSM##_attr_dir_stuff)); \
+				  LSM##_attr_dir_stuff + ARRAY_SIZE(LSM##_attr_dir_stuff)); \
 } \
 \
 static const struct inode_operations proc_##LSM##_attr_dir_inode_ops =3D {=
 \
--=20
2.20.1

---
Cheers,
Stephen Rothwell

--Sig_/_XKVVmyKvVxz5fOvB+koE+H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSgS8ACgkQAVBC80lX
0GxDTgf+LDv04yPNNHI0yhLXV/diqjIIChuPWpdcxSpxeJ+t+wuwd40Kyfh05262
ijqCLsYOM7PHNch880MxlkS9hMx9xp1413piPHciVyG4aIY1nv3/aqL+B39HU3w1
01NyNSIriTCwy8OEAbMasgJQd1HLXQOZBXJSXv7m4BqbccKKfTMEcsoV9Zb0x8AF
eydYsECO/MJhldcqKAG8WL+pM4zV7RDBzeDhXKTk2M5NUdwZ7j+4McZUhiw5npBh
0+zLjqmNS09qpfTJZIze1Mgv0v2OTgcqez1lNmFubdlZL3N1VPl0l7Oguh64dQZE
KEfAPrhBkskhfrJVIym9k0YCbxZWJA==
=pNhc
-----END PGP SIGNATURE-----

--Sig_/_XKVVmyKvVxz5fOvB+koE+H--
