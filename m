Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91236C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49F2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F49F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeIDTio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:38:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:20249 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeIDTio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:38:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="85916338"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2018 08:12:37 -0700
Date:   Tue, 4 Sep 2018 23:25:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: [RFC PATCH tip] x86/xen: xen_reservation_lock can be static
Message-ID: <20180904152512.GV17047@intel.com>
References: <201809040116.CNt3UQy0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809040116.CNt3UQy0%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: f030aade9165 ("x86/xen: Move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mmu_pv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bf30fa0..7ada9e4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -104,7 +104,7 @@ static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
  * Protects atomic reservation decrease/increase against concurrent increases.
  * Also protects non-atomic updates of current_pages and balloon lists.
  */
-DEFINE_SPINLOCK(xen_reservation_lock);
+static DEFINE_SPINLOCK(xen_reservation_lock);
 
 /*
  * Note about cr3 (pagetable base) values:
