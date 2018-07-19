Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9115C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF3020693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zwd4ZrIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF3020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeGSLEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:04:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42510 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeGSLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:04:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so3696211pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhicpM+fOwiju9bXMJkS3VO7PHDcULJCpsLkjk0bEWY=;
        b=zwd4ZrIM/kAY6Q2wPWF6kkcEksFgOYPNgetSQA3VKxZ6K21+ok7hIDxKxZ+s8CN81A
         PTAIyLFm/9JYAMdEwhqN57LVFn6Nc9CSQBorZ3vxsRHlShUWS2pIDj/a5B6sfeWuMkPw
         k1ZIJRixHobbzCSdKGnjcfOSl8XfvjROAYQpdIu9NpGPp+iRv6Y2vR7gk6r8H2960HTb
         vN7wgOd4NVJ0uBpJ58w+ghEvS0mtpRuORwTugZc0N4F3ojaR24x/Q5jLBCZsmgPCymw3
         F6FA5mBmfb3WXRdJFPIIUA3tHTRJheZwv8P5J7otLU7SE03iRGR1L4jl8Zp5EZE4hwgx
         Okuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhicpM+fOwiju9bXMJkS3VO7PHDcULJCpsLkjk0bEWY=;
        b=WNQQ6XjjCC47BJgUs3KOliWC/dxm+Hh9lRmeGhdn1KJk7b2C5lLBU2RZ14wWA7vIe2
         9WZ1fcXFwUW7wQCXGFynFbA9XzRcZI9ih2MoLqDVwB81ozR4IafSt6OIzWpNXjk0RtNw
         BXJbPIpsxcEIVmpaApZkqFMo4wfOJ75owie6ckijE9LP9QHYp+txqXrxBi+Ib/jQM5BS
         rHq5PyaWx8H0N4zhkPSGxB61AQsbjZnEUExvjVD/eXg7FFAQxUVjqkSHtPlXcvpYl+i2
         vxwnONF+oNGBX+lnQiJliB5AC2T3rfbKVciPJ90vYM/5nGrIZCGzzvmMWhbDqeqFiz8G
         Lzsw==
X-Gm-Message-State: AOUpUlFoBt6XDnizgCY2ezYs58LGJfZ849E8SVmcr1LFaZ4XV27r1HwM
        eiMvOJolBQKmd9dv9jpL696WpMhyToPj2w==
X-Google-Smtp-Source: AAOMgpfjenhRm7TPLvKOeN++8hHfUzYus1YwdjVdwEdwbgSOWE2EiDKQYqyCGHQXA3sHVww3DZfq7g==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr8998233pgp.283.1531995697129;
        Thu, 19 Jul 2018 03:21:37 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id f17-v6sm10131045pfj.122.2018.07.19.03.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:21:36 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 079E4300251; Thu, 19 Jul 2018 13:21:30 +0300 (+03)
Date:   Thu, 19 Jul 2018 13:21:30 +0300
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
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:19:10PM -0700, Dave Hansen wrote:
> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> > mktme_nr_keyids holds number of KeyIDs available for MKTME, excluding
> > KeyID zero which used by TME. MKTME KeyIDs start from 1.
> > 
> > mktme_keyid_shift holds shift of KeyID within physical address.
> 
> I know what all these words mean, but the combination of them makes no
> sense to me.  I still don't know what the variable does after reading this.
> 
> Is this the lowest bit in the physical address which is used for the
> KeyID?  How many bits you must shift up a KeyID to get to the location
> at which it can be masked into the physical address?

Right.

I'm not sure what is not clear from the description. It look fine to me.

> > mktme_keyid_mask holds mask to extract KeyID from physical address.
> 
> Good descriptions, wrong place.  Please put these in the code.

Okay.

> Also, the grammar constantly needs some work.  "holds mask" needs to be
> "holds the mask".

Right. Thanks

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mktme.h | 16 ++++++++++++++++
> >  arch/x86/kernel/cpu/intel.c  | 12 ++++++++----
> >  arch/x86/mm/Makefile         |  2 ++
> >  arch/x86/mm/mktme.c          |  5 +++++
> >  4 files changed, 31 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/x86/include/asm/mktme.h
> >  create mode 100644 arch/x86/mm/mktme.c
> > 
> > diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> > new file mode 100644
> > index 000000000000..df31876ec48c
> > --- /dev/null
> > +++ b/arch/x86/include/asm/mktme.h
> > @@ -0,0 +1,16 @@
> > +#ifndef	_ASM_X86_MKTME_H
> > +#define	_ASM_X86_MKTME_H
> > +
> > +#include <linux/types.h>
> > +
> > +#ifdef CONFIG_X86_INTEL_MKTME
> > +extern phys_addr_t mktme_keyid_mask;
> > +extern int mktme_nr_keyids;
> > +extern int mktme_keyid_shift;
> > +#else
> > +#define mktme_keyid_mask	((phys_addr_t)0)
> > +#define mktme_nr_keyids		0
> > +#define mktme_keyid_shift	0
> > +#endif
> > +
> > +#endif
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index bf2caf9d52dd..efc9e9fc47d4 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -573,6 +573,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
> >  
> >  #ifdef CONFIG_X86_INTEL_MKTME
> >  	if (mktme_status == MKTME_ENABLED && nr_keyids) {
> > +		mktme_nr_keyids = nr_keyids;
> > +		mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
> > +
> >  		/*
> >  		 * Mask out bits claimed from KeyID from physical address mask.
> >  		 *
> > @@ -580,10 +583,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
> >  		 * and number of bits claimed for KeyID is 6, bits 51:46 of
> >  		 * physical address is unusable.
> >  		 */
> > -		phys_addr_t keyid_mask;
> > -
> > -		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
> > -		physical_mask &= ~keyid_mask;
> > +		mktme_keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, mktme_keyid_shift);
> > +		physical_mask &= ~mktme_keyid_mask;
> 
> Seems a bit silly that we introduce keyid_mask only to make it global a
> few patches later.

Is it a big deal?

I found it easier to split changes into logical pieces this way.

> >  	} else {
> >  		/*
> >  		 * Reset __PHYSICAL_MASK.
> > @@ -591,6 +592,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
> >  		 * between CPUs.
> >  		 */
> >  		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > +		mktme_keyid_mask = 0;
> > +		mktme_keyid_shift = 0;
> > +		mktme_nr_keyids = 0;
> >  	}
> 
> Should be unnecessary.  These are zeroed by the compiler.

No. detect_tme() called for each CPU in the system.

> > diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> > index 4b101dd6e52f..4ebee899c363 100644
> > --- a/arch/x86/mm/Makefile
> > +++ b/arch/x86/mm/Makefile
> > @@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
> >  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> > +
> > +obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o
> > diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> > new file mode 100644
> > index 000000000000..467f1b26c737
> > --- /dev/null
> > +++ b/arch/x86/mm/mktme.c
> > @@ -0,0 +1,5 @@
> > +#include <asm/mktme.h>
> > +
> > +phys_addr_t mktme_keyid_mask;
> > +int mktme_nr_keyids;
> > +int mktme_keyid_shift;
> 
> Descriptions should be here, please, not in the changelog.

Okay.

-- 
 Kirill A. Shutemov
