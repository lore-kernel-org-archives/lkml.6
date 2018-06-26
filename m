Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF08C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D43426AC5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D43426AC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeFZURd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:17:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:17671 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933482AbeFZURa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:17:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 13:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="53111742"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 13:17:27 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXuOy-000WK4-97; Wed, 27 Jun 2018 04:17:24 +0800
Date:   Wed, 27 Jun 2018 04:16:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        luto@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        kernel-team@fb.com, tglx@linutronix.de, efault@gmx.de,
        songliubraving@fb.com, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 4/6] x86,tlb: only send page table free TLB flush to lazy
 TLB CPUs
Message-ID: <201806270453.Vf1oYmtl%fengguang.wu@intel.com>
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

Hi Rik,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc2 next-20180626]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rik-van-Riel/mm-allocate-mm_cpumask-dynamically-based-on-nr_cpu_ids/20180627-021116
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   arch/x86/mm/tlb.c:39:6: sparse: symbol 'clear_asid_other' was not declared. Should it be static?
>> arch/x86/mm/tlb.c:710:6: sparse: symbol 'mm_fill_lazy_tlb_cpu_mask' was not declared. Should it be static?
   arch/x86/mm/tlb.c:833:15: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
