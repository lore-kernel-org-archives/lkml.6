Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF9D20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="d2j82Ymg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF9D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbeGWKsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:48:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42492 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeGWKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:48:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so8173pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VjCdVT72yGyZRDBZIu7vDGiE5k+3qldmoPrCopkGq1w=;
        b=d2j82Ymg8tT3R49p1Y6KNStMcvFIMfe1myLMu39ktLO/AW9NJ7ur4kik0Pb4xE7/LI
         GGOO7RmdjfkTKJSTypw/a6itc4hOv2A4pdaxSJM3f56e1SXSWI7vkAfWExLIFB+q4EIG
         cK/0w3jifpB9/SEV1PaayMdickfw8FToQMLeLS8MzCiMWyUKwmf0QehsYML7P8V45ikq
         CsVhjCpqmsVd0XLqk3PpdFb1Jd6yOxlpaRRsrvo2K67GzxN+kh/jOdIy3o88Du7zLqzC
         VGyxcubzMQhCw+Otjpv26McVzfOfVrNZSg8O0OILAmUHXZlwK34ZoWW5YdG/FYZiSb6z
         9dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjCdVT72yGyZRDBZIu7vDGiE5k+3qldmoPrCopkGq1w=;
        b=AjFFdMS9ESKp+XgeJVNmlTfnUguy5yOr7IuOkT1Oe+4P6JH7M4c4bbxRoMXBuzprBx
         efrGc5MoX/enJV0Zi4a4XhI56wcFHbVJB0XXnHruGLpqdN9f4uRMd+lnei8dpidriqkD
         e/Hq90knCJsuTYL4ogn9kES/aKa5ySUM/qdvoWbJWSo4rN/kwRfPDiTjIPk8rVsUPplT
         L5ewslQpDNlUZcFfOxdwQ91ECiF5jtYjkeHw8SO1KUJpc5WWF2EshCSjcCPBkOgxlGyd
         /6xAaTcT2VA0e4gGdD73iox/q+/5GipPNgIN73UOgRRfoMN2NYuZbpcz1Zet1nklpb9l
         8jdA==
X-Gm-Message-State: AOUpUlFk+/Vixm3uMXeHBj5cwDAlxJXWupeshyVRwn+crvB5TTBwc2HC
        fjq+a7pScBblW8o1eTNlVLpBpw==
X-Google-Smtp-Source: AAOMgpf/rcyHm9WCWXkU4BYCcgXO0i5VOLJfACyV13WDiFCXRmDhwoyce1H4kKyHJf9x2xh9ZfzElA==
X-Received: by 2002:a63:9741:: with SMTP id d1-v6mr11207534pgo.403.1532339270602;
        Mon, 23 Jul 2018 02:47:50 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 8-v6sm12795393pfk.132.2018.07.23.02.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 02:47:49 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4F2EA303A0F; Mon, 23 Jul 2018 12:47:46 +0300 (+03)
Date:   Mon, 23 Jul 2018 12:47:46 +0300
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
Subject: Re: [PATCHv5 11/19] x86/mm: Implement vma_keyid()
Message-ID: <20180723094746.447v2jnegqlosi2f@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-12-kirill.shutemov@linux.intel.com>
 <a204a032-5e2b-63f6-31d3-c17014f94c8b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a204a032-5e2b-63f6-31d3-c17014f94c8b@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:40:14PM -0700, Dave Hansen wrote:
> > --- a/arch/x86/mm/mktme.c
> > +++ b/arch/x86/mm/mktme.c
> > @@ -1,3 +1,4 @@
> > +#include <linux/mm.h>
> >  #include <asm/mktme.h>
> >  
> >  phys_addr_t mktme_keyid_mask;
> > @@ -37,3 +38,14 @@ struct page_ext_operations page_mktme_ops = {
> >  	.need = need_page_mktme,
> >  	.init = init_page_mktme,
> >  };
> > +
> > +int vma_keyid(struct vm_area_struct *vma)
> > +{
> > +	pgprotval_t prot;
> > +
> > +	if (!mktme_enabled())
> > +		return 0;
> > +
> > +	prot = pgprot_val(vma->vm_page_prot);
> > +	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
> > +}
> 
> I'm a bit surprised this isn't inlined.  Not that function calls are
> expensive, but we *could* entirely avoid them using the normal pattern of:
> 
> // In the header:
> static inline vma_keyid(...)
> {
> 	if (!mktme_enabled())
> 		return 0;
> 
> 	return __vma_keyid(...); // <- the .c file version
> }

Okay. I'll do this. But it would be a macros. <asm/mktme.h> gets included
very early. We cannot really use jump label code there directly.

-- 
 Kirill A. Shutemov
