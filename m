Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44276C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CB4222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LAGy2OmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405489AbfBNDgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:36:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43006 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBNDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:36:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E3ZneI096601;
        Wed, 13 Feb 2019 21:35:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550115349;
        bh=/sYTOaQQtRjSep9pG9qPit4KzEEkrH8t9kP2VLqnOAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LAGy2OmT1QEHlnWU9NVKyROSXGAOJAClpPp9e5BXKzS8tBQapAkLC17kUpU/ZuQOd
         AyTGMr0gf+Ur1FySaH2oLwICWlIEnTWPyjUG2syFKvsjqria6w6dCSZLVVciDGJxuU
         jgKh5CIGIZtwWKhZGsFrWBeU8cyuKtM/HlT4Eeik=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E3Zn5v112890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 21:35:49 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 21:35:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 21:35:49 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E3ZmGI029771;
        Wed, 13 Feb 2019 21:35:48 -0600
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
To:     Roger Quadros <rogerq@ti.com>,
        David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
 <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
 <5BFFBFA0.9000104@ti.com>
 <ec83108c-1748-cec4-bebf-119d261fb229@lechnology.com>
 <5C065107.8080600@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <09c30d72-9d1c-9c96-a1ef-8d30fc8c5bfa@ti.com>
Date:   Wed, 13 Feb 2019 21:35:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C065107.8080600@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 12/4/18 4:03 AM, Roger Quadros wrote:
> On 29/11/18 18:12, David Lechner wrote:
>> On 11/29/18 4:29 AM, Roger Quadros wrote:
>>> Bjorn, Suman,
>>>
>>> On 26/11/18 23:29, David Lechner wrote:
>>>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>>>> From: Suman Anna <s-anna@ti.com>
>>>>>
>>>>> The rproc_da_to_va() API is currently used to perform any device
>>>>> to kernel address translations to meet the different needs of the
>>>>> remoteproc core/platform drivers (eg: loading). The function also
>>>>> invokes the da_to_va ops, if present, to allow the remoteproc
>>>>> platform drivers to provide address translation. However, not all
>>>>> platform implementations have linear address spaces, and may need
>>>>> an additional parameter to be able to perform proper translations.
>>>>>
>>>>> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
>>>>> been expanded to take in an additional flags field enabling some
>>>>> remoteproc implementations (like the TI PRUSS remoteproc driver)
>>>>> to use these flags. Also, define some semantics for this flags
>>>>> argument as this can vary from one implementation to another. A
>>>>> new flags type is encoded into the upper 16 bits along side the
>>>>> actual value in the lower 16-bits for the flags argument, to
>>>>> allow different individual implementations to have better
>>>>> flexibility in interpreting the flags as per their needs.
>>>>
>>>> This seems like an overly complex solution for a rather simple
>>>> problem. Instead of passing all sorts of flags, could we just add
>>>> a parameter named "page" to da_to_va() that indicates the memory
>>>> page of the address in the remote processor?
>>>>
>>>> Or perhaps there is some other use for all of these flags that I
>>>> am not aware of?
>>>
>>> I'm not a big fan of this patch either.
>>>
>>> rproc_da_to_va() is used at the following places
>>>
>>> 2 qcom_q6v5_mss.c         qcom_q6v5_dump_segment           974 void *ptr = rproc_da_to_va(rproc, segment->da, segment->size,
>>> 3 remoteproc_core.c       rproc_da_to_va                   197 void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
>>> 4 remoteproc_core.c       rproc_handle_trace               582 ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, RPROC_FLAGS_NONE);
>>> 5 remoteproc_core.c       rproc_coredump                  1592 ptr = rproc_da_to_va(rproc, segment->da, segment->size,
>>> 6 remoteproc_elf_loader.c rproc_elf_load_segments          185 ptr = rproc_da_to_va(rproc, da, memsz,
>>> 7 remoteproc_elf_loader.c rproc_elf_find_loaded_rsc_table  337 return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size,
>>>
>>> At rproc_elf_load_segments() we need to pass enough information so that
>>> the rproc driver can load the segment into proper area (IRAM vs DRAM).
>>> So providing page should suffice.
>>
>> FYI, the PRU series I sent a while back has some patches to do
>> something like this so feel free to use them if they are helpful.
>>
>> https://lore.kernel.org/lkml/20180623210810.21232-2-david@lechnology.com/
>> https://lore.kernel.org/lkml/20180623210810.21232-3-david@lechnology.com/
>>
> 
> Thanks. I think we need to do something like that. Too bad you had to reverse engineer
> the TI specific headers. I'll check if we have this available somewhere internally.

I commented on this in your v2 series, but let's see if we can
incorporate some of this custom logic within the PRU remoteproc driver
else. The remoteproc core does allow you to use your own implementations
for some firmware related ops.

> 
>>>
>>> I want to understand more about rproc_elf_find_loaded_rsc_table() myself.
>>> rproc_elf_find_loaded_rsc_table() is called only in rproc_start() in remoteproc_core.c
>>> with the comment
>>>
>>>          /*
>>>           * The starting device has been given the rproc->cached_table as the
>>>           * resource table. The address of the vring along with the other
>>>           * allocated resources (carveouts etc) is stored in cached_table.
>>>           * In order to pass this information to the remote device we must copy
>>>           * this information to device memory. We also update the table_ptr so
>>>           * that any subsequent changes will be applied to the loaded version.
>>>           */
>>>          loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
>>>
>>> Why isn't cached_table sufficient?
>>> Why do we need to call rproc_find_loaded_rsc_table()?
>>>
>>> why do we need to load the resource table into remote processor memory at all.
>>> As discussed earlier, some PRU systems have very little memory (512 bytes?)
>>> and we want to avoid unnecessary loading.
>>>
> 
> This question still holds.
> Suman?

The resource table is used for publishing back various allocated
resource values to the remote processor, so this needs to be loaded into
memory. For example, with RSC_CARVEOUTs, we fill in the address Linux
kernel allocated. With VDEVs, the virtio config status is shared and
used for synchronization between the Linux host and the remote processor.

regards
Suman

