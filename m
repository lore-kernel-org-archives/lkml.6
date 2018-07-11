Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60611C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42A20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ts6pnHLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D42A20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeGKLOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:14:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33415 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:14:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id u14-v6so20958266lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wFp7nvzwQ5jXYJ9IS6aiNoK9z5S8m3fCt+Onxh54Aoo=;
        b=ts6pnHLtRDTJizioUUxWAgmRGU0DpoKqqQkoe9x6AzW4HLYP6AzXPcyK98lh3V+iBT
         TwK9tBaXKLZH8dG/av/7RZ6hoV+BnT6C6TBKUNmREfnmlHhICHvRAqYfihMNwZh6A7Mz
         awdKLgawfUcnPuWL5YH3FYsXhgb+nubbHkhNGTCeYx0fypXrH6jPsp8FeKk02sHlbShU
         oEfDmws8kmuEAYu472eAr2GG0mO63veX77UIYZ4WEjCVLoEyDp7tIYev9kc0v0GwK71/
         kTIrl2o84o0+JRkazQMVTB9QccJat6VhRymTIDsVm/GOQDVvvtOoX95F5fm3hWXZYv9p
         LYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wFp7nvzwQ5jXYJ9IS6aiNoK9z5S8m3fCt+Onxh54Aoo=;
        b=EfYNw9YqVzBwvKRM6gDerWnNzW9WSrNPnAw7eyD5vyGVo8Ev7GTVzUQB/QqDk+qi56
         vqcBqHfdsCLTprmGp+cutGPdr8XwZ5Xsha4wHnoyzs43KjutlIf+dRI7Tq0HU2GVBXE1
         S557ErQeZ4YfH8urD09Xc/LNjW6T5yHwIsIuCAzfotkqGgSQhcM9QElanQnheniBOAqp
         sMUJC0nJA7ZXoSADFAi9dsfILg7e0bHlCoF6xI8+An03kgTgD77MuI51Q7op93W2Awbi
         tvmca+LAw6Jnasd4CDO1oymsO1cv17ybv8L4CFLuvVTRO+d3zlUx9F+p5u8Fbj98uALh
         w0mQ==
X-Gm-Message-State: APt69E3dvqqPnqSQ3Mk7wg6Tyy44N0HoAmr9aLsEVrpnHx4CRWKAk9nN
        R7UJ2EWpxfdTXiILkDZNBlMBzg==
X-Google-Smtp-Source: AAOMgpcjp7M89dYrBiWf3+4SkENZRsoCHuC32woc1jt0whjoJxLpqbKBIRtSVzQdbzbAgAPxkKOW6g==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr6080112lfg.41.1531307455861;
        Wed, 11 Jul 2018 04:10:55 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-114-95-122-178.brest.dynamic.pppoe.byfly.by. [178.122.95.114])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2986103ljc.50.2018.07.11.04.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:10:55 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B9EE730029D; Wed, 11 Jul 2018 14:10:52 +0300 (+03)
Date:   Wed, 11 Jul 2018 14:10:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:34:06AM +0800, Yang Shi wrote:
> 
> Background:
> Recently, when we ran some vm scalability tests on machines with large memory,
> we ran into a couple of mmap_sem scalability issues when unmapping large memory
> space, please refer to https://lkml.org/lkml/2017/12/14/733 and
> https://lkml.org/lkml/2018/2/20/576.
> 
> 
> History:
> Then akpm suggested to unmap large mapping section by section and drop mmap_sem
> at a time to mitigate it (see https://lkml.org/lkml/2018/3/6/784).
> 
> V1 patch series was submitted to the mailing list per Andrew's suggestion
> (see https://lkml.org/lkml/2018/3/20/786). Then I received a lot great feedback
> and suggestions.
> 
> Then this topic was discussed on LSFMM summit 2018. In the summit, Michal Hocko
> suggested (also in the v1 patches review) to try "two phases" approach. Zapping
> pages with read mmap_sem, then doing via cleanup with write mmap_sem (for
> discussion detail, see https://lwn.net/Articles/753269/)
> 
> 
> Approach:
> Zapping pages is the most time consuming part, according to the suggestion from
> Michal Hocko [1], zapping pages can be done with holding read mmap_sem, like
> what MADV_DONTNEED does. Then re-acquire write mmap_sem to cleanup vmas.
> 
> But, we can't call MADV_DONTNEED directly, since there are two major drawbacks:
>   * The unexpected state from PF if it wins the race in the middle of munmap.
>     It may return zero page, instead of the content or SIGSEGV.
>   * Can’t handle VM_LOCKED | VM_HUGETLB | VM_PFNMAP and uprobe mappings, which
>     is a showstopper from akpm
> 
> And, some part may need write mmap_sem, for example, vma splitting. So, the
> design is as follows:
>         acquire write mmap_sem
>         lookup vmas (find and split vmas)
>         set VM_DEAD flags
>         deal with special mappings
>         downgrade_write
> 
>         zap pages
>         release mmap_sem
> 
>         retake mmap_sem exclusively
>         cleanup vmas
>         release mmap_sem
> 
> Define large mapping size thresh as PUD size, just zap pages with read mmap_sem
> for mappings which are >= PUD_SIZE. So, unmapping less than PUD_SIZE area still
> goes with the regular path.
> 
> All vmas which will be zapped soon will have VM_DEAD flag set. Since PF may race
> with munmap, may just return the right content or SIGSEGV before the optimization,
> but with the optimization, it may return a zero page. Here use this flag to mark
> PF to this area is unstable, will trigger SIGSEGV, in order to prevent from the
> unexpected 3rd state.
> 
> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, they are considered
> as special mappings. They will be dealt with before zapping pages with write
> mmap_sem held. Basically, just update vm_flags. The actual unmapping is still
> done with read mmap_sem.
> 
> And, since they are also manipulated by unmap_single_vma() which is called by
> zap_page_range() with read mmap_sem held in this case, to prevent from updating
> vm_flags in read critical section and considering the complexity of coding, just
> check if VM_DEAD is set, then skip any VM_DEAD area since they should be handled
> before.
> 
> When cleaning up vmas, just call do_munmap() without carrying vmas from the above
> to avoid race condition, since the address space might be already changed under
> our feet after retaking exclusive lock.
> 
> For the time being, just do this in munmap syscall path. Other vm_munmap() or
> do_munmap() call sites (i.e mmap, mremap, etc) remain intact for stability reason.
> And, make this 64 bit only explicitly per akpm's suggestion.

I still see VM_DEAD as unnecessary complication. We should be fine without it.
But looks like I'm in the minority :/

It's okay. I have another suggestion that also doesn't require VM_DEAD
trick too :)

1. Take mmap_sem for write;
2. Adjust VMA layout (split/remove). After the step all memory we try to
   unmap is outside any VMA.
3. Downgrade mmap_sem to read.
4. Zap the page range.
5. Drop mmap_sem.

I believe it should be safe.

The pages in the range cannot be re-faulted after step 3 as find_vma()
will not see the corresponding VMA and deliver SIGSEGV.

New VMAs cannot be created in the range before step 5 since we hold the
semaphore at least for read the whole time.

Do you see problem in this approach?

-- 
 Kirill A. Shutemov
