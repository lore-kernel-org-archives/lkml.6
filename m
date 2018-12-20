Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE641C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC79218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcExMQRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbeLTRq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:46:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41387 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbeLTRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:46:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so2331246ljc.8;
        Thu, 20 Dec 2018 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZ4YzqOHpFWUQ0/pEHtv3BikubPB9YIuouKUxeGNxjU=;
        b=KcExMQRCubA38XU0TFtFOUJr4xIBb3XdrLyip4uVnhMbBvO+VZ8g0jv0bf0PLPZdkz
         w3Ei41Ly5dBFRJJJpmylyWo9oDVhZdUSMb2QORGmX/fFszpPAwJFvEiXCBYreoyNNz8n
         8reY1Hh2O7bHQr0pxoWCVv0pjNo+XZ0x33QpVwKLYFrEerKy22HwGMvqXqXIJzNv9+tS
         KRVATpVS+MJYTlma/cyezaqsQK/AiSEcFC/cEpR0U4o4f+3XCD3WmJP84sUzHsct44bH
         THxhDe0BVtMwEfzzvltmR1HWvvbqxvcKFrBu9N0iLkr4VQ9Lohp+MODL6rOPeytgjc/L
         zpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ4YzqOHpFWUQ0/pEHtv3BikubPB9YIuouKUxeGNxjU=;
        b=jys39s3Q23U34lH3JEO39ybHwUs+8x94J3Oz33QPSd7UsAgG49LKaCQpUcJ79cvP/9
         CHlLFjU17QT9aKvGhn5gmjiSe5Zk7G3govnu9GgrpAbgwGCfgCcduEQ6ekBLZkKL/JIK
         uyafUPGIsEWxshpki5GwEPHUGS13sKFv93Eq2B2ySB4et7i4F0A1W6zMOV9VFTHoxpua
         VJ/4j8JkBHKi1x5C8EG3umey2GP3tFWwqn1KEuD1KFNnYzzmJ11IQK5ocP9U33lOPNum
         3BwzPiZGGLpqtQqaRz/+OwTSPGyKLD+7HAVkhto6asTwI0JlygRSNSzU9aObcXWvNnfA
         +dIw==
X-Gm-Message-State: AA+aEWbNY3WutKYdNL9DaRTDISfHOzo7z4zdyPkI7Ap0jZJ9fMcfdMF1
        cUdpGsJCuIR9hfP6O0MXqChmYPQyVOo=
X-Google-Smtp-Source: AFSGD/XQx/towY2jqYyqyNWePQFUqjXPcFtJAbZbjx2GTZvmk7Uw5B2Dfrb5qV923AOIXbjQUQA9rQ==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr17756247ljj.61.1545328012899;
        Thu, 20 Dec 2018 09:46:52 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id z7-v6sm4105645lji.42.2018.12.20.09.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:46:52 -0800 (PST)
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
 <87r2ecunc2.fsf@morokweng.localdomain>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <31a2fc9c-440b-ba09-b4b6-6ecacce63e01@gmail.com>
Date:   Thu, 20 Dec 2018 19:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87r2ecunc2.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/12/2018 19:20, Thiago Jung Bauermann wrote:
> 
> Hello Igor,
> 
>> +/*
>> + * The following two variables are statically allocated by the linker
>> + * script at the the boundaries of the memory region (rounded up to
>> + * multiples of PAGE_SIZE) reserved for __wr_after_init.
>> + */
>> +extern long __start_wr_after_init;
>> +extern long __end_wr_after_init;
>> +
>> +static inline bool is_wr_after_init(unsigned long ptr, __kernel_size_t size)
>> +{
>> +	unsigned long start = (unsigned long)&__start_wr_after_init;
>> +	unsigned long end = (unsigned long)&__end_wr_after_init;
>> +	unsigned long low = ptr;
>> +	unsigned long high = ptr + size;
>> +
>> +	return likely(start <= low && low <= high && high <= end);
>> +}
>> +
>> +void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
>> +	      enum wr_op_type op)
>> +{
>> +	temporary_mm_state_t prev;
>> +	unsigned long offset;
>> +	unsigned long wr_poking_addr;
>> +
>> +	/* Confirm that the writable mapping exists. */
>> +	if (WARN_ONCE(!wr_ready, "No writable mapping available"))
>> +		return (void *)dst;
>> +
>> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
>> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
>> +		return (void *)dst;
>> +
>> +	offset = dst - (unsigned long)&__start_wr_after_init;
>> +	wr_poking_addr = wr_poking_base + offset;
>> +	local_irq_disable();
>> +	prev = use_temporary_mm(wr_poking_mm);
>> +
>> +	if (op == WR_MEMCPY)
>> +		copy_to_user((void __user *)wr_poking_addr, (void *)src, len);
>> +	else if (op == WR_MEMSET)
>> +		memset_user((void __user *)wr_poking_addr, (u8)src, len);
>> +
>> +	unuse_temporary_mm(prev);
>> +	local_irq_enable();
>> +	return (void *)dst;
>> +}
> 
> There's a lot of casting back and forth between unsigned long and void *
> (also in the previous patch). Is there a reason for that?

The intention is to ensure that algebraic operations between addresses 
are performed as intended, rather than gcc operating some incorrect 
optimization, wrongly assuming that two addresses belong to the same object.

Said this, I can certainly have a further look at the code and see if I 
can reduce the amount of casts. I do not like them either.

But I'm not sure how much can be dropped: if I start from (void *), then 
I have to cast them to unsigned long for the math.

And the xxx_user() operations require a (void __user *).

> My impression
> is that there would be less casts if variables holding addresses were
> declared as void * in the first place. 

It might save 1 or 2 casts. I'll do the count.

> In that case, it wouldn't hurt to
> have an additional argument in __rw_op() to carry the byte value for the
> WR_MEMSET operation.

Wouldn't it clobber one more register? Or can gcc figure out that it's 
not used? __wr_op() is not inline.

>> +
>> +#define TB (1UL << 40)

^^^^^^^^^^^^^^^^^^^^^^^^^^spurious

>> +
>> +struct mm_struct *copy_init_mm(void);
>> +void __init wr_poking_init(void)
>> +{
>> +	unsigned long start = (unsigned long)&__start_wr_after_init;
>> +	unsigned long end = (unsigned long)&__end_wr_after_init;
>> +	unsigned long i;
>> +	unsigned long wr_range;
>> +
>> +	wr_poking_mm = copy_init_mm();
>> +	if (WARN_ONCE(!wr_poking_mm, "No alternate mapping available."))
>> +		return;
>> +
>> +	wr_range = round_up(end - start, PAGE_SIZE);
>> +
>> +	/* Randomize the poking address base*/
>> +	wr_poking_base = TASK_UNMAPPED_BASE +
>> +		(kaslr_get_random_long("Write Rare Poking") & PAGE_MASK) %
>> +		(TASK_SIZE - (TASK_UNMAPPED_BASE + wr_range));
>> +
>> +	/*
>> +	 * Place 64TB of kernel address space within 128TB of user address
>> +	 * space, at a random page aligned offset.
>> +	 */
>> +	wr_poking_base = (((unsigned long)kaslr_get_random_long("WR Poke")) &
>> +			  PAGE_MASK) % (64 * _BITUL(40));
> 
> You're setting wr_poking_base twice in a row? Is this an artifact from
> rebase?

Yes, the first is a leftover. Thanks for spotting it.

--
igor
