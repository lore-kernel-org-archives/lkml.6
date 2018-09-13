Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E543C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HECPvkEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B9820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIMSTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:19:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37971 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeIMSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:19:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5-v6so1147977otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMsz4N+Joz7F76aAEf5Ham3AqYrnEj7vXQ7piB57CJs=;
        b=HECPvkEQHHwpw87qUrNjq6mfn/ZGebcCSgm+0PZ3uah+gDQQY5a7bcw0lr2jlMFTyi
         vKgW/W22JHGvZAvCD+I7ecv7yy/UspryQjreBtfbsSJq4qByqegRGZV17/MVebLSqKt4
         grFeyMKe2x7ohe7tVwafGSrY/4clMAbRSQnZzyOF+zOMc8qxS5NvsIf0C98waRpuRLzz
         2cJy77msIsPiX88e0Nzc+xovYM/btpgCskfZk3TePse45Jm/KZ1uggGUwZOQo/xiCJlv
         t+9JVKJ6gRhnIvviMwkJxthdif5LrI37e8uwlKsm8/Ye3XfdOlwOmJSsB0A7fuQCVyeK
         NttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMsz4N+Joz7F76aAEf5Ham3AqYrnEj7vXQ7piB57CJs=;
        b=izXT4MGoQFW09eFH+012axtg3HCSXmIgyyxZKXLBn3sHgitv+GjWKAOQ+TCx6we/BA
         FG2SQvFnI8pXDrXvZodiXN01DBIdxKviEfnl1Az1vKWynGAhST0HjDyZTuHIiap11s6s
         F0YXvLNpNh8LgMQ6Etoca/EvzCnXn9FSf7Ypaa65mh3aF3wEsOjo3AiKFvdOiqbKH/vP
         J6ZxKxY1KEdDj2UWVwEITQi/MhpYkPG1lB9ylXa8k+TKMAmw9VKwkOdY2SP5yk9M4yf3
         LDvdVknCXlU6WZbT7R01/BtQwfl+i3eC5hbzignfOewZBo5ki2Yp+MRHLfs3BLR0bWX9
         JWnw==
X-Gm-Message-State: APzg51DodwGTq1UXy7sggeqHwDtosOIZgpItqGrjKZ/1/ngKxJIqw4Lq
        U23QD+0BDiBPdUnfAHK7/Afa5KxOHT0nv7qEmxsmng==
X-Google-Smtp-Source: ANB0Vda/Rk6AH+r1qX+zURb5DBzockCK8M+DU+VSANymwOuJU/w1tAaZ25e1OKBNdzmhLYIwsKXmsMNnQLWEjlusu+4=
X-Received: by 2002:a9d:3224:: with SMTP id t36-v6mr1078443otc.284.1536844213571;
 Thu, 13 Sep 2018 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180913092110.817204997@infradead.org> <20180913092812.132208484@infradead.org>
In-Reply-To: <20180913092812.132208484@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Sep 2018 15:09:47 +0200
Message-ID: <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, npiggin@gmail.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Provide a generic tlb_flush() implementation that relies on
> flush_tlb_range(). This is a little awkward because flush_tlb_range()
> assumes a VMA for range invalidation, but we no longer have one.
>
> Audit of all flush_tlb_range() implementations shows only vma->vm_mm
> and vma->vm_flags are used, and of the latter only VM_EXEC (I-TLB
> invalidates) and VM_HUGETLB (large TLB invalidate) are used.
>
> Therefore, track VM_EXEC and VM_HUGETLB in two more bits, and create a
> 'fake' VMA.
>
> This allows architectures that have a reasonably efficient
> flush_tlb_range() to not require any additional effort.
[...]
> +#define tlb_flush tlb_flush
> +static inline void tlb_flush(struct mmu_gather *tlb)
> +{
> +       if (tlb->fullmm || tlb->need_flush_all) {
> +               flush_tlb_mm(tlb->mm);
> +       } else {
> +               struct vm_area_struct vma = {
> +                       .vm_mm = tlb->mm,
> +                       .vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
> +                                   tlb->vma_huge ? VM_HUGETLB : 0,

This looks wrong to me. Bitwise OR has higher precedence than the
ternary operator, so I think this code is equivalent to:

.vm_flags = tlb->vma_exec ? VM_EXEC    : (0 | tlb->vma_huge) ? VM_HUGETLB : 0

meaning that executable+huge mappings would only get VM_EXEC, but not
VM_HUGETLB.

> +               };
> +
> +               flush_tlb_range(&vma, tlb->start, tlb->end);
> +       }
>  }
> +#endif
