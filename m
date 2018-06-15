Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A12FBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56223208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56223208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbeFOEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:06:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46089 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeFOEGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:06:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 161ADAB9D;
        Fri, 15 Jun 2018 04:06:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 15 Jun 2018 14:06:20 +1000
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfs: discard ATTR_ATTR_FLAG
Message-ID: <877en0hewz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


This flag was introduce in 2.1.37pre1 and the only place it was tested
was removed in 2.1.43pre1.  The flag was never set.

Let's discard it properly.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/hostfs/hostfs.h | 3 +--
 include/linux/fs.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index cb8374af08a6..b16619b8e298 100644
=2D-- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -19,9 +19,8 @@
 #define HOSTFS_ATTR_ATIME_SET	128
 #define HOSTFS_ATTR_MTIME_SET	256
=20
=2D/* These two are unused by hostfs. */
+/* This one is unused by hostfs. */
 #define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
=2D#define HOSTFS_ATTR_ATTR_FLAG	1024
=20
 /*
  * If you are very careful, you'll notice that these two are missing:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bacd33e3a4af..c1ad4346fab9 100644
=2D-- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -176,7 +176,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t o=
ffset,
 #define ATTR_ATIME_SET	(1 << 7)
 #define ATTR_MTIME_SET	(1 << 8)
 #define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
=2D#define ATTR_ATTR_FLAG	(1 << 10)
 #define ATTR_KILL_SUID	(1 << 11)
 #define ATTR_KILL_SGID	(1 << 12)
 #define ATTR_FILE	(1 << 13)
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsjOz0ACgkQOeye3VZi
gblKrw/+PkYQU83zIYzPKHavkmSZoJ6WjFdrXv0Z0Et6VibRlfZsWlRvf/EVPHK2
k7puF1t7W/kkaHYjd3H+I5y9TyAt5wRa9MQLh8aCndtNan3Q4/itlmf9qxN0Gtq9
iBT1rXg+3H0y1mjWB0tmxUe1QEmXF+yMoax9pcGLA8vCFKfrCtyCwpI1GcRj1TcD
jT+1vvEd5Vm2XvCJvDCGNkC96MX7uUeoGxcc086qGv7I1aL1B7jc/G+89nSgD158
Qy/le6SYOpViEHoZ4+IzGdtge30dJPLT+W5ifsfuuoNgX463lZ1fWWtnuhKT2s9G
GchDj35+ZCbBSGiRSnYwDWvfF4xmi6q/qGo9BkheEFJ7hBxMSYlVmiR+IHxtxefQ
mfdbls5+kEwZuSHiqhPGU7MbvkTDeBRGVhtF2l3S/eHBpCfWqmPSZeK7ggNFPC6C
1SySg9gBseO9vjwLiyJZ6rMMJoxEv+PlXDqoYI9W6iRJpxsQLcPTIg54jeP+bIAU
s2vR4y6VlGGAMz3YpeVm5NzdBwZh7hJFN8CluLcWRVr9d/sixpkZjM+UsTnDZkYS
Fv1cPpMBTA5Ye7kzOnsquLQ7HObd/gpmb+8XGuD0W+R+TvOTQnuQ9sQsBuWlyMuP
057T1qdt7l4dj8OYQbQcG/FpI0M13ULnzuaGXP88YeF14rsV6qE=
=n8gT
-----END PGP SIGNATURE-----
--=-=-=--
