Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8221929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394991AbfBONlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:41:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394970AbfBONlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:41:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FDf3211195892
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 05:41:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FDf3dj1195889;
        Fri, 15 Feb 2019 05:41:03 -0800
Date:   Fri, 15 Feb 2019 05:41:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-a0bcd3c0b8a52ba0eb74371fa6be15ad0390ba67@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-edac@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        yazen.ghannam@amd.com, mchehab@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mchehab@kernel.org,
          yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
          mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190212212417.107049-2-Yazen.Ghannam@amd.com>
References: <20190212212417.107049-2-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] EDAC/mce_amd: Decode MCA_STATUS in bit definition
 order
Git-Commit-ID: a0bcd3c0b8a52ba0eb74371fa6be15ad0390ba67
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

Commit-ID:  a0bcd3c0b8a52ba0eb74371fa6be15ad0390ba67
Gitweb:     https://git.kernel.org/tip/a0bcd3c0b8a52ba0eb74371fa6be15ad0390ba67
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Tue, 12 Feb 2019 21:24:29 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 14:36:31 +0100

EDAC/mce_amd: Decode MCA_STATUS in bit definition order

Sort the MCA_STATUS bits in decode output to follow how they are defined
in the register.

The order is as follows:

  Bit | Decode
  ------------
  62  | Over
  61  | UC
  59  | MiscV
  58  | AddrV
  57  | PCC
  55  | TCC
  53  | SyndV
  46  | CECC
  45  | UECC
  44  | Deferred
  43  | Poison
  40  | Scrub

 [ bp: Massage a bit. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190212212417.107049-2-Yazen.Ghannam@amd.com
---
 drivers/edac/mce_amd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index b349c22bb386..0a1814dad6cf 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1051,26 +1051,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_UC)	? "UE"	  :
 		 (m->status & MCI_STATUS_DEFERRED) ? "-"  : "CE"),
 		((m->status & MCI_STATUS_MISCV)	? "MiscV" : "-"),
-		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"),
-		((m->status & MCI_STATUS_ADDRV)	? "AddrV" : "-"));
-
-	if (fam >= 0x15) {
-		pr_cont("|%s", (m->status & MCI_STATUS_DEFERRED ? "Deferred" : "-"));
-
-		/* F15h, bank4, bit 43 is part of McaStatSubCache. */
-		if (fam != 0x15 || m->bank != 4)
-			pr_cont("|%s", (m->status & MCI_STATUS_POISON ? "Poison" : "-"));
-	}
+		((m->status & MCI_STATUS_ADDRV)	? "AddrV" : "-"),
+		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		u32 low, high;
 		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
 
-		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
-
 		if (!rdmsr_safe(addr, &low, &high) &&
 		    (low & MCI_CONFIG_MCAX))
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
+
+		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
 	}
 
 	/* do the two bits[14:13] together */
@@ -1078,6 +1070,14 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (ecc)
 		pr_cont("|%sECC", ((ecc == 2) ? "C" : "U"));
 
+	if (fam >= 0x15) {
+		pr_cont("|%s", (m->status & MCI_STATUS_DEFERRED ? "Deferred" : "-"));
+
+		/* F15h, bank4, bit 43 is part of McaStatSubCache. */
+		if (fam != 0x15 || m->bank != 4)
+			pr_cont("|%s", (m->status & MCI_STATUS_POISON ? "Poison" : "-"));
+	}
+
 	if (fam >= 0x17)
 		pr_cont("|%s", (m->status & MCI_STATUS_SCRUB ? "Scrub" : "-"));
 
