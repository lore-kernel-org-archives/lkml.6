Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA615C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25DC208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlmS0Wyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25DC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeLDIxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:53:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47007 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeLDIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:53:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so13168938edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naPYivzUbSD136Zmc8GMw+uYeyRypkHMz0OobuffUDM=;
        b=NlmS0Wyfuo+XM4apPPYOa5PH00bfzaFF7+bGF+3cKKGYT3R3rm13Jf4McnZ+c9VUrU
         e4/j9jzsb1t0h6NvfGw7DjfpNYrDkKXa1LFMXC3yARnehuxjvWwoA2Lor4OwWW/GPCAh
         +eet768Nu7jPL7lh0ijEj3ZA+efpBG7AB9b37osQYHKaRJkW+T1fZEhJC7z4ZBqWEu3h
         NL5BGT0VrEEyq6sEtRzZBvxArPEuzCjE/9t4jWF8/oQFpjvegq6l2g71EXH26ovPNaUt
         XRTZtV3vHy6OBto2kN4BLCMQuwemnU7zh1GXQlfunZC8kgwnZ0WCHv0PZWM9I9aixmz0
         SmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naPYivzUbSD136Zmc8GMw+uYeyRypkHMz0OobuffUDM=;
        b=bw/pkl2C/G15cFgz4z1IlfRz5CezU0Dhi9fqhjbg3Hfkjt17Sc+/UScrKlnh2cUR0Z
         x4mpBlg3AxHNYy2A/2CF6IHqHpxbJRI6IQthM+8npn865em7O5DFNw6KZ3rQ9q2CLUSf
         3H8rJeiglV+sIjM6goHuKzaS9poeViauW5FI/bbggXUvOcER70xj/pr+y7tQYkSRY40o
         +7Ytj3HCa7swzIRlPZwcZPk/AF3Yf4RSYx+IhykqfZ2r/GxUQ3c9bpnZ9WJLc/D4bSxz
         NvHwfnT5LIFVXuqd+wlWcf4NNLs8deRy0GOOPmnMMAaZmSxHz3481UKzUTCS2rQoiGTM
         NmLA==
X-Gm-Message-State: AA+aEWYKe8QHwk5WlcfkYkhGz6vrLS5Lx+gmlzYAAs79vl0H7hE/Ipn7
        vVUKE3aoOMqNCM/TrN5PQRKjz+LwR/Yl9heGwQ==
X-Google-Smtp-Source: AFSGD/WX+tLFLDKcSOgWJQ4hqi/5n+QS8O77S9OH7rLwR5KcGctisFjwcMw22p/u8N53j0C8JmVf5mVThuaXUisK5hc=
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr15311029ejb.11.1543913583728;
 Tue, 04 Dec 2018 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204065453.4rsyhtsk2aej4vim@master> <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
 <20181204083428.emgcaomg6vulknaq@master>
In-Reply-To: <20181204083428.emgcaomg6vulknaq@master>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Dec 2018 16:52:52 +0800
Message-ID: <CAFgQCTtY28w=9LLgOMT5J-SfKqz-Cirv-bNvXQvjazn_Ev4F4g@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 4:34 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Tue, Dec 04, 2018 at 03:20:13PM +0800, Pingfan Liu wrote:
> >On Tue, Dec 4, 2018 at 2:54 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> >>
> >> On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
> >> >During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> >> >kernel failed to bootup, because some node's data struct can not be allocated,
> >> >e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> >> >device->numa_node info is used as preferred_nid param for
> >>
> >> could we fix the preferred_nid before passed to
> >> __alloc_pages_nodemask()?
> >>
> >Yes, we can doit too, but what is the gain?
>
> node_zonelist() is used some places. If we are sure where the problem
> is, it is not necessary to spread to other places.
>
> >
> >> BTW, I don't catch the function call flow to this point. Would you mind
> >> giving me some hint?
> >>
> >You can track the code along slab_alloc() ->...->__alloc_pages_nodemask()
>
> slab_alloc() pass NUMA_NO_NODE down, so I am lost in where the
> preferred_nid is assigned.
>
You can follow:
[    5.773618]  new_slab+0xa9/0x570
[    5.773618]  ___slab_alloc+0x375/0x540
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
where static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)

Thanks,
Pingfan
