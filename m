Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E06218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L3AgAu9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbeLTUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:40:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32929 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbeLTUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:40:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so3375237qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oTBSe3eBPo/GCYBpxqqW/LZuTvviXbX7laF7qYlMa2Y=;
        b=L3AgAu9oyxmnRfSqnvcnaycoziTA+Mzlq5bOXYSqRifR1isBO8hg0r1C09S00TMCsr
         OpZwSIV4b/eAhc4TE22IW90V3PJG+RyEl0eRd9z2ZVNY1yw/RZ093iAY1nF6bDbKA0x7
         sWZQJZJ38i2G+dQQiSqiyKtvSnIrLh4Z6et+w+cixrp0xuRLzUD4aaw6c02F71244LSF
         +Jgc8wsKsaoD6hs9wFKxvYT8ZfhTLFRNpOB+T58Oe6uRf9MwOSJFN4XlTgGm3CGy2IhR
         0XvPEFHS/F1pALmAjJHAlBE8Sz8F4mcfvT+MGhTh2NfYx4mBvfo/2g73YCwxGKBTAA+5
         z9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oTBSe3eBPo/GCYBpxqqW/LZuTvviXbX7laF7qYlMa2Y=;
        b=LiNOW9hXwNo89bBgZ0m36SvJ6+9zyOX+LtwmQIIhCpYgMoBryQrXOS4HF6bSh26Bsr
         iE4s4OEludU9t6KBjFCkWO3I4DscnkNxhnSxmKhG9vog4OaZBTWgBGpQX1Nv1cOK0Xd4
         vpxN42XQulv9kpiJe2yqg+oFUvj3YwFcetryJYJbQXVHkneZs4JEkxpcyCVnDY5IKu+S
         NROkCf25kun46sfv7XVs7iqApQLEZzk7cFmkqDHzP63agpdGhqqzQAKUiRFvlhwyefuG
         KKN6lfbuPr+mfyccWgKl0IPWhcg+XLNYsiRcq4nBDqrSYBojKYLb7/VTwRtY5IpF3jzP
         pJSw==
X-Gm-Message-State: AA+aEWbcPUoAuTJc5bdvMAuC8sMUX/Q/Zg2Ycyvv7bRd0U0Uwo/U/vJr
        +K/eQQs851LyH0OsAVqTDapr3Q==
X-Google-Smtp-Source: AFSGD/Vuhahggmh3ECufo5R1afRLgw8Qs2N/vyETT0Vz7sTXva+w2ukUMCL1tlMxiOK7aOIA3yEAlA==
X-Received: by 2002:aed:3482:: with SMTP id x2mr26720808qtd.72.1545338436434;
        Thu, 20 Dec 2018 12:40:36 -0800 (PST)
Received: from localhost ([2601:182:c980:96c:8dd:4488:90b1:59d1])
        by smtp.gmail.com with ESMTPSA id 7sm7304915qka.38.2018.12.20.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:40:35 -0800 (PST)
Date:   Thu, 20 Dec 2018 12:40:35 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:39:32 PST (-0800)
Subject:     Re: [PATCH v3 0/6] IRQ affinity support in PLIC driver
In-Reply-To: <CAAhSdy0t9H4VMSpoZy1Xt2caW_BxOfEA-x-QhnMsbzXned6AUA@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-b072b061-91a6-40d3-a8a0-baf39cb7c33c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 01:37:58 PST (-0800), anup@brainfault.org wrote:
> On Fri, Nov 30, 2018 at 1:32 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> This patchset primarily adds IRQ affinity support in PLIC driver and
>> other improvements.
>>
>> The patchset gives mechanism for explicitly routing external interrupts to
>> particular CPUs using smp_affinity attribute of each Linux IRQs. Also, we
>> can now use IRQ balancer from kernel-space or user-space.
>>
>> The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc4
>> and can be found at riscv_plic_irq_affinity_v3 branch of:
>> https://github.com/avpatel/linux.git
>>
>> Changes since v2:
>>  - Fixed incorrect address of enable registers using sizeof(u32) in PATCH1
>>  - Retained comment about need for locking in PATCH1
>>  - Split PATCH2 into two patches
>>  - Split PATCH3 into two patches
>>  - Minor fix in commit description of PATCH4
>>
>> Changes since v1:
>>  - Removed few whitspace changes from PATCH1
>>  - Keep use of DEFINE_PER_CPU() as it is
>>
>> Anup Patel (6):
>>   irqchip: sifive-plic: Pre-compute context hart base and enable base
>>   irqchip: sifive-plic: Add struct plic_hw for global PLIC HW details
>>   irqchip: sifive-plic: More flexible plic_irq_toggle()
>>   irqchip: sifive-plic: Add warning in plic_init() if handler already
>>     present
>>   irqchip: sifive-plic: Differentiate between PLIC handler and context
>>   irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
>>
>>  drivers/irqchip/irq-sifive-plic.c | 143 +++++++++++++++++++-----------
>>  1 file changed, 90 insertions(+), 53 deletions(-)
>>
>> --
>> 2.17.1
>>
>
> Any comments on this series?

I also haven't had a chance to look at these yet.
