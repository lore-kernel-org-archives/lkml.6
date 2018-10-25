Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5664C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8724E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8724E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJZHZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:25:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34908 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJZHZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:25:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PMoYWr024096;
        Thu, 25 Oct 2018 17:50:34 -0500
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PMoYgk077514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 17:50:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 17:50:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 17:50:34 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PMoXWb025307;
        Thu, 25 Oct 2018 17:50:33 -0500
Subject: Re: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
To:     Loic PALLARDY <loic.pallardy@st.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-3-git-send-email-loic.pallardy@st.com>
 <91e489e7-86c3-6ee3-918d-151ef1697429@ti.com>
 <68acbbf905384f6c80b646330a3d1344@SFHDAG7NODE2.st.com>
 <8f19b68f-10f5-b21f-9143-eadb0103999b@ti.com>
 <ba92141e939f47699ebf7181fda51a85@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f526d2f4-9e38-afc0-7adf-fc465aea612d@ti.com>
Date:   Thu, 25 Oct 2018 17:50:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ba92141e939f47699ebf7181fda51a85@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 7:58 AM, Loic PALLARDY wrote:
> 
> 
>> -----Original Message-----
>> From: Suman Anna <s-anna@ti.com>
>> Sent: mercredi 24 octobre 2018 05:19
>> To: Loic PALLARDY <loic.pallardy@st.com>; bjorn.andersson@linaro.org;
>> ohad@wizery.com
>> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>> benjamin.gaignard@linaro.org
>> Subject: Re: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
>>
>> On 10/23/18 2:51 PM, Loic PALLARDY wrote:
>>> Hi Suman,
>>>
>>>> -----Original Message-----
>>>> From: Suman Anna <s-anna@ti.com>
>>>> Sent: mardi 23 octobre 2018 18:51
>>>> To: Loic PALLARDY <loic.pallardy@st.com>; bjorn.andersson@linaro.org;
>>>> ohad@wizery.com
>>>> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>>>> benjamin.gaignard@linaro.org
>>>> Subject: Re: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
>>>>
>>>> Hi Loic, Bjorn,
>>>>
>>>> On 7/27/18 8:14 AM, Loic Pallardy wrote:
>>>>> This new function translates CPU virtual address in
>>>>> CPU physical one according to virtual address location.
>>>>>
>>>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>>>> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>> ---
>>>>>  drivers/remoteproc/remoteproc_core.c | 18 +++++++++++++++++-
>>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>> index 437fabf..8e5fe1e 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -140,6 +140,22 @@ static void rproc_disable_iommu(struct rproc
>>>> *rproc)
>>>>>  	iommu_domain_free(domain);
>>>>>  }
>>>>>
>>>>> +static phys_addr_t rproc_va_to_pa(void *cpu_addr)
>>>>> +{
>>>>> +	/*
>>>>> +	 * Return physical address according to virtual address location
>>>>> +	 * - in vmalloc: if region ioremapped or defined as
>>>> dma_alloc_coherent
>>>>> +	 * - in kernel: if region allocated in generic dma memory pool
>>>>> +	 */
>>>>> +	if (is_vmalloc_addr(cpu_addr)) {
>>>>> +		return page_to_phys(vmalloc_to_page(cpu_addr)) +
>>>>> +				    offset_in_page(cpu_addr);
>>>>> +	}
>>>>> +
>>>>> +	WARN_ON(!virt_addr_valid(cpu_addr));
>>>>> +	return virt_to_phys(cpu_addr);
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc
>>>> address
>>>>>   * @rproc: handle of a remote processor
>>>>> @@ -711,7 +727,7 @@ static int rproc_handle_carveout(struct rproc
>>>> *rproc,
>>>>>  	 * In this case, the device address and the physical address
>>>>>  	 * are the same.
>>>>>  	 */
>>>>> -	rsc->pa = dma;
>>>>> +	rsc->pa = (u32)rproc_va_to_pa(va);
>>>>
>>>> While I agree with the direction here, we ought to add a check here
>>>> warning users if some address bits are getting lost as a result of the
>>>> typecast. Granted the issue may have been present previously with
>>>> dma_addr_t as well, but most platforms were using 32-bit dma addresses,
>>>> so this was kinda masked. There are ARMv7 platforms with LPAE enabled
>>>> allowing physical addresses > 32-bits.
>>>>
>>>> In anycase, we definitely have a need for a v2 for the fw_rsc_carveout
>>>> structure to deal with 64-bit addresses.
>>>>
>>>
>>> Agree with you.
>>> Assumption for this series was to keep resource table as it is. Resource
>> table improvement is planned in a second step.
>>
>> Perhaps, we should add a WARN_ON for the time being until we enhance
>> the
>> resource table for 64-bit platforms/addresses.
> 
> OK I will propose a patch to add WARN_ON on cast applied on resource table field

Yes, thanks.

regards
Suman

> Regards,
> Loic
>>
>> regards
>> Suman
>>
>>> Regards,
>>> Loic
>>>
>>>> regards
>>>> Suman
>>>>
>>>>>
>>>>>  	carveout->va = va;
>>>>>  	carveout->len = rsc->len;
>>>>>
>>>
> 

