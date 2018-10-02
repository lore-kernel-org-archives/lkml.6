Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC7C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B47206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWskc4OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B47206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJCEFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:05:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43821 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCEFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:05:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so1402153ywj.10;
        Tue, 02 Oct 2018 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpeB2ufv9/XoA/JU0EYFqJqBeDm1iADZF+1EE6KiGPg=;
        b=iWskc4OELLAg8KNjv2/34C9V8wqI0C9SzmK+oMNx8AY5f6ZO63TfHI2noXKeGeOqxn
         oKY0qtY2AyXGDTuo48v026dFEjx2PqJNFs9euaKrF7qldQwYO+znaALdMRPxZiIASOFb
         p+wKD321FH0vfHcCeU5o2O8dgzGfzuDerNDEsmxd+1l+pYCHUh/2ytVA6TLZO2Dl0yzC
         zeYcnJyDj5ETGVyYlRq3OjQfOivW9u6Yir+g37EhMycTE99sIEtnk6vOxUS0tyZET+bT
         Ign7JViLXZB1a5JRwWDr+n/sTODEDem1uV53BWV4BnbAmVJBAxavAgB9Wb0oV7Vl9d1z
         cTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpeB2ufv9/XoA/JU0EYFqJqBeDm1iADZF+1EE6KiGPg=;
        b=Gw9sJTzBG2SV60QIBZppwazZMYJmt6vB7xZj9oSM850RCBwfVbrKXwyiULF0uytyaw
         d05AqVxDTcrTIdJ2uA01OWri7G9D4AOKzYn12tQVVKO/pW7MnILrNdseLfV31Jw2xPFF
         F0vAZZs47ryBB/PD6ASDdGJTpa+wk5BOcecPoAOtPz9WfbNBzxZBjPIDTczw99yVBXEc
         Z5Kh8HQKUjYiAYkVAmmugSW87UOW/Ao8C7CjICObYjn7+3tkZvYLpiIjGgxE+JAIru58
         S6UUK47TOtpza88Hye0D3Pp428jqP65vtMP4c62+kIe+cQXHJiaru5pnO134HCOb5CrC
         eU6Q==
X-Gm-Message-State: ABuFfoj0OVsJpfDHRWOUk0lBDNgvZa/FOak5/Q9vuPiSy6HT2ZdQtMAs
        UhQQXQMnJRm3daAF5O/DNQ==
X-Google-Smtp-Source: ACcGV639t4zJc1Eu1e9zKAM13w53JsgA8S7rdf1jSSgBMtGV8pNlat2KuXQXpmTRk7/JF33J49Q5xQ==
X-Received: by 2002:a81:8302:: with SMTP id t2-v6mr9378596ywf.428.1538515189992;
        Tue, 02 Oct 2018 14:19:49 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id v34-v6sm14938521ywh.45.2018.10.02.14.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 14:19:49 -0700 (PDT)
Date:   Tue, 2 Oct 2018 17:19:43 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     m.mizuma@jp.fujitsu.com, bhe@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181002211943.gamda74lwc7vy3zd@gabell>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
 <20181002150517.GA19822@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002150517.GA19822@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 05:05:18PM +0200, Borislav Petkov wrote:
> On Tue, Oct 02, 2018 at 03:18:41AM -0700, tip-bot for Masayoshi Mizuma wrote:
> > Commit-ID:  3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
> > Gitweb:     https://git.kernel.org/tip/3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
> > Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > AuthorDate: Mon, 1 Oct 2018 10:08:42 -0400
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 2 Oct 2018 11:47:21 +0200
> > 
> > ACPI/NUMA: Add warning message if the padding size for KASLR is not enough
> > 
> > Add warning message if the padding size for KASLR,
> > rand_mem_physical_padding, is not enough. The message also
> > says the suitable padding size.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Link: http://lkml.kernel.org/r/20181001140843.26137-3-msys.mizuma@gmail.com
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  arch/x86/include/asm/setup.h |  2 ++
> >  drivers/acpi/numa.c          | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> > index ae13bc974416..65a5bf8f6aba 100644
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
> > index 85167603b9c9..3d69834c692f 100644
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
> > @@ -435,6 +436,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
> >  int __init acpi_numa_init(void)
> >  {
> >  	int cnt = 0;
> > +	u64 max_possible_phys, max_actual_phys, threshold;
> >  
> >  	if (acpi_disabled)
> >  		return -EINVAL;
> > @@ -463,6 +465,18 @@ int __init acpi_numa_init(void)
> >  
> >  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
> >  					    acpi_parse_memory_affinity, 0);
> > +
> > +		/* check the padding size for KASLR is enough. */
> > +		if (parsed_numa_memblks && kaslr_enabled()) {
> > +			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
> > +			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
> > +			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
> 
> Nope, not really:
> 
> ld: drivers/acpi/numa.o: in function `acpi_numa_init':
> /home/boris/kernel/linux/drivers/acpi/numa.c:473: undefined reference to `rand_mem_physical_padding'
> make: *** [Makefile:1030: vmlinux] Error 1
> 
> due to CONFIG_RANDOMIZE_MEMORY=n in my .config.
> 
> You need to add a fix ontop which adds a function
> get_rand_mem_physical_padding() which is defined in CONFIG_RANDOMIZE_MEMORY=y
> and outside returns 0.
> 
> And then make that rand_mem_physical_padding static and do not export it
> to anything outside of kaslr.c but use the accessor.

Thank you for the report and suggetions!
I'll fix it and resubmit soon.

Thanks,
Masa
