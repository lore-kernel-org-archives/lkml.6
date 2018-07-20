Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6946FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146D420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="T72rB7Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146D420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbeGTNbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:07 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36982 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbeGTNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:06 -0400
Received: by mail-pg1-f170.google.com with SMTP id n7-v6so6809643pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfBdQniUB9bdKP6xaDSKOtdMjQtgEZeyYrQxnd5Vw0U=;
        b=T72rB7YzA58+6ElNFB3+liZx04korcF3rBD4SgW5RYBFaccmeRMl4mlf28DC4RoIfo
         JMYTCWiBK9HQrbseLREC2IA/A0Qj1zNJ/sq+Rjx+O2NZoco+Wi1Pou4xJvOAIU0IqGTD
         VNU+muS4YhLt6kcgubwbsIFAofmaS6sxybNTf6mQSpTwumGPCb1m+7ufYrpGqN5JcEht
         /1GGBVsNtchaPdvPimfQW6SFbl10nsLJc4LEkUDPzOGC3LAMjQREuqcHQYXNkpmy78+0
         G9zdKwxgEgF9+IFsiY1Ge+MGJA/LwIy9Yg6dC3nWHxEGlB6yNxF5QqRCJ6r1Y2iYBbQh
         SdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfBdQniUB9bdKP6xaDSKOtdMjQtgEZeyYrQxnd5Vw0U=;
        b=hELPFibxFtBUQbZWu+pg5jmvPaK1T4T4bl87GDjB7PpGtbol7QcGWSd0Zu9rbjxoi/
         gUs2H0ivfihleWU4B/yWgS3JB0/9vjHk+qx2Iq5UKFuCPkFR7vFr0fGuEmhuP6Ci5cZp
         f+llTczZ25kcOs1G9ijc6034Mxgb3YdrQJkbE1n18TGl0Nngj6R8WRWbXrYgPcmJrIYW
         AEx37XJngaZMsHmGRdy1iR5kemlNT6Mr+pPzu6ucC4gNoWF/XI1rIgceDJ+tG7XAgaB4
         Ru9OTOpZyuBPVfT9aykymc6TZfYsJ2M/QM5W1jkIIPdAOaPhz4nxB7QD8uH7kHU9KOQJ
         +IFw==
X-Gm-Message-State: AOUpUlH8PR95+rE8bquTtPwFxyZeOA2hl5Twp1/87Knv1UXP2BlmEL1I
        Omgd2BXRTu1HP7B+Khpld/Vb4Q==
X-Google-Smtp-Source: AAOMgpdiFzO1OrfsAIkzA0bYl+kcFHD8pMoZmnb1ct/TWJVbxxGyulvw7SEto3AsqBRWFfQ2b6U/rA==
X-Received: by 2002:a63:2dc1:: with SMTP id t184-v6mr1979381pgt.62.1532090580816;
        Fri, 20 Jul 2018 05:43:00 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id g11-v6sm2505536pfh.63.2018.07.20.05.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:43:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 9FF13300254; Fri, 20 Jul 2018 15:42:56 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:42:56 +0300
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
Subject: Re: [PATCHv5 09/19] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20180720124256.nvtw4mw2lcjkfrte@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-10-kirill.shutemov@linux.intel.com>
 <202c809d-8720-8dbb-51f5-1018e947a62a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202c809d-8720-8dbb-51f5-1018e947a62a@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:30:35PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > An encrypted VMA will have KeyID stored in vma->vm_page_prot. This way
> > we don't need to do anything special to setup encrypted page table
> > entries
> 
> We don't do anything special for protection keys, either.  They just
> work too.
> 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 99fff853c944..3731f7e08757 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -120,8 +120,21 @@
> >   * protection key is treated like _PAGE_RW, for
> >   * instance, and is *not* included in this mask since
> >   * pte_modify() does modify it.
> > + *
> > + * They include the physical address and the memory encryption keyID.
> > + * The paddr and the keyID never occupy the same bits at the same time.
> > + * But, a given bit might be used for the keyID on one system and used for
> > + * the physical address on another. As an optimization, we manage them in
> > + * one unit here since their combination always occupies the same hardware
> > + * bits. PTE_PFN_MASK_MAX stores combined mask.
> > + *
> > + * Cast PAGE_MASK to a signed type so that it is sign-extended if
> > + * virtual addresses are 32-bits but physical addresses are larger
> > + * (ie, 32-bit PAE).
> >   */
> 
> Could you please make the comment block consistent?  You're a lot wider
> than the comment above.

Okay.

> > -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> > +#define PTE_PFN_MASK_MAX \
> > +	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> > +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >  			 _PAGE_SOFT_DIRTY)
> 
> Man, I'm not a fan of this.  This saves us from consuming 6 VM_HIGH bits
> (which we are not short on).  But, at the cost of complexity.

15, not 6. We have up-to 15 KeyID bits architecturally.

We can just have a separate field in vm_area_struct if we must.
But vm_page_prot work fine so far. I don't see a big reasone to change
them.

> Protection keys eat up PTE space and have an interface called
> pkey_mprotect().  MKTME KeyIDs take up PTE space and will probably have
> an interface called something_mprotect().  Yet, the implementations are
> going to be _very_ different with pkeys being excluded from
> _PAGE_CHG_MASK and KeyIDs being included.
> 
> I think you're saved here because we don't _actually_ do pte_modify() on
> an existing PTE: we blow the old one away upon encrypted_mprotect() and
> replace the PTE with a new one.
> 
> But, this is incompatible with any case where we want to change the
> KeyID and keep the old PTE target.  With AES-XTS, I guess this is a safe
> assumption, but it's worrying.
> 
> Are there scenarios where we want to keep PTE contents, but change the
> KeyID?

I don't see such scenario.

If for some reason we would need to map the same memory with different
KeyID it can be done from scratch. Without modifing existing mapping.

-- 
 Kirill A. Shutemov
