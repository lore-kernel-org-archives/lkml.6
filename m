Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C871F60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFFLPd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:15:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750864AbeFFLPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:15:32 -0400
Date: Wed, 06 Jun 2018 20:15:29 +0900 (JST)
Message-Id: <20180606.201529.867663362891798169.yamato@redhat.com>
To: tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH] x86/iommu: Fix a typo in a macro parameter
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <alpine.DEB.2.21.1806061235330.1579@nanos.tec.linutronix.de>
References: <20180606051026.29535-1-yamato@redhat.com>
        <alpine.DEB.2.21.1806061235330.1579@nanos.tec.linutronix.de>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 12:37:34 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Jun 2018, Masatake YAMATO wrote:
> 
> Can you please explain why 0 is the wrong value.

I don't know such constants, 0 and 1.

What I change is just the name of macro parameter as 

     s/detect/_detect/

I don't change the definition of macro.

Masatake YAMATO

> That's not a typo, that's
> a functional change and both the subject line and the changelog itself
> should be explanatory.
> 
> Thanks,
> 
> 	tglx
> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>  arch/x86/include/asm/iommu_table.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
>> index 1fb3fd1a83c2..2a0d5f7d1ed1 100644
>> --- a/arch/x86/include/asm/iommu_table.h
>> +++ b/arch/x86/include/asm/iommu_table.h
>> @@ -66,7 +66,7 @@ struct iommu_table_entry {
>>  #define IOMMU_INIT_POST(_detect)					\
>>  	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 0)
>>  
>> -#define IOMMU_INIT_POST_FINISH(detect)					\
>> +#define IOMMU_INIT_POST_FINISH(_detect)					\
>>  	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 1)
>>  
>>  /*
>> -- 
>> 2.17.0
>> 
>> 
