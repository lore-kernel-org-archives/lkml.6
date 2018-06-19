Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89747C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DEC20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="HYcptq6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DEC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966935AbeFSRbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:31:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33747 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:31:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so756366lfy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=noEIzbB0fOpn3bvIO5TCB4M6/4Ede4bM82qp5+jXM4w=;
        b=HYcptq6YAcR313/qbgEEp8587D1AR+Lp2jp6LodZgS7g9H88NKycjZ6VS8QMsBcQQc
         2UyrDLJvqshsAhGqZvnQwPBxj5CY18vWd+P0IFqkRFpxrz6BpubLj3Xo7Txay7jiW/5m
         ktOPz3Ps8cKcyjXPZgs8OEctLrEgN6zrUcohILZ9lAE+MRve7dvHg/7Rl4ylmy9wMPzd
         ihAE9TaDdNDRG8TVOuO/L+RoZHYXPSJvVkx/M/38iAUBX+t/QKf4IGiBvK6E2QjzCkrX
         GyiNef31U9S8MySotnIYuPRUXOVuKJ1hgf3d77lMHdSNesxJbjv47n/3OnJWRnqYrSHi
         l4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=noEIzbB0fOpn3bvIO5TCB4M6/4Ede4bM82qp5+jXM4w=;
        b=YlROKKe0toyWysycRTkom8SAae65qsEp30o59o5ai4+2RUERnVQjFAEeNx1s0L1629
         iVoe5KKB747dS1UVR9bTBfZJAYhTHsHaB8den2pMLrlETiad3zbFhtlH0Ptyw3nyGfBE
         DxcorbIZScOYnw6NlKAN/lBSUHkc+ndiUfAv5Meb9iEqrZYfG7jLeh1+qobf5BvMIVzw
         GNmwtW9ixbEGFEe3qlxbYm67yL0FkDDI2SYkxqyJnHdd5cLKQbZQJglst1CsCFv9FF9d
         I2BGrfBrkAjblzfcrmOKNT2wqXyYoQ+xwDhMXyNtxxzl6p0G9dgKJbJy0OjfWxuFG+4A
         ckYw==
X-Gm-Message-State: APt69E3WMVhV04u2mA3XtCOcNLUD4usdfif8C7dJe48d5LyPEP0gT4up
        sDCMonqssbrUvHtDx+4hE/SyUNgmz+fVsDh3OEp8Xw==
X-Google-Smtp-Source: ADUXVKIIhls66O09ycSj0djvcDzctTKvOt0dzH0CPFAif2ln2ZcF7zUTfFH0YcQyhtrLNvTeZtbgmdegmhdKA7hW8mo=
X-Received: by 2002:a2e:889a:: with SMTP id k26-v6mr11517623lji.54.1529429490497;
 Tue, 19 Jun 2018 10:31:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e11:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 10:31:29
 -0700 (PDT)
In-Reply-To: <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
References: <20180619165453.31894-1-mdf@kernel.org> <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 19 Jun 2018 10:31:29 -0700
Message-ID: <CAAtXAHfGwSLfhhPU9B=O8q5aGExrmgkPgkC5u8XYLtKL5i4JHQ@mail.gmail.com>
Subject: Re: [PATCH] net: nixge: Add __packed attribute to DMA descriptor struct
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Jun 19, 2018 at 10:13 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/19/2018 09:54 AM, Moritz Fischer wrote:
>> Add __packed attribute to DMA descriptor structure  in order to
>> make sure that the DMA engine's alignemnt requirements are met.
>>
>> Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
>> National Instruments XGE netdev")
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>
>> Hi David,
>>
>> this addresses an issue where padding occured breaking the alignment
>> in the array the descriptors are allocated in coherent memory.
>> This was discovered when we tried to bring up the driver via a PCIe
>> bridge on x86.
>
> How could padding be inserted given than all of the structure members
> are naturally aligned (all u32 type). Compiler bug?

I have no good answer to this, all I can tell you is that it wouldn't work
otherwise. This was part of a bunch of changes that I made in order
to make this work with 64bit DMA. I made sure to remove the padding/
reserved fields accordingly such that the net difference would be zero.

I might've messed that up? The descriptors looked something like this:

struct nixge_hw_dma_bd {
#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
        u64 next;
        u64 phys;
#else
        u32 next;
        u32 reserved1;
        u32 phys;
        u32 reserved2;
#endif
        u32 reserved3;
        u32 reserved4;
        u32 cntrl;
        u32 status;
        u32 app0;
        u32 app1;
        u32 app2;
        u32 app3;
        u32 app4;
#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
        u64 sw_id_offset;
#else
        u32 sw_id_offset;
        u32 reserved5;
#endif
        u32 reserved6;
} __packed;


I'll have some follow up patches to add 64bit support together with a
wrapper driver for the PCIe bridge once the architecture solidifies here.

Thanks for the feedback,

Moritz
