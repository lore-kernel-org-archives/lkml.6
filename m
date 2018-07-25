Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBBFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FC220891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="Ce34qY5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FC220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeGYMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:37:42 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37216 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbeGYMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:37:41 -0400
Received: by mail-vk0-f66.google.com with SMTP id v72-v6so3605463vkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4/LA+odJ6m0a+z3vChCwyKPhprbd9Dgo9CIEQyMnWKQ=;
        b=Ce34qY5A1EWdrbc5JqU+sTVU66bEpl3kyCeuRbiUPo8US47w38FPMEhpL3a7f80Tjh
         OjnPUigoZk3goW/rVkuWUj55Enh2A+I+FYO4qntVCuujx3a+xq3MEqDnjzQhyjtOUIPB
         mPFZlVqyMg7BC9FeBFOherpQ4KjFPEx95vPsFUnPCURufV5PpO1Eix6/NARNC3G5FPki
         TJLQeSn2N9EqdiXQjXFqOVX3BDWWZOno6jVFCNIga/Fz8XmJWi1WarFZwWMiX8T7GZHd
         QR/nkHqbxq5wZwoq3OHiLHA2AtPxxO7AZSQNbera37eLgvd1csSbOdatjbxJUUL+wosF
         vFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4/LA+odJ6m0a+z3vChCwyKPhprbd9Dgo9CIEQyMnWKQ=;
        b=jvw7kRmVB/jTzmyBYgqXdC1lQaKXzauJWz+BJx13yMeut7CvVCNNepqcLnBfLfYHu8
         ltBXCANT0Vg6HXsDPstJ54NuFAapWkui69tlpmi1hx0q8YrTrmo7cBFv7/kTcbe92A/h
         oimwFmIbCg3PHpu4+sbMBZiA2KuS1mKwcLcJzLHv9JCgEe4jzc7qIrf0pAQcLYUrvSu5
         rZeHMGUkmBPdOlZm/dAa5hqmfsKWjHygQUWaeYeutywXmFn4rHoewF3HHYABQadiQwQo
         b/mDBeAayaat8+y5Mb+Y9qUTecpJgvOe1Kkn+liQicRfAUT1PVXOACvehrgbBfl25tw2
         dYww==
X-Gm-Message-State: AOUpUlEWShbMgcQ0FJGnB2jU4i4VHqxHRlH6qhJPIbDAe/THCKtE40fO
        Vyo2BOlUE8F36AMfOpqcvV+Gxz+RX62h91rqetNc2w==
X-Google-Smtp-Source: AAOMgpeNoyR8C1QYyCIV4QNtj00VwKHeShitz7CE4gomUfNGDTNW8eRT2PuovaGgpxopaUiUF8nC14EiRD1Dp4FzwLc=
X-Received: by 2002:a1f:8cd5:: with SMTP id o204-v6mr12639023vkd.49.1532517986315;
 Wed, 25 Jul 2018 04:26:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 04:26:25 -0700 (PDT)
In-Reply-To: <20180724224635.143944-1-shakeelb@google.com>
References: <20180724224635.143944-1-shakeelb@google.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 25 Jul 2018 13:26:25 +0200
Message-ID: <CAOm-9arFu63A9YJ6yVtm6_LdtbRKZg1Q3dz8WugdkBBQfoOWYw@mail.gmail.com>
Subject: Re: [PATCH] memcg: reduce memcg tree traversals for stats collection
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 00:46, Shakeel Butt <shakeelb@google.com> wrote:
> I ran a simple benchmark which reads the root_mem_cgroup's stat file
> 1000 times in the presense of 2500 memcgs on cgroup-v1. The results are:
>
> Without the patch:
> $ time ./read-root-stat-1000-times
>
> real    0m1.663s
> user    0m0.000s
> sys     0m1.660s
>
> With the patch:
> $ time ./read-root-stat-1000-times
>
> real    0m0.468s
> user    0m0.000s
> sys     0m0.467s

Thanks for cc'ing me. I've tried this patch using my test case and the
results are interesting. With the patch applied, running my script
only generates about 8000 new cgroups, compared to 40,000 before -
presumably because the optimisation has altered the timing.

On the other hand, if I run the script 5 times to generate 40000
zombie cgroups, the time to get stats for the root cgroup (cgroup-v1)
is almost unchanged at around 18ms (was 20ms, but there were slightly
more cgroups as well), compared to the almost 4x speedup you're seeing
in your test.

Regards
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
