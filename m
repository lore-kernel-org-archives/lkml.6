Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F38C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A712173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2QdwSYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBZFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:40:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33936 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:40:18 -0500
Received: by mail-io1-f67.google.com with SMTP id e1so9596949iok.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2WRTnzkd0HHCIjHVGDZyo2Tadbbej1CTbAbmG5YY9w=;
        b=X2QdwSYDVj6jxsGxJsdDJJneo6b5fquN5fFtA6SykEWJhLqubJcPoWN5lKnxJKKz67
         Fonk5NMgG1cE+lSUaX4QR7Tff6pZu0LW/yY9J+M3MT8l5V3Nqwu16EgSN+q+1RBjcLK0
         QyYPzDcRfCdllfLMObOJC50abCmOuYJJag55a7i3XjGhR/zyzUeuMnqM+WrRocLSjv5y
         uu2C1M5t3jNMiKJ9omydhdJkJJ8N4TsUDBjP9cK/PLm1vOeyBZh3YzzeEwHAK/nrhwN5
         hxHuHMUiHRz0zd+MWkStMTfICfV5WFnYTt9M9fi9v6r5fxvirvG2nyXtSLGC/ibOaVgc
         Xb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2WRTnzkd0HHCIjHVGDZyo2Tadbbej1CTbAbmG5YY9w=;
        b=ikm4Ltsf8ilCxmsUf973tMLzowjP4R6V7PTk4Aa8wIdIx0FBQ/IIgWGtYDd5CsVJzN
         k6kOyJxvFpw7AEXCiKIzYf/GfWuPefxs5fmwnufHPUe+C0so8+3Wz/lUwD6Tjiyj3gU1
         3Biw4rVpQ5B700LtZ/qH91Bb5bbOvr0tK1nfUvQOm1eqi44jW+7AbOPTEuOPzpq+247y
         +DPKWzZVnYCmPzi4MCi0zOVmS9uFkCiLjOBWxIChjbhhj5qAqRceGUaM1HbcuQwkI/fC
         xgT8ywB+fCN/Ya9W/NBpdQ8acURckrGAghJ5OWNWN780iBCP9OQW3hTCYDszEg0aOcZa
         Q25g==
X-Gm-Message-State: AHQUAuajjTouh/8NT1rR45b1RsMqkwMn+k7o+5E7oUB2wq5lY01gep09
        2SxMvcHJb2Nmx10UswVFtARAwOtAimU2v8eusvADzexqKg==
X-Google-Smtp-Source: AHgI3IZjrjSzD1nRszTH2FEyQdqiRXJzhZJUWFL6BsYzsCiCOsSM+KaJ+E2jSbQUfSQcLFlJhighGurgkx9xiEQVaFE=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr10644521iog.281.1551159617251;
 Mon, 25 Feb 2019 21:40:17 -0800 (PST)
MIME-Version: 1.0
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <1551011649-30103-3-git-send-email-kernelfans@gmail.com> <0371b80b-3b4c-2377-307f-2001153edd19@intel.com>
In-Reply-To: <0371b80b-3b4c-2377-307f-2001153edd19@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 13:40:05 +0800
Message-ID: <CAFgQCTtuy=ueX_Eb5Z56SKMACc05qtPMJOw-WAgBbCAH_wZyjA@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/memblock: make full utilization of numa info
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:34 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/24/19 4:34 AM, Pingfan Liu wrote:
> > +/*
> > + * build_node_order() relies on cpumask_of_node(), hence arch should
> > + * set up cpumask before calling this func.
> > + */
>
> Whenever I see comments like this, I wonder what happens if the arch
> doesn't do this?  Do we just crash in early boot in wonderful new ways?
>  Or do we get a nice message telling us?
>
If doesn't do this, this function will crash. It is a shame but a
little hard to work around, since this function is called at early
boot stage, things like cpumask_of_node(cpu_to_node(cpu)) can not work
reliably, and we lack of an abstract interface to get such information
from all archs. So I leave this to arch's developer.

> > +void __init memblock_build_node_order(void)
> > +{
> > +     int nid, i;
> > +     nodemask_t used_mask;
> > +
> > +     node_fallback = memblock_alloc(MAX_NUMNODES * sizeof(int *),
> > +             sizeof(int *));
> > +     for_each_online_node(nid) {
> > +             node_fallback[nid] = memblock_alloc(
> > +                     num_online_nodes() * sizeof(int), sizeof(int));
> > +             for (i = 0; i < num_online_nodes(); i++)
> > +                     node_fallback[nid][i] = NUMA_NO_NODE;
> > +     }
> > +
> > +     for_each_online_node(nid) {
> > +             nodes_clear(used_mask);
> > +             node_set(nid, used_mask);
> > +             build_node_order(node_fallback[nid], num_online_nodes(),
> > +                     nid, &used_mask);
> > +     }
> > +}
>
> This doesn't get used until patch 6 as far as I can tell.  Was there a
> reason to define it here?
>
Yes, it gets used until patch 6. Patch 6 has two groups of
pre-requirements [1-2] and [3-5]. Do you think reorder the patches and
moving [3-5] ahead of [1-2] is a better choice?

Thanks and regards,
Pingfan
