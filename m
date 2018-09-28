Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8E1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE372170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usNmOxfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE372170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeI1Img (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:42:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45507 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeI1Imf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:42:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so5017884qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4tUHHwO7J91i4l2JdnkhWSShRf+dZSrclrHwPTvzrwM=;
        b=usNmOxfiiqqR+n4iyMQndZRxYiyOT+T4GBltWZ7NPV9BI8jwBbIU9Ca70UloMkjy+M
         hmqbNBJVZUVf3o3G4aWoUTm77GcnzrHq6aG4q137GzxfjSebM4b12UHnS5B7RD+exfuc
         jMdnyRfyWaWTlNpsEhpCc0mz73hN/Xpzi34TcgNKml1wL8JCz9deMqZnsuuRKczyCqly
         rFFbQ7l6JrB3hN0hy/CoHCNRIleuxvbDhKEuw8PvduY4JzvYhZpHXU2Z/zyCiv1thdHA
         6YNynr5ZtgLVk8xlPwvfVgxqqJRBUiztjzxXHasFVS/8C8ZX6IODY6z1XE7cmg0uYwS2
         6VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4tUHHwO7J91i4l2JdnkhWSShRf+dZSrclrHwPTvzrwM=;
        b=fvpFxjWaddEWrzfOxRIiMFsviTLNCv5xQPZRfy6j5Ph7GHkJcclc1GzsRh1eGlzjtz
         Hq5q0ABwR/lzriJLzC0wHzqvmItL7NHTTS8aZRjvHOP1bcm4yDIqv0bThfJ9ctO9HG+c
         47uvz+M3Pvf9NyCeHG3HCBO9VhW/lVff9oE1YlFMvL6s+z8pgyRin+JgZ+FWnvk+GttJ
         qmo00GJTUoEgNfBdyRl4hQdh+f3Y5mBKW71v0IPfxZP8fBXSTAviBQkrjzp2A/BsUy0B
         TrAiVQkfdWfVggw7P23jv9Ojij1W/V38OOmMB6G1l0ZD1ZWBocK5N6HHq9een7avI1ha
         qSVg==
X-Gm-Message-State: ABuFfogz9fiFDMcenALibS1ZgvJ9ejRJM7/JoLuQZ8K8fXxYOmttuy/R
        EeNMUSqQ64RGjEG/pz6oOw==
X-Google-Smtp-Source: ACcGV60QzjCI3G0tRkNfnyJ7Ex9weiWUrdiwAA4Umw7ZZJuuUY74wURc6hstguYGL13Xi/NwtJa+Cg==
X-Received: by 2002:a0c:b584:: with SMTP id g4-v6mr10423414qve.94.1538101272779;
        Thu, 27 Sep 2018 19:21:12 -0700 (PDT)
Received: from gabell ([2601:18f:600:d880:61f5:1cd1:112d:c09c])
        by smtp.gmail.com with ESMTPSA id g64-v6sm2022059qkc.37.2018.09.27.19.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 19:21:12 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:21:06 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ACPI / NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20180928022105.f5tz2665morrunwo@gabell>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
 <20180927203146.12201-3-msys.mizuma@gmail.com>
 <20180927211425.GC19687@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927211425.GC19687@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:14:25PM +0200, Borislav Petkov wrote:
> On Thu, Sep 27, 2018 at 04:31:45PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Add warning message if the padding size for KASLR,
> > rand_mem_physical_padding, is not enough. The message also
> > says the suitable padding size.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  arch/x86/include/asm/setup.h |  2 ++
> >  drivers/acpi/numa.c          | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> > index ae13bc9..65a5bf8 100644
> > --- a/arch/x86/include/asm/setup.h
> > +++ b/arch/x86/include/asm/setup.h
> > @@ -80,6 +80,8 @@ static inline unsigned long kaslr_offset(void)
> >  	return (unsigned long)&_text - __START_KERNEL;
> >  }
> >  
> > +extern int rand_mem_physical_padding;
> > +
> >  /*
> >   * Do NOT EVER look at the BIOS memory size location.
> >   * It does not work on many machines.
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index 8516760..9c3cc3c 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/numa.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/topology.h>
> > +#include <asm/setup.h>
> >  
> >  static nodemask_t nodes_found_map = NODE_MASK_NONE;
> >  
> > @@ -435,6 +436,8 @@ acpi_table_parse_srat(enum acpi_srat_type id,
> >  int __init acpi_numa_init(void)
> >  {
> >  	int cnt = 0;
> > +	u32 max_phys_addr_tb;
> > +	u64 max_phys_addr;
> >  
> >  	if (acpi_disabled)
> >  		return -EINVAL;
> > @@ -463,6 +466,17 @@ int __init acpi_numa_init(void)
> >  
> >  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
> >  					    acpi_parse_memory_affinity, 0);
> > +
> > +		if (parsed_numa_memblks && kaslr_enabled()) {
> > +			max_phys_addr = PFN_PHYS(max_possible_pfn);
> > +			max_phys_addr_tb = (roundup(max_phys_addr, 1ULL << 40)) >> 40;
> > +
> > +			if (max_phys_addr_tb > rand_mem_physical_padding)
> > +				pr_warn("Set 'rand_mem_physical_padding=%d' "
> > +					"as the kernel parameter. "
> > +					"Otherwise, memory hotadd may be failed.\n",
> > +					max_phys_addr_tb);
> 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense:
> 
> WARNING: quoted string split across lines
> #75: FILE: drivers/acpi/numa.c:476:
> +                               pr_warn("Set 'rand_mem_physical_padding=%d' "
> +                                       "as the kernel parameter. "
> 
> WARNING: quoted string split across lines
> #76: FILE: drivers/acpi/numa.c:477:
> +                                       "as the kernel parameter. "
> +                                       "Otherwise, memory hotadd may be failed.\n",
> 
> total: 0 errors, 2 warnings, 40 lines checked
> 
> Also, that sentence needs polishing:
> 
> 				pr_warn("Set 'rand_mem_physical_padding=%d' to avoid memory hotadd failure.\n",

Thank you for pointing it out.
I'll fix it.

Thnaks,
Masa

> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
