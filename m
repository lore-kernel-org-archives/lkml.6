Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6974ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7296820857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="HT4KM/3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7296820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeGRSTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:19:19 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43414 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbeGRSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:19:19 -0400
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so3440472ual.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yZ8zbIt8GJyXFrLlH8mC1+FnxeShZPK5fz6lK90At2M=;
        b=HT4KM/3gHyYuv4ZZyT453K+PfCBaa29Hx3omU6yetjAybi0Fwf6Q0SMGNXQj0pecld
         tozuo3TwYnYW/lIndFodmaedbBPKRmEhA4NPgYWD9bbBK5l5RhLWBK/Tc03+il6owtjB
         nBW5xKgWRsTeIMUpDgJtYtM++AYImL3TURdB7KjWuzM1NQ6+kaL4DKZxfBwAegYjs2hI
         Vp92czw3c1KDJoQMTTRhGSnokZdrsEHhnEqZsmaI7EoRYNdsMq846dl+i54pVKJPOVxm
         k4xiA7pzcKIBW9ULUGa/bguAaYopDwYsOZ7KCy6N9eTM+Q3Pis7s6JyFU3H7tYZZ+ISK
         C0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yZ8zbIt8GJyXFrLlH8mC1+FnxeShZPK5fz6lK90At2M=;
        b=LOs4K9Vybar+zZjiOJOVZf5OIdeIDjF0vIuqSTk1cIWerR0pM+Jj/wL+V0Y3GdHADh
         w3Z10+9hUUe9xN435FVM0PVJHs8c19B+F1Bk4wPYiTeqeinVs7txwDD/8oDFxAQwC7b/
         Uw0/lBea7KyDRpmdWiL7w+k8/srsyXwS3LIOxV9Lvw53SPPYD+9Dtfnl7EB1QbZXrl9v
         9SF4uMHiGsqyAlGfspZEBUie3hs2yZsqGELiDaLZGmt/7qYm4dKgluoU25Fqfe+Ed9J2
         ZXfG80NNRyufc4tz/eN8cDLOkLqP4YN8iJ+c/ib764L6AlvfH1iW0wQC/K5k0Tq5oeGw
         GJqQ==
X-Gm-Message-State: AOUpUlHgGKUkMUibSZ5HpfqmZRZd//3rToWhuIeqQ1MoMQoYTKPY2stS
        VjAyic0+ldE6tq8YOrsSaOv8eurWUGT85iU7A6GCQg==
X-Google-Smtp-Source: AAOMgpeXsKfbvanCZND6JpzcNGqinPUkL8kL9J3t6v1x64XMB5GQzFEWyWQcytPKxtU/XMJ2YBdhyH4FxOTAVD1ZFgw=
X-Received: by 2002:a9f:33d8:: with SMTP id y24-v6mr4471630uab.164.1531935621052;
 Wed, 18 Jul 2018 10:40:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 10:40:20 -0700 (PDT)
In-Reply-To: <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com> <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 19:40:20 +0200
Message-ID: <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 17:49, Shakeel Butt <shakeelb@google.com> wrote:
> On Wed, Jul 18, 2018 at 8:37 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>> That sounds promising. Is there any way to tell how many zombies there
>> are, and is there any way to deliberately create zombies? If I can
>> produce zombies that might give me a reliable way to reproduce the
>> problem, which could then sensibly be tested against newer kernel
>> versions.
>>
>
> Yes, very easy to produce zombies, though I don't think kernel
> provides any way to tell how many zombies exist on the system.
>
> To create a zombie, first create a memcg node, enter that memcg,
> create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
> That memcg will be a zombie until you delete that tmpfs file.

Thanks, that makes sense. I'll see if I can reproduce the issue. Do
you expect the same thing to happen with normal (non-tmpfs) files that
are sitting in the page cache, and/or dentries?

Cheers
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
