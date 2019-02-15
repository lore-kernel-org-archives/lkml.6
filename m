Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A321929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394966AbfBONlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:41:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbfBONlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:41:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FDeOqG1195844
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 05:40:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FDeMD81195834;
        Fri, 15 Feb 2019 05:40:22 -0800
Date:   Fri, 15 Feb 2019 05:40:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-3f4da372ec8e4ce58c17ac4f2e3c8891bbfea17e@git.kernel.org>
Cc:     puwen@hygon.cn, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com, mingo@redhat.com, james.morse@arm.com,
        bp@suse.de, hpa@zytor.com, qiuxu.zhuo@intel.com, mingo@kernel.org,
        tony.luck@intel.com, vishal.l.verma@intel.com, x86@kernel.org,
        tglx@linutronix.de, linux-edac@vger.kernel.org
Reply-To: tony.luck@intel.com, mingo@kernel.org, qiuxu.zhuo@intel.com,
          x86@kernel.org, tglx@linutronix.de, linux-edac@vger.kernel.org,
          vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
          puwen@hygon.cn, mchehab@kernel.org, hpa@zytor.com, bp@suse.de,
          james.morse@arm.com, yazen.ghannam@amd.com, mingo@redhat.com
In-Reply-To: <20190212212417.107049-1-Yazen.Ghannam@amd.com>
References: <20190212212417.107049-1-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] EDAC/mce_amd: Decode MCA_STATUS[Scrub] bit
Git-Commit-ID: 3f4da372ec8e4ce58c17ac4f2e3c8891bbfea17e
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

Commit-ID:  3f4da372ec8e4ce58c17ac4f2e3c8891bbfea17e
Gitweb:     https://git.kernel.org/tip/3f4da372ec8e4ce58c17ac4f2e3c8891bbfea17e
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Tue, 12 Feb 2019 21:24:28 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 14:25:58 +0100

EDAC/mce_amd: Decode MCA_STATUS[Scrub] bit

Previous AMD systems have had a bit in MCA_STATUS to indicate that an
error was detected on a scrub operation. However, this bit was defined
differently within different banks and families/models.

Starting with Family 17h, MCA_STATUS[40] is either Reserved/Read-as-Zero
or defined as "Scrub", for all MCA banks and CPU models. Therefore, this
bit can be defined as the "Scrub" bit.

Define MCA_STATUS[40] as "Scrub" and decode it in the AMD MCE decoding
module for Family 17h and newer systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190212212417.107049-1-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h | 1 +
 drivers/edac/mce_amd.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 299a38536567..22d05e3835f0 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
+#define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
 
 /*
  * McaX field if set indicates a given bank supports MCA extensions:
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index f286b880f981..b349c22bb386 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1078,6 +1078,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (ecc)
 		pr_cont("|%sECC", ((ecc == 2) ? "C" : "U"));
 
+	if (fam >= 0x17)
+		pr_cont("|%s", (m->status & MCI_STATUS_SCRUB ? "Scrub" : "-"));
+
 	pr_cont("]: 0x%016llx\n", m->status);
 
 	if (m->status & MCI_STATUS_ADDRV)
