Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D623D4C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9vJJFMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D623D4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeFVEx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:53:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44018 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeFVExY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:53:24 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so2837398plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8+qMHzZIx+mdLYxwduEyc3SV+K3dZR8NDGDti6KiHc=;
        b=J9vJJFMhFZ3gaGz3gRoJE7I6ubZg1TGLRXt9yRkOFs2qq46UEkwJTwB9rATGWp9efy
         iFDNMUCk6ikw8VDUIJmbOgmKtbbeCLJryg9m73o3Yro9wl5Mv0MwJ7zn7BgBxTLLDZ4k
         tiOmCB6i6swePUcJpu5g4vqC7kkUumbcPNFUcWWNXPBlzLPevwa03JMPJonzmqZuhAfi
         w5A6lo8q6kdlDtWFjpkK3SNIW3hAKxEuJ+qW1zhh3ewB2BRLxNvCnCqBEPnMbpmjAp0m
         fvstUeLQE3FLrSibIssKKajOlCwPTsG6gsr92erEDakN39Aal0XGjDCgm8AbDXRY7HdS
         nWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8+qMHzZIx+mdLYxwduEyc3SV+K3dZR8NDGDti6KiHc=;
        b=QEkBpPYVWzLD1ina/RPYN0sfDCwsRvQfY98T6Q1/HTKUUUvd3w/dN5nCwDAT74+/Fe
         HG324HgS0X7RigxwnKrEAA/DJ0s2mZNCOnDmNkz5p014POqWlWivsoLWO0fZJb7G/+lP
         9563kWHN3bQ2EKdDmBMV6fIga/9KAVGSbeqPRibQ8YMSXaYJ89R7dTTcoJBqXRK56rTr
         jqQTv4crzr0brNP3dg10AJT47CdZwoYNZ/9Z1NGm7RfXnxbDWRXJToqOn6/s2adsvTc7
         oLB+t5BNV9a0B5WuwCrOjIpBVgGbaQ4tGyPQWOVsiXFOJ10VWtkMaWEP384zo0yQqglr
         VPOw==
X-Gm-Message-State: APt69E1HmA8lT+ZhhuZYv0vAff7QMc4XgscbwDONkW1u5praykvRTTuY
        BvvkLudmzLP7+RTLNdtkgzA=
X-Google-Smtp-Source: ADUXVKIL69wC1f5+r82VAKxQGyugo2JghiILFEeGd565f+pmcfeaigvImLCgjmNEnWj6U7QGn8Dj+w==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr46873pls.37.1529643204475;
        Thu, 21 Jun 2018 21:53:24 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (s169.156.222.122.fls.vectant.ne.jp. [122.222.156.169])
        by smtp.gmail.com with ESMTPSA id q24-v6sm9684311pfh.26.2018.06.21.21.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 21:53:23 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:53:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA
 API
Message-ID: <20180622145317.668cdafa@roar.ozlabs.ibm.com>
In-Reply-To: <20180622043815.GA31255@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
        <20180621212835.5636-14-willy@infradead.org>
        <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
        <20180622043815.GA31255@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 21:38:15 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 22, 2018 at 12:15:11PM +1000, Nicholas Piggin wrote:
> > On Thu, 21 Jun 2018 14:28:22 -0700
> > Matthew Wilcox <willy@infradead.org> wrote:  
> > >  static int alloc_context_id(int min_id, int max_id)  
> ...
> > > -	spin_lock(&mmu_context_lock);
> > > -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
> > > -	spin_unlock(&mmu_context_lock);  
> ...
> > > @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
> > >  {
> > >  	int index, context_id;
> > >  
> > > -	spin_lock(&mmu_context_lock);
> > >  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
> > >  		context_id = ctx->extended_id[index];
> > >  		if (context_id)
> > > -			ida_remove(&mmu_context_ida, context_id);
> > > +			ida_free(&mmu_context_ida, context_id);
> > >  	}
> > > -	spin_unlock(&mmu_context_lock);
> > >  }
> > >  
> > >  static void pte_frag_destroy(void *pte_frag)  
> > 
> > This hunk should be okay because the mmu_context_lock does not protect
> > the extended_id array, right Aneesh?  
> 
> That's my understanding.  The code today does this:
> 
> static inline int alloc_extended_context(struct mm_struct *mm,
>                                          unsigned long ea)
> {
>         int context_id;
> 
>         int index = ea >> MAX_EA_BITS_PER_CONTEXT;
> 
>         context_id = hash__alloc_context_id();
>         if (context_id < 0)
>                 return context_id;
> 
>         VM_WARN_ON(mm->context.extended_id[index]);
>         mm->context.extended_id[index] = context_id;
> 
> so it's not currently protected by this lock.  I suppose we are currently
> protected from destroy_contexts() being called twice simultaneously, but
> you'll notice that we don't zero the array elements in destroy_contexts(),
> so if we somehow had a code path which could call it concurrently, we'd
> be seeing warnings when the second caller tried to remove the context

Yeah that'd be an existing bug.

> IDs from the IDA.  I deduced that something else must be preventing
> this situation from occurring (like, oh i don't know, this function only
> being called on process exit, so implicitly only called once per context).

I think that's exactly right.

Thanks,
Nick
