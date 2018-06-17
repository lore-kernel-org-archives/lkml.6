Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30906C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A0208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFpSDwdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33A0208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFQVqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:46:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36405 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeFQVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:46:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so7180762pfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmMHwZHtwTk5MtQ5AGsD4BaJTg0aDMru7/qm0ousseM=;
        b=FFpSDwdo75tGk2FQ0/wo/Xr7CE8hCKGouksSriupJ0dH1KeI4a4IQmmlQ/Y/efSJrY
         ijXviY79DJhlZot4lz1j02kp2LlOt5oRAYl7FoYG8TP+CrWbO/dyvgU64h9OCi29C8Ks
         GD8dDazelMsMOsHSHIefZm5+zNpsowxUYDqA6AtgQeSkgCACPpmtEHKESmFZVPCKkhTQ
         R4/+6bf0qBDvyMlJvMXsGElc0j3JQtx65GdZwHMxMG1GYRWvbifj0Iceyc0yhoEgv96W
         DixBb7uIWWfaOWRFMVMMdaxXXQDglI/99dQYTTYHtG+zEU7n4Wtis2vSSLwwKbSkmkQa
         CHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmMHwZHtwTk5MtQ5AGsD4BaJTg0aDMru7/qm0ousseM=;
        b=TrMb1i6wZU4u38AT3Fmkp1BZ7Z8sGAVfg/qbnwuSa0lW+8n10vUYGp6DsY23DnaCBV
         G5WKDuIinIezs7IkPczMG3VmxbuYKDaxYfOZTJTAInzk8bubwTc/+6+PSiqP/oGxmzvi
         +levo14CpetzZreRffqt4pPbeAj/1Aw4f21fn7mY7ZbQlv2iIw0vHL07WhNYBlSIe/k2
         XDoKHEmE1F6puUCGSbBIX6QBUC2YGjM6r/ktz9NuAYa+iVvhRreE9YpCHoUzOGwGrrap
         hor7jzj0+i5DNByAJ6d1rRecS/cMg2EXxBGYR+lR7yOlDQlHcMSkhm1sqIXPbYetjyrm
         buAw==
X-Gm-Message-State: APt69E2br8JCMBw4Ey64Zy76X8+Bkl+mvtxaUvAuXMnj/UeIMWGyz7sp
        Pvbxsq8D2nEMmdKEVghvOxCj9Xtgo0E=
X-Google-Smtp-Source: ADUXVKJ1RjD4nAoVswUcekXcHveQVGe68eYypVjISjwx4MlblrqwsNELPzzxzUuZcjno2ub8pS4rmw==
X-Received: by 2002:a62:d8c5:: with SMTP id e188-v6mr10776423pfg.151.1529271968482;
        Sun, 17 Jun 2018 14:46:08 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id r3-v6sm23535099pfl.162.2018.06.17.14.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 14:46:07 -0700 (PDT)
Date:   Mon, 18 Jun 2018 06:46:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mm: Mark pages in use for page tables
Message-ID: <20180617214605.GC24595@lianli.shorne-pla.net>
References: <20180307134443.32646-1-willy@infradead.org>
 <20180307134443.32646-5-willy@infradead.org>
 <20180617150931.GB24595@lianli.shorne-pla.net>
 <20180617185222.GA21805@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617185222.GA21805@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:52:22AM -0700, Matthew Wilcox wrote:
> On Mon, Jun 18, 2018 at 12:09:31AM +0900, Stafford Horne wrote:
> > On Wed, Mar 07, 2018 at 05:44:43AM -0800, Matthew Wilcox wrote:
> > > Define a new PageTable bit in the page_type and use it to mark pages in
> > > use as page tables.  This can be helpful when debugging crashdumps or
> > > analysing memory fragmentation.  Add a KPF flag to report these pages
> > > to userspace and update page-types.c to interpret that flag.
> > 
> > I have bisected a regression on OpenRISC in v4.18-rc1 to this commit.  Using
> > our defconfig after boot I am getting:
> 
> Hi Stafford.  Thanks for the report!
> 
> >     BUG: Bad page state in process hostname  pfn:00b5c
> >     page:c1ff0b80 count:0 mapcount:-1024 mapping:00000000 index:0x0
> >     flags: 0x0()
> >     raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
> >     page dumped because: nonzero mapcount
> >     Modules linked in:
> >     CPU: 1 PID: 38 Comm: hostname Tainted: G    B
> >     4.17.0-simple-smp-07461-g1d40a5ea01d5-dirty #993
> >     Call trace:
> >     [<(ptrval)>] show_stack+0x44/0x54
> >     [<(ptrval)>] dump_stack+0xb0/0xe8
> >     [<(ptrval)>] bad_page+0x138/0x174
> >     [<(ptrval)>] ? ipi_icache_page_inv+0x0/0x24
> >     [<(ptrval)>] ? cpumask_next+0x24/0x34
> >     [<(ptrval)>] free_pages_check_bad+0x6c/0xd0
> >     [<(ptrval)>] free_pcppages_bulk+0x174/0x42c
> >     [<(ptrval)>] free_unref_page_commit.isra.17+0xb8/0xc8
> >     [<(ptrval)>] free_unref_page_list+0x10c/0x190
> >     [<(ptrval)>] ? set_reset_devices+0x0/0x2c
> >     [<(ptrval)>] release_pages+0x3a0/0x414
> >     [<(ptrval)>] tlb_flush_mmu_free+0x5c/0x90
> >     [<(ptrval)>] tlb_flush_mmu+0x90/0xa4
> >     [<(ptrval)>] arch_tlb_finish_mmu+0x50/0x94
> >     [<(ptrval)>] tlb_finish_mmu+0x30/0x64
> >     [<(ptrval)>] exit_mmap+0x110/0x1e0
> >     [<(ptrval)>] mmput+0x50/0xf0
> >     [<(ptrval)>] do_exit+0x274/0xa94
> >     [<(ptrval)>] ? _raw_spin_unlock_irqrestore+0x1c/0x2c
> >     [<(ptrval)>] ? __up_read+0x70/0x88
> >     [<(ptrval)>] do_group_exit+0x50/0x110
> >     [<(ptrval)>] __wake_up_parent+0x0/0x38
> >     [<(ptrval)>] _syscall_return+0x0/0x4
> > 
> > 
> > In this series we are overloading mapcount with page_type, the above is caused
> > due to this check in mm/page_alloc.c (free_pages_check_bad):
> > 
> >         if (unlikely(atomic_read(&page->_mapcount) != -1))
> >                 bad_reason = "nonzero mapcount";
> > 
> > We can see in the dump above that _mapcount is fffffbff, this corresponds to the
> > 'PG_table' flag.  Which was added here.  But it seems for some case in openrisc
> > its not getting cleared during page free.
> > 
> > This is as far as I got tracing it.  It might be an issue with OpenRISC, but our
> > implementation is mostly generic.  I will look into it more in the next few days
> > but I figured you might be able to spot something more quickly.
> 
> More than happy to help.  You've done a great job of debugging this.
> I think the problem is in your __pte_free_tlb definition.  Most other
> architectures are doing:
> 
> #define __pte_free_tlb(tlb, pte, address) pte_free((tlb)->mm, pte)
> 
> while you're doing:
> 
> #define __pte_free_tlb(tlb, pte, addr) tlb_remove_page((tlb), (pte))
> 
> and that doesn't call pgtable_page_dtor().
> 
> Up to you how you want to fix this ;-)  x86 defines a ___pte_free_tlb which
> calls pgtable_page_dtor() before calling tlb_remove_table() as an example.

I will do it the x86 way unless anyone has a concern, I notice a few other do it
this way too.  I have tested it out and it works fine.

Thanks a lot for your help.

-Stafford
