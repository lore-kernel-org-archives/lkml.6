Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D55C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B78720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq6ypJou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B78720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLKIGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:06:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37915 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeLKIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:06:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so11739607ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5arwluNogIhjrj6+p7Xsh1oCsZxtyS54KTPYcMeaeM=;
        b=Qq6ypJouCgpkMiKtDrcQbH4LesYSDHAGBEOS/ZQn1b/AZrtJHSFiCAoFC5sDvgJGEG
         Ms3HRKK8G1iZKi11s6pubWWdds9Dzm3Gs1/iqzTSMazB3pFfYXgWEPyi5Z+FhqVhFBe2
         ClE6Y/oGtrdoPL98N0l4reuf9rgq6Rqu1WM47GP9nwrEaRwxS4cpzWlc40ytr7E3lV9P
         1nL3G4CVeY8u2YhZwpqJ7OZ2m8offYk1/W6K7z10wHzab+sibTOBJyRxpMIaeG3x26KF
         QI6C7ROLV6zmQFVtOzeEdaOHWfj156M3gpaPYVHJuSoZq2hxd+Fc7bylSR5AJ6oGt1db
         iV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5arwluNogIhjrj6+p7Xsh1oCsZxtyS54KTPYcMeaeM=;
        b=W32HXe7T8t3bgOKLLYQC9aXvhHvaNeBtFo4uBbhK/E8Oxtwt6UET9DoC4CaklytmD0
         mTx+qFYjRrLGCxF/i0ARBnDYcw+d4k1NYg71a2Mx8KoTw+WhNDbR60rtRAqaPesw9z5f
         pLbQcGAtq15IeOy0wU0k4GbVlz6+S3LnVdQq0uT5u+KkTCmtWo5uxpdY4M19HHyri8CR
         ujDaHPO75GJUrb61dfC5Y5S6flC7448W4PrhuOEc/mo3dez7LP7O3iHHj/4mB9dtQmlt
         wHH58sKoAZZYKcXDS0CqWPxL2H/m50xu6GlG9EQcav6bAW4vAncoslt0V6z5TAZg+zQI
         eSIg==
X-Gm-Message-State: AA+aEWax56e70p/zPLQQ7MZb/a6EXGOhrnpdY7HtWS6njqPwGFOb6wEm
        n+fGh8LhgnovxCl0Vj9gAchF1XgEIHBL4XQabg==
X-Google-Smtp-Source: AFSGD/UB8UhFTMGm12ZQyxJXaYfsQADejIMXCFnc4JZFFiTYXbMBDELH9eMLN+C8NaYIT141Uc/uoeI3Wg/X6zhCRH4=
X-Received: by 2002:a17:906:8301:: with SMTP id j1-v6mr11803738ejx.60.1544515570435;
 Tue, 11 Dec 2018 00:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz> <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz> <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz> <20181210123738.GN1286@dhcp22.suse.cz>
In-Reply-To: <20181210123738.GN1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 11 Dec 2018 16:05:58 +0800
Message-ID: <CAFgQCTsb-G6=o=kyh845RHDTB2WYXywfLiYRddPmoiQVGpqzLA@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 8:37 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 07-12-18 16:56:27, Michal Hocko wrote:
> > On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
> > [...]
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 1308f54..4dc497d 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
> > >  {
> > >         int cpu;
> > >         u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
> > > +       int node, nr;
> > >
> > >         BUG_ON(cpu_to_apicid == NULL);
> > > +       nr = cpumask_weight(cpu_possible_mask);
> > > +
> > > +       /* bring up all possible node, since dev->numa_node */
> > > +       //should check acpi works for node possible,
> > > +       for_each_node(node)
> > > +               if (!node_online(node))
> > > +                       init_memory_less_node(node);
> >
> > I suspect there is no change if you replace for_each_node by
> >       for_each_node_mask(nid, node_possible_map)
> >
> > here. If that is the case then we are probably calling
> > free_area_init_node too early. I do not see it yet though.
>
> OK, so it is not about calling it late or soon. It is just that
> node_possible_map is a misnomer and it has a different semantic than
> I've expected. numa_nodemask_from_meminfo simply considers only nodes
> with some memory. So my patch didn't really make any difference and the
> node stayed uninialized.
>
> In other words. Does the following work? I am sorry to wildguess this
> way but I am not able to recreate your setups to play with this myself.
>
No problem. Yeah, in order to debug the patch, you need a numa machine
with a memory-less node. And unlucky, the patch can not work either by
grub bootup or kexec -l boot. There is nothing, just silent.  I will
dig into numa_register_memblks() to figure out the problem.

Thanks,
Pingfan
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 1308f5408bf7..d51643e10d00 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -216,8 +216,6 @@ static void __init alloc_node_data(int nid)
>
>         node_data[nid] = nd;
>         memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> -
> -       node_set_online(nid);
>  }
>
>  /**
> @@ -527,6 +525,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
>         }
>  }
>
> +static void __init init_memory_less_node(int nid)
> +{
> +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> +
> +       free_area_init_node(nid, zones_size, 0, zholes_size);
> +
> +       /*
> +        * All zonelists will be built later in start_kernel() after per cpu
> +        * areas are initialized.
> +        */
> +}
> +
>  static int __init numa_register_memblks(struct numa_meminfo *mi)
>  {
>         unsigned long uninitialized_var(pfn_align);
> @@ -570,7 +581,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                 return -EINVAL;
>
>         /* Finally register nodes. */
> -       for_each_node_mask(nid, node_possible_map) {
> +       for_each_node(nid) {
>                 u64 start = PFN_PHYS(max_pfn);
>                 u64 end = 0;
>
> @@ -592,6 +603,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                         continue;
>
>                 alloc_node_data(nid);
> +               if (!end)
> +                       init_memory_less_node(nid);
> +               else
> +                       node_set_online(nid);
>         }
>
>         /* Dump memblock with node info and return. */
> @@ -721,21 +736,6 @@ void __init x86_numa_init(void)
>         numa_init(dummy_numa_init);
>  }
>
> -static void __init init_memory_less_node(int nid)
> -{
> -       unsigned long zones_size[MAX_NR_ZONES] = {0};
> -       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> -
> -       /* Allocate and initialize node data. Memory-less node is now online.*/
> -       alloc_node_data(nid);
> -       free_area_init_node(nid, zones_size, 0, zholes_size);
> -
> -       /*
> -        * All zonelists will be built later in start_kernel() after per cpu
> -        * areas are initialized.
> -        */
> -}
> -
>  /*
>   * Setup early cpu_to_node.
>   *
> @@ -763,9 +763,6 @@ void __init init_cpu_to_node(void)
>                 if (node == NUMA_NO_NODE)
>                         continue;
>
> -               if (!node_online(node))
> -                       init_memory_less_node(node);
> -
>                 numa_set_node(cpu, node);
>         }
>  }
> --
> Michal Hocko
> SUSE Labs
