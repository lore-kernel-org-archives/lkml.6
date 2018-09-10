Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512F6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F173720645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJR3UX93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F173720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIJLkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:40:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37522 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:40:24 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so6140103iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjpx9FpBH0vhHFJZ4TZPSO4Q3nR89KZndBlu4Oa2TyI=;
        b=LJR3UX93kj0i0KIPLsqXjH5KLgJwYMSUfXQFHK1jWvIBp28pKK0yA6VuwswRrgSk8B
         6u/DCkYXdcAHAVeuvJz+HGd75QgIRzBe8k9tiVAsPp0fAtESkp/YoCZTV20U/mFODRCk
         EKXmqfF9S2+kztFz1faay8e9kq1NAKmU3y/yAoSszDoPlXLfElkoH7pKoekagd3b+4mw
         YwkgzPfL9tfOCsMtJw4BCdYD9YSpx9yuNaQKRg9NQ5fVJGXZHWRTsNBPpSscynAQKxEp
         JFBwYF+wnD3HhYViVeejo4Sr/Fn4ibTXHeyzNVI2jkztmwM47gQPFyIvnim7Er8xygiZ
         EX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjpx9FpBH0vhHFJZ4TZPSO4Q3nR89KZndBlu4Oa2TyI=;
        b=BOnXi4vV+Il/LJT/vdgCzdFcsVvOpKVS/xxLEGxF2AtJt9lARiknhuppzT5hWF0Gn5
         vZSPeSTwRT0kenMYL8HhI5roqJEo26cmbt4bKU/J2j+N9h6kuo7T8aJNSJIJ7kYgLon4
         +WInC8V5yc5/Z0Oz/maaeSYFruH9FoCtzaSxzZrtqBWBQ9WSRZ3ERR7ABVDEyxJ5xVuj
         Ce/fW7pS9dWjD2RTg80uM0rtyHcM48DrirDED4wu7TVUmYP1XoAD7jmeTKqgDO6TpvTh
         NpTzlmtskxkRlPoxvA/gnKie/1M3vj80F0JmXOXpks04D2c5rk739BKCAZCj8OhEjsvS
         7EtQ==
X-Gm-Message-State: APzg51C/wNlSOXweFN1/QIY9td85YsNoTd3sORnGaIJ/UexFQsKB+e8Y
        NN/9Q4G8fjLP6UMp+6klos3xzPAa15iwvGgilA==
X-Google-Smtp-Source: ANB0VdaTJ2vn+7CICO4MBWah++e6k1xgo81hY17ftfQxyNHlAQJ3B/Vp2P6k6C/HkkC22FRs+9l5VkujAi0tk3eOZ08=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr16295356iop.238.1536562073637;
 Sun, 09 Sep 2018 23:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com> <20180909233309.GU1740@192.168.1.3>
In-Reply-To: <20180909233309.GU1740@192.168.1.3>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 10 Sep 2018 14:47:41 +0800
Message-ID: <CAFgQCTvxHTdTgrJb5avH3kkaG3oYwkakqXHbNLRvkwkTfDZJUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/boot/KASLR: enhance randomness of kernel load
 addr when using GiB hugepage
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:33 AM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> On 09/06/18 at 10:36am, Pingfan Liu wrote:
> > commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
> > pages when doing physical randomization (KASLR)") and commit
> > 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
> > handling") prevent the physical load addr of kernel from spoiling a good
> > candidate of GiB page. But the algorithm deterministicly chooses the most
> > front GiB page for hugetlb, and sacrifices the randomness, which
> > is the heart of the KASLR. This patch tries to enlarge the randomness in
> > the cases where hugepages=X < the num Y of good candidate of GiB
> > page.
>
> Better tell how you improve in cover letter or patch log.
>
Yes, good advice.

> > To comparison, taking a typical KVM guest for example, the head 3GiB mem
> > can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
> > Z=5, then Y=2, assuming X=1, the randomness range before this patch is
> > 4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
> > If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
> > assuming X=1, the improvement will be: 20% (6/(6-1) - 1)
>
> Hmm, what if hugepages=1, or 2, even 100, but system owns 1PB memory?
>
Not agree, since the kvm guest is much popular, but most of them have
no much memory.

> Secondly, even in the case that hugepages=1, system memory is 5G, if no
> 'movable_node' specified, the last 1G can't be chosen for hugepage.
> Because memblock will allocate memory top to down. This is not
> improving, but make the code not work.
>
Yes, you are right. It is too hard to consider the runtime layout at
this very early stage.

> Lastly, getting better randomness is the heart of KASLR, while
> process_mem_region() is the heart of kernel KASLR code. Unless the
> current code blocks serious fix, we'd better not touch it. Keeping
> it can make the current code logic simple and more readable. It's

Yes.

Thanks,
Pingfan
> like a proved running well machine, we just dig out the unwanted
> middle, feed the good head and tail regions into it, then it gives
> back good slot for kernel position one by one.
>
> To sum up, I personally think this patchset is not a good idea.
>
> Thanks
> Baoquan
