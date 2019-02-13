Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F62C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C791222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403969AbfBMPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:50:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:53160 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBMPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:50:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 07:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126168330"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.68.82]) ([10.252.68.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 07:49:59 -0800
Subject: Re: [PATCH v2 00/10] ICL support and other enhancements for PMC Core
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <63bb8cc7-4feb-f69c-33be-ba5308c441d1@linux.intel.com>
Date:   Wed, 13 Feb 2019 21:19:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Feb-19 9:03 PM, Andy Shevchenko wrote:
> On Wed, Feb 13, 2019 at 5:08 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> This patch series provides Icelake support for PMC Core driver and while
>> doing so it introduces the Icelake Mobile to intel-family.h as per the
>> CPUID from below Coreboot link
>> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
>> and provides some fixes and enhancements to the driver.
> It's not applicable to my tree.

Hi Andy,  I could apply and test in on latest upstream so i think its 
probably because you have applied 5 patches from v1 on your tree. 
https://github.com/dvhart/linux-pdx86/commits/for-next

I sent the whole series again since 
https://patchwork.kernel.org/patch/10791893 referred to a wrong commit 
for Fixes:. If you want to address that by rebasing then can you please 
just consider patches 6-10.

Please let me know if there is any other issue?

>> Changes in v2:
>>   * Addressed review comments from Thomas
>>   * Added tags revieved
>>   * Folded in SHA1 suggestions from Stephen Rothwell, though Andy might want to
>>     fix it via rebasing
>>   * Rebased and tested with Linux v5.0.0-rc6
>>
>> This series:
>>   - Adds ICL U/Y CPUID to intel-family.h
>>   - Enables PMC driver for ICL
>>   - Introduces a new "package cstate show" feature
>>   - Fixes a customer issue related to S0ix on latest HP laptops
>>   - Fixes some minor bugs
>>
>> Rajneesh Bhardwaj (10):
>>    platform/x86: intel_pmc_core: Handle CFL regmap properly
>>    platform/x86: intel_pmc_core: Fix PCH IP sts reading
>>    platform/x86: intel_pmc_core: Fix PCH IP name
>>    platform/x86: intel_pmc_core: Fix file permissions for ltr_show
>>    platform/x86: intel_pmc_core: Include Reserved IP for LTR
>>    x86/cpu: Add Icelake to Intel family
>>    platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
>>    platform/x86: intel_pmc_core: Add ICL platform support
>>    platform/x86: intel_pmc_core: Add Package cstates residency info
>>    platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
>>
>>   arch/x86/include/asm/intel-family.h   |   2 +
>>   drivers/platform/x86/intel_pmc_core.c | 155 +++++++++++++++++++++-----
>>   drivers/platform/x86/intel_pmc_core.h |  14 ++-
>>   3 files changed, 145 insertions(+), 26 deletions(-)
>>
>> --
>> 2.17.1
>>
>
