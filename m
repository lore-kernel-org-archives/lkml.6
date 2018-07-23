Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6DE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Iab5QCTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6DE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbeGWLMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:12:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43613 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbeGWLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:12:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so44777pgr.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OUS1htVp6+P4rXegZC8xT6XmUfNXx2uDCrdTRyrHXd0=;
        b=Iab5QCThTYTHyvgOyR5ZJulJ2pJWbal59Q1sQg03+YbPxzKRPRi/YEkRpjz6egGYy5
         qX/b6NdTixcXrJTtyKC8hbeGoVuVF61Kusz4I0jU6hC0SAiqxS0jg9+OzEwGB1Y8vGUD
         sPRvaUCxA0J48wIgFFFnbUSyMAwXDCJ0yaAIqoPGaJz1qyl9Bm2FflohfFUC6nzR5bng
         5rwSufrbsl4izo9kWMu1AvT/Ml/yp3P+hTuM29971dqXIrYHD2YBlbEknYJLhlLUEQ8Y
         JoICtcTO1SY7jsVwjmqi4NiSw2eRvnoZQxA1TMK3RPiaCEFjrstYnSnvkJtTakDOBQg8
         wjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUS1htVp6+P4rXegZC8xT6XmUfNXx2uDCrdTRyrHXd0=;
        b=KXnRVY3f9/og1fucIU5bxWFsggDDC/DO6dJeTMWQFf1wcl8dKF0SM0qoXl9bDBnqWb
         kKf0J1OpqwFp8ch76lxx4gVnqZm1es4Tz7Dpe+sUaWnXELjgJU7rGHk0QkgJg5kurheH
         3lGpncLl9E51z5/Hr8RJdJ4NZ8ZF7L9PGHLDB9UMPsrJwfFpe9/hnmy9yfESc1poT1Fp
         l7YzWExWg4hrtxJZ7b5/lclhF0FqPEWW+MihWB9FWmmVlMZ/aqNy78OWQV8YRQpUCD2H
         C1gvRu15Omld0kfvIt++LFKhGoguW0PgKjljitpd4ym3Y/B7Lq9F1VfRnFYwJ89YnPG8
         jLyQ==
X-Gm-Message-State: AOUpUlEolSNEkVq3D7CsxpFEv3bDQaJAWgLDDjQb0gKBKjwNdURwea2y
        25es2EHgXEKNzKfTaFlGTDtgwQ==
X-Google-Smtp-Source: AAOMgpe/u+/GchDvhkOAHtwb8MLtyWKB+hlz5ngKXVHBl/sADDZRmR4eeH7ujdGVEDq6jv3pSUUlRg==
X-Received: by 2002:a63:81c3:: with SMTP id t186-v6mr11872998pgd.413.1532340729969;
        Mon, 23 Jul 2018 03:12:09 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id d81-v6sm22221549pfj.122.2018.07.23.03.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 03:12:09 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 343C1303B2F; Mon, 23 Jul 2018 13:12:03 +0300 (+03)
Date:   Mon, 23 Jul 2018 13:12:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 18/19] x86/mm: Handle encrypted memory in
 page_to_virt() and __pa()
Message-ID: <20180723101201.wjbaktmerx3yiocd@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-19-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1807182356520.1689@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807182356520.1689@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:21:44AM +0200, Thomas Gleixner wrote:
> On Tue, 17 Jul 2018, Kirill A. Shutemov wrote:
> 
> > Per-KeyID direct mappings require changes into how we find the right
> > virtual address for a page and virt-to-phys address translations.
> > 
> > page_to_virt() definition overwrites default macros provided by
> > <linux/mm.h>. We only overwrite the macros if MTKME is enabled
> > compile-time.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mktme.h   | 3 +++
> >  arch/x86/include/asm/page_64.h | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> > index ba83fba4f9b3..dbfbd955da98 100644
> > --- a/arch/x86/include/asm/mktme.h
> > +++ b/arch/x86/include/asm/mktme.h
> > @@ -29,6 +29,9 @@ void arch_free_page(struct page *page, int order);
> >  
> >  int sync_direct_mapping(void);
> >  
> > +#define page_to_virt(x) \
> > +	(__va(PFN_PHYS(page_to_pfn(x))) + page_keyid(x) * direct_mapping_size)
> 
> This really does not belong into the mktme header.
> 
> Please make this the unconditional x86 page_to_virt() implementation in
> asm/page.h, which is the canonical and obvious place for it.

Okay. (and I owe Dave a beer on this :P)

> The page_keyid() name is quite generic as well. Can this please have some
> kind of reference to the underlying mechanism, i.e. mktme?

Hm. I intentially get the name generic. It used outside arch/x86.

We can have an alias (mktme_page_keyid() ?) to be used in arch/x86 to
indicate undelying mechanism.

Is it what you want to see?

> Please hide the multiplication with direct_mapping_size in the mktme header
> as well. It's non interesting for the !MKTME case. Something like:
> 
> #define page_to_virt(x) \
> 	(__va(PFN_PHYS(page_to_pfn(x))) + mktme_page_to_virt_offset(x))
> 
> makes it immediately clear where to look and also makes it clear that the
> offset will be 0 for a !MKTME enabled kernel and (hopefully) for all !MKTME
> enabled processors as well.
> 
> And then have a proper implementation of mktme_page_to_virt_offset() with a
> proper comment what on earth this is doing. It might be all obvious to you
> now, but it's completely non obvious for the casual reader and you will
> have to twist your brain around it 6 month from now as well.

Sure.

> >  #else
> >  #define mktme_keyid_mask	((phys_addr_t)0)
> >  #define mktme_nr_keyids		0
> > diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> > index f57fc3cc2246..a4f394e3471d 100644
> > --- a/arch/x86/include/asm/page_64.h
> > +++ b/arch/x86/include/asm/page_64.h
> > @@ -24,7 +24,7 @@ static inline unsigned long __phys_addr_nodebug(unsigned long x)
> >  	/* use the carry flag to determine if x was < __START_KERNEL_map */
> >  	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
> >  
> > -	return x;
> > +	return x & direct_mapping_mask;
> 
> This hunk also lacks any explanation both in the changelog and in form of a
> comment.

I'll fix it.

> > Per-KeyID direct mappings require changes into how we find the right
> > virtual address for a page and virt-to-phys address translations.
> 
> That's pretty useless as it does just tell about 'changes', but not at all
> about what kind of changes and why these changes are required. It's really
> not helpful to assume that everyone stumbling over this will know the whole
> story especially not 6 month after this has been merged and then someone
> ends up with a bisect on that change.
> 
> While at it, please get rid of the 'we'. We are neither CPUs nor code.

Okay. I'll rewrite this.

-- 
 Kirill A. Shutemov
