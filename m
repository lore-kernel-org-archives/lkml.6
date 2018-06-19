Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38B3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ti9jbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED5020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030382AbeFSRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:41:48 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44020 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030239AbeFSRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:41:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id y89-v6so494023qtd.10;
        Tue, 19 Jun 2018 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ClZGOqpw+eKMrPUJdVMGXrectjY9pUtV/KRq4VLtMo=;
        b=L+ti9jbwUsVQpCJX8GZJbquNhde/dYCvbKwFguN3NEu6tT9klYOky+B9K+nfQRXIF0
         WvoO76kAEnM7ThfOaQqMYPj97sYfvf3owK6OOyHQzzZeUGqyRn357Hvl3fy83Svr6tOO
         ZbZilJBUmreT5Jsma7OWItMRw1alsFXTNGdjDVWhttQ2GwVa9rmg5ubr0VBZ2hMWRUpc
         GaPyPnomkVuEQJJf2OVA+czeyf6p3EqH6albcrLk0tj6qo4mfVFZ5pV2pM9PuHiHSaYg
         g9p6ozHHMRN6gz7kYix+z8O7Ylfzz8eI44PiPqJiwsSVy1LIyMaf0fckJQ8QWOmMIIMe
         Nweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0ClZGOqpw+eKMrPUJdVMGXrectjY9pUtV/KRq4VLtMo=;
        b=SyVQagwb8Dn3iGcLaqde1xpBytxrM3QxIr3pc3YPYCtf7UcpwRA8WJXqRTOLQaKqlY
         VVkUJ96zk7KFQlunD+xpo4uxPJReH9oCMuwzId52wIMi5261G767yDbMHGGR0iUXoUaD
         3kw/zuZxR4CmrGjd80Eu+71zc5PlcD+2YbepNDCW6CGwXiMQMN4WfgEkD0WeKhY4RzdY
         eTyNSz8WZdQ+Am7yhw8wDJKTNmnJ9bEIbvh2CMJQNVfWBxNfzmNKr0q2t84mmmjSFSQ8
         lT7OpW0PD+VoDiMExIztFEjM9yn421X5sOKau3WsQ2tMgS6WE8k93OGUGZExdQ3diR5G
         t/9w==
X-Gm-Message-State: APt69E3VGTYCANMkSWV+DjP72Wkw64URJSOpnWsEEeK/Ah+VVgcZTsvd
        vzGLYAthH5zwxneXwH9uAbDb7Z2U
X-Google-Smtp-Source: ADUXVKI9yu0sZX9kbjxpoOPaXGK9+XE64NLsRE8d7gKZkHPf4u4UwV3S7OQoYtt4rhlbujo6bzrMqg==
X-Received: by 2002:ac8:3283:: with SMTP id z3-v6mr15541450qta.324.1529430102588;
        Tue, 19 Jun 2018 10:41:42 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d72-v6sm318366qkj.17.2018.06.19.10.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:41:41 -0700 (PDT)
Subject: Re: [PATCH] net: nixge: Add __packed attribute to DMA descriptor
 struct
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180619165453.31894-1-mdf@kernel.org>
 <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
 <CAAtXAHfGwSLfhhPU9B=O8q5aGExrmgkPgkC5u8XYLtKL5i4JHQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b8dc3d5c-c830-d94a-6ba4-ac2f07f06cb2@gmail.com>
Date:   Tue, 19 Jun 2018 10:41:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAtXAHfGwSLfhhPU9B=O8q5aGExrmgkPgkC5u8XYLtKL5i4JHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 10:31 AM, Moritz Fischer wrote:
> Hi Florian,
> 
> On Tue, Jun 19, 2018 at 10:13 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 06/19/2018 09:54 AM, Moritz Fischer wrote:
>>> Add __packed attribute to DMA descriptor structure  in order to
>>> make sure that the DMA engine's alignemnt requirements are met.
>>>
>>> Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
>>> National Instruments XGE netdev")
>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>> ---
>>>
>>> Hi David,
>>>
>>> this addresses an issue where padding occured breaking the alignment
>>> in the array the descriptors are allocated in coherent memory.
>>> This was discovered when we tried to bring up the driver via a PCIe
>>> bridge on x86.
>>
>> How could padding be inserted given than all of the structure members
>> are naturally aligned (all u32 type). Compiler bug?
> 
> I have no good answer to this, all I can tell you is that it wouldn't work
> otherwise. This was part of a bunch of changes that I made in order
> to make this work with 64bit DMA. I made sure to remove the padding/
> reserved fields accordingly such that the net difference would be zero.
> 
> I might've messed that up? The descriptors looked something like this:

Ah ah! This is not the layout in the upstream tree I am looking at, but
your layout below will definitive introduce padding, yes.

> 
> struct nixge_hw_dma_bd {
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>         u64 next;
>         u64 phys;
> #else
>         u32 next;
>         u32 reserved1;
>         u32 phys;
>         u32 reserved2;
> #endif
>         u32 reserved3;
>         u32 reserved4;
>         u32 cntrl;
>         u32 status;
>         u32 app0;
>         u32 app1;
>         u32 app2;
>         u32 app3;
>         u32 app4;
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>         u64 sw_id_offset;
> #else
>         u32 sw_id_offset;
>         u32 reserved5;
> #endif
>         u32 reserved6;
> } __packed;
> 
> 
> I'll have some follow up patches to add 64bit support together with a
> wrapper driver for the PCIe bridge once the architecture solidifies here.

Why not have the structure updated like this:

struct nixge_hw_dma_bd {
	u32 next_lo;	/* lower 32-bit address part */
	u32 next_hi;	/* upper 32-bit address part */
	u32 phys_lo;
	u32 phys_hi;
        u32 reserved3;
        u32 reserved4;
        u32 cntrl;
        u32 status;
        u32 app0;
        u32 app1;
        u32 app2;
        u32 app3;
        u32 app4;
        u32 sw_id_offset_low;
        u32 sw_id_offset_hi;
        u32 reserved6;
};

That assumes I got the upper/lower address part correct, if not, swapthe
members. Then in your code, if you want to be efficient, you can
populate the fields only if CONFIG_ARCH_DMA_ADDR_T_64BIT is defined. I
did that in bcmgenet.c for instance because the register accesses are
slow, so if we can save 200ns per packet transmit/receive, that's a win.

This should not change anything because the structure size is the same
in both cases, but how you are managing is different, and that would in
turn influence what the HW sees.

Does that make sense?

> 
> Thanks for the feedback,
> 
> Moritz
> 


-- 
Florian
