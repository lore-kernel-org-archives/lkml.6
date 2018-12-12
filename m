Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB20C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645202086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eON7OqkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645202086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLLIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:33:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43458 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:33:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so14815481eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8dHeNFud+oTAfucUN6P3uYFVdEaTbx1RNrOc/domP0=;
        b=eON7OqkOwFUAJ9+jTGof+/hpfQQpIVhA5tTdGjI7BW2GUw8k0JLcFirkLbnsq/WQ+a
         aiKS25qPOEENVNzJbX/EYfM4dugcSqBK/63oQ3ob/QJcQ1RObn8jo0ndBKlD/KO9qD/k
         s1JtVwXkoa8A43xWa+HKoOx0SGHo11mN5UiEM67gNE4TRPqxpMtZo7DHkJ2imsLw3Ag1
         7pQI8NXiFYI/Y6XUXWR0wbpz4aPDrg87P2ABGSaDR92o03AvQDMusu21aK4vkYR4/Ra9
         Z67QMfw4iU2g+pH1QF5HIr7x+PZEoJhWrWJkFbh4b84A7C3Gb8RRg55PapKJC5vJxRX5
         IsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8dHeNFud+oTAfucUN6P3uYFVdEaTbx1RNrOc/domP0=;
        b=lhj5TPLyUzl3QZkaDJ6kYLxXjEgx5TdR2jqryYnsJdYkThem47lNlFQTmJCBgsas3U
         8ue22CYFQX5nKWqnkmSiFH/KOsvB1Gl1HpnuvtbUkTFua8q0OXQBVh4RaO1XBGWLGDE4
         odv7acc3xAA03RUAiIlYK2kEsy4pPMssM+rfoa1GC05dq0dnqRdt4HCT7w5YsgQdS3oj
         kFfxzVq4m/7ya7mXZoFaEFyThWUC1Id4+owzDkmKS0u58F6aXjMP3TtcSlRjhQK5f7Un
         OWhRX7wTaYvV7StgZ47UL0PZ/KDMOMAdR0ybAyQ59aHqgnKfeOxlBsuEwJYvPrKajxNA
         DjHQ==
X-Gm-Message-State: AA+aEWY1v2Xz/Q3nxIO8LGgMyoblmYflyVoTIaZiF3yPnOH/p5GMQUiT
        b1a8CrSBz692PwyLoUlguq6YnV9hy1LCYOBGM+9SUJU=
X-Google-Smtp-Source: AFSGD/Wru6LcpT5O2LyCrMySpBXc/+pIRYl9K5xImGSEGelvTdzWoGcE0HSLTr9yHo2/Ssl4mGzG6Yf2cP2GSUGyCDI=
X-Received: by 2002:aa7:d487:: with SMTP id b7mr17332973edr.256.1544603617929;
 Wed, 12 Dec 2018 00:33:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz> <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz> <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz> <20181210123738.GN1286@dhcp22.suse.cz>
 <CAFgQCTsb-G6=o=kyh845RHDTB2WYXywfLiYRddPmoiQVGpqzLA@mail.gmail.com> <20181211094436.GC1286@dhcp22.suse.cz>
In-Reply-To: <20181211094436.GC1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 12 Dec 2018 16:33:25 +0800
Message-ID: <CAFgQCTsbuX8MROsFpQrjd0OAfp6oVRtq7VKYi2VGNyrQvxVF-w@mail.gmail.com>
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

On Tue, Dec 11, 2018 at 5:44 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 11-12-18 16:05:58, Pingfan Liu wrote:
> > On Mon, Dec 10, 2018 at 8:37 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 07-12-18 16:56:27, Michal Hocko wrote:
> > > > On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
> > > > [...]
> > > > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > > > index 1308f54..4dc497d 100644
> > > > > --- a/arch/x86/mm/numa.c
> > > > > +++ b/arch/x86/mm/numa.c
> > > > > @@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
> > > > >  {
> > > > >         int cpu;
> > > > >         u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
> > > > > +       int node, nr;
> > > > >
> > > > >         BUG_ON(cpu_to_apicid == NULL);
> > > > > +       nr = cpumask_weight(cpu_possible_mask);
> > > > > +
> > > > > +       /* bring up all possible node, since dev->numa_node */
> > > > > +       //should check acpi works for node possible,
> > > > > +       for_each_node(node)
> > > > > +               if (!node_online(node))
> > > > > +                       init_memory_less_node(node);
> > > >
> > > > I suspect there is no change if you replace for_each_node by
> > > >       for_each_node_mask(nid, node_possible_map)
> > > >
> > > > here. If that is the case then we are probably calling
> > > > free_area_init_node too early. I do not see it yet though.
> > >
> > > OK, so it is not about calling it late or soon. It is just that
> > > node_possible_map is a misnomer and it has a different semantic than
> > > I've expected. numa_nodemask_from_meminfo simply considers only nodes
> > > with some memory. So my patch didn't really make any difference and the
> > > node stayed uninialized.
> > >
> > > In other words. Does the following work? I am sorry to wildguess this
> > > way but I am not able to recreate your setups to play with this myself.
> > >
> > No problem. Yeah, in order to debug the patch, you need a numa machine
> > with a memory-less node. And unlucky, the patch can not work either by
> > grub bootup or kexec -l boot. There is nothing, just silent.  I will
> > dig into numa_register_memblks() to figure out the problem.
>
> I do not have such a machine handy. Anyway, can you post the full serial
> console log. Maybe I can infer something. It is quite weird that this
> patch would make an existing situation any worse.

After passing extra param to earlyprintk, finally I got something. I
replied it in another mail, and some notes to your code.

Thanks,
Pingfan
