Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AEAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4E2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfBESPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:15:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:30235 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfBESN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:13:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 10:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="317869081"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.67]) ([10.252.74.67])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2019 10:13:55 -0800
Subject: Re: [PATCH 00/10] ICL support and other enhancements for PMC Core
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VeFBnQzv4dacZ0GPUwPYUmzFJvLC1qwVy8DqkST=b=hgw@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <d603593e-cba6-0df4-5f8d-8465be5c9456@linux.intel.com>
Date:   Tue, 5 Feb 2019 23:43:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeFBnQzv4dacZ0GPUwPYUmzFJvLC1qwVy8DqkST=b=hgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Feb-19 11:36 PM, Andy Shevchenko wrote:
> On Fri, Feb 1, 2019 at 9:32 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> This patch series provides Icelake support for PMC Core driver and while
>> doing so it introduces the Icelake Mobile to intel-family.h as per the
>> CPUID from below Coreboot link
>> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
>> and provides some fixes and enhancements to the driver.
>>
> I have applied first 5 patches (fixes) to my review and testing queue, thanks!
Thank you Andy :)
>
> I'll wait for the next version next week, based on what would be
> promoted to our for-next branch and addressed comments from reviewers.
Fine, I'll look forward to submit remaining patches after addressing all 
received feedback thus far, next week.
>
>> This series:
>>   -adds ICL U/Y CPUID to intel-family.h
>>   -enable PMC driver for ICL.
>>   -introduce a new "package cstate show" feature
>>   -fixes a customer issue related to S0ix on latest HP laptops.
>>   -fixes some minor bugs
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
