Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E121A20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6tsJbxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E121A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeG3Xaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:30:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42225 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbeG3Xaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:30:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so5114408pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nUmipr2/F4g8kEJwlOipcRl8v+DJmY7MY9xxF+LecJs=;
        b=p6tsJbxLJ4Z31oHQ4h3sXGlrMLnjUXsZl9vOL6DIPeAkverp4mDX5vu2sNUSSighVc
         sZDZ4cdzAexNiD4Lzql/7DGI0G0hYnYcY+h4w33KMlG/cKEpdB5UsWbseqVdqHTOexuj
         wPXRV7zC3FWjrTz3F8vvrJZxDFaKAem7bXGG7b32PEsBB/EKr3q2QRmbKK3LGoxr2Vw1
         lNz7wsp+YEjs4Iphakhb5V0OEE5pN4NI/ia+Xd/1DmNyUgQnzlqaVeorlFfYYHuf5wqT
         d1SwGKiW4QM6NcW65B9QXQtrRBI9ffVOccdMZovV1DQJ5ysl43w2IS2gQP2u6bK2/cg8
         snfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nUmipr2/F4g8kEJwlOipcRl8v+DJmY7MY9xxF+LecJs=;
        b=a2PgUw8w3hBtWcPlqmOrhziWw2FafFfvrqGHXumYSKpI9+izzWpvqCq482Mu1kGSzW
         IeDBOkWyFY4AUSSrArW3Rc9R6+eAw403ZOaRrRG/Xb7qZM9nw775MBbxRtT8GtUbSdgN
         idThhlDNn8ykFM0n/J4yyK9TAHieLLZW12gLu3m54cBsK+FO5Oc5Ajd4DeIHJ+yYqIVm
         z7VOBbCKvy2zZGZJAPaaLjF5/KpLIICZ1WploHibYEgVHA9N3MYC1B8IKQm/bRN5Sqd/
         i62zjGVI86vZBbhvN2CiKH44/1KwmHXJyCGtgiVaJK1kao2ePYjGZ6TEz5ULvl0r/tmt
         jezw==
X-Gm-Message-State: AOUpUlExdzHnS9ls0kKEC8OEXKxNVOYoruZ1prl8sbP1in0xk+aISHuo
        ikf8Sc0Tu/vxzt0P6KAmBEN4bA==
X-Google-Smtp-Source: AAOMgpdYRD/bAEFHQ26hB7TSOh1DnwKNSs3P1aBtPrEZmhO/iWrr+Fs+a+4HUOGfRpFRo/wfVndl5g==
X-Received: by 2002:a63:4b5a:: with SMTP id k26-v6mr17335150pgl.384.1532987610371;
        Mon, 30 Jul 2018 14:53:30 -0700 (PDT)
Received: from [100.112.64.65] ([104.133.8.97])
        by smtp.gmail.com with ESMTPSA id p66-v6sm22198861pfd.65.2018.07.30.14.53.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 14:53:28 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:53:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257@gmail.com
Subject: Re: Linux 4.18-rc7
In-Reply-To: <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com> <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
 <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 6:01 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > I think I missed vma_set_anonymous() somewhere, but I fail to see where.
> 
> Honestly, by now we just need to revert that commit.
> 
> It's not even clear that it was a good idea to begin with. The rest of
> the commits were cleanups, this one was driven by a incorrect
> VM_BUG_ON() that triggered, and that checked "vma_is_anonymous(vma)"
> without any explanations of wht it should matter.
> 
> I think the biggest problem with vma_is_anonymous() may be its name,
> not what it does.
> 
> What the code historically *did* (and what vma_is_anonymous() checks)
> is not "is this anonymous", but rather "does this have any special
> operations associated with it".
> 
> The two are similar. But people have grown opinions about exactly what
> "anonymous" means. If we had named it just "no_vm_ops()", we wouldn't
> have random crazy checks for "vma_is_anonymous()" in places where it
> makes no sense.
> 
> So what I think we want a real explanation for is why people who use
> "vma_is_anonymous()" care. Instead of trying to change its very
> historical meaning, we should look at the users, and perhaps change
> its name.

You make a very good point on the naming. Especially confusing when
layered on top of "we call shmem 'file' here, but 'anon' there".

I have no problem with reverting -rc7's vma_is_anonymous() series.

> 
> In this case, for example, I think the *real* problem was described by
> commit 684283988f70 ("huge pagecache: mmap_sem is unlocked when
> truncation splits pmd"), and the problem is that an existing check
> that required that mmap_sem was held was changed to say "only for
> anonymous mappings".
> 
> But the fact is, you can truncate mappings that don't have any ops just *fine*.
> 
> So maybe that original BUG() was entirely bogus to begin with, and it
> shouldn't exist at all?
> 
> Or maybe the code should test "do I have a vm_file" instead of testing
> "do I have vm_ops"?
> 
> What's the problem with just doing split_huge_pmd() there when it's a
> pmd_trans_huge or pmd_devmap pmd? Why is that VM_BUG_ON_VMA() there in
> the first place? Why are allegedly "anonymous" mappings so special
> here for locking?
> 
> Adding a few more people to the cc, they were involved the last that
> time VM_BUG_ON_VMA() was modified.
> 
> New people: see commit bfd40eaff5ab ("mm: fix vma_is_anonymous()
> false-positives") for details. Right now I think it's getting
> reverted, but the oops explanation in the commit is about that
> 
>             kernel BUG at mm/memory.c:1422!
> 
> which was/is debatable and seems to make no sense (and definitely is
> still triggerable despite that commit 684283988f70 ("huge pagecache:
> mmap_sem is unlocked when truncation splits pmd") that limited it a
> bit - but I think it didn't limit it enough.

I'm all for deleting that VM_BUG_ON_VMA() in zap_pmd_range(), it was
just a compromise with those who wanted to keep something there;
I don't think we even need a WARN_ON_ONCE() now.

It's historical: back in the day when only (hugetlbfs which never
gets there, and) anon THP used huge pmds for userspace, it did half-
document an obscure assumption underlying __split_huge_pmd(), and
IIRC was added in response to a trinity bug catch in that area.

(It remains quite interesting how exit_mmap() does not come that way,
and most syscalls split the vma beforehand in vma_adjust(): it's mostly
about madvise(,,MADV_DONTNEED), perhaps others now, which zap ptes
without prior splitting.)

Once DAX and huge tmpfs came in, the BUG had to be scrapped or weakened
because truncation and hole-punching can come that way without mmap_sem.
And perhaps other drivers since are taking advantage of huge pmds now,
with other assumptions.

But I have not yet taken a look to see where the -rc7 changes actually
go wrong: I'll spend a little while looking, but don't expect to find it -
certainly don't wait on me, I'll only speak up if I find something.

Hugh
