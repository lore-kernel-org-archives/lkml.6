Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8FC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C342220823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SbHWvxty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfBISyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:54:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46758 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfBISyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:54:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id x25-v6so2042766ljj.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYxAwFPICt9TibMfenX6wMGJAfvnFLVL6l1OJ0fn0cc=;
        b=SbHWvxtyAersQBxhISFuLW5kA2E+zARouATr37N2I26NZTFMnKNqBalg3qb3xeauCs
         dSr8X+iNVAXFRfZGpR379NIfDF2H6dXTKSzTeylxKrhCJFJVktLdPioKRHLLVTsKjOE+
         FUlGvlEHZ7J2emYKs1c/uH4pMlGSXH9Uezqec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYxAwFPICt9TibMfenX6wMGJAfvnFLVL6l1OJ0fn0cc=;
        b=I9gOYF+c2ndwGdTsOtPVMEkqpsZeDpuv9nH8ZPT1N3cZ9BEX5yIsj/9K3b21USvces
         TmMzkxoRAEyBic7Hx/9ydHI/v0n3LdwgJyuDBwr9I2vOjeoVpUmCuVjYSDjU6jsT9UQ4
         UvQTi7MT8XHOpKTGj4zWKVKweiNHV8zD+pVsMZDSdrYn1ypRVWM27dYMBqGvjkJSEeXh
         4UcBrZMejuSQ8Lqwjesl0frPxefISjiSJuu986NzyZVRGVa4ilEq6hW/obefVkg5EWND
         1e/BRKmK4QcFGO13CD/laR+mOfkSUalrkmvtbjnNTqUFmLKRstsbwgSlx+JOTn3POtQI
         /wOA==
X-Gm-Message-State: AHQUAualSoWDTDE2hqNZ/fc4S8VScuvCftSSB4bCIYQA2S8ovqO/UXCU
        Lu3XN/OTtRf5tB6KZ9M4ZTxQUDhBgjM=
X-Google-Smtp-Source: AHgI3IYp3t9iaaovulziUyFWprFPc7Z8VBPLdEN6XHeloL0i7KUaw2cbKU1eZOWXsxTUNaZfytta2w==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr17056821ljc.147.1549738484907;
        Sat, 09 Feb 2019 10:54:44 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e132sm1237646lfg.22.2019.02.09.10.54.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 10:54:43 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id r10-v6so5692201ljj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:54:43 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr4686247ljz.54.1549738482966;
 Sat, 09 Feb 2019 10:54:42 -0800 (PST)
MIME-Version: 1.0
References: <39ae9195-cf8f-01fe-df83-38a9a4c52e48@eikelenboom.it>
In-Reply-To: <39ae9195-cf8f-01fe-df83-38a9a4c52e48@eikelenboom.it>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Feb 2019 10:54:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=winXFRv0KUa332spZx0yaDKMAbdKSeAcBATtacACLgm0A@mail.gmail.com>
Message-ID: <CAHk-=winXFRv0KUa332spZx0yaDKMAbdKSeAcBATtacACLgm0A@mail.gmail.com>
Subject: Re: Linux 5.0 regression: BUG: unable to handle kernel paging request
 at ffff888023e26778
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:24 AM Sander Eikelenboom <linux@eikelenboom.it> wrote:
>
> I haven't got a reproducer so i might be hard to hit it again,
> system is AMD and this is from the host kernel running under
> the Xen hypervisor might it matter.

I think this is a Xen bug.

In particular, there's a few poison values in there that look like
zen. Like this:

   R10: deadbeefdeadf00d

looks like a special poison value that is from Xen itself.

It looks like the oops is around the TLB flushing code, looking at the
code it's the

        arch_leave_lazy_mmu_mode();
        if (force_flush)
                flush_tlb_range(vma, old_end - len, old_end);
        if (new_ptl != old_ptl)
                spin_unlock(new_ptl);

sequence in move_page_tables. The oopsing code sequence is


  28:* 48 89 45 00          mov    %rax,0x0(%rbp) <-- trapping instruction
  2c: 41 f6 46 52 40        testb  $0x40,0x52(%r14)

and that "testb $0x40" instruction that comes after the trapping
instruction is the

                           ((vma)->vm_flags & VM_HUGETLB)               \

from the flush_tlb_range() macro:

#define flush_tlb_range(vma, start, end)                                \
        flush_tlb_mm_range((vma)->vm_mm, start, end,                    \
                           ((vma)->vm_flags & VM_HUGETLB)               \
                                ? huge_page_shift(hstate_vma(vma))      \
                                : PAGE_SHIFT, false)

if I read that oops correctly.

I have no idea what that store to 0(%rbp) is for, though - I can't
line that up with anything I see with my own kernel config.

We *do* have changes to 5.0 in the move_page_tables() code (mremap on
a pmd level), so I'm cc'ing some of the people involved there, but
that odd poison value does make me wonder abut Xen issues. When I
google for that value, all I see is Xen reports (and your report for
this).

                    Linus
