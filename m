Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F1FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0221529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="f3DS8B3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF0221529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeITRIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:08:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46226 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeITRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:08:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id t20-v6so768623ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D0Kw1I77Y0l6xXuP9N5z5PHtctpMF/iQTka3d0Nvzpo=;
        b=f3DS8B3pYUaNAz6SOyaSWXHhDsBCNqgFKOA6L3ENamt5p7QsIUPesQjfq8G/RCNQyL
         ruHHjH8NwuZuyWnmR6umbQOU2JngK1JXPaWtywEIH+i/IgygBLRjOVKupVs8RsvlCU4H
         piAC0FQPeiRigPOPlw+ui5uvUPi3tzM3l0JBCLvMb0psIogxZ9h85jul0mfyfyVr6XoU
         DW5MeyPuYVm4UpdTY3sDiX/0qCm9XhwYIqc4lE+VfQWtn6TtE3grDv6LWBUXglu6XYcF
         o9z7zi+lYp9CW1EDo6cDPl56zzQRdbMWeVYqiHGebnQJBKMNvCqM9ZOt2/ylBvl7LR36
         fPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0Kw1I77Y0l6xXuP9N5z5PHtctpMF/iQTka3d0Nvzpo=;
        b=CM2GcVqu9+Gia4omwdCukOfHDWsdLmD6/BtqSGUByDFKc9J5JHjoElZUBv488XHfQc
         4IGtgfhF1ibn5IwGwnIIlXNNvETj7da7Y8d+yLmFjUiWTIAKyW8DQPBQlnRDjZp2esHH
         EOwASutjkXKDqbvFgwlRHf2E4/ojVrI/6w/ZYwJRHsUk1QhB9RGgmolsS59oBVw8sM9H
         ggE/Li5Im4dV59wButNEFm0tjUw2LPKqlVozNyzeIVhUaIQiYlg5iIQuunihK8wcxyvJ
         Hpu/ZxNbPGjz4QALjmvsSmqtA9CtvzIR+xTVzn3CiyklEfRmX+xcJeJnj5cPPn8g4veK
         aKQA==
X-Gm-Message-State: APzg51A+emXybYxAenmIZ6OAnR3aDiI13VEsn6BSE51zx+c8Fz2NsPdQ
        hgjZUHTJZxyZ1b7Tg+VVd7H9u+L44EMA6w==
X-Google-Smtp-Source: ANB0VdZ6MxPDPt1R7vaDdW/yjmsMKRfruBlRh9Ml1IfSU/TK+maq+Ih1Dl5nuizVz5BvV3ny1zAJrw==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6-v6mr39142115pls.117.1537442746247;
        Thu, 20 Sep 2018 04:25:46 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id j184-v6sm31229454pge.77.2018.09.20.04.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 04:25:45 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 50D8E300527; Thu, 20 Sep 2018 14:25:37 +0300 (+03)
Date:   Thu, 20 Sep 2018 14:25:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Recheck page table entry with page table lock held
Message-ID: <20180920112536.52jpx4sptrvbnyul@kshutemo-mobl1>
References: <20180920092408.9128-1-aneesh.kumar@linux.ibm.com>
 <20180920110538.rlcpw75eabkqudkl@kshutemo-mobl1>
 <a22a21d6-c872-63e9-77ec-8071bac9bfc9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22a21d6-c872-63e9-77ec-8071bac9bfc9@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 04:41:59PM +0530, Aneesh Kumar K.V wrote:
> On 9/20/18 4:35 PM, Kirill A. Shutemov wrote:
> > On Thu, Sep 20, 2018 at 02:54:08PM +0530, Aneesh Kumar K.V wrote:
> > > We clear the pte temporarily during read/modify/write update of the pte. If we
> > > take a page fault while the pte is cleared, the application can get SIGBUS. One
> > > such case is with remap_pfn_range without a backing vm_ops->fault callback.
> > > do_fault will return SIGBUS in that case.
> > 
> > It would be nice to show the path that clears pte temporarily.
> > 
> > > Fix this by taking page table lock and rechecking for pte_none.
> 
> 
> we do that in the ptep_modify_prot_start/ptep_modify_prot_commit. Also in
> hugetlb_change_protection. The hugetlb case many not be relevant because
> that cannot be backed by a vma without vma->vm_ops.
> 
> What will hit this will be mprotect of a remap_pfn_range address?

Sounds right. Please update commit message.
> 
> > > 
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   mm/memory.c | 31 +++++++++++++++++++++++++++----
> > >   1 file changed, 27 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index c467102a5cbc..c2f933184303 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3745,10 +3745,33 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
> > >   	struct vm_area_struct *vma = vmf->vma;
> > >   	vm_fault_t ret;
> > > -	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
> > > -	if (!vma->vm_ops->fault)
> > > -		ret = VM_FAULT_SIGBUS;
> > > -	else if (!(vmf->flags & FAULT_FLAG_WRITE))
> > > +	/*
> > > +	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
> > > +	 */
> > > +	if (!vma->vm_ops->fault) {
> > > +
> > > +		/*
> > > +		 * pmd entries won't be marked none during a R/M/W cycle.
> > > +		 */
> > > +		if (unlikely(pmd_none(*vmf->pmd)))
> > > +			ret = VM_FAULT_SIGBUS;
> > > +		else {
> > > +			vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> > > +			/*
> > > +			 * Make sure this is not a temporary clearing of pte
> > > +			 * by holding ptl and checking again. A R/M/W update
> > > +			 * of pte involves: take ptl, clearing the pte so that
> > > +			 * we don't have concurrent modification by hardware
> > > +			 * followed by an update.
> > > +			 */
> > > +			spin_lock(vmf->ptl);
> > > +			if (unlikely(pte_none(*vmf->pte)))
> > > +				ret = VM_FAULT_SIGBUS;
> > > +			else
> > > +				ret = VM_FAULT_NOPAGE;
> > 
> > We return 0 if we did nothing in fault path.
> > 
> 
> I didn't get that. If we find the pte not none, we return so that we retry
> the access. Are you suggesting VM_FAULT_NOPAGE is not the right return for
> that?

We usually use VM_FAULT_NOPAGE to indicate that ->fault() installed the
pte and we don't need to do anything. We don't touch pte in this page
fault.

It doesn't make difference in this particular case, nobody cares upper by
stack. Just a nitpick.

-- 
 Kirill A. Shutemov
