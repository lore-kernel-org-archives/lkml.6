Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE752156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE752156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeI0Ubd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:31:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0Ubc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:31:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RECoAV053719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 07:12:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RECo9S053716;
        Thu, 27 Sep 2018 07:12:50 -0700
Date:   Thu, 27 Sep 2018 07:12:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qiuxu Zhuo <tipbot@zytor.com>
Message-ID: <tip-93ac57540e9129004b569beee54e50b3519b0b07@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com,
        tglx@linutronix.de, mchehab@s-opensource.com, tony.luck@intel.com,
        aris@redhat.com, mingo@kernel.org, qiuxu.zhuo@intel.com
Reply-To: qiuxu.zhuo@intel.com, mingo@kernel.org, tony.luck@intel.com,
          aris@redhat.com, mchehab@s-opensource.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de
In-Reply-To: <20180925000127.GA5998@agluck-desk>
References: <20180925000127.GA5998@agluck-desk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Use BIT_ULL(x) for bit mask definitions
Git-Commit-ID: 93ac57540e9129004b569beee54e50b3519b0b07
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  93ac57540e9129004b569beee54e50b3519b0b07
Gitweb:     https://git.kernel.org/tip/93ac57540e9129004b569beee54e50b3519b0b07
Author:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate: Mon, 24 Sep 2018 17:01:27 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 16:06:37 +0200

x86/mce: Use BIT_ULL(x) for bit mask definitions

Current coding style is to use the BIT_ULL() macro.

 [ bp: Align the MCG_STATUS defines vertically too. ]

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20180925000127.GA5998@agluck-desk
---
 arch/x86/include/asm/mce.h | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3a17107594c8..6f95047179eb 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -10,41 +10,41 @@
 
 /* MCG_CAP register defines */
 #define MCG_BANKCNT_MASK	0xff         /* Number of Banks */
-#define MCG_CTL_P		(1ULL<<8)    /* MCG_CTL register available */
-#define MCG_EXT_P		(1ULL<<9)    /* Extended registers available */
-#define MCG_CMCI_P		(1ULL<<10)   /* CMCI supported */
+#define MCG_CTL_P		BIT_ULL(8)   /* MCG_CTL register available */
+#define MCG_EXT_P		BIT_ULL(9)   /* Extended registers available */
+#define MCG_CMCI_P		BIT_ULL(10)  /* CMCI supported */
 #define MCG_EXT_CNT_MASK	0xff0000     /* Number of Extended registers */
 #define MCG_EXT_CNT_SHIFT	16
 #define MCG_EXT_CNT(c)		(((c) & MCG_EXT_CNT_MASK) >> MCG_EXT_CNT_SHIFT)
-#define MCG_SER_P		(1ULL<<24)   /* MCA recovery/new status bits */
-#define MCG_ELOG_P		(1ULL<<26)   /* Extended error log supported */
-#define MCG_LMCE_P		(1ULL<<27)   /* Local machine check supported */
+#define MCG_SER_P		BIT_ULL(24)  /* MCA recovery/new status bits */
+#define MCG_ELOG_P		BIT_ULL(26)  /* Extended error log supported */
+#define MCG_LMCE_P		BIT_ULL(27)  /* Local machine check supported */
 
 /* MCG_STATUS register defines */
-#define MCG_STATUS_RIPV  (1ULL<<0)   /* restart ip valid */
-#define MCG_STATUS_EIPV  (1ULL<<1)   /* ip points to correct instruction */
-#define MCG_STATUS_MCIP  (1ULL<<2)   /* machine check in progress */
-#define MCG_STATUS_LMCES (1ULL<<3)   /* LMCE signaled */
+#define MCG_STATUS_RIPV		BIT_ULL(0)   /* restart ip valid */
+#define MCG_STATUS_EIPV		BIT_ULL(1)   /* ip points to correct instruction */
+#define MCG_STATUS_MCIP		BIT_ULL(2)   /* machine check in progress */
+#define MCG_STATUS_LMCES	BIT_ULL(3)   /* LMCE signaled */
 
 /* MCG_EXT_CTL register defines */
-#define MCG_EXT_CTL_LMCE_EN (1ULL<<0) /* Enable LMCE */
+#define MCG_EXT_CTL_LMCE_EN	BIT_ULL(0) /* Enable LMCE */
 
 /* MCi_STATUS register defines */
-#define MCI_STATUS_VAL   (1ULL<<63)  /* valid error */
-#define MCI_STATUS_OVER  (1ULL<<62)  /* previous errors lost */
-#define MCI_STATUS_UC    (1ULL<<61)  /* uncorrected error */
-#define MCI_STATUS_EN    (1ULL<<60)  /* error enabled */
-#define MCI_STATUS_MISCV (1ULL<<59)  /* misc error reg. valid */
-#define MCI_STATUS_ADDRV (1ULL<<58)  /* addr reg. valid */
-#define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
-#define MCI_STATUS_S	 (1ULL<<56)  /* Signaled machine check */
-#define MCI_STATUS_AR	 (1ULL<<55)  /* Action required */
+#define MCI_STATUS_VAL		BIT_ULL(63)  /* valid error */
+#define MCI_STATUS_OVER		BIT_ULL(62)  /* previous errors lost */
+#define MCI_STATUS_UC		BIT_ULL(61)  /* uncorrected error */
+#define MCI_STATUS_EN		BIT_ULL(60)  /* error enabled */
+#define MCI_STATUS_MISCV	BIT_ULL(59)  /* misc error reg. valid */
+#define MCI_STATUS_ADDRV	BIT_ULL(58)  /* addr reg. valid */
+#define MCI_STATUS_PCC		BIT_ULL(57)  /* processor context corrupt */
+#define MCI_STATUS_S		BIT_ULL(56)  /* Signaled machine check */
+#define MCI_STATUS_AR		BIT_ULL(55)  /* Action required */
 
 /* AMD-specific bits */
-#define MCI_STATUS_TCC		(1ULL<<55)  /* Task context corrupt */
-#define MCI_STATUS_SYNDV	(1ULL<<53)  /* synd reg. valid */
-#define MCI_STATUS_DEFERRED	(1ULL<<44)  /* uncorrected error, deferred exception */
-#define MCI_STATUS_POISON	(1ULL<<43)  /* access poisonous data */
+#define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
+#define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
+#define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
+#define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
 
 /*
  * McaX field if set indicates a given bank supports MCA extensions:
@@ -84,7 +84,7 @@
 #define  MCI_MISC_ADDR_GENERIC	7	/* generic */
 
 /* CTL2 register defines */
-#define MCI_CTL2_CMCI_EN		(1ULL << 30)
+#define MCI_CTL2_CMCI_EN		BIT_ULL(30)
 #define MCI_CTL2_CMCI_THRESHOLD_MASK	0x7fffULL
 
 #define MCJ_CTX_MASK		3
