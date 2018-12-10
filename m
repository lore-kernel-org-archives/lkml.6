Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D96205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxW3UI5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D96205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLJH5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:57:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45119 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLJH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:57:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so8613007edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lK7e7MOQU8j6wHCV0p74SUnJiNIXtV3U2lQzw6nRSs=;
        b=XxW3UI5onXgbssvX/mZGF2N4Cuj7pb+9d/8gAchtOi90ksESrkECg3OAAPnwIiVpgz
         Sia4RjJRzNy9iwCCW9i3F2rbNY5uLKw+PQeKvY0M38rW5u3aDa9HlmmVqtb03rHXKgQv
         1zCQxDl8ENiZOc8JUqk4HiKeGZd9EmZAay/ngSv2101Bk/sd/M2rmUPXCiJpFiKTLO9q
         jKG5h9CopUtu8sir+5sGiVhsk/ko/MVYqXLKFUm5GwimzpMaocTF2m5W1h6eK34FPHo5
         dLeHJXP7wBokEsqQ+QWeAShDO4mjvt8LKcDe69K0UBzN40wIz9GlcdZMi/Cwijmc5nZ5
         iwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lK7e7MOQU8j6wHCV0p74SUnJiNIXtV3U2lQzw6nRSs=;
        b=guA5Rq+mju++G0Gi9L7ZxFAh+uXBjC9ndS7zy8E0msNGFZeLwr9oMEm5h+pkC9i5sm
         AX1K4Ui9gQbgcWuu3ZHT8deZX2zrvltShmmcysgTJOeBXB4qxV6nR2g7dPo/Y5vQvpi6
         Ri+3qzGHDDFcFBueBg/s5MmsvUIWCv9hkDLtbpLByRPui6uWDtJ1NSHv1xf6JRkJ8v5w
         lKjcMPBrYINmCroJZs0ftqdZjxoi+f7eyDxsFozomNHaOZq2mZjPlEYe5J+hkHctMqcE
         968AYw1ns1YvMoQEASEC9C6XsPXrgo9JOwL2LQrNQZT0g+2kLQZJYEodnqWMHbEstEsN
         qwdQ==
X-Gm-Message-State: AA+aEWZ4jlsWXomMXUHFhmjJoVhR8FcgvThVGxTxJFdoe+JcvmHNKucU
        SxHIp29NlyiROM5HnMOclN0VUN8Q/2xN0gMdkA==
X-Google-Smtp-Source: AFSGD/WTI7SLutf1gj6zKueIn1cyqDcj6bQiXpm8bU52jots1mj+g3QjkSqaWTqXOaKfJrener8mjcg3Jyh4yec6hCE=
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr10728458edx.208.1544428634965;
 Sun, 09 Dec 2018 23:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz> <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz> <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz> <CAFgQCTvXDFL73YopcU6iwtQFvxxJno78n=dii9ESskV2PP8+fQ@mail.gmail.com>
In-Reply-To: <CAFgQCTvXDFL73YopcU6iwtQFvxxJno78n=dii9ESskV2PP8+fQ@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 10 Dec 2018 15:57:02 +0800
Message-ID: <CAFgQCTu18oebiMWk2EtPdsxZ2db9iK=tZ4qM7zh38QdkpCnJsw@mail.gmail.com>
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

On Mon, Dec 10, 2018 at 12:00 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Fri, Dec 7, 2018 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
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
> >         for_each_node_mask(nid, node_possible_map)
> >
> > here. If that is the case then we are probably calling
> > free_area_init_node too early. I do not see it yet though.
>
> Maybe I do not clearly get your meaning, just try to guess. But if you
> worry about node_possible_map, then it is dynamically set by
> alloc_node_data(). The map is changed after the first time to call

A mistake, it should be node_online_map. and in free_area_init_nodes()
for_each_online_node(nid) {
   free_area_init_node(nid, NULL,..

So at this time, we do not need to worry about the memory-less node.

> free_area_init_node() for the node with memory.  This logic is the
> same as the current x86 code.
>
> Thanks,
> Pingfan
