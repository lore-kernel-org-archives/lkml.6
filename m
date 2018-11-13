Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6322419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmzcFMMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F6322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbeKNC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:57:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35500 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeKNC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:57:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so11991154otj.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNzXSfoK1sML3OwVXkTovAbcUbqJPVckvuVET53jicI=;
        b=OmzcFMMTczkNvBzNH6VOgxT7Ti1dbym24Vy37hrpB1QvImzzIR6643cbIXR/7IdJRi
         M3KTS4xSIhsCh7jjO5k8zZ+0pU3aMYA5HCkgZY0uvJ22BevHbcjFMGzeCeYkc7OF/M5D
         I54QAjF1J34b+C+HnTA0JUZlIrEUwUEB9xSPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNzXSfoK1sML3OwVXkTovAbcUbqJPVckvuVET53jicI=;
        b=G7jGzIrvClWJbl69eZOT+w8G6yxWJjOLI5V8FRbvlFHhYdtkY1Nb0P+LXiFNieQUL0
         XeUs50UTDE63zwrRJzpo9qe+FPmCKB/J+fL3Op98ZyycQyyIE/mywhEsVBsIVkhrZS11
         NwH8skzMFNUphVbAfd86FKUomvR91AcnUSO3UzvadfSe/sGjz8+ZiGQ8t8p5ytyNR7He
         631NQQy0/2TYA+tb2i5frOxqcYWnTy3EWFib8zrLte2Nlgv2htbKOd9T4xyIUcSQEKp4
         4bZsaG7iJiPoupyy2GROqXkk+wiZypx9HvCNZKQuKQLVubZT0fQf/jI9wltc2qSL4JNj
         cg7Q==
X-Gm-Message-State: AGRZ1gIHGtSn0qh4TR5TId7QOiX6x8vrEI8oe88LxGlz2ek3fBUBnd1L
        HX73xldk16JPL5WNzFbe+TP/kg==
X-Google-Smtp-Source: AJdET5fWOqaAKIpOOOqf6zekB2UzxTtF28xbJIONV8740euFdTFWoFlhg1SXNxcuKolunlQtIJIn2g==
X-Received: by 2002:a9d:7097:: with SMTP id l23mr3419736otj.49.1542128285147;
        Tue, 13 Nov 2018 08:58:05 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 82-v6sm8587994oid.36.2018.11.13.08.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:58:04 -0800 (PST)
Subject: Re: [RFC PATCH 04/12] soc: qcom: ipa: immediate commands
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-5-elder@linaro.org>
 <CAK8P3a3iKshE3yCG477AeZbKbLtpDwMhn5mfLySFRLOLmUv5AQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <dbaf1c86-ab9d-fa90-6718-998f1f1b6dd3@linaro.org>
Date:   Tue, 13 Nov 2018 10:58:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3iKshE3yCG477AeZbKbLtpDwMhn5mfLySFRLOLmUv5AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:36 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> +/**
>> + * struct ipahal_context - HAL global context data
>> + * @empty_fltrt_tbl:   Empty table to be used for table initialization
>> + */
>> +static struct ipahal_context {
>> +       struct ipa_dma_mem empty_fltrt_tbl;
>> +} ipahal_ctx_struct;
>> +static struct ipahal_context *ipahal_ctx = &ipahal_ctx_struct;
> 
> Remove the global variables here

Not done yet, but I will do this.  I've been working on eliminating
the top-level "ipa_ctx" global (which is *very* pervasive) and in
the process I'm eliminating all the others as well.  I'll get to
this soon.

>> +/* Immediate commands H/W structures */
>> +
>> +/* struct ipa_imm_cmd_hw_ip_fltrt_init - IP_V*_FILTER_INIT/IP_V*_ROUTING_INIT
>> + * command payload in H/W format.
>> + * Inits IPv4/v6 routing or filter block.
>> + * @hash_rules_addr: Addr in system mem where hashable flt/rt rules starts
>> + * @hash_rules_size: Size in bytes of the hashable tbl to cpy to local mem
>> + * @hash_local_addr: Addr in shared mem where hashable flt/rt tbl should
>> + *  be copied to
>> + * @nhash_rules_size: Size in bytes of the non-hashable tbl to cpy to local mem
>> + * @nhash_local_addr: Addr in shared mem where non-hashable flt/rt tbl should
>> + *  be copied to
>> + * @rsvd: reserved
>> + * @nhash_rules_addr: Addr in sys mem where non-hashable flt/rt tbl starts
>> + */
>> +struct ipa_imm_cmd_hw_ip_fltrt_init {
>> +       u64 hash_rules_addr;
>> +       u64 hash_rules_size     : 12,
>> +           hash_local_addr     : 16,
>> +           nhash_rules_size    : 12,
>> +           nhash_local_addr    : 16,
>> +           rsvd                : 8;
>> +       u64 nhash_rules_addr;
>> +};
> 
> In hardware structures, you should not use bit fields, as the ordering
> of the bits is not well-defined in C. The only portable way to do this
> is to use shifts and masks unfortunately.

This is something I held off fixing because I have seen other use
of bit fields in the kernel.  I wasn't sure whether my instinct about
it (which matches what you say) was wrong, and didn't want to do the
work to change things over to masks without knowing.  Based on your
suggestion, I will proceed with this conversion.

>> +struct ipa_imm_cmd_hw_hdr_init_local {
>> +       u64 hdr_table_addr;
>> +       u32 size_hdr_table      : 12,
>> +           hdr_addr            : 16,
>> +           rsvd                : 4;
>> +};
> 
> I would also add a 'u32 pad' member at the end to make the padding
> explicit here, or mark the first member as '__aligned(4) __packed'
> if you want to avoid the padding.

Yes, this is a good suggestion, and I will implement it.

You're right that the actual size of this structure includes the
extra 4 byte pad.  But I'm not actually sure whether the hardware
touches it because the size of immediate commands is implied by
the opcode.  To be safe, I'll make the pad explicit; but if I
learn it's not needed I'll define it to be packed.

>> +void *ipahal_dma_shared_mem_write_pyld(struct ipa_dma_mem *mem, u32 offset)
>> +{
>> +       struct ipa_imm_cmd_hw_dma_shared_mem *data;
>> +
>> +       ipa_assert(mem->size < 1 << 16);        /* size is 16 bits wide */
>> +       ipa_assert(offset < 1 << 16);           /* local_addr is 16 bits wide */
>> +
>> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return NULL;
>> +
>> +       data->size = mem->size;
>> +       data->local_addr = offset;
>> +       data->direction = 0;    /* 0 = write to IPA; 1 = read from IPA */
>> +       data->skip_pipeline_clear = 0;
>> +       data->pipeline_clear_options = IPAHAL_HPS_CLEAR;
>> +       data->system_addr = mem->phys;
>> +
>> +       return data;
>> +}
> 
> The 'void *' return looks odd here, and also the dynamic allocation.

It was done because it allows the definition of the data structure
to be hidden within this file.

> It looks to me like all these functions could be better done the
> other way round, basically putting the
> ipa_imm_cmd_hw_dma_shared_mem etc structures on the stack
> of the caller. At least for this one, the dynamic allocation
> doesn't help at all because the caller is the same that
> frees it again after the command. I suspect the same is
> true for a lot of those commands.

Yes, I see what you're saying.  In fact, now that I look, all of
these payload allocating functions except for one are used just
the way you describe (freed in the same function that uses it).
And the one is saved with the intention of avoiding an allocation
failure...  But I'll mention that this code was structured very
differently originally.

So I agree, putting them on the stack (given they're relatively
small--most 16 bytes one 24 bytes) is better.  And it seems I
can reduce some complexity by getting rid of that preallocated
command, which is a great outcome.

If I run into trouble implementing any of the above suggestions
I will circle back and explain.

Thanks a lot.

					-Alex

> 
>        Arnd
> 

