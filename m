Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7707C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526672156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526672156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeI0UcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:32:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeI0UcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:32:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8REDNaH053775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 07:13:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8REDNHF053772;
        Thu, 27 Sep 2018 07:13:23 -0700
Date:   Thu, 27 Sep 2018 07:13:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qiuxu Zhuo <tipbot@zytor.com>
Message-ID: <tip-e5276b1ffa97e3883802f40a5e3a167fe1cb1d20@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, tony.luck@intel.com,
        bp@suse.de, linux-kernel@vger.kernel.org, aris@redhat.com,
        qiuxu.zhuo@intel.com, mchehab@s-opensource.com, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, tony.luck@intel.com,
          bp@suse.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mchehab@s-opensource.com, aris@redhat.com, qiuxu.zhuo@intel.com
In-Reply-To: <20180925000343.GB5998@agluck-desk>
References: <20180925000343.GB5998@agluck-desk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Add macros for the corrected error count
 bit field
Git-Commit-ID: e5276b1ffa97e3883802f40a5e3a167fe1cb1d20
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

Commit-ID:  e5276b1ffa97e3883802f40a5e3a167fe1cb1d20
Gitweb:     https://git.kernel.org/tip/e5276b1ffa97e3883802f40a5e3a167fe1cb1d20
Author:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate: Mon, 24 Sep 2018 17:03:43 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 16:08:18 +0200

x86/mce: Add macros for the corrected error count bit field

The bit field [52:38] of MCi_STATUS contains the corrected error count.
Add {*_SHIFT|*_MASK|*_CEC(c)} macros for it.

 [ bp: use GENMASK_ULL. ]

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20180925000343.GB5998@agluck-desk
---
 arch/x86/include/asm/mce.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6f95047179eb..97d6969f9a8a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -39,6 +39,9 @@
 #define MCI_STATUS_PCC		BIT_ULL(57)  /* processor context corrupt */
 #define MCI_STATUS_S		BIT_ULL(56)  /* Signaled machine check */
 #define MCI_STATUS_AR		BIT_ULL(55)  /* Action required */
+#define MCI_STATUS_CEC_SHIFT	38           /* Corrected Error Count */
+#define MCI_STATUS_CEC_MASK	GENMASK_ULL(52,38)
+#define MCI_STATUS_CEC(c)	(((c) & MCI_STATUS_CEC_MASK) >> MCI_STATUS_CEC_SHIFT)
 
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
