Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809FC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E53B20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Y/MVe8ZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E53B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeG2HFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 03:05:01 -0400
Received: from sonic310-22.consmr.mail.gq1.yahoo.com ([98.137.69.148]:44476
        "EHLO sonic310-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726153AbeG2HFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 03:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1532842551; bh=H3Tz7HbJT+GHuWrjaMsNJfCwQbFE/GK/H8wFDgdr6YU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Y/MVe8ZPLRX4D5/dK5cl2tHBP/So9z5GmifLZFG919JHMvEG3KscSpVTFqWHnCrJm89rWJ1nwExJ1ZIRa3JV2PpU7JFi+DYsMRMkS9+ydXav7C3VE2V1q6xq28P0OW/4Pql6cQQaps1IhmeouBNZ4IHlawE6N2TewZRC/a+KI5VcIVw6Hs96NpH0dWONQGFF5Y1lHFoA/5TL3UFTs6n5IfriKTPJIdTn/4D8yNfCiUEF9pANReVZzU1xsWT6UnlRptwVrnZTbUparg0lBOqR8bTHEipwn8jkMEPn0kVQkSwsMUX+aUQEfAVgOxU7xSTb7plz1LLjhb7MRn3uxLNuvg==
X-YMail-OSG: hrTkX7oVM1mwRFteOgX6_eMcsuIKCHm4BQbaTz1oXjZ74uqkzXTgYSMKVbBLycZ
 _WQK55SUIAa9CfU_9HCo_OPcr4PAyfe8w5eTK_HxwJqkmsxhJaQPjsMokfExFSKeoqWisMSGtLu5
 B_spEmZYUKfvPQJ1lgLhhTEJrVHrqJwJ25gq7JXQ40ybYwKHN9pSptvkiJGbjSydJ1pbllxXcO3c
 YpcLCMc7ClyS2fWijM0MSO075yaoFPpXGJYhcwABmjQ9RWcaSuEFW9l.GLkM5gzzsIXZ8BqOU3zU
 EM40UrOLfw4eDDoCJ1tCzV9znQ3MN_Ht9R_OFhW4yQuimI5B4iUUAQUjfcIMsHk5L3Pun71d6e3z
 F1ZgyqsxJLEvqf6WMNnYrBXE.mFrz65qQT7ssiz75Ps2CwljxszRHj9.fQrpkaEFp2qDUE1Hl61u
 N7lPZbR3aD_tzvZkdnmmoES4GA3yydWyY5pJ.J6eiQ88SZ92X3vNIKk9TD8E5v8qi3DUFi0na2_g
 t2fTsbK_hTkoNYC5eHC5Ma0p894f.4ltyr6J0yq.FpwvaGlv5GT.WDtnj1AR9KgEIRquiU48MAM2
 UmthLjSlTM_meLVORgmTE4ZH2SZZPBrIy9VX3Y3nfaKXcDslqFUIJ8KvSucGvGaYSdDjdfkA2gIW
 u6RrTHTv5UdyQBHsULaCPLeu66AMsgwvDD6R2Y5WL0G0f986KnIF6i7TeISek1EE_XpwRdYdTynd
 ASbJNfQjsAcZJjwgwNCdH2DQMJsDpAS.dQhHQ42t5W_gtbWD62UsA.9d8VTTZEZy0_RMUdxgG4.w
 xrBurTYLBiGWP2fRCAxhNo8um8.Mn.NNVaucPZfhcCVYrWOpKv69W6MdcGwjc1zTn45hQMK2m.As
 ZQCu8xEor0xB7IroKg96o2AsTQJn0EFM1uZYWGisayCO70vJ8DRfMZbc93DUPZDp9dKKwcaAJ1tL
 RHf9eQgdwWotmRXGzFo7cBVfOVhDkkrXjpdS0wwuXNQjIUt.gkoJv2airkOHnekKJ3aTFYQ5AQ1T
 G5UiH9S.0Q03o80_kxWImEWMBxSxXMd7LPQRsj4TJytbmRXLagYvS_dmUdBlWr8Ni4gEzHuXp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 Jul 2018 05:35:51 +0000
Received: from 116.226.251.211 (EHLO localhost.localdomain) ([116.226.251.211])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d20fd8c0982f186cce0cc478006ef778;
          Sun, 29 Jul 2018 05:35:46 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <chao@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@aol.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 1/2] staging: erofs: fix compile error without built-in decompression support
Date:   Sun, 29 Jul 2018 13:34:58 +0800
Message-Id: <20180729053459.34140-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1532761832-6964-1-git-send-email-gaoxiang25@huawei.com>
References: <1532761832-6964-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes incorrect code snippets due to spilt code
into small patches by mistake.

Link: https://lists.01.org/pipermail/kbuild-all/2018-July/050747.html
Link: https://lists.01.org/pipermail/kbuild-all/2018-July/050750.html
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 I test several Kconfig option combinations and all these
combinations are successfully compiled.

Hi Chao,
 Could you please review this two patches first before merging
into staging-next tree?

Thanks,
Gao Xiang

 drivers/staging/erofs/internal.h  | 4 ++--
 drivers/staging/erofs/super.c     | 2 +-
 drivers/staging/erofs/unzip_vle.c | 7 ++++---
 drivers/staging/erofs/utils.c     | 7 ++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 669f93ae6920..367b39fe46e5 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -260,9 +260,9 @@ static inline void erofs_workstation_cleanup_all(struct super_block *sb)
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 #define EROFS_UNALLOCATED_CACHED_PAGE	((void *)0x5F0EF00D)
 
-extern int try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+extern int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	struct erofs_workgroup *egrp);
-extern int try_to_free_cached_page(struct address_space *mapping,
+extern int erofs_try_to_free_cached_page(struct address_space *mapping,
 	struct page *page);
 #endif
 
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 97da5c8a8ef3..1aec509c805f 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -269,7 +269,7 @@ static int managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	BUG_ON(mapping->a_ops != &managed_cache_aops);
 
 	if (PagePrivate(page))
-		ret = try_to_free_cached_page(mapping, page);
+		ret = erofs_try_to_free_cached_page(mapping, page);
 
 	return ret;
 }
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 7671fe8194ce..0e410a228cd4 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -131,8 +131,8 @@ static bool grab_managed_cache_pages(struct address_space *mapping,
 }
 
 /* called by erofs_shrinker to get rid of all compressed_pages */
-int try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
-				 struct erofs_workgroup *egrp)
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *egrp)
 {
 	struct z_erofs_vle_workgroup *const grp =
 		container_of(egrp, struct z_erofs_vle_workgroup, obj);
@@ -166,7 +166,8 @@ int try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int try_to_free_cached_page(struct address_space *mapping, struct page *page)
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(mapping->host->i_sb);
 	const unsigned int clusterpages = erofs_clusterpages(sbi);
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index ee70bb9e1636..595cf90af9bb 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -160,7 +160,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		}
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (try_to_free_all_cached_pages(sbi, grp))
+		if (erofs_try_to_free_all_cached_pages(sbi, grp))
 			goto skip;
 
 		erofs_workgroup_unfreeze(grp, 1);
@@ -247,7 +247,9 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
 
-		/* add scan handlers here */
+#ifdef CONFIG_EROFS_FS_ZIP
+		freed += erofs_shrink_workstation(sbi, nr, false);
+#endif
 
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
@@ -260,7 +262,6 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		list_move_tail(&sbi->list, &erofs_sb_list);
 		mutex_unlock(&sbi->umount_mutex);
 
-		freed += erofs_shrink_workstation(sbi, nr, false);
 		if (freed >= nr)
 			break;
 	}
-- 
2.17.1

