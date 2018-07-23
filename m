Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1729ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709FC20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWuBepB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709FC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeGWXp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:45:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33476 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbeGWXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:45:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id b17-v6so376590pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ibXFQeF0NCfjsnBdh9J6miE8RYtNr5i3hFFO2bWolLs=;
        b=MWuBepB6fdWrpRg2mzjVWegpnVMPI5Nx93B1NJJGUUtDPGILIz1EZ21DvzOWPPhr+O
         G5AXTtZLkg3NLezSfTwdOuWrHSlKGxK8Lc08bsdHdwxzrp5TX2ipKMCi6Cdfol7p+YFV
         jt+wINZcrl2Y66tavVNh11607WlEeLV/HRLa3dIHHWO3UD3OmQKGfn5mkBECRg/DCA2X
         K+33WuvEAMScubYNeOutXFACvbfOYle0gN8eL7Jbh+VbM0k5+cRyxQM35icWu2vCS6zK
         Vc+sW0sZPsmCVMcCGK3AQhHkUA2Ryy6a5Nujp19eKu1nFlpAt1rn3scFco1GnARFiIVX
         Rnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ibXFQeF0NCfjsnBdh9J6miE8RYtNr5i3hFFO2bWolLs=;
        b=alq1drMFYXOMoOwdbI0ngx2Vg9uXLGpwId18dauFkF61J6K7F+KDZ41XEp6jk+LIYq
         2kAGucg313v8Dux86lIxY/I5fi+zQ3xvNgzcfftA/r/FPgLtaHL2sRkdw+QZjH4EqA/7
         RaC556fkF6g/eJ9skpSXDi/zKvyC5FkJTkiUFoOEGo3NP/2VXwYsAm4IoJbIPgB1Ea5P
         QNTlIqomlglOFFBd09B5tN5MUbLPT+jGWhbnbvNtc11ocFZqcHgQuluFTAgSa0qxBhf7
         WziGRPlrwK1pjKdAT4+7wZJ3MqMxhT5Oeu5puRyYvc1jBYMRclIvSvbOi9/wYN7hqrUh
         Yo2A==
X-Gm-Message-State: AOUpUlFy9RDgsgs06Va6MQtnQtGs8w6njudgpxwyfHYaQq883E27zpfT
        Y6fPrF/a7iggTPFT/ZiDt6L/og==
X-Google-Smtp-Source: AAOMgpfc0w5Ijh91bQpywzVOJINWUArMf6uoAeW90ZeCrsOGz/tE3eMVnjsVhv7lWcqFvzv6BLWCOg==
X-Received: by 2002:a65:4c87:: with SMTP id m7-v6mr13679263pgt.98.1532385752365;
        Mon, 23 Jul 2018 15:42:32 -0700 (PDT)
Received: from [100.112.68.191] ([104.133.9.111])
        by smtp.gmail.com with ESMTPSA id z5-v6sm7612938pfi.4.2018.07.23.15.42.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 15:42:31 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:42:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <20180723203628.GA18236@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.1807231531240.2545@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org> <alpine.LSU.2.11.1807221856350.5536@eggly.anvils> <20180723140150.GA31843@bombadil.infradead.org> <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> On Mon, Jul 23, 2018 at 12:14:41PM -0700, Hugh Dickins wrote:
> > On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > > On Sun, Jul 22, 2018 at 07:28:01PM -0700, Hugh Dickins wrote:
> > > > Whether or not that fixed syzbot's kernel BUG at mm/shmem.c:815!
> > > > I don't know, but I'm afraid it has not fixed linux-next breakage of
> > > > huge tmpfs: I get a similar page_to_pgoff BUG at mm/filemap.c:1466!
> > > > 
> > > > Please try something like
> > > > mount -o remount,huge=always /dev/shm
> > > > cp /dev/zero /dev/shm
> > > > 
> > > > Writing soon crashes in find_lock_entry(), looking up offset 0x201
> > > > but getting the page for offset 0x3c1 instead.
> > > 
> > > Hmm.  I don't see a crash while running that command,
> > 
> > Thanks for looking.
> > 
> > It is the VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page)
> > in find_lock_entry(). Perhaps you didn't have CONFIG_DEBUG_VM=y
> > on this occasion? Or you don't think of an oops as a kernel crash,
> > and didn't notice it in dmesg? I see now that I've arranged for oops
> > to crash, since I don't like to miss them myself; but it is a very
> > clean oops, no locks held, so can just kill the process and continue.
> 
> Usually I run with that turned on, but somehow in my recent messing
> with my test system, that got turned off.  Once I turned it back on,
> it spots the bug instantly.
> 
> > Or is there something more mysterious stopping it from showing up for
> > you? It's repeatable for me. When not crashing, that "cp" should fill
> > up about half of RAM before it hits the implicit tmpfs volume limit;
> > but I am assuming a not entirely fragmented machine - it does need
> > to allocate two 2MB pages before hitting the VM_BUG_ON_PAGE().
> 
> I tried that too, before noticing that DEBUG_VM was off; raised my test
> VM's memory from 2GB to 8GB.
> 
> > Are you sure that those pages are free, rather than most of them tails
> > of one of the two compound pages involved? I think it's the same in your
> > rewrite of struct page, the compound_head field (lru.next), with its low
> > bit set, were how to recognize a tail page.
> 
> Yes, PageTail was set, and so was TAIL_MAPPING (0xdead0000000000400).
> What was going on was the first 2MB page was being stored at indices
> 0-511, then the second 2MB page was being stored at indices 64-575
> instead of 512-1023.
> 
> I figured out a fix and pushed it to the 'ida' branch in
> git://git.infradead.org/users/willy/linux-dax.git

Great, thanks a lot for sorting that out so quickly. But I've cloned
the tree and don't see today's patch, so assume you've folded the fix
into an existing commit? If possible, please append the diff of today's
fix to this thread so that we can try it out. Or if that's difficult,
please at least tell which files were modified, then I can probably
work it out from the diff of those files against mmotm.

Thanks,
Hugh

> 
> It won't be in linux-next tomorrow because the nvdimm people have
> just dumped a pile of patches into their tree that conflict with
> the XArray-DAX rewrite, so Stephen has pulled the XArray tree out
> of linux-next temporarily.  I didn't have time to sort out the merge
> conflict today because I judged your bug report more important.
