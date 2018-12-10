Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D966C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0922081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm1148zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0922081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeLJEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:00:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLJEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:00:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so8309192edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 20:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm6Lz0Gq3rNsyHZXFWF3JTzoIllqElfNczDvThKKAtg=;
        b=Bm1148zcQRQemMCL2MhKQ4rIlq8GE/acWh19T9NgFWt+kBgb2cnM6CCxnNrwiCaPvQ
         uOaLOYk8K1NNy5gSXRiKm9bRMYzGL76QVkTKFU/qYtnhQeFnF3/XYFPJ3+MtACQL5Cj2
         dLpj5a2RWq0BO33z93hPl5qJnFuwINXwEbl2SOTb95wgWn5wiIAWEAykPTKcbR8diz2p
         0QAXkOsXEN0F5OSK4JteZPrz8mfhfCLHcTBuVcIMo8xwH95e2ZmAS7b1r9Pt1z0fw0yM
         3JKxFOOMqK43MD0JVaQPW47AnjmZx5YRq2AObm4JXmiYxxQvTST/zqv/hlxi0oFn5GPo
         9Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm6Lz0Gq3rNsyHZXFWF3JTzoIllqElfNczDvThKKAtg=;
        b=pm6JF2st85WcsdHegaKVS/MMrkTbGhBYV42AMqKaktwb/CBPZN/5YxXKSR34FjV4vz
         2wXc6CYp3MX138wbvs5qmy7vNbfClA2OdKiIMi5e9nxsyMUHXC2LumDyyy+fRJ83NiI/
         q/1g7laedBWqiPPozhGXh0IVRR4kmWGIfFgYzlmP9qD9j2ixHDEE0njUL9AifnPJFCXz
         1VKQwAs3nr7FaSuvzudg7GsKz11PQjeXZ4+ejs13vW35qrJI5S9rakIX7KuQWSSz4eEY
         asjjuZ88VqABtSmFJlGdXQjKajGf0aFWDp6i28z6pX1eOoxQBrepoaUt2AmuINORgbGK
         8cuQ==
X-Gm-Message-State: AA+aEWbJXMznwTc7p/r+Zvl49xWNrfotweHchjPBPAO+CYWXIaGDeWiE
        HM9LFKDplVSZqtyxDvFc4poecZX8xjIT5M460nuVYOQ=
X-Google-Smtp-Source: AFSGD/WXPnm1W4X1syFfxmi2K2zI1iDfLRMICDRNFAKD8bK0V7TG5QPApdPIA19VYVoCSbt9WEZ+6+kZRQPoqJo/+1s=
X-Received: by 2002:aa7:d487:: with SMTP id b7mr9673796edr.256.1544414454227;
 Sun, 09 Dec 2018 20:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz> <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz> <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz>
In-Reply-To: <20181207155627.GG1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 10 Dec 2018 12:00:41 +0800
Message-ID: <CAFgQCTvXDFL73YopcU6iwtQFvxxJno78n=dii9ESskV2PP8+fQ@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
> [...]
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 1308f54..4dc497d 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
> >  {
> >         int cpu;
> >         u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
> > +       int node, nr;
> >
> >         BUG_ON(cpu_to_apicid == NULL);
> > +       nr = cpumask_weight(cpu_possible_mask);
> > +
> > +       /* bring up all possible node, since dev->numa_node */
> > +       //should check acpi works for node possible,
> > +       for_each_node(node)
> > +               if (!node_online(node))
> > +                       init_memory_less_node(node);
>
> I suspect there is no change if you replace for_each_node by
>         for_each_node_mask(nid, node_possible_map)
>
> here. If that is the case then we are probably calling
> free_area_init_node too early. I do not see it yet though.

Maybe I do not clearly get your meaning, just try to guess. But if you
worry about node_possible_map, then it is dynamically set by
alloc_node_data(). The map is changed after the first time to call
free_area_init_node() for the node with memory.  This logic is the
same as the current x86 code.

Thanks,
Pingfan
