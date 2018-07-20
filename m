Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0800ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9317420673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9317420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeGTFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:47:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeGTFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:47:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6K50oDI2534894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 22:00:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6K50oTE2534891;
        Thu, 19 Jul 2018 22:00:50 -0700
Date:   Thu, 19 Jul 2018 22:00:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for K. Y. Srinivasan" <tipbot@zytor.com>
Message-ID: <tip-be0e16ce7c3bf9855f1ef5ae46cf889e1784ddea@git.kernel.org>
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, kys@microsoft.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mikelley@microsoft.com,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          kys@microsoft.com
In-Reply-To: <20180720035009.3995-1-kys@linuxonhyperv.com>
References: <20180720035009.3995-1-kys@linuxonhyperv.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Fix wrong merge conflict resolution
Git-Commit-ID: be0e16ce7c3bf9855f1ef5ae46cf889e1784ddea
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

Commit-ID:  be0e16ce7c3bf9855f1ef5ae46cf889e1784ddea
Gitweb:     https://git.kernel.org/tip/be0e16ce7c3bf9855f1ef5ae46cf889e1784ddea
Author:     K. Y. Srinivasan <kys@microsoft.com>
AuthorDate: Fri, 20 Jul 2018 03:50:09 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 06:56:23 +0200

x86/hyper-v: Fix wrong merge conflict resolution

When the mapping betwween the Linux notion of CPU ID to the hypervisor's
notion of CPU ID is not initialized, IPI must fall back to the
non-enlightened path.

The recent merge of upstream changes into the hyperv branch resolved a
merge conflict wronly by returning success in that case, which results in
the IPI not being sent at all. Fix it up.

Fixes: 8f63e9230dec ("Merge branch 'x86/urgent' into x86/hyperv")
Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org
Cc: olaf@aepfle.de
Cc: apw@canonical.com
Cc: jasowang@redhat.com
Cc: hpa@zytor.com
Cc: sthemmin@microsoft.com
Cc: Michael.H.Kelley@microsoft.com
Cc: vkuznets@redhat.com
Link: https://lkml.kernel.org/r/20180720035009.3995-1-kys@linuxonhyperv.com
---
 arch/x86/hyperv/hv_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 0c3c9f8fee77..5b0f613428c2 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -168,7 +168,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
 		if (vcpu == VP_INVAL)
-			return true;
+			return false;
 
 		/*
 		 * This particular version of the IPI hypercall can
