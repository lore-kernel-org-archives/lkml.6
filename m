Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7444ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8620685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Qe8NJdwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE8620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbeGWKvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:51:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36754 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbeGWKvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:51:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so14486plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seB4p8Ce99OAz1JgNP1URFi4/nGC1mU2hyKPuBYHYm4=;
        b=Qe8NJdwa+Q4dlh2zHkEFHc6/cZJVppradMxIfeZg9hKxVWJTwMViRXs6Tz5hicHZtY
         u2dfo0uNdfuLKzfFmr1EljBtvt00PgGYmzyOuKdC0JXELTMiuT+EQgCAZXLvNDu8+bYM
         3xQej7QCv6TorRzJ68ypR2mQXO+rf4N0hnyvE6K1tza7sPK/Y5rzZIHeRRbmx1iOYl0n
         DYLu+9QaNS+HDeMgmwQud6PTYk38S93hhMLdA5I/tHkULV989ZL+wYe6zQMZBvmfcal+
         vTX0rKaLiXqAWXvP04O/oY+MQDmQFT9NsQlfu7pX4V50pJgo51cZQkOP9aT7tWbDQLbA
         lAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seB4p8Ce99OAz1JgNP1URFi4/nGC1mU2hyKPuBYHYm4=;
        b=Ltbhn3dc851rDVrMB5VtwUVjRwmya5oWxOTNrkLqVH4o9WjmyFqJX4XvORzdGc+cAk
         ecHslpjSJwlIQwXWC/jg+oW+XAs9GaTprntuXN59qS08VpJ4znZF/rTm141wf5RnUUw3
         Z2ZAUdtfzUzva0N3LijPND8kJDmX1oEubcqKlXxhsragdPeAWWc5MxZ6++I0AHJ5Qe67
         YyqSi8Nih9aJ1R6fUZyeHR2CM3jfNemZIeek6UDGxB4KAYQMfZ/pQzwr4wcSc4y+U/vN
         XKSFjR/8rcwuiEclySFr3NAMn+XkBZ2BMpPtkvPlEEBA3UHSJNsL591C+tC43POnm4Lx
         t8fw==
X-Gm-Message-State: AOUpUlFvzMbYPw6Dbp0YuUm67EivY4OX5CbtWcVXENI1ubpVBEtAJmlc
        /USpBVtCxu9P46+zi37l9iq5nw==
X-Google-Smtp-Source: AAOMgpd5U8t1XxnatmJ3UHCrYFjTNZcBrvSvX/1oIy+kejyTqKm/z4OH5WU0oFYcy6rdHe7Q5wAgCA==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9-v6mr12223639plz.116.1532339444601;
        Mon, 23 Jul 2018 02:50:44 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id d22-v6sm14740187pfk.69.2018.07.23.02.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 02:50:44 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 41A5B303A0F; Mon, 23 Jul 2018 12:50:40 +0300 (+03)
Date:   Mon, 23 Jul 2018 12:50:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 12/19] x86/mm: Implement prep_encrypted_page() and
 arch_free_page()
Message-ID: <20180723095040.w67jp7c7cnxezuwp@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-13-kirill.shutemov@linux.intel.com>
 <a05d800e-4c18-88e0-388c-093fc3dac6ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05d800e-4c18-88e0-388c-093fc3dac6ec@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:53:27PM -0700, Dave Hansen wrote:
> The description doesn't mention the potential performance implications
> of this patch.  That's criminal at this point.
> 
> > --- a/arch/x86/mm/mktme.c
> > +++ b/arch/x86/mm/mktme.c
> > @@ -1,4 +1,5 @@
> >  #include <linux/mm.h>
> > +#include <linux/highmem.h>
> >  #include <asm/mktme.h>
> >  
> >  phys_addr_t mktme_keyid_mask;
> > @@ -49,3 +50,51 @@ int vma_keyid(struct vm_area_struct *vma)
> >  	prot = pgprot_val(vma->vm_page_prot);
> >  	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
> >  }
> > +
> > +void prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
> > +{
> > +	int i;
> > +
> > +	/* It's not encrypted page: nothing to do */
> > +	if (!keyid)
> > +		return;
> 
> prep_encrypted_page() is called in the fast path in the page allocator.
> This out-of-line copy costs a function call for all users and this is
> also out of the reach of the compiler to understand that keyid!=0 is
> unlikely.
> 
> I think this needs to be treated to the inline-in-the-header treatment.

Okay. Again as a macros.

> > +	/*
> > +	 * The hardware/CPU does not enforce coherency between mappings of the
> > +	 * same physical page with different KeyIDs or encryption keys.
> > +	 * We are responsible for cache management.
> > +	 *
> > +	 * We flush cache before allocating encrypted page
> > +	 */
> > +	clflush_cache_range(page_address(page), PAGE_SIZE << order);
> 
> It's also worth pointing out that this must be done on the keyid alias
> direct map, not the normal one.
> 
> Wait a sec...  How do we know which direct map to use?

page_address() -> lowmem_page_address() -> page_to_virt()

page_to_virt() returns virtual address from the right direct mapping.

> > +	for (i = 0; i < (1 << order); i++) {
> > +		/* All pages coming out of the allocator should have KeyID 0 */
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
> > +		lookup_page_ext(page)->keyid = keyid;
> > +
> > +		/* Clear the page after the KeyID is set. */
> > +		if (zero)
> > +			clear_highpage(page);
> > +
> > +		page++;
> > +	}
> > +}
> > +
> > +void arch_free_page(struct page *page, int order)
> > +{
> > +	int i;
> > +
> > +	/* It's not encrypted page: nothing to do */
> > +	if (!page_keyid(page))
> > +		return;
> 
> Ditto on pushing this to a header.
> 
> > +	clflush_cache_range(page_address(page), PAGE_SIZE << order);
> 
> OK, how do we know which copy of the direct map to use, here?

The same way as above.

> > +	for (i = 0; i < (1 << order); i++) {
> > +		/* Check if the page has reasonable KeyID */
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);
> > +		lookup_page_ext(page)->keyid = 0;
> > +		page++;
> > +	}
> > +}
> > 
> 

-- 
 Kirill A. Shutemov
