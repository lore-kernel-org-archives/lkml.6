Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34425C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E892086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhqWPaD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E892086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeINGiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:38:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42328 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeINGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:38:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so3563401pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 18:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oInL0NSyM+tLRjeuoJ4JTD8ChMfRpJqEciSz64mYETc=;
        b=XhqWPaD4x3MR2UIrvYac0H3mjpEzLUQ2fG2wpqoyoDL3NCEhVErHWCKvOuXvySbT6/
         AVl+/hznIIVHhtPYVuRkGwicPGX7KxgzA8kzfN+BqyrMIOA0hq6e1DIubcZVzZkut9Hw
         EqXj1gd7V9CqLaHqqK6p3JECn43zLn4fpKH4Mk0aLc26g2CXMst52A2XiXPxiha3+W56
         K9HQGTRMtdoMtpk94j/lJXPhdDv6HAnBQvw65OQ6XjPLB8EvP3Bq7m8jGHiKrU5DsbSv
         x97tXA70ST/m0Tx4iPXUCHjGsnWPnSWa6YU8YTzhFcGDCyw20b3DcV45Ckc6cfg9BizA
         7GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oInL0NSyM+tLRjeuoJ4JTD8ChMfRpJqEciSz64mYETc=;
        b=me7po8eh2eSOqqX3tFs14ys+lDJtbbB/BceS+iMB2H2mdkspDoe0zgGcAfDpfLQOKC
         BHyHpoI7dTD89XeqMWu1UYePK2Y4eKO1f/hs8XGUEHPF1MSNs4QAV7ZLLpWkcxnMAhfU
         FMyx67Ui1jOZRxIfZXWsijh7E3QkwxQLPEnL4hC4/XFUsbpfyr3/+p6QXQiBiPkNDZCO
         HtXsKuBFLeAAdFJ2K4QyFucy45TgUqu3sccC33rEhSTWxc5Tk7utoAOUWqKB1KhGdkiW
         Kvk9XsAwmlZ8/mkmS+P2VW9efCGY1lMOKUrcRDN+UlAwrO/6Uu1k6uEIHxCtgR/jw5rh
         XmXw==
X-Gm-Message-State: APzg51ASXRxEem0+KsuqPIINWhW4F/uGVgAdMHpCgpPvjb/cd+OiwWVR
        49SC695SBPO3VtkSFm0Ete4=
X-Google-Smtp-Source: ANB0VdbdCrsttvVXcNbClNd/Zf9fosDFeyiQrPl6hQjkzPFckg4vn1qEIt2i6beHNnz9p0B5eXJx2g==
X-Received: by 2002:a63:cd02:: with SMTP id i2-v6mr9069363pgg.93.1536888367622;
        Thu, 13 Sep 2018 18:26:07 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8404885pfn.123.2018.09.13.18.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 18:26:06 -0700 (PDT)
Subject: Re: [PATCH v14 06/16] of/fdt: add helper functions for handling
 properties
From:   Frank Rowand <frowand.list@gmail.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
 <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
Message-ID: <8403dfd5-3188-219b-966c-72b009f94e0f@gmail.com>
Date:   Thu, 13 Sep 2018 18:26:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was re-reading this while answering a later email in the thread.  After reading
other patches in the series that were not sent to me, I have a better understanding
of the intent behind this patch, and some changes to my previous reply.

The intent of the helper functions is related to properties whose values are
tuples of the same format as the "reg" property of the "/memory" nodes.  For
example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
the "/chosen" node.

The patch header and the function names should be updated to reflect this intent.
This means most or all of my previous suggested function name changes are no longer
useful.

Please add devicetree@vger.kernel.org to the next version of this patch and to
the patches that use the functions in this patch.


On 09/07/18 12:53, Frank Rowand wrote:
> On 09/07/18 01:00, AKASHI Takahiro wrote:
>> These functions will be used later to handle kexec-specific properties
>> in arm64's kexec_file implementation.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> ---
>>  drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/of_fdt.h | 10 +++++--
>>  2 files changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 800ad252cf9c..dc960cea1355 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/debugfs.h>
>>  #include <linux/serial_core.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/types.h>
>>  
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #include <asm/page.h>
>> @@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>  
>>  /* Everything below here references initial_boot_params directly. */
>> -int __initdata dt_root_addr_cells;
>> -int __initdata dt_root_size_cells;
>> +int dt_root_addr_cells;
>> +int dt_root_size_cells;
>>  
>>  void *initial_boot_params;
>>  
>> @@ -1323,3 +1324,60 @@ late_initcall(of_fdt_raw_init);
>>  #endif
>>  
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>> +

Global comment: this code should not be using the variables
dt_root_addr_cells and dt_root_size_cells.  These variables are
__initdata.

The code that is using these helpers is acting upon a specific FDT
(copied from initial_boot_params).  This code should be getting the
values of the root node's "#address-cells" and "#size-cells" from
the FDT.


> Please add comment:
> 
> /* helper functions for arm64 kexec */
> 
> 
>> +bool of_fdt_cells_size_fitted(u64 base, u64 size)
> 
> Please rename as of_fdt_range_valid()

I'm not entirely sure of what the caller in 12/16 is trying to ensure
with this function.

(1) At the minimum (and what the implementation in of_fdt_cells_size_fitted()
does) is make sure that an address and size tuple are consistent with
the root properties "#address-cells" and "#size-cells".

The caller in 12/16 is using this check to validate values for the
properties  "linux,elfcorehdr" and "linux,usable-memory-range".

(2) A more complete check _might_ be to ensure that the values also
specify memory that is available to the kernel.  This memory is described
by the "reg" property of one or more "/memory" nodes.

This second check is probably what is actually desired.

One possible issue to note is that the binding for "linux,usable-memory-range"
suggests that available memory could be described by an EFI memory map.
I am not familiar with how or when an EFI memory map might exist instead
of the "/memory" nodes.


>> +{
>> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
>> +	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
>> +		return false;
>> +
>> +	if ((dt_root_size_cells == 1) && (size > U32_MAX))
>> +		return false;
> 
> Should also check that base + size does not wrap around.
> 
> 
>> +
>> +	return true;
>> +}
>> +
>> +size_t of_fdt_reg_cells_size(void)
> 
> Please rename as of_fdt_root_range_size()

Even better would be to remove this function and replace the one place
that it is called from with the one line of code in this function.

-Frank


>> +{
>> +	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
>> +}
>> +
>> +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
>> +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
>> +
>> +int fdt_prop_len(const char *prop_name, int len)
> 
> Please rename as fdt_len_added_prop()
> 
> 
>> +{
>> +	return (strlen(prop_name) + 1) +
>> +		sizeof(struct fdt_property) +
>> +		FDT_TAGALIGN(len);
>> +}
>> +
> 
> Please add comment, something like:
> 
> /* cells must be 1 or 2 */
> 
> 
>> +static void fill_property(void *buf, u64 val64, int cells)
> 
> Please rename as cpu64_to_fdt_cells()
> 
> Thanks,
> 
> Frank
> 
>> +{
>> +	__be32 val32;
>> +
>> +	while (cells) {
>> +		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
>> +		memcpy(buf, &val32, sizeof(val32));
>> +		buf += sizeof(val32);
>> +	}
>> +}
>> +
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +						u64 addr, u64 size)
>> +{
>> +	char buf[sizeof(__be32) * 2 * 2];
>> +		/* assume dt_root_[addr|size]_cells <= 2 */
>> +	void *prop;
>> +	size_t buf_size;
>> +
>> +	buf_size = of_fdt_reg_cells_size();
>> +	prop = buf;
>> +
>> +	fill_property(prop, addr, dt_root_addr_cells);
>> +	prop += dt_root_addr_cells * sizeof(u32);
>> +
>> +	fill_property(prop, size, dt_root_size_cells);
>> +
>> +	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
>> +}
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index b9cd9ebdf9b9..9615d6142578 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>>  				   struct device_node **mynodes);
>>  
>>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
>> -extern int __initdata dt_root_addr_cells;
>> -extern int __initdata dt_root_size_cells;
>> +extern int dt_root_addr_cells;
>> +extern int dt_root_size_cells;
>>  extern void *initial_boot_params;
>>  
>>  extern char __dtb_start[];
>> @@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>  
>> +bool of_fdt_cells_size_fitted(u64 base, u64 size);
>> +size_t of_fdt_reg_cells_size(void);
>> +int fdt_prop_len(const char *prop_name, int len);
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +						u64 addr, u64 size);
>> +
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* _LINUX_OF_FDT_H */
>>
> 
> 

