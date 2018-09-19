Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC582C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727D12098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="c0stgD/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727D12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeISVps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:45:48 -0400
Received: from sonic311-22.consmr.mail.gq1.yahoo.com ([98.137.65.203]:46105
        "EHLO sonic311-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbeISVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1537373232; bh=P4UAvpIItCh51IZs8xCoJSUmI46M5b/c90VK8zAJrC0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=c0stgD/+M8YQlhnz7WE67GM+bq6ubBGC2+5Fg1bsxs8RQq5jiXtFnua6gYkpea/aHEdHxky+rA+QD/aJp4nggu3u3AuKrgG04nxQSh2kAhDAyaXDVMnxGjTnyc3F1A3kV5IFDea4EPbkKtxSru6+sVOtZ4UghPQ9LybLeDjj1v7eHsZ2gJaR696b92TSmqVFOq+pydOEa3ctCjvNBc2rPsinyapwjWPzzUnyTEuAeorCLHRi8GDOU8dBQzWUYDk/elpbGGuzFiCRORllbI/ccQyFTcH/4SUdABjRIfaoT4c0mznBF5NFGXgMslLnXmDjOIq0RGf+UL48bqCP01o+aw==
X-YMail-OSG: fGQ0f_MVM1mwQevSt1WV_E3O9LrnwURVvH08qwU9ZnIsK2f7i7IvaUejm3wVtcz
 aQuXmrjR62ur2pES4I0jZpqCqognyRtSPGM5sgESwPYWBT3iEgy.yOwPlBtRyP4FL7phBzdZdgAi
 GTVLYDZqWRb9rPPkC63uRf6dT3B0uKAN7h7xKH2ioTIud_cRaF2OTo7AFdk.APD6c878e66lCHIY
 _rmiTnJQR8q3FiNok96ziqXZSlIvYbxvtWf17l3REnuM2qjsNnpktH_c0RttU0Q_sebS4xzIgGOn
 C_P5jeynO2n_2YMv1MRCx165zbuvLGl16.s_HZ_oBwxEnOkuolTsY1MHkqBIMUvosii0CICPRo_y
 2BToXhphfv1PwE4VB5xJ1rU3LQ4f6wDHZ0rzQv7.lcc5ZUdkGiCcH6Vy_wCOFdxIlHeAzvKbBsPw
 aoBh3xVuXdIOMD509OYbTq5.cCRgU2qCemCykyMP6_o.KwpdHpuOxqpt3emNgSWq5LJh1NSWd.9u
 eRqo27w0TCn3zkb_thWa5QnM13uVJlCP6WfCn3uDhPRSS.uc7P5nIEQr5z7ifMxXBihlfR38uzl1
 M7RD1A0U3rIZJKF06yoY41z2ML_1e1Y8uYB0HPH3M7PndsHJOSoPhxVw6_WxP4tVJPRyfyDxsexH
 mlb3lp0hM4YftifPqBErYGRbquIuX7k9p4cWAiPA7pq9.UYFAQiucHvy2T9_ADhJHKnk8sm8NTX5
 pvd1SJmSTNVHCYctkMjvXxMhc1dg_LMNGudtAkxfmYPMTO_ookI7JxmlXTwqe6cAT6tcjMT1sQZy
 eCRxB6Qx2nvHGDj0pAQZuulCAcAWtAlbFswMvDn62aH5SYYmVMVYO3PPoz4c5YekXnZRoRFG_2qW
 yeMjpQVOkmNoF8egxOGltpd3NLSCGRtXWti5PBEPIvikz9Q2zi9DOdliBrYogZYJdC_04Yn6MgjI
 sShI0wwTbowfK_pdCkIbrIHBbckMN3Gfxoo0HwupT8ylRBE3jGiM.xH0qj6kpc.ImJsR00FAr8l_
 v
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Sep 2018 16:07:12 +0000
Received: from 180.173.110.117 (EHLO DESKTOP-OR0BAOP.domain.name) ([180.173.110.117])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b6c966ed82991e8f4023ac65d22450af;
          Wed, 19 Sep 2018 16:07:11 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 4/6] staging: erofs: cleanup `z_erofs_vle_normalaccess_readpages'
Date:   Thu, 20 Sep 2018 00:06:56 +0800
Message-Id: <1537373216-21281-1-git-send-email-hsiangkao@aol.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
References: <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch introduces `__should_decompress_synchronously' to
cleanup `z_erofs_vle_normalaccess_readpages'.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
 - Leave the original threshold "3" for DEFAULT_MAX_SYNC_DECOMPRESS_PAGES
   and just do the cleanup work.

 drivers/staging/erofs/internal.h  | 11 +++++++++++
 drivers/staging/erofs/super.c     |  5 +++++
 drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index cfcc6db..c2cc4a016 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -95,6 +95,9 @@ struct erofs_sb_info {
 	/* the dedicated workstation for compression */
 	struct radix_tree_root workstn_tree;
 
+	/* threshold for decompression synchronously */
+	unsigned int max_sync_decompress_pages;
+
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	struct inode *managed_cache;
 #endif
@@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
 	struct page *page);
 #endif
 
+#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	3
+
+static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
+						     unsigned int nr)
+{
+	return nr <= sbi->max_sync_decompress_pages;
+}
+
 #endif
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 802202c..5b87f59 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -162,6 +162,11 @@ static void erofs_build_fault_attr(struct erofs_sb_info *sbi,
 
 static void default_options(struct erofs_sb_info *sbi)
 {
+	/* set up some FS parameters */
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->max_sync_decompress_pages = DEFAULT_MAX_SYNC_DECOMPRESS_PAGES;
+#endif
+
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
 #endif
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 9fe18cd3..337a82d 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1308,12 +1308,14 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	return 0;
 }
 
-static inline int __z_erofs_vle_normalaccess_readpages(
-	struct file *filp,
-	struct address_space *mapping,
-	struct list_head *pages, unsigned int nr_pages, bool sync)
+static int z_erofs_vle_normalaccess_readpages(struct file *filp,
+					      struct address_space *mapping,
+					      struct list_head *pages,
+					      unsigned int nr_pages)
 {
 	struct inode *const inode = mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
+	const bool sync = __should_decompress_synchronously(sbi, nr_pages);
 
 	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
 	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
@@ -1372,16 +1374,6 @@ static inline int __z_erofs_vle_normalaccess_readpages(
 	return 0;
 }
 
-static int z_erofs_vle_normalaccess_readpages(
-	struct file *filp,
-	struct address_space *mapping,
-	struct list_head *pages, unsigned int nr_pages)
-{
-	return __z_erofs_vle_normalaccess_readpages(filp,
-		mapping, pages, nr_pages,
-		nr_pages < 4 /* sync */);
-}
-
 const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 	.readpage = z_erofs_vle_normalaccess_readpage,
 	.readpages = z_erofs_vle_normalaccess_readpages,
-- 
2.7.4

