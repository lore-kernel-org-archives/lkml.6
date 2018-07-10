Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8112087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qYPyCzYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8112087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGJKtR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:49:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39670 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbeGJKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:49:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so7448672plq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Liq0XqzYgRwe+5P80iC5Ynn4dCdGZtQlioKGTGWd85o=;
        b=qYPyCzYMbhkLvmLl3Fi+6jwSDSsccKAlTDH1yFD64lINEs7CpXPB90rGqeSQD698ED
         I5Uv90gn9eukNvoreKBCbifLPfulFXkKdIAbAVU11tyuD3r86yvqhIVBBU1Flqv39B2d
         tLBtmVgchMF7sKN7I15cWKZalLbsS8qbZnVnMVb2GNU3bkWkL0Iiwy98Fo97cl/5/mpL
         /SFpXahAJKPhTsjNIU+S0DDq11MqXR8RFELOV83Ql+RI2KaanUipm9F2WtwVbf0j9A6u
         s75H0HAWtWEOlcGCqCHZ9+bLUEZjZkCD9zhsvtwsHJwI8seskGBs+wuq8rT3/ccUkH17
         w6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Liq0XqzYgRwe+5P80iC5Ynn4dCdGZtQlioKGTGWd85o=;
        b=i+mT/Fr6GW6qdrp4w3uSDjM/rXpMiEe5gjCKqKHz2Va/qtY3Hg62ZJ9Gngiclr0b+X
         NymYqOHLkth5kKN9jbjjI7A5CxfDhEEbO7TXHcGQU+3yLidkxdqLOGduRTeLO/GqikrV
         WYpFx46ABr3+3u2CELypmlf12ldqPBtuPhgg49Xs2Z2s2AEf6Mr6x3QKfQp8296ZE/1H
         RqjnlK6LawACn2o/oxK2NpiiF8QzixtLGKnh7BpW84N1JysruRHFFIpPRL3T2iDec06R
         YKtXI30G0Vn+IVxMPapahv/esz7bnTF1FgXg/aJCz1WON1uO69bFaByHH5HhswoRrCP2
         92lA==
X-Gm-Message-State: APt69E3Kiu4GAdXdqsZM0oHPszlGrbAWfIae3OzfvYJtbX42XxBZzRTt
        4pb5A0AEe7oCdp4iWn0TV2NgyA==
X-Google-Smtp-Source: AAOMgpdIXUDxH3hHAAyevrI4sjyo69OqSy1oB1pbfHkOAxMi1q1v6CoTCTHWF6GQesbPgDCM5U1ioQ==
X-Received: by 2002:a17:902:9b82:: with SMTP id y2-v6mr24306046plp.69.1531219755475;
        Tue, 10 Jul 2018 03:49:15 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id v6-v6sm60451207pfa.28.2018.07.10.03.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 03:49:14 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8DCC830003F; Tue, 10 Jul 2018 13:49:10 +0300 (+03)
Date:   Tue, 10 Jul 2018 13:49:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 13/18] x86/mm: Allow to disable MKTME after enumeration
Message-ID: <20180710104910.3xpiniksptpby4fo@kshutemo-mobl1>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-14-kirill.shutemov@linux.intel.com>
 <20180709182055.GI6873@char.US.ORACLE.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709182055.GI6873@char.US.ORACLE.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:20:55PM -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Jun 26, 2018 at 05:22:40PM +0300, Kirill A. Shutemov wrote:
> > The new helper mktme_disable() allows to disable MKTME even if it's
> > enumerated successfully. MKTME initialization may fail and this
> > functionality allows system to boot regardless of the failure.
> > 
> > MKTME needs per-KeyID direct mapping. It requires a lot more virtual
> > address space which may be a problem in 4-level paging mode. If the
> > system has more physical memory than we can handle with MKTME.
> 
> .. then what should happen?

We fail MKTME initialization and boot the system. See next sentence.

> > The feature allows to fail MKTME, but boot the system successfully.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mktme.h | 2 ++
> >  arch/x86/kernel/cpu/intel.c  | 5 +----
> >  arch/x86/mm/mktme.c          | 9 +++++++++
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> > index 44409b8bbaca..ebbee6a0c495 100644
> > --- a/arch/x86/include/asm/mktme.h
> > +++ b/arch/x86/include/asm/mktme.h
> > @@ -6,6 +6,8 @@
> >  
> >  struct vm_area_struct;
> >  
> > +void mktme_disable(void);
> > +
> >  #ifdef CONFIG_X86_INTEL_MKTME
> >  extern phys_addr_t mktme_keyid_mask;
> >  extern int mktme_nr_keyids;
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index efc9e9fc47d4..75e3b2602b4a 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -591,10 +591,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
> >  		 * Maybe needed if there's inconsistent configuation
> >  		 * between CPUs.
> >  		 */
> > -		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > -		mktme_keyid_mask = 0;
> > -		mktme_keyid_shift = 0;
> > -		mktme_nr_keyids = 0;
> > +		mktme_disable();
> >  	}
> >  #endif
> >  
> > diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> > index 1194496633ce..bb6210dbcf0e 100644
> > --- a/arch/x86/mm/mktme.c
> > +++ b/arch/x86/mm/mktme.c
> > @@ -13,6 +13,15 @@ static inline bool mktme_enabled(void)
> >  	return static_branch_unlikely(&mktme_enabled_key);
> >  }
> >  
> > +void mktme_disable(void)
> > +{
> > +	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > +	mktme_keyid_mask = 0;
> > +	mktme_keyid_shift = 0;
> > +	mktme_nr_keyids = 0;
> > +	static_branch_disable(&mktme_enabled_key);
> > +}
> > +
> >  int page_keyid(const struct page *page)
> >  {
> >  	if (!mktme_enabled())
> > -- 
> > 2.18.0
> > 
> 

-- 
 Kirill A. Shutemov
