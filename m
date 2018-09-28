Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F84C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C38020779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoPTdDOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C38020779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeI1Uun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:50:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35827 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Uun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:50:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id z14-v6so6850566qtn.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQnVi8wUAiqnxlTl73Slq2pOQzl1K90IPxbHwQeFnis=;
        b=RoPTdDOV3k4zRiMehbUo1Sv/ssEXTlul1jQ2+K409/s+8lF5oBVKYiQE19Ag09o6/z
         7cu5FrnQebsSd/BlYHHltl7e8L/kePUep2DxkmL03/qmaSCOXtStYE0CfC73ndnUIsPc
         rNe9bHT24jdLN7wHYKlnkvIcCSGZlKXd2WFcCiaTE3mPN8oLhkWA2cexIK55YTCoq+6Y
         //y3c0xkwy7PGSDY32lpAL2a09Xx1BrZp3atIFtg9AP4+aJMBcymFeJ3hT4ZjXEFol3y
         KZtqo5SP32dHL/vcZR1uWV33qkkSriYtg+V37SIXi5cIN6gQSd7/OdlewVbDmJKfd1es
         Ic1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQnVi8wUAiqnxlTl73Slq2pOQzl1K90IPxbHwQeFnis=;
        b=NMP4zU7Qh7HnvaKjz63YxnAOGK7Bz+s2ssuxp82TSAP8Vjm8jWJ6CwxTb3e0pvkXdG
         J3cSyke0xP82THLq/3G6ihsMOtcXk2k2LZKPJGPSnscX/OIJjjPCx1WDWMjYTGc4fCJG
         ges8QRWRx5s1vp1ruenXQhp0bC9GqQgONPBb2fZ4n28vQfksmWrkzHkYQQ5k/7zW6+8N
         Xmi9VT3vKsmCtyoGWimrqsUgWUyzX9ue6Dm8tyYhS6FSA/dDqXQex1kr/Jg7G6ykBJhb
         c3SVarE8/Pjoawwq3EGV3SI6pciRg96vzFx0zXi4Eb083sn75xzqVTtOKFpvtV2X93U3
         wNyQ==
X-Gm-Message-State: ABuFfog/h6nuoKMxRUay3bfsD6Rcw+4TJuCisxT0kF0T188IdzAMpTWi
        MFLFJkEvoFGrkCnpww6GGYwxC7o=
X-Google-Smtp-Source: ACcGV62uw4ni2dUirqaZx9ce87zKeopFJ1F6GSvRPeEfW8VDSPsDopV5sYVsJIVj4NnJrkMXNOISiw==
X-Received: by 2002:a0c:c3c6:: with SMTP id p6-v6mr11974037qvi.146.1538144800378;
        Fri, 28 Sep 2018 07:26:40 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v10-v6sm3519784qkv.90.2018.09.28.07.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:26:40 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:26:34 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ACPI / NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20180928142633.u5me4uhq7lkiblh5@gabell>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
 <20180927203146.12201-3-msys.mizuma@gmail.com>
 <20180928024857.GA14470@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928024857.GA14470@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:48:57AM +0800, Baoquan He wrote:
> On 09/27/18 at 04:31pm, Masayoshi Mizuma wrote:
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
> 
> Here I assume max_phys_addr_tb is the end of the possible RAM in system.

Yes, correct.

> rand_mem_physical_padding is the preserved space for later memory
> extending. Don't we add the actual RAM size to the
> rand_mem_physical_padding, then compare with max_phys_addr_tb?

This is very good point! You are right, the padding should be
adjusted to exceed the possible RAM size, like as follows.

   ADDRESS
     0
     :
    1TB           <= actual RAM size
     :
    2TB           <= possible RAM size
    2TB and more  <= actual + padding size (kaslr_regions[0].size_tb)

I'll fix it, thanks!

- Masa

> 
> Please correct me if I am wrong.
> 
> Thanks
> Baoquan
> 
> > +				pr_warn("Set 'rand_mem_physical_padding=%d' "
> > +					"as the kernel parameter. "
> > +					"Otherwise, memory hotadd may be failed.\n",
> > +					max_phys_addr_tb);
> > +		}
> >  	}
> >  
> >  	/* SLIT: System Locality Information Table */
> > -- 
> > 2.18.0
> > 
