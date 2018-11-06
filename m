Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEAB20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLz6Fvi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEAB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeKGGdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:33:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37481 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbeKGGdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:33:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so6781180pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cuz2i+4DuzJaj/42BHCpmW81c9M9VO7m6Xb305qzI4E=;
        b=NLz6Fvi9XYbJfCb0ISzj/R6VfJMJutykOf7QMw1HBsMU3/n0N2jwuM+AyNmHbtT6Ic
         hzZy/G4ZIgiVxAVoq5aSuEJ6ICAxRuAu3BddCWyzBA9fEXSLt8KdT3lXixuEZQi7Fr97
         MsKFO2LJV1ySfDsrvw1u0DNicIMb0hLc5Y9r4Np1pIENsg8WhBQWQTBWUqRWKVN8MOUc
         EPAkHQsb5Inxa6Jlge3FRrw84d88PkcyVlJbhDp8eE4LbL9+gVUEh0H6J6vidiKSn0Zf
         VvAuTkMbzbkmiC03kd7Tuz4JYslbn28YkARXvLkPWmsVBWo4kwCD29SQbc69tBOpIORD
         W8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cuz2i+4DuzJaj/42BHCpmW81c9M9VO7m6Xb305qzI4E=;
        b=Dzz1KMTRAZONsBcSCLBnX7aSZrtyuXzWNL2/VzIhTNDxORwVZ2kCE9P7M/rGpmCyig
         Mww6/L0kzz6ZUy9XEOVaG3wxrageCq0qspeh10ruDmyBcrFgihMYPuN2MM1JCTzIu9XR
         6YxhkJpU4ySbxD4SKzEuNPGtHJo+rFqiJQO2OpxkTLwVZLt6jPre4Ek0qacy5iSy/CMI
         kOedhQhtcv3g/zVAr3PwxtIohELy9+2hr9CoIP4j6hx9DMaOGDAair026s3nIDNc3EJe
         fGrUHd1eGSTCumzMfDoAkI96b8f6L1M0VEFkPDTSH9IuQt3Fa4gKigc5/4b7TDhig0vt
         dziQ==
X-Gm-Message-State: AGRZ1gIasf31gF3aU7XEbVY4TKRGQ4ZxCK4RtZSTuLCfOJvu+c8x5EpE
        2u4uD9DR+hBJ6aSISwmz5XvbPA==
X-Google-Smtp-Source: AJdET5dlXKg81/+9+p6r+vlnP1LBbDlX3U0NMPLAQru+D3qB/tJMPZEozJ1DuhgohT0m5zmLmMLY7w==
X-Received: by 2002:a17:902:64:: with SMTP id 91-v6mr28140715pla.161.1541538359810;
        Tue, 06 Nov 2018 13:05:59 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id 186-v6sm10087064pfe.39.2018.11.06.13.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 13:05:59 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:05:53 -0500
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Radim =?UTF-8?B?S3LEjW3DocWZ?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181106160553.5a8025ed@gnomeregan.cam.corp.google.com>
In-Reply-To: <20181029210716.212159-1-brho@google.com>
References: <20181029210716.212159-1-brho@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-29 at 17:07 Barret Rhoden <brho@google.com> wrote:
> Another issue is that kvm_mmu_zap_collapsible_spte() also uses
> PageTransCompoundMap() to detect huge pages, but we don't have a way to
> get the HVA easily.  Can we just aggressively zap DAX pages there?

Any thoughts about this?  Is there a way to determine the HVA or GFN in
this function:

static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,                        
                                         struct kvm_rmap_head *rmap_head)        
{       
        u64 *sptep;                                                              
        struct rmap_iterator iter;                                               
        int need_tlb_flush = 0;
        kvm_pfn_t pfn;
        struct kvm_mmu_page *sp;
                                                                                 
restart:        
        for_each_rmap_spte(rmap_head, &iter, sptep) {
                sp = page_header(__pa(sptep));
                pfn = spte_to_pfn(*sptep);

                /*
                 * We cannot do huge page mapping for indirect shadow pages,     
                 * which are found on the last rmap (level = 1) when not using   
                 * tdp; such shadow pages are synced with the page table in      
                 * the guest, and the guest page table is using 4K page size     
                 * mapping if the indirect sp has level = 1.                     
                 */     
                if (sp->role.direct &&                                           
                        !kvm_is_reserved_pfn(pfn) &&                             
                        PageTransCompoundMap(pfn_to_page(pfn))) {                
                        pte_list_remove(rmap_head, sptep);                       
                        need_tlb_flush = 1;                                      
                        goto restart;                                            
                }                                                                
        }
                                   
        return need_tlb_flush;                                                   
}    

If not, I was thinking of changing that loop to always remove PTEs for
DAX mappings, with the understanding that they'll get faulted back in
later.  Ideally, we'd like to check if the page is huge, but DAX can't
use the PageTransCompoundMap check.

Thanks,

Barret



