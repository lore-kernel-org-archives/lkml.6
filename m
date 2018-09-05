Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59912073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdPYwe22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59912073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIFCHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:07:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45470 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:07:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so3247839ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHSk24eMBoFLn1koBU9Al9BMY9SPsJFdsl1t/KrFCps=;
        b=pdPYwe22IKtdXmOsJ8LJJCiQIb9my0jSiW+diSq1VA1erRIup4LTGGRD7vse+C+dKd
         zuvd03wid1hrmmq4z5eVJnB3xiY9M7iOAYhbJg5HNGBMCprY+3ubRoHBv7Osq0JhIcad
         ZTFcMMvDTvbrP62rK5b/YIJ04mfPPp50HkB1kiyk24NG+i8LBMsL2uBSAjApa8+3rlrG
         wtDKEmrs5Xii5LmRlfO6b0OAVW9PyHBV/keYO2eiQegJHWnzAeXRmvqNq066kSh9Yzya
         hwS1SDaWyqmYVtJOxl91m7ivhW0pQR1r1NVvEWkid5alcXk9kwXNpmJoW6Gi2FIsuk5A
         WuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHSk24eMBoFLn1koBU9Al9BMY9SPsJFdsl1t/KrFCps=;
        b=rbrFY//46f7IFVMuqWtubLFrMa1kLcBZsKN3jwOYayLRYOX12F3+B5T6KJBccnX3Gt
         YBbA7p7Ma/O5koPaw2F4p7uhUHzvhREZrYMbhNcHcozlwT9+ozhpXdgpc8y62wV334qV
         VOh0eOMLhzM36uUY30AYldbtYdeu6DKsBdAGL1uWNLsys6dX8Rt1oPOeIzjt5baVkmqm
         A/YDk0FhdIdRaYQ8XNIGZELI9tzP7oyTxgNDe98twJwh0nCl9sKc9VJsV8p3lpJIbMSS
         5H/9OZShtXVKUZo7WpOLHkUVIcrBVfGU9N39dDoQMAMRaiOw2m0vtUCb+tSQwVJt8ozt
         OH0Q==
X-Gm-Message-State: APzg51Da/JO72YvtWave2jXD2k1Xxtiw3NvBcDs+oqZoqLsqZaIQRvfv
        oVt4L2O5+FiYraNTZvzYElSR6C5UZ3zWtc1hsCbByw==
X-Google-Smtp-Source: ANB0VdaZRGHM0dePExwhC3cfIs+XvXtW++XklGHkHf3G5z4TbZHsTDLWMEab9cWKL3DFpsX78IRvOs53HZcRaTYy8Cc=
X-Received: by 2002:a81:6a85:: with SMTP id f127-v6mr22491482ywc.27.1536183340212;
 Wed, 05 Sep 2018 14:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180904224707.10356-1-guro@fb.com> <20180905135152.1238c7103b2ecd6da206733c@linux-foundation.org>
 <20180905212241.GA26422@tower.DHCP.thefacebook.com>
In-Reply-To: <20180905212241.GA26422@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 Sep 2018 14:35:29 -0700
Message-ID: <CALvZod4-7cMOqYR5dF82PWuB4qDr5QKu+ScersCVgp74jhvvWA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: slowly shrink slabs with a relatively small number
 of objects
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, jbacik@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:23 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Sep 05, 2018 at 01:51:52PM -0700, Andrew Morton wrote:
> > On Tue, 4 Sep 2018 15:47:07 -0700 Roman Gushchin <guro@fb.com> wrote:
> >
> > > Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
> > > changed the way how the target slab pressure is calculated and
> > > made it priority-based:
> > >
> > >     delta = freeable >> priority;
> > >     delta *= 4;
> > >     do_div(delta, shrinker->seeks);
> > >
> > > The problem is that on a default priority (which is 12) no pressure
> > > is applied at all, if the number of potentially reclaimable objects
> > > is less than 4096 (1<<12).
> > >
> > > This causes the last objects on slab caches of no longer used cgroups
> > > to never get reclaimed, resulting in dead cgroups staying around forever.
> >
> > But this problem pertains to all types of objects, not just the cgroup
> > cache, yes?
>
> Well, of course, but there is a dramatic difference in size.
>
> Most of these objects are taking few hundreds bytes (or less),
> while a memcg can take few hundred kilobytes on a modern multi-CPU
> machine. Mostly due to per-cpu stats and events counters.
>

Beside memcg, all of its kmem caches, most empty, are stuck in memory
as well. For SLAB even the memory overhead of an empty kmem cache is
not negligible.

Shakeel
