Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B48D20672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjAAZ87t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B48D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeLEFum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:50:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37487 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLEFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:50:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so15953838edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifzMLHybfpW67tLPQj0RQFPXuznK3mpTjDTJkJL18mk=;
        b=PjAAZ87t+wOMqn6WHyhKukIAAazuNj3I6oGd1RzFLIQh/vLXGWwe6eKDuheoslZFbb
         GOsLDmTXub0MsFlLB3eP4LqXvyWkv9iIEj2qpfIaKE1l/lb7o3Uf3BAeeM0Ho4X+q3CP
         MLMld1Gi2GXKA41NEu6LMPn/WD6vupVFkSoGHxSltscpj32nm6/wX2lKfgxzUn9nyRGG
         1YzrjWYc7SettOWfJGuUzKWeyfM4u0mOeoh0fHge5w5xdcEPJeyLCAn/9b3nV2aGNdD6
         DIZLWmbtrCfjRvsbxHAap+Z9r1jggZsiLd8GcY/nLyUr8B1Dbwxu7hspGJdWqTjBknvW
         PhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifzMLHybfpW67tLPQj0RQFPXuznK3mpTjDTJkJL18mk=;
        b=GULlnRCXrjn9xrabINfTglpCj4gMZXsGdW9Q8h+0iZyD2viI3tfoLsc5CzvWMYdcCx
         Ra0m248xZIk8ZiZsuuxhrwlWG3e4OJffdUktAoHxxQhCgxec1VdwTa0nYpvRLI27HnBY
         dwVCRD/uvU/NG8OZU060l49SyRrXyZb5ChysYdGpN5raSECIrQ2UZzt2opNb8RKbC8N3
         g/OUN1mekwG78S2Dg6EvyCbJqyN+KmadZVFEjTbIYcvKbBDTh8j6YqgYv1rMPpLXCuMP
         DHp3Ww/Nfy2z53yPAarVf/jbZB0nP68KyKxz4LY1eHF4Hz63fiCFIGaH1FMZFWZ9lHOT
         JpgQ==
X-Gm-Message-State: AA+aEWYmMlncFPCj2gA7+wancGsVc6Uo0GXGKEsxu+iRvKhNA4g4o+jh
        ME6pyZKkVDawSLuxQiP/jVHu3eXPn0pc4M5XFQ==
X-Google-Smtp-Source: AFSGD/X+XHawdJJovpkrNLhhTxCdqknrKH81D/cxUpITyoAk881bqp7WWlp10uxvjrTANGQhSxi/vLX7wdKSEoadPuI=
X-Received: by 2002:a17:906:a281:: with SMTP id i1-v6mr17635876ejz.86.1543989040326;
 Tue, 04 Dec 2018 21:50:40 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204065453.4rsyhtsk2aej4vim@master> <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
 <20181204083428.emgcaomg6vulknaq@master> <CAFgQCTtY28w=9LLgOMT5J-SfKqz-Cirv-bNvXQvjazn_Ev4F4g@mail.gmail.com>
 <20181204090950.ql3zbnbjjbfnvhdg@master>
In-Reply-To: <20181204090950.ql3zbnbjjbfnvhdg@master>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 5 Dec 2018 13:50:28 +0800
Message-ID: <CAFgQCTtKud54LL+afhf+j4axzho9MNErDN1DCNZLbOtHG-gHWQ@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     richard.weiyang@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:09 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Tue, Dec 04, 2018 at 04:52:52PM +0800, Pingfan Liu wrote:
> >On Tue, Dec 4, 2018 at 4:34 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> >>
> >> On Tue, Dec 04, 2018 at 03:20:13PM +0800, Pingfan Liu wrote:
> >> >On Tue, Dec 4, 2018 at 2:54 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> >> >>
> >> >> On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
> >> >> >During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> >> >> >kernel failed to bootup, because some node's data struct can not be allocated,
> >> >> >e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> >> >> >device->numa_node info is used as preferred_nid param for
> >> >>
> >> >> could we fix the preferred_nid before passed to
> >> >> __alloc_pages_nodemask()?
> >> >>
> >> >Yes, we can doit too, but what is the gain?
> >>
> >> node_zonelist() is used some places. If we are sure where the problem
> >> is, it is not necessary to spread to other places.
> >>
> >> >
> >> >> BTW, I don't catch the function call flow to this point. Would you mind
> >> >> giving me some hint?
> >> >>
> >> >You can track the code along slab_alloc() ->...->__alloc_pages_nodemask()
> >>
> >> slab_alloc() pass NUMA_NO_NODE down, so I am lost in where the
> >> preferred_nid is assigned.
> >>
> >You can follow:
> >[    5.773618]  new_slab+0xa9/0x570
> >[    5.773618]  ___slab_alloc+0x375/0x540
> >[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
> >where static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
> >
>
> Well, thanks for your patience, but I still don't get it.
>
> new_slab(node)
>     allocate_slab(node)
>        alloc_slab_page(node)
>            if (node == NUMA_NO_NODE)
>                alloc_pages()
>            eles
>                __alloc_pages_node(node)
>
> As you mentioned, this starts from slab_alloc() which pass NUMA_NO_NODE.
> This means it goes to alloc_pages() and then alloc_pages_current() ->
> __alloc_pages_nodemask(). Here we use policy_node() to get the
> preferred_nid.
>
> I didn't catch the relathionship between policy_node() and
> device->numa_node. Maybe I got wrong in some place. Would you minding
> sharing more?
>
Have uploaded the full panic log. Enjoy it.

Regards,
Pingfan
