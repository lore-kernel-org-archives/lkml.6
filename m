Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7927C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LIPI/C6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeHQM1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:27:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:27:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so3350783pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hG13vbn4AjbWWiuwGW9MXovuBEdchpmhOByQe5ubkuw=;
        b=LIPI/C6UG+C/ymZYhY5g+VDuWsXNsDLVVuiWPxWQn7R0+h7eJ9+2JIsQW9t4+ohIYW
         AjBs+gaagFFCsxUhAkbJOSWezTJ5BHUHHIB03NCulRb0WCNm8gWHd/IARcSld8DHDVJu
         OvFITz7jQbO6VUkXEdFrlI/yJFmWVAaDYh8ORgGLEEPgFbNT68QbEQq0AOM5LvWIQ1bt
         +kUTpsvx9M7RlAtOjBAKX1NG8hvH4qpxOUYtAFF4oVKSmpBbYEEaD4hgyyD8nwvOp1yh
         WAP/D7H90wjUtEFsdA9TMe7LM48HxXG+mLf5M0th7BwlsAXffnjVaEQDKlkuhMT/0GgB
         Z6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hG13vbn4AjbWWiuwGW9MXovuBEdchpmhOByQe5ubkuw=;
        b=qthJH6FJm5tDkBCu8e3qy1pFK1EAQa38oIIYtqVGgXtO/jL1/1IlrhxbVH/FcrOsEG
         QyC8EVVoWGYlQyDv2d02OmGI45l69aw9Cmp+oNJ3mDvO1C/XB8yUR1vYcRtJePJWZ0HZ
         1x4cQz5oETHT89nVMbFJj9LNsEnW+YYeq/z44vghzYttD7WlHxKlZj3CYApyGn1w5aHB
         X7NXcekatVicv3iKLl0OqRhfNAz/tKgJZd/84UBhMbr2GtwDnXg31VKYYN+tintKUaQN
         +7wiO8rI0Td1JPXXq9hdhcLOHSrgLF5enbGey29wQmR2nTicU/HEFFih45QA2cH/1Kqp
         6T2w==
X-Gm-Message-State: AOUpUlF0gsCg720A7pr47vMfVddigIdyW6iJ6nZB+wDjDAH3+loY/NAv
        qx68zfstCmlWjHEHIkEmxi13zQ==
X-Google-Smtp-Source: AA+uWPw+ULJ2deMGmkk4FLsK1EYjnHt5H63JFnlSy3ICR/6tMiSIBMXt3nPankkuHHrW6G15YF/Ycg==
X-Received: by 2002:a65:5205:: with SMTP id o5-v6mr32431915pgp.108.1534497901384;
        Fri, 17 Aug 2018 02:25:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 82-v6sm2309621pfw.159.2018.08.17.02.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:25:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 9411C3000A7; Fri, 17 Aug 2018 12:24:55 +0300 (+03)
Date:   Fri, 17 Aug 2018 12:24:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 19/19] x86: Introduce CONFIG_X86_INTEL_MKTME
Message-ID: <20180817092455.2ogsxsybfxdesrma@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-20-kirill.shutemov@linux.intel.com>
 <20180815074812.GB28093@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815074812.GB28093@xo-6d-61-c0.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:48:12AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Add new config option to enabled/disable Multi-Key Total Memory
> > Encryption support.
> > 
> > MKTME uses MEMORY_PHYSICAL_PADDING to reserve enough space in per-KeyID
> > direct mappings for memory hotplug.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b6f1785c2176..023a22568c06 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1523,6 +1523,23 @@ config ARCH_USE_MEMREMAP_PROT
> >  	def_bool y
> >  	depends on AMD_MEM_ENCRYPT
> >  
> > +config X86_INTEL_MKTME
> > +	bool "Intel Multi-Key Total Memory Encryption"
> > +	select DYNAMIC_PHYSICAL_MASK
> > +	select PAGE_EXTENSION
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	---help---
> > +	  Say yes to enable support for Multi-Key Total Memory Encryption.
> > +	  This requires an Intel processor that has support of the feature.
> > +
> > +	  Multikey Total Memory Encryption (MKTME) is a technology that allows
> > +	  transparent memory encryption in upcoming Intel platforms.
> > +
> > +	  MKTME is built on top of TME. TME allows encryption of the entirety
> > +	  of system memory using a single key. MKTME allows having multiple
> > +	  encryption domains, each having own key -- different memory pages can
> > +	  be encrypted with different keys.
> > +
> >  # Common NUMA Features
> >  config NUMA
> >  	bool "Numa Memory Allocation and Scheduler Support"
> 
> Would it be good to provide documentation, or link to documentation, explaining
> what security guarantees this is supposed to provide, and what disadvantages (if any)
> it has?

The main goal is to add additional level of isolation between different
tenants of a machine. It mostly targeted to VMs and protect against
leaking information between guests.

In the design kernel (or hypervisor) is trusted and have a mean to access
encrypted memory as long as key is programmed into the CPU.

Worth noting that encryption happens in memory controller so all data in
caches of all levels are plain-text.

The spec can be found here:

https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Total-Memory-Encryption-Spec.pdf

> I guess  it costs a bit of performance...

The most overhead is paid on allocation and freeing of encrypted pages:
switching between keyids for a page requires cache flushing.

Access time to encrypted memory *shouldn't* be measurably slower.
Encryption overhead is hidden within other latencies in memory pipeline.

> I see that TME helps with cold boot attacks.

Right.

-- 
 Kirill A. Shutemov
