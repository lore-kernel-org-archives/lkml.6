Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAADAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6195520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OOOYGbU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6195520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeGYSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:46:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33746 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbeGYSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:46:32 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so7011961iol.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdgp2iY6KpwnbVZRZQ/kUXPPBAhZqjnyWnhn2NF7H0k=;
        b=OOOYGbU8QZJBW8DyoUS1cFWOsNkQsFkeo8SppHnRYmPyc2sjcTHKJt4kybmH6GxOVc
         G2lhlYaGOFDSZh+3ajjGe7syyrooOEOt5n+kqXI/MjXtaESLxn6xPSYZ6EOmDs0HAwpR
         1MAlOxo5IWTQc/3+HVJz3vuxP15AC5QD6Pv9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdgp2iY6KpwnbVZRZQ/kUXPPBAhZqjnyWnhn2NF7H0k=;
        b=OuEm3A0Vs10xKPEQXDiLoxjG08TRoIpkCaGSdabN2gxvOKVuAJOCJogLocsRHe8DwH
         lAF8wUa2hNM7QF0w8s+sQ3AqIGZ32I90s39vx6VNO3cAPCtBfjMDqEwLBRNr0DFUXaJp
         qEtTJe/HhKdz/3h1temA2bp8NDIg1/192/p2P7TkIbx5p1fliCcfypOoayqf0YuJxhKZ
         /8QJZFoh+cALiHrXZCnSFJ5NZmcyo6VcF0JqR8mrSBdN1REpA+Zd0+VvtHSf7WsNNoRW
         PVsaFOw/QLdh7orH7mZjTHhE6xvRdhoeMzF78m9bCtw66RNP8rHSzB+Zb+LgJMPUqReE
         +ZwA==
X-Gm-Message-State: AOUpUlEu5RxsGXIXSD2FBlDqRXXiXw4JGCQuXdnMCFgdzC1FoMxShlUu
        jUHSmoDIRIcqH9gzichmPR44idI5SJj+9p1oBTw=
X-Google-Smtp-Source: AAOMgpeikD0RjLzAcOBmkyanq9fDb17e77jkQZmxO27L/oHlwwroE1ReHgK3tS/noWMwOYo58DuMFJcwHwjtHbkQxd0=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr18700396iov.203.1532540032406;
 Wed, 25 Jul 2018 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
 <20180724121139.62570-2-kirill.shutemov@linux.intel.com> <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
 <CA+55aFz1Vj3b2w-nOBdV5=WwsCYhSBprjPjGog6=_=q75Z5Z-w@mail.gmail.com>
 <20180724134158.676dfa7a4da16adbab3b851c@linux-foundation.org> <20180725123924.g2yvgie2iz2txmek@kshutemo-mobl1>
In-Reply-To: <20180725123924.g2yvgie2iz2txmek@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Jul 2018 10:33:41 -0700
Message-ID: <CA+55aFyAo5DK2hLbFF2qg8FY0qFUaYJZNyS2wYhrSm=HfVvsWA@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] mm: Introduce vma_init()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 5:39 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> There are few more:
>
> arch/arm64/include/asm/tlb.h:   struct vm_area_struct vma = { .vm_mm = tlb->mm, };
> arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };
> arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };

We probably do not care. These are not "real" vma's and are never used
as such. They are literally just fake vmas for the "flush_tlb()"
machinery, which won't ever really cause any VM activity and will just
call back to the architecture TLB flushing routines.

They initialize vm_mm exactly because that's how the mm is passed down
to the tlb flushing (we pass the whole vma because some architectures
than have special flags in vm_flags too that can affect how the TLB
gets flushed - ie "only flush ITLB if it's an execute-only vma" etc).

Using "vma_init()" on them is only confusing, I think.

                 Linus
