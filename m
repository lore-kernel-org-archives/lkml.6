Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EE3C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5620989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F5620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKHHAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:00:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKHHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:00:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7LRsMW1620791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 13:27:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7LRs311620788;
        Wed, 7 Nov 2018 13:27:54 -0800
Date:   Wed, 7 Nov 2018 13:27:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Janakarajan Natarajan <tipbot@zytor.com>
Message-ID: <tip-08e823c2c5899ef2de3aa1727233f1f19e8c1cc1@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dwmw@amazon.co.uk,
        r.marek@assembler.cz, Janakarajan.Natarajan@amd.com,
        fenghua.yu@intel.com, konrad.wilk@oracle.com, x86@kernel.org
Reply-To: tglx@linutronix.de, bp@suse.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@redhat.com,
          r.marek@assembler.cz, dwmw@amazon.co.uk,
          Janakarajan.Natarajan@amd.com, fenghua.yu@intel.com,
          konrad.wilk@oracle.com, x86@kernel.org
In-Reply-To: <1541624211-32196-1-git-send-email-Janakarajan.Natarajan@amd.com>
References: <1541624211-32196-1-git-send-email-Janakarajan.Natarajan@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Add WBNOINVD feature definition
Git-Commit-ID: 08e823c2c5899ef2de3aa1727233f1f19e8c1cc1
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

Commit-ID:  08e823c2c5899ef2de3aa1727233f1f19e8c1cc1
Gitweb:     https://git.kernel.org/tip/08e823c2c5899ef2de3aa1727233f1f19e8c1cc1
Author:     Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
AuthorDate: Wed, 7 Nov 2018 20:59:07 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 7 Nov 2018 22:21:03 +0100

x86/cpufeatures: Add WBNOINVD feature definition

Add a new cpufeature definition for the WBNOINVD instruction.

The WBNOINVD instruction writes all modified cache lines in all levels of
the cache associated with a processor to main memory while retaining the
cached values.

Both AMD and Intel support this instruction.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: David Woodhouse <dwmw@amazon.co.uk>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Rudolf Marek <r.marek@assembler.cz>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1541624211-32196-1-git-send-email-Janakarajan.Natarajan@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 28c4a502b419..39a48f06d39d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -281,6 +281,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
