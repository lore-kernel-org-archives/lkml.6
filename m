Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E266ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA2420856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA2420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeGTEt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:49:59 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:54220
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725737AbeGTEt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:49:58 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 00:49:58 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id gMS0f6mKIdH2EgMS0frhbm; Thu, 19 Jul 2018 20:51:29 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fgMS0-00013l-E8; Thu, 19 Jul 2018 20:51:28 -0700
From:   kys@linuxonhyperv.com
To:     x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] x86/hyper-v: Fix a merge error
Date:   Fri, 20 Jul 2018 03:50:09 +0000
Message-Id: <20180720035009.3995-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJKTRWPRD87MhCqrwrQb9A19BU85KTPsqEzrZ1iKfhCwn7WvRx0jcm5th1EhDWdLpH2XmhATGG6Jjvhf7Sfqjl5Bkpmy7Qu8bim6QyYdiDvD6cpe2WSs
 hEqwO3koyRR9e+qjr8EISyRi9PyvB6+elqay6dcl2MGQza2lzLSYaCjm9D08dfXlC0BBhXHEruUmt4kt4SbEXP3fJlrZv/s2Eqpr6IKjdqcJWCqtmQs6YUWn
 wP+Q72C1ljDqzIeUYAJwPPXZjoP/bO3PCg0RjlDCaORxpSe9v5lxofrftObqSpYuA82ZbhInuL1S2jxeUs4CDessM6QHL5s2Lfagzgq+uG8E4z5gQaQc36Y6
 IDhIyHDXC0yiAXxxxzL0RA5KvnXQc/eTTyLUkpEtk0DyF4hCDbonayS7pXAyozkF9vvJwDiLVvR8cQBv5daFgkF3X8pBSYRDgm+QVPNpreaR0TEfIHSzjV0A
 QO6Qi8o8yLJHUDSMP66r+u0865r1vksWzFNnuijNwORFWv7mX7GbhsOtiapeyVU3WcWDMaO/byCXOGLUhLzgUyC6XWLzgEOzQKmxQgLoQ0g/CdRbrxdt42Nt
 5XZS8hXFLdeD7vBcarSjrNXt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

When the mapping betwween the Linux notion of CPU ID
to the hypervisor's notion of CPU ID is not initialized,
we should fall back on the non-enligghtened path for IPI.
A merge error introduced this bug; fix it.

Fixes: 1268ed0c474a ("Merge branch 'x86/urgent' into x86/hyperv")

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
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
-- 
2.17.1

