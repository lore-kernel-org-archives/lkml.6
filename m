Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD27C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DF22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1SDQ6RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfBZFrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:47:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54137 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBZFrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:47:49 -0500
Received: by mail-it1-f196.google.com with SMTP id v2so2217904ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DH6OmOhpK8WgxNk1LoNuyjA4n2qWxmN58P+jI2jwAgM=;
        b=t1SDQ6RY9H+7oBQfzulejsUdCOh5LzYK3hfMJ1duuFr1BYKc5iwKxllIUrfA7ww+4A
         1/qlOvRqvfxXlzDtDs98stby4xlGTpRSqX8n0TRi70vbkbuC+EHZkBBl5TwOFIYMoHnt
         FOk2hX0BbDozu3Ph/9ZlruXfUzLbTsNQ0KLEDdYW7CzIoIMuM66JbJm4T7fPIpDSBpAe
         mvJsSE4nZ+KHhTqOmVh+12wT62T/pVxsO32D4ek9VC3Ixn68HFoMKcJPiVCxAZiOsZvP
         9/g3DqBDoxOe9qiGlnXt7UvbtFE5XRBDzGAOhMUMwgAoGnuiihD2giMbHxFO5P5sfR0e
         kxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DH6OmOhpK8WgxNk1LoNuyjA4n2qWxmN58P+jI2jwAgM=;
        b=h8XH2a582tq+WUmfpqDf6a/aooYUCnVj2V6bti+Nxg9bKrzt+n5z4cSvJ5CqbFFvtr
         GpkBUeOhdsEnaC2tF82sJBi+8UsFxBaOfgTfxrjlkOsPszfviIREaHDmZ589wXo46KnV
         E61NaMqfv0XoTpSzZbTPxV/mwsltC8lUVJnGiIjSZLzomWyq1C3vYR2f0n/S3Rog7NCc
         jHQidvF6UPVBMfnNJbnINqfrwRCjKVa8ZWyD1S+QZh8Qx6HTWt/B+cXMtZOBsaRu9qDw
         Mv9HKU+OseV/WLjV9i3OZiHto1uGLYgV3LRpMwC2fWrc4AspcJDhD2hvU0oAjA4ZMaWq
         /vvw==
X-Gm-Message-State: AHQUAuamC9r7FbOPlj+08sTsr6M99SvPttnxnK0Hl+RBti/muP9iPEZL
        FERuiXiEP+O8Fymo6xd1r9uH+kld+YqtZmq4Yw==
X-Google-Smtp-Source: AHgI3IaOM6lhYu7Ut6XAju3LJS/9hGEbwXMQiyJSieRYahzFibEcaiYEEWRQF4PHCaHRe49ZNLYnKpoIhwYdq7FjZS4=
X-Received: by 2002:a24:4650:: with SMTP id j77mr1506587itb.6.1551160068374;
 Mon, 25 Feb 2019 21:47:48 -0800 (PST)
MIME-Version: 1.0
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com> <20190225160358.GW10588@dhcp22.suse.cz>
In-Reply-To: <20190225160358.GW10588@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 13:47:37 +0800
Message-ID: <CAFgQCTuD9MMdXRjyu1w5s3QSupWWtdcCOR6LhdSEP=1xGONWjQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] make memblock allocator utilize the node's fallback info
To:     Michal Hocko <mhocko@kernel.org>
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

On Tue, Feb 26, 2019 at 12:04 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 24-02-19 20:34:03, Pingfan Liu wrote:
> > There are NUMA machines with memory-less node. At present page allocator builds the
> > full fallback info by build_zonelists(). But memblock allocator does not utilize
> > this info. And for memory-less node, memblock allocator just falls back "node 0",
> > without utilizing the nearest node. Unfortunately, the percpu section is allocated
> > by memblock, which is accessed frequently after bootup.
> >
> > This series aims to improve the performance of per cpu section on memory-less node
> > by feeding node's fallback info to memblock allocator on x86, like we do for page
> > allocator. On other archs, it requires independent effort to setup node to cpumask
> > map ahead.
>
> Do you have any numbers to tell us how much does this improve the
> situation?

Not yet. At present just based on the fact that we prefer to allocate
per cpu area on local node.

Thanks,
Pingfan
