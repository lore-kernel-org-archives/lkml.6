Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeENVAL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:00:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeENVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:00:09 -0400
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <938d5a51-0aa8-0d28-84e3-ce007e73c173@infradead.org>
Date: Mon, 14 May 2018 14:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 01:00 PM, Gary R Hook wrote:
> On 05/14/2018 12:50 PM, Randy Dunlap wrote:
>> On 05/14/2018 10:20 AM, Gary R Hook wrote:
>>> Implement a skeleton framework for debugfs support in the
>>> AMD IOMMU.
>>>
>>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>>> ---
>>>   drivers/iommu/Makefile            |    5 +++++
>>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>>   drivers/iommu/amd_iommu_types.h   |    3 +++
>>>   5 files changed, 57 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>>
>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>> index 74cfbc392862..dd980f7dd8b6 100644
>>> --- a/drivers/iommu/Makefile
>>> +++ b/drivers/iommu/Makefile
>>> @@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>>>   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>>> +
>>> +# This ensures that only the required files are compiled
>>> +ifeq ($(CONFIG_IOMMU_DEBUGFS), y)
>>
>> Most Makefiles don't use a space before the 'y', but since you tested it,
>> I guess either way works.
> 
> Pretty sure whitespace isn't used as a delimiter in this construct. I could be mistaken. But yes, it's perfectly serviceable.
> 
>> But why do this in the Makefile at all?  Why not just add another Kconfig
>> symbol and simplify the Makefile?
>>
>>> +obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
>>> +endif
> 
> 
> This was brought up a few weeks ago in, I believe, version 3 of this patch. That question was discussed (because that's what I did the first time out), and _someone_ _else_ asked about why I didn't just do it the way I've done it here.

Sorry I missed it.  I would have been glad to chime in at that time.

> Everyone has a preference.
> 
> I chose to simplify the choices and avoid multiple symbols, instead opting for two switches: choose your device, and decide on Debug FS enablement for it. IMO Very simple.
> 
> I can't fathom a scenario where this wouldn't work. Is there one?

Probably not.

But we used to have ugly, messy, convoluted makefiles with very little config help.
Then we got better kconfig tools (well, arguably :) and then the makefiles were
cleaned up and simplified a lot (or A LOT!).  We shouldn't want to go back there.

-- 
~Randy
