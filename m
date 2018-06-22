Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA8FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65289244E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLTLgBA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65289244E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933907AbeFVPd4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:33:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46523 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933662AbeFVPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:33:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id l14-v6so2055617wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2ZpZRMO5Zxl1TQ5jcvOeTPicfb43lcGtkmgOqtPeyk=;
        b=QLTLgBA+XXIzLTZgQMqfncMO/Gmew4vSKGaYK40/jL8zzmcKHpDbanBZR8YOrRmC2W
         z2jvWsjUuQIGbrr17rh6+WU1qpSMKDNYw5ZFZWN1GHMGmxj4VJrvxpeTeX5Xd2q5NNPj
         CNUD6q9hzsjuwCioihJ+Wd73UQ8/qttWXziQnhd1ZelIna/19Ehs12FlSuZHeWGO2nLt
         eEkNP8tbp0W2HMAZH/7L+9VSmLWtc0UIskLWyPm5cwa/f/06mcjrm2b7u22LzW3QkZh/
         k8CvyEEcFvPs7BEuYdUm/JNCqhxsxMmE+2lzUoqJs1rkx4/s2HRdEvt2Gv8ZWv3vhNQw
         Z5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2ZpZRMO5Zxl1TQ5jcvOeTPicfb43lcGtkmgOqtPeyk=;
        b=Y4GluCr8RTmNv7vCrsHCP+3G25Jxxt88V7WwNI7EH9dt6pRtgEYafn2Utdpq1NE3sw
         sQprcEz7FX7DsY3Z1e9EckpiGAaOfZyX2c0Pndhk3D4tBC9MvdIWvZa6LtYPxKmmRcJL
         f8AXMiOT6xPsuLny7YDvfTgfLhAMkWM7v/PVFyh0K2ZbJKdyGVHFe6NxJvw1iXBRHA/T
         xSwxRc3AyuTM18SCj3tD+DsTGNYyb1/zllp5GJjM5t6rwKSnt5JnYuA00faHUOcfs1nf
         Dg1HcrSxxOotq20MSLgGx3eXVe6toGVXr/Kvx01mn+r5RYq9zX/Htc6IgIVhadmpBBF8
         gXQw==
X-Gm-Message-State: APt69E0lG4tcUeHKnLr9A/E325qjlfY4cEg+xEwGhws3K1qBuFj+l4D+
        b1+o64d/SsSMcmRdDx8kMx1FRgVmmeMgz6OFVErqRw==
X-Google-Smtp-Source: AAOMgpdXNhnJ1LToSh8oHHiCGSgpad437GGuv0SdUdWTgJ0byUL5S4v/eWWZIROZgHv2uPFsBjt1bM+FfWUr6f4/SUI=
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr2144408wrm.2.1529681632401;
 Fri, 22 Jun 2018 08:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180620224147.23777-1-shakeelb@google.com> <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
 <20180621150122.GB13063@dhcp22.suse.cz>
In-Reply-To: <20180621150122.GB13063@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Jun 2018 08:33:40 -0700
Message-ID: <CALvZod7Rf0FZHqYBPd1OTkVuvA5QRrkYQku40QJtS2--g6PrQQ@mail.gmail.com>
Subject: Re: [PATCH] slub: track number of slabs irrespective of CONFIG_SLUB_DEBUG
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:01 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 21-06-18 01:15:30, Cristopher Lameter wrote:
> > On Wed, 20 Jun 2018, Shakeel Butt wrote:
> >
> > > For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> > > allocated per node for a kmem_cache. Thus, slabs_node() in
> > > __kmem_cache_empty(), __kmem_cache_shrink() and __kmem_cache_destroy()
> > > will always return 0 for such config. This is wrong and can cause issues
> > > for all users of these functions.
> >
> >
> > CONFIG_SLUB_DEBUG is set by default on almost all builds. The only case
> > where CONFIG_SLUB_DEBUG is switched off is when we absolutely need to use
> > the minimum amount of memory (embedded or some such thing).
>
> I thought those would be using SLOB rather than SLUB.
>
> >
> > > The right solution is to make slabs_node() work even for
> > > !CONFIG_SLUB_DEBUG. The commit 0f389ec63077 ("slub: No need for per node
> > > slab counters if !SLUB_DEBUG") had put the per node slab counter under
> > > CONFIG_SLUB_DEBUG because it was only read through sysfs API and the
> > > sysfs API was disabled on !CONFIG_SLUB_DEBUG. However the users of the
> > > per node slab counter assumed that it will work in the absence of
> > > CONFIG_SLUB_DEBUG. So, make the counter work for !CONFIG_SLUB_DEBUG.
> >
> > Please do not do this. Find a way to avoid these checks. The
> > objective of a !CONFIG_SLUB_DEBUG configuration is to not compile in
> > debuggin checks etc etc in order to reduce the code/data footprint to the
> > minimum necessary while sacrificing debuggability etc etc.
> >
> > Maybe make it impossible to disable CONFIG_SLUB_DEBUG if CGROUPs are in
> > use?
>
> Why don't we simply remove the config option altogether and make it
> enabled effectively.
>

Christopher, how do you want to proceed? I don't have any strong
opinion. I just don't want KASAN users kept broken for SLUB.

thanks,
Shakeel
