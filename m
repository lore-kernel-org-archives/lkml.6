Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2772080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfBVDnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:43:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:8317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBVDnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:43:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 19:43:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="126321573"
Received: from sgdharne-mobl2.gar.corp.intel.com (HELO [10.252.84.57]) ([10.252.84.57])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2019 19:43:36 -0800
Subject: Re: [PATCH v3 0/5] ICL support and other enhancements for PMC Core
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcdBMVgDxuJKyiw5n9UZr7w0u+zz73GAUnRM6Y9C-=r0w@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <35e994a3-cb87-5af0-5b44-0ce3512640f6@linux.intel.com>
Date:   Fri, 22 Feb 2019 09:13:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcdBMVgDxuJKyiw5n9UZr7w0u+zz73GAUnRM6Y9C-=r0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-19 7:55 PM, Andy Shevchenko wrote:
> On Thu, Feb 14, 2019 at 1:56 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> Changes in v3:
>>   * Dropped reference to coreboot project as suggested by Thomas and Boris.
>>   * Rebased onto "for-next" branch of pdx86 tree and dropped previously
>>     accepted five patches from v2 of this series since they are already
>>     present there.
>>   * Fixed checkpatch complains about 75 char limit for commit messages.
>>
>> Changes in v2:
>>   * Addressed review comments from Thomas
>>   * Added tags revieved
>>   * Folded in SHA1 suggestions from Stephen Rothwell, though Andy might
>>     want to fix it via rebasing
>>   * Rebased and tested with Linux v5.0.0-rc6
>>
>> This series:
>>   - Adds ICL U/Y CPUID to intel-family.h
>>   - Enables PMC driver for ICL
>>   - Introduces a new "package cstate show" feature
>>   - Fixes a customer issue related to S0ix on latest HP laptops
>>   - Fixes some minor bugs
>>
>>
> Pushed to my review and testing queue, thanks!

Thank you!

>
>
>> Rajneesh Bhardwaj (5):
>>    x86/cpu: Add Icelake to Intel family
>>    platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
>>    platform/x86: intel_pmc_core: Add ICL platform support
>>    platform/x86: intel_pmc_core: Add Package cstates residency info
>>    platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
>>
>>   arch/x86/include/asm/intel-family.h   |   2 +
>>   drivers/platform/x86/intel_pmc_core.c | 144 ++++++++++++++++++++++----
>>   drivers/platform/x86/intel_pmc_core.h |  10 ++
>>   3 files changed, 135 insertions(+), 21 deletions(-)
>>
>> --
>> 2.17.1
>>
>
