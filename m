Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560126AC5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560126AC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeFZUR2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:17:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:11633 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754968AbeFZUR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:17:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 13:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="50750674"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2018 13:17:25 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXuOy-000WJ3-2b; Wed, 27 Jun 2018 04:17:24 +0800
Date:   Wed, 27 Jun 2018 04:16:54 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        luto@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        kernel-team@fb.com, tglx@linutronix.de, efault@gmx.de,
        songliubraving@fb.com, Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH] x86,tlb: mm_fill_lazy_tlb_cpu_mask() can be static
Message-ID: <20180626201654.GA8061@lkp-ivb-ep02>
References: <20180626173126.12296-5-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626173126.12296-5-riel@surriel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 4d7614ce489c ("x86,tlb: only send page table free TLB flush to lazy TLB CPUs")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 tlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 03512772..e6d5b01 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -707,7 +707,7 @@ void tlb_flush_remove_tables_local(void *arg)
 	}
 }
 
-void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm, struct cpumask* lazy_cpus)
+static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm, struct cpumask* lazy_cpus)
 {
 	int cpu;
 
