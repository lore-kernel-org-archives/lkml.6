Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F402C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQLTDDp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF7A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLGNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:20:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38616 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:20:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so3694957ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 05:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pk87ABggv2HgkD2ACJYGcU2Zns0Q/xdt4eNvvKc0Y5U=;
        b=EQLTDDp0nI8DoHySUj5t+Oc/huEFGeVbZUUeTxRvZTqu8XbRED2J454kO5oDzL9I8N
         Li2loiNXYtvnZEmBB/4lxYozR+5YZVBXqQm0inSV9ynhqwe1hIZCNWnI4pcDoAyDTYgp
         WTMP9UHKvFgylmaM84o6oeMzL/P6h/JBBkqVnkr8QBOJv9pDqG2w2WeUm3jP1xPK/asC
         GFKU5VBUi39EtwN4+WqQU//TQxX9arwTfPdXberrIoc0/P8ln5r1ujOl/70JvkPtVckh
         ow9uj94vZ9omplRYCmARa88QIa70rkEh+2IEP7KpYcjyFQ5fcpBJnwVHu1GIpGN4lHph
         Kr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pk87ABggv2HgkD2ACJYGcU2Zns0Q/xdt4eNvvKc0Y5U=;
        b=MU3dsiZCglV5n8obxFVXJC6iAPpyTwr2UeL+Igbfgi+5XQVIeDyFB0lYe597b/XYAK
         USlkJ6kjMkAGyO2K0LRGCy8uiPAj/Seu/N5K68Q0YPEvuFgovWZDv3Tf36ndTbRay7Ix
         BzYOrrvX+Y0miyNN4i1b5l2aq4W5Pk2d2c+DHiZEgPblprenRdzENKMwO3p0ZTevJi+E
         qelZPyb/tySA9+ZXVToRhjOtxV6gmIU8UpOZnv4EQhiYApzF0d9VMBm2HHnrHpSEoX42
         WGrlP6FP9Twe6zPMG1xOYa1fIKtYUyfRMN5sWWeaf+oTMTtlvlJHH4TCI7Bvmj//rN34
         dDKA==
X-Gm-Message-State: AA+aEWarCXSND/edjeSDxFuJfR5LmXXYl+74B1Aj0G+SRbI7UJ/S50VC
        YBEwzqEkgUhPVee/Qle0u1AirFaEOg26XAXaww==
X-Google-Smtp-Source: AFSGD/Wl2XAOMl46oKPSqLiPZidgil+c8Kk0Aqp+jsEK6CODVrDNdEFEfj8N8SDRLLb+neMbgX60AMCz0hTqqfsZ/W8=
X-Received: by 2002:a17:906:22ca:: with SMTP id q10-v6mr1951644eja.66.1544188830339;
 Fri, 07 Dec 2018 05:20:30 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz> <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz> <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz>
In-Reply-To: <20181207113044.GB1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 7 Dec 2018 21:20:17 +0800
Message-ID: <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 7:30 PM Michal Hocko <mhocko@kernel.org> wrote:
>
[...]
> On Fri 07-12-18 17:40:09, Pingfan Liu wrote:
> > On Fri, Dec 7, 2018 at 3:53 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 07-12-18 10:56:51, Pingfan Liu wrote:
> > > [...]
> > > > In a short word, the fix method should consider about the two factors:
> > > > semantic of online-node and the effect on all archs
> > >
> > > I am pretty sure there is a lot of room for unification in this area.
> > > Nevertheless I strongly believe the bug should be fixed firs with the
> > > simplest way and all the cleanup should be done on top.
> > >
> > > Do I get it right that the diff worked for you and I can prepare a full
> > > patch?
> > >
> > Sure, I am glad to test you new patch.
>
> From 46e68be89d9c299fd497b2b8bea3f2add144f17f Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 7 Dec 2018 12:23:32 +0100
> Subject: [PATCH] x86, numa: always initialize all possible nodes
>
> Pingfan Liu has reported the following splat
> [    5.772742] BUG: unable to handle kernel paging request at 0000000000002088
> [    5.773618] PGD 0 P4D 0
> [    5.773618] Oops: 0000 [#1] SMP NOPTI
> [    5.773618] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc1+ #3
> [    5.773618] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.4.3 06/29/2018
> [    5.773618] RIP: 0010:__alloc_pages_nodemask+0xe2/0x2a0
> [    5.773618] Code: 00 00 44 89 ea 80 ca 80 41 83 f8 01 44 0f 44 ea 89 da c1 ea 08 83 e2 01 88 54 24 20 48 8b 54 24 08 48 85 d2 0f 85 46 01 00 00 <3b> 77 08 0f 82 3d 01 00 00 48 89 f8 44 89 ea 48 89
> e1 44 89 e6 89
> [    5.773618] RSP: 0018:ffffaa600005fb20 EFLAGS: 00010246
> [    5.773618] RAX: 0000000000000000 RBX: 00000000006012c0 RCX: 0000000000000000
> [    5.773618] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
> [    5.773618] RBP: 00000000006012c0 R08: 0000000000000000 R09: 0000000000000002
> [    5.773618] R10: 00000000006080c0 R11: 0000000000000002 R12: 0000000000000000
> [    5.773618] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
> [    5.773618] FS:  0000000000000000(0000) GS:ffff8c69afe00000(0000) knlGS:0000000000000000
> [    5.773618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.773618] CR2: 0000000000002088 CR3: 000000087e00a000 CR4: 00000000003406e0
> [    5.773618] Call Trace:
> [    5.773618]  new_slab+0xa9/0x570
> [    5.773618]  ___slab_alloc+0x375/0x540
> [    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
> [    5.773618]  __slab_alloc+0x1c/0x38
> [    5.773618]  __kmalloc_node_track_caller+0xc8/0x270
> [    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
> [    5.773618]  devm_kmalloc+0x28/0x60
> [    5.773618]  pinctrl_bind_pins+0x2b/0x2a0
> [    5.773618]  really_probe+0x73/0x420
> [    5.773618]  driver_probe_device+0x115/0x130
> [    5.773618]  __driver_attach+0x103/0x110
> [    5.773618]  ? driver_probe_device+0x130/0x130
> [    5.773618]  bus_for_each_dev+0x67/0xc0
> [    5.773618]  ? klist_add_tail+0x3b/0x70
> [    5.773618]  bus_add_driver+0x41/0x260
> [    5.773618]  ? pcie_port_setup+0x4d/0x4d
> [    5.773618]  driver_register+0x5b/0xe0
> [    5.773618]  ? pcie_port_setup+0x4d/0x4d
> [    5.773618]  do_one_initcall+0x4e/0x1d4
> [    5.773618]  ? init_setup+0x25/0x28
> [    5.773618]  kernel_init_freeable+0x1c1/0x26e
> [    5.773618]  ? loglevel+0x5b/0x5b
> [    5.773618]  ? rest_init+0xb0/0xb0
> [    5.773618]  kernel_init+0xa/0x110
> [    5.773618]  ret_from_fork+0x22/0x40
> [    5.773618] Modules linked in:
> [    5.773618] CR2: 0000000000002088
> [    5.773618] ---[ end trace 1030c9120a03d081 ]---
>
> with his AMD machine with the following topology
>   NUMA node0 CPU(s):     0,8,16,24
>   NUMA node1 CPU(s):     2,10,18,26
>   NUMA node2 CPU(s):     4,12,20,28
>   NUMA node3 CPU(s):     6,14,22,30
>   NUMA node4 CPU(s):     1,9,17,25
>   NUMA node5 CPU(s):     3,11,19,27
>   NUMA node6 CPU(s):     5,13,21,29
>   NUMA node7 CPU(s):     7,15,23,31
>
> [    0.007418] Early memory node ranges
> [    0.007419]   node   1: [mem 0x0000000000001000-0x000000000008efff]
> [    0.007420]   node   1: [mem 0x0000000000090000-0x000000000009ffff]
> [    0.007422]   node   1: [mem 0x0000000000100000-0x000000005c3d6fff]
> [    0.007422]   node   1: [mem 0x00000000643df000-0x0000000068ff7fff]
> [    0.007423]   node   1: [mem 0x000000006c528000-0x000000006fffffff]
> [    0.007424]   node   1: [mem 0x0000000100000000-0x000000047fffffff]
> [    0.007425]   node   5: [mem 0x0000000480000000-0x000000087effffff]
>
> and nr_cpus set to 4. The underlying reason is tha the device is bound
> to node 2 which doesn't have any memory and init_cpu_to_node only
> initializes memory-less nodes for possible cpus which nr_cpus restrics.
> This in turn means that proper zonelists are not allocated and the page
> allocator blows up.
>
> Fix the issue by moving init_memory_less_node into numa_register_memblks
> and always initialize all possible nodes consistently at a single place.
>
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/x86/mm/numa.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 1308f5408bf7..4575ae4d5449 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -527,6 +527,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
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
> @@ -592,6 +605,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                         continue;
>
>                 alloc_node_data(nid);
> +               if (!end)
> +                       init_memory_less_node(nid);
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
> 2.19.2
>
Hi Michal,

As I mentioned in my previous email, I have manually apply the patch,
and the patch can not work for normal bootup. Your new patch seems to
have no essential changes, I applied it and had a try. It does not
work yet.

Thanks,
Pingfan
