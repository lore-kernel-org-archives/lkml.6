Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716A8208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716A8208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPJvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:51:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeGPJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:51:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6G9Oukl1084000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Jul 2018 02:24:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6G9OuTe1083997;
        Mon, 16 Jul 2018 02:24:56 -0700
Date:   Mon, 16 Jul 2018 02:24:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-0f0caa52cd4a48a44f6cdc77bf83272bbb450727@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kys@microsoft.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, mingo@kernel.org,
        haiyangz@microsoft.com, vkuznets@redhat.com, mikelley@microsoft.com
Reply-To: mingo@kernel.org, haiyangz@microsoft.com, vkuznets@redhat.com,
          mikelley@microsoft.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          sthemmin@microsoft.com, kys@microsoft.com,
          Michael.H.Kelley@microsoft.com
In-Reply-To: <20180709174012.17429-2-vkuznets@redhat.com>
References: <20180709174012.17429-2-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Check cpumask_to_vpset() return value
 in hyperv_flush_tlb_others_ex()
Git-Commit-ID: 0f0caa52cd4a48a44f6cdc77bf83272bbb450727
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

Commit-ID:  0f0caa52cd4a48a44f6cdc77bf83272bbb450727
Gitweb:     https://git.kernel.org/tip/0f0caa52cd4a48a44f6cdc77bf83272bbb450727
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Mon, 9 Jul 2018 19:40:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 16 Jul 2018 11:19:48 +0200

x86/hyper-v: Check cpumask_to_vpset() return value in hyperv_flush_tlb_others_ex()

Commit 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI
enlightenment") made cpumask_to_vpset() return '-1' when there is a CPU
with unknown VP index in the supplied set. This needs to be checked before
we pass 'nr_bank' to hypercall.

Fixes: 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI enlightenment")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: devel@linuxdriverproject.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709174012.17429-2-vkuznets@redhat.com

---
 arch/x86/hyperv/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 0d90e515ec98..453d2355cd61 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -186,6 +186,8 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
+	if (nr_bank < 0)
+		return U64_MAX;
 
 	/*
 	 * We can flush not more than max_gvas with one hypercall. Flush the
