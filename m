Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C0C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C79B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="tIjSoPl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfARQfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:35:34 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39685 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfARQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:35:34 -0500
Received: by mail-yb1-f193.google.com with SMTP id s17so4573780ybp.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=goW1Z0jvHsdrb1efjgnzxYsLnKmpr74zaTtESzdE3TE=;
        b=tIjSoPl2crufU7iL8VGWE+B4GzYPKI0nj9xPJyPBwBD3uKkJgxSCf7N1JalfxM+MCk
         jCNr0/9IYpsKBKcA4neuOLYyfeeSVev1PmMDF84r3m+CCjrWKySXmbciaHcGw/GxYV17
         85wSekhP2/vApxYqtdicAWqvm1sjMXah7j2aEAL1o3tbW4ZJMW5ZTBjbXHGpjMfhI5tN
         xV6x0QEnwqoOI10bK1I/zLjkitKKE3DShOLxws8zyiDow4XDIV98e3ejM2hez+sWsnBO
         PcnjjZZm81DjPD3IMiRVcTa8SnMUSAkRye5BzIbMkqSbjoSftjRmHezAgSWOp0deLwHT
         G60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=goW1Z0jvHsdrb1efjgnzxYsLnKmpr74zaTtESzdE3TE=;
        b=gXqeaaA3ka9J6mhUAp+e22vtegKW6K48u1rmbSjknhJCznkREJhDxPyCRyBVFUEGCG
         cRyQXTT2aXC0WDq/jFk3zWz9EzJmq8bRLB8uWcgsrMZk4l5aeQ8rtUJ+92LxI4PWzCz1
         XuosLOqI1pQJy4tGf1i4mTu/A0CEhkVmwFBh+8bRfvRQoFnMzsOI1R/QOVvUMb43hCHi
         Mz4LicEVy0460DN4rHROMCwVh6XPravfxr2CEIF33F/qxHQjwrnSlkJYsSltrDgm4XWG
         tmDGJMsMYQLju5bKba+KBbALr323rLXK2YQDh9qSs08HUYodLnSKbxmGMQkbwu0Cxqte
         EX0w==
X-Gm-Message-State: AJcUuke3HVNNSKlbFPfldcbMcI1EUbKiZqiEYq7vWK6aWLmhDeNxKa1n
        0D1AbazHYZ5sgM4rgR3jnzZ4wA==
X-Google-Smtp-Source: ALg8bN4LqSMUqSIubxs+eeY8ann6PlQ91Xe1dord5OagoviT2y+A7CQqPvW3m6/ilKCtHivtYPrD8g==
X-Received: by 2002:a25:2046:: with SMTP id g67mr1648536ybg.259.1547829333177;
        Fri, 18 Jan 2019 08:35:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:e09e])
        by smtp.gmail.com with ESMTPSA id s185sm4611635yws.69.2019.01.18.08.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:35:32 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:35:31 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
References: <20190118103127.325-1-righi.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118103127.325-1-righi.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:31:24AM +0100, Andrea Righi wrote:
> This is a redesign of my old cgroup-io-throttle controller:
> https://lwn.net/Articles/330531/
> 
> I'm resuming this old patch to point out a problem that I think is still
> not solved completely.
> 
> = Problem =
> 
> The io.max controller works really well at limiting synchronous I/O
> (READs), but a lot of I/O requests are initiated outside the context of
> the process that is ultimately responsible for its creation (e.g.,
> WRITEs).
> 
> Throttling at the block layer in some cases is too late and we may end
> up slowing down processes that are not responsible for the I/O that
> is being processed at that level.

How so?  The writeback threads are per-cgroup and have the cgroup stuff set
properly.  So if you dirty a bunch of pages, they are associated with your
cgroup, and then writeback happens and it's done in the writeback thread
associated with your cgroup and then that is throttled.  Then you are throttled
at balance_dirty_pages() because the writeout is taking longer.

I introduced the blk_cgroup_congested() stuff for paths that it's not easy to
clearly tie IO to the thing generating the IO, such as readahead and such.  If
you are running into this case that may be something worth using.  Course it
only works for io.latency now but there's no reason you can't add support to it
for io.max or whatever.

> 
> = Proposed solution =
> 
> The main idea of this controller is to split I/O measurement and I/O
> throttling: I/O is measured at the block layer for READS, at page cache
> (dirty pages) for WRITEs, and processes are limited while they're
> generating I/O at the VFS level, based on the measured I/O.
> 

This is what blk_cgroup_congested() is meant to accomplish, I would suggest
looking into that route and simply changing the existing io controller you are
using to take advantage of that so it will actually throttle things.  Then just
sprinkle it around the areas where we indirectly generate IO.  Thanks,

Josef
