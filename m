Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E7EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9D123EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YXXkxjJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D123EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeGCIIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:08:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43427 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeGCIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:08:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so622309pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRXpUWYXVLFYd8d3H11qZaENAVUpmq1GFehxCVK/qmQ=;
        b=YXXkxjJUBxgVieYunDkNl8sD8Kl+SG1lcOLWqxWJNYJWfIk8C/8hd6Yt3OUM1kuepC
         Ip57M9CVrmYlghlwryrTFCq/Qxu6hamue8wjSXEtEjyVtW5cNlXFClc6Dc7NPrmJKISL
         NWEWHzr5PJWe0LeHmukG7QFRKqyhWYy7T7s8CryRbLooS59T81eSj+cAOiU0WamvnkGr
         rURBK8iF1rgeBijSZUILWGJ8cpJ6VFqbAUERwK6N+kvSp8BfXzr7aMGuDmEcLLqSKm9k
         dwoeqN9Mip+ZYtlbCxy/rRyfIyI0JC3djjdf0TOyovy0KEu/TE0r3YVCQLjy7zgxZb8V
         EybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRXpUWYXVLFYd8d3H11qZaENAVUpmq1GFehxCVK/qmQ=;
        b=gQxvjkqbGlI5+CbDBlOuuva1Hf/Tc83ILOAzVM8LRkihtjJT3Y7vxZo/LRihc7sSAi
         ChQ4fHtOtqziPtRZR1BQmKSYQ+FN9U0b46Hp8+BzzU4zK5AAe0z1pXj3a28hopsz9xfN
         AEEKeQWVeP5lJXSy/CGsPNz9PPpUO/NRpMLPeTrfdJT+gjltMVm7oQbbsY5d0Li2ymHX
         WMibHUFmd53ky28PuOJUIU4lkwLM3Ml9E99HzWiWIQ2+kuGmEdpi7kWvZe4vqZUovdls
         IqVqAZSq0Uf6iYnuznMRY4jLtLcPzgVCYE4zAQB4WsoNyTOULLmTM0fYQ3JGVCG1HJKp
         x5cQ==
X-Gm-Message-State: APt69E2BhqHiDK1w14QYbc0T8c7S2yA+/mmaE+kokEpc0tGI7hbFBU/1
        xN2cTzwChOIBEWEWQ2byoHqNjw==
X-Google-Smtp-Source: AAOMgpcFL5hZGNK7PhpTw57Khl8j2k63G+cza/cpyYJ522W39nhM3YqJF69DnKU4wURclBXQGdWFaw==
X-Received: by 2002:a63:6e0a:: with SMTP id j10-v6mr8026499pgc.321.1530605283876;
        Tue, 03 Jul 2018 01:08:03 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id p2-v6sm1128156pgq.14.2018.07.03.01.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:08:02 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E9AEB30003C; Tue,  3 Jul 2018 11:07:57 +0300 (+03)
Date:   Tue, 3 Jul 2018 11:07:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180703080757.jryyxefaehil3yt3@kshutemo-mobl1>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180702123350.dktmzlmztulmtrae@kshutemo-mobl1>
 <17c04c38-9569-9b02-2db2-7913a7debb46@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c04c38-9569-9b02-2db2-7913a7debb46@linux.alibaba.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:19:32AM -0700, Yang Shi wrote:
> 
> 
> On 7/2/18 5:33 AM, Kirill A. Shutemov wrote:
> > On Sat, Jun 30, 2018 at 06:39:44AM +0800, Yang Shi wrote:
> > > When running some mmap/munmap scalability tests with large memory (i.e.
> > > > 300GB), the below hung task issue may happen occasionally.
> > > INFO: task ps:14018 blocked for more than 120 seconds.
> > >         Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
> > >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > > message.
> > >   ps              D    0 14018      1 0x00000004
> > >    ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
> > >    ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
> > >    00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
> > >   Call Trace:
> > >    [<ffffffff817154d0>] ? __schedule+0x250/0x730
> > >    [<ffffffff817159e6>] schedule+0x36/0x80
> > >    [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
> > >    [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
> > >    [<ffffffff81717db0>] down_read+0x20/0x40
> > >    [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
> > >    [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
> > >    [<ffffffff81241d87>] __vfs_read+0x37/0x150
> > >    [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
> > >    [<ffffffff81242266>] vfs_read+0x96/0x130
> > >    [<ffffffff812437b5>] SyS_read+0x55/0xc0
> > >    [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
> > > 
> > > It is because munmap holds mmap_sem from very beginning to all the way
> > > down to the end, and doesn't release it in the middle. When unmapping
> > > large mapping, it may take long time (take ~18 seconds to unmap 320GB
> > > mapping with every single page mapped on an idle machine).
> > > 
> > > It is because munmap holds mmap_sem from very beginning to all the way
> > > down to the end, and doesn't release it in the middle. When unmapping
> > > large mapping, it may take long time (take ~18 seconds to unmap 320GB
> > > mapping with every single page mapped on an idle machine).
> > > 
> > > Zapping pages is the most time consuming part, according to the
> > > suggestion from Michal Hock [1], zapping pages can be done with holding
> > > read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
> > > mmap_sem to cleanup vmas. All zapped vmas will have VM_DEAD flag set,
> > > the page fault to VM_DEAD vma will trigger SIGSEGV.
> > > 
> > > Define large mapping size thresh as PUD size or 1GB, just zap pages with
> > > read mmap_sem for mappings which are >= thresh value.
> > > 
> > > If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, then just
> > > fallback to regular path since unmapping those mappings need acquire
> > > write mmap_sem.
> > > 
> > > For the time being, just do this in munmap syscall path. Other
> > > vm_munmap() or do_munmap() call sites remain intact for stability
> > > reason.
> > > 
> > > The below is some regression and performance data collected on a machine
> > > with 32 cores of E5-2680 @ 2.70GHz and 384GB memory.
> > > 
> > > With the patched kernel, write mmap_sem hold time is dropped to us level
> > > from second.
> > > 
> > > [1] https://lwn.net/Articles/753269/
> > > 
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/mmap.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 134 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 87dcf83..d61e08b 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2763,6 +2763,128 @@ static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
> > >   	return 1;
> > >   }
> > > +/* Consider PUD size or 1GB mapping as large mapping */
> > > +#ifdef HPAGE_PUD_SIZE
> > > +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
> > > +#else
> > > +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
> > > +#endif
> > PUD_SIZE is defined everywhere.
> 
> If THP is defined, otherwise it is:
> 
> #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })

I'm talking about PUD_SIZE, not HPAGE_PUD_SIZE.

-- 
 Kirill A. Shutemov
