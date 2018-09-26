Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DF520684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoc5CMZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DF520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeIZOWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:22:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33428 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:22:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so9588950plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y/jETNbStI+fUQ3J68FJ+i0wF/lv2NmuwtnCLGJdTBE=;
        b=Yoc5CMZeS9WKsV+g/BR7YO8bsz5kXy2tq1xRI4L/7u0o7ZfixLxYj8RwIX5EAqAimj
         OqlQMtuoqEAsgcWeKaN6ID4U3Lugi/AZswZosJzOj9L0g/xM9MANBf2RRzZJQNYKuv37
         nGiZotqUcjYVXbLMxOMk/efCY/32OUTRpS9xdYyerMR7ow2IO93IKoHp1H1QXcojeiEe
         EZ5LSTiaA3P/e84IU6fmnp/PceRlK/X+/PwuvdFsdjjibAgeRJW0S7LijjjA2/Yfb49m
         SXGg8srHXeAPXky3mHF1H0J9mK/XC/NfJYKu63XK9o9e1Trwu0m0K1vmefYc5pWnT7l2
         YZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y/jETNbStI+fUQ3J68FJ+i0wF/lv2NmuwtnCLGJdTBE=;
        b=QR2W8/Ho1XW/anpiz1v/pdxLgzHORPmLXPpkHbmA1VXef1rkFzsXE87lSIPLpEdGsZ
         Rqt6T6Cc9DwnkV99509jDrQfGIm6/FvKuktujWZcxY50E6G9TXaY2JDPRLCOrNNG8sBO
         PZLSzZZbzE3cId2hY9phUKCIpCRmCU9ms9RHR8jLWNZglhlmg2OQtDqJIafB/hq0nePJ
         BQvcQdh5CU+rqO9cL1MP/IrMUM3QmxnjmkX37hRPjDHAGSG6pIP/8UEqRnXmgdQoOOaO
         CpJ9PSiX6bh/ubSW9xCYz5BOcBgEAI9mtQOESnydpaj3acWYYip9CcKJ4/6HU7mxl3H1
         j3Qg==
X-Gm-Message-State: ABuFfoiIRmoesmMZOYX+kQCwaKRrPabBOyL6qNcn9fUIqD7zEPH0K2zM
        BSsjvKgJ5qcCsChqs9FhZwA=
X-Google-Smtp-Source: ACcGV63lSnLUhxrow/5h3roM3i0IN8mjwTWCHnrVKI5slJ1tjQo+p+2m+qcgMlCiiPS9zPqNX0EFjA==
X-Received: by 2002:a17:902:b712:: with SMTP id d18-v6mr4985202pls.53.1537949434562;
        Wed, 26 Sep 2018 01:10:34 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n22-v6sm6476821pfi.185.2018.09.26.01.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:10:33 -0700 (PDT)
Subject: Re: [PATCH v14 06/16] of/fdt: add helper functions for handling
 properties
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
 <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
 <8403dfd5-3188-219b-966c-72b009f94e0f@gmail.com>
 <16a39f7f-a8cc-72a1-89a7-e9b49a4d6547@gmail.com>
 <20180926055704.GC27322@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8394773d-e614-3868-c725-f6825690a57e@gmail.com>
Date:   Wed, 26 Sep 2018 01:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926055704.GC27322@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09/25/18 22:57, AKASHI Takahiro wrote:
> Frank,
> 
> On Fri, Sep 14, 2018 at 10:19:38AM -0700, Frank Rowand wrote:
>> On 09/13/18 18:26, Frank Rowand wrote:
>>> I was re-reading this while answering a later email in the thread.  After reading
>>> other patches in the series that were not sent to me, I have a better understanding
>>> of the intent behind this patch, and some changes to my previous reply.
>>>
>>> The intent of the helper functions is related to properties whose values are
>>> tuples of the same format as the "reg" property of the "/memory" nodes.  For
>>> example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
>>> the "/chosen" node.
>>>
>>> The patch header and the function names should be updated to reflect this intent.
>>> This means most or all of my previous suggested function name changes are no longer
>>> useful.
>>>
>>> Please add devicetree@vger.kernel.org to the next version of this patch and to
>>> the patches that use the functions in this patch.
>>>
>>>
>>> On 09/07/18 12:53, Frank Rowand wrote:
>>>> On 09/07/18 01:00, AKASHI Takahiro wrote:
>>>>> These functions will be used later to handle kexec-specific properties
>>>>> in arm64's kexec_file implementation.
>>>>>
>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>>> ---
>>>>>  drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
>>>>>  include/linux/of_fdt.h | 10 +++++--
>>>>>  2 files changed, 68 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>>> index 800ad252cf9c..dc960cea1355 100644
>>>>> --- a/drivers/of/fdt.c
>>>>> +++ b/drivers/of/fdt.c
>>>>> @@ -25,6 +25,7 @@
>>>>>  #include <linux/debugfs.h>
>>>>>  #include <linux/serial_core.h>
>>>>>  #include <linux/sysfs.h>
>>>>> +#include <linux/types.h>
>>>>>  
>>>>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>>>>  #include <asm/page.h>
>>>>> @@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>>>>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>>>>  
>>>>>  /* Everything below here references initial_boot_params directly. */
>>>>> -int __initdata dt_root_addr_cells;
>>>>> -int __initdata dt_root_size_cells;
>>>>> +int dt_root_addr_cells;
>>>>> +int dt_root_size_cells;
>>>>>  
>>>>>  void *initial_boot_params;
>>>>>  
>>>>> @@ -1323,3 +1324,60 @@ late_initcall(of_fdt_raw_init);
>>>>>  #endif
>>>>>  
>>>>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>>>> +
>>>
>>> Global comment: this code should not be using the variables
>>> dt_root_addr_cells and dt_root_size_cells.  These variables are
>>> __initdata.
>>>
>>> The code that is using these helpers is acting upon a specific FDT
>>> (copied from initial_boot_params).  This code should be getting the
>>> values of the root node's "#address-cells" and "#size-cells" from
>>> the FDT.
>>


Can you confirm whether "[PATCH 3/3] scripts/dtc: ..." (see below) will
be in the v4.20 pull request?


>> There will be new functions available soon to return the values of
>> a node's "#address-cells" and "#size-cells" from an fdt.  They are
>> fdt_address_cells() and fdt_size_cells().
>>
>> Rob submitted the patch to add them yesterday in "[PATCH 3/3] scripts/dtc:
>> Update to upstream version v1.4.7-14-gc86da84d30e4" [1]
> 
> Will this patch go into mainline in v4.20 merge window?
> 
>>   [1] https://lkml.kernel.org/r/<20180913202828.15372-3-robh@kernel.org>
> 
> Unfortunately, fdt_addresses.c where fdt_address_cells() and
> fdt_size_cells() are defined is NOT compiled in the kernel.
> I will submit a patch.
> 
> -Takahiro Akashi
> 
> 
>> -Frank

Thanks,

Frank


>>
>>
>>>
>>>
>>>> Please add comment:
>>>>
>>>> /* helper functions for arm64 kexec */
>>>>
>>>>
>>>>> +bool of_fdt_cells_size_fitted(u64 base, u64 size)
>>>>
>>>> Please rename as of_fdt_range_valid()
>>>
>>> I'm not entirely sure of what the caller in 12/16 is trying to ensure
>>> with this function.
>>>
>>> (1) At the minimum (and what the implementation in of_fdt_cells_size_fitted()
>>> does) is make sure that an address and size tuple are consistent with
>>> the root properties "#address-cells" and "#size-cells".
>>>
>>> The caller in 12/16 is using this check to validate values for the
>>> properties  "linux,elfcorehdr" and "linux,usable-memory-range".
>>>
>>> (2) A more complete check _might_ be to ensure that the values also
>>> specify memory that is available to the kernel.  This memory is described
>>> by the "reg" property of one or more "/memory" nodes.
>>>
>>> This second check is probably what is actually desired.
>>>
>>> One possible issue to note is that the binding for "linux,usable-memory-range"
>>> suggests that available memory could be described by an EFI memory map.
>>> I am not familiar with how or when an EFI memory map might exist instead
>>> of the "/memory" nodes.
>>>
>>>
>>>>> +{
>>>>> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
>>>>> +	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
>>>>> +		return false;
>>>>> +
>>>>> +	if ((dt_root_size_cells == 1) && (size > U32_MAX))
>>>>> +		return false;
>>>>
>>>> Should also check that base + size does not wrap around.
>>>>
>>>>
>>>>> +
>>>>> +	return true;
>>>>> +}
>>>>> +
>>>>> +size_t of_fdt_reg_cells_size(void)
>>>>
>>>> Please rename as of_fdt_root_range_size()
>>>
>>> Even better would be to remove this function and replace the one place
>>> that it is called from with the one line of code in this function.
>>>
>>> -Frank
>>>
>>>
>>>>> +{
>>>>> +	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
>>>>> +}
>>>>> +
>>>>> +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
>>>>> +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
>>>>> +
>>>>> +int fdt_prop_len(const char *prop_name, int len)
>>>>
>>>> Please rename as fdt_len_added_prop()
>>>>
>>>>
>>>>> +{
>>>>> +	return (strlen(prop_name) + 1) +
>>>>> +		sizeof(struct fdt_property) +
>>>>> +		FDT_TAGALIGN(len);
>>>>> +}
>>>>> +
>>>>
>>>> Please add comment, something like:
>>>>
>>>> /* cells must be 1 or 2 */
>>>>
>>>>
>>>>> +static void fill_property(void *buf, u64 val64, int cells)
>>>>
>>>> Please rename as cpu64_to_fdt_cells()
>>>>
>>>> Thanks,
>>>>
>>>> Frank
>>>>
>>>>> +{
>>>>> +	__be32 val32;
>>>>> +
>>>>> +	while (cells) {
>>>>> +		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
>>>>> +		memcpy(buf, &val32, sizeof(val32));
>>>>> +		buf += sizeof(val32);
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>>>>> +						u64 addr, u64 size)
>>>>> +{
>>>>> +	char buf[sizeof(__be32) * 2 * 2];
>>>>> +		/* assume dt_root_[addr|size]_cells <= 2 */
>>>>> +	void *prop;
>>>>> +	size_t buf_size;
>>>>> +
>>>>> +	buf_size = of_fdt_reg_cells_size();
>>>>> +	prop = buf;
>>>>> +
>>>>> +	fill_property(prop, addr, dt_root_addr_cells);
>>>>> +	prop += dt_root_addr_cells * sizeof(u32);
>>>>> +
>>>>> +	fill_property(prop, size, dt_root_size_cells);
>>>>> +
>>>>> +	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
>>>>> +}
>>>>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>>>>> index b9cd9ebdf9b9..9615d6142578 100644
>>>>> --- a/include/linux/of_fdt.h
>>>>> +++ b/include/linux/of_fdt.h
>>>>> @@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>>>>>  				   struct device_node **mynodes);
>>>>>  
>>>>>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
>>>>> -extern int __initdata dt_root_addr_cells;
>>>>> -extern int __initdata dt_root_size_cells;
>>>>> +extern int dt_root_addr_cells;
>>>>> +extern int dt_root_size_cells;
>>>>>  extern void *initial_boot_params;
>>>>>  
>>>>>  extern char __dtb_start[];
>>>>> @@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
>>>>>  static inline void unflatten_and_copy_device_tree(void) {}
>>>>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>>>>  
>>>>> +bool of_fdt_cells_size_fitted(u64 base, u64 size);
>>>>> +size_t of_fdt_reg_cells_size(void);
>>>>> +int fdt_prop_len(const char *prop_name, int len);
>>>>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>>>>> +						u64 addr, u64 size);
>>>>> +
>>>>>  #endif /* __ASSEMBLY__ */
>>>>>  #endif /* _LINUX_OF_FDT_H */
>>>>>
>>>>
>>>>
>>>
>>>
>>
> 

