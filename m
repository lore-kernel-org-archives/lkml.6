Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469DBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C1C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C1C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966646AbeFSPoP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:44:15 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966193AbeFSPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:44:13 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LupZV-1gDC9l053J-0101XE; Tue, 19 Jun 2018 17:33:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steve French <sfrench@samba.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cifs: use 64-bit timestamps for fscache
Date:   Tue, 19 Jun 2018 17:27:59 +0200
Message-Id: <20180619153255.3634720-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619153255.3634720-1-arnd@arndb.de>
References: <20180619153255.3634720-1-arnd@arndb.de>
X-Provags-ID: V03:K1:qxAaGmQKval2Htg1xz1M+yzaV/JcTkAAro5o3OtZaOkFa9rVvNb
 +PTxu8UJ+QoH0GqoexiI0jlErOtDObWfcT6/H1wZ0BGFzc+KBtYD5Df1O3jEXSXmiKp0XUC
 q3aibvGsB1Zzfl11PeZAYSFunABRG0fxjioa1tHeE5QA3HOJCPr4rtsm59NXEgZhnZEuOkO
 tpnihWMty46CxQwu392dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rXqREHusXe8=:nb4ADdMgSlQsqiCmz772fN
 DcczVHf7Jwd0mW6wwXXdsVL4sOvmuoUX8Tr36CHIw9sTkvmLTcqy7vW/BfWAIUgLNwyzgUBnG
 45A4IUPT57koqr60qkOItURcTm+NNnCZGWQbKDoe75bfjMlRlEeYLHonMYrV293VdnMsEOQPs
 HX8Uow4VjVqHVbfu9xS8HCdsN//yKVxEwkWoBlxhFP7WiDMCjUx/6T4l3EYCMM2IXrPnv1/E8
 6whhyklCxUxoJ9p/MS694Ec2Hhlq6MCTvYC6M3ewIeSgd5GA1L1hvoj6wUNX7f1ktLWeQvk8F
 OJjL2AmtWgJrur8ruumHKi35oQWrR3xeIIfUUwcYYzZzRrM0wkz8fFx+wKrm9r3Syk3uA/aB0
 18xQQF5rK7bxNoNL4/snSijvajX+hMN0SUFmny2BXlOfTlfdVQHU92IlTP52eDXZAbQ5eklTR
 VzF23pcNfTF80M64S1aDaX6n+ShuskzD1UlK3wr9WZxKAEYbk9Saw+6MPbI+jA2yUquVTxBGf
 LPzhF+ZbOGyKBGFzaMqCilfUmuu5nbArNtyckqufUnaDvprqMsmWkqPEB88O8bsIMnaufes9s
 1xYuyEQSvFcwVQosUDZu6RMicbN2aYqO0hzwm3Gm6HBIBtWqt7FbkMsDTe3f9N+yLNGJF8dFE
 Dbodd2DkyRjqsVA342+0FSGoKyTyeAE0+v/mPWkr2pA0obkL1KBuGdvfAferYGns8qX0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the fscache, we just need the timestamps as cookies to check for
changes, so we don't really care about the overflow, but it's better
to stop using the deprecated timespec so we don't have to go through
explicit conversion functions.

To avoid comparing uninitialized padding values that are copied
while assigning the timespec values, this rearranges the members of
cifs_fscache_inode_auxdata to avoid padding, and assigns them
individually.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cifs/cache.c   |  6 ++++--
 fs/cifs/fscache.c | 12 ++++++++----
 fs/cifs/fscache.h |  8 +++++---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cache.c b/fs/cifs/cache.c
index e1553d1e0e50..b7420e605b28 100644
--- a/fs/cifs/cache.c
+++ b/fs/cifs/cache.c
@@ -128,8 +128,10 @@ fscache_checkaux cifs_fscache_inode_check_aux(void *cookie_netfs_data,
 
 	memset(&auxdata, 0, sizeof(auxdata));
 	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
-	auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
+	auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (memcmp(data, &auxdata, datalen) != 0)
 		return FSCACHE_CHECKAUX_OBSOLETE;
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 85145a763021..ea6ace9c2417 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -129,8 +129,10 @@ static void cifs_fscache_acquire_inode_cookie(struct cifsInodeInfo *cifsi,
 
 	memset(&auxdata, 0, sizeof(auxdata));
 	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
-	auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
+	auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
 
 	cifsi->fscache =
 		fscache_acquire_cookie(tcon->fscache,
@@ -166,8 +168,10 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 	if (cifsi->fscache) {
 		memset(&auxdata, 0, sizeof(auxdata));
 		auxdata.eof = cifsi->server_eof;
-		auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
-		auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
+		auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
+		auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
+		auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
+		auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
 
 		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
 		fscache_relinquish_cookie(cifsi->fscache, &auxdata, false);
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index c7e3ac251e16..8c0862e41306 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -31,9 +31,11 @@
  * Auxiliary data attached to CIFS inode within the cache
  */
 struct cifs_fscache_inode_auxdata {
-	struct timespec	last_write_time;
-	struct timespec	last_change_time;
-	u64		eof;
+	u64 last_write_time_sec;
+	u64 last_change_time_sec;
+	u32 last_write_time_nsec;
+	u32 last_change_time_nsec;
+	u64 eof;
 };
 
 /*
-- 
2.9.0

