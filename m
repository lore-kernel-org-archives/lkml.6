Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24906C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8A2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="QWvsOqRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfA1VmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:42:17 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47079 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1VmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:42:17 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so7350159ywe.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9PsKmGgPsTKkLBb3g/jY5/HxZPgchB4hPGH18bC0Lo=;
        b=QWvsOqRqyIcKZR7jItEvBi0genFdYcFV76xiW7vN4DO4Eba+BvzpUc474b40EBe4es
         h4O385MUeLovYQGLyM9wvEI2R3H0Lshq64jenrQ1csimCipZwR+Ux6IUPGUTgHM8Jw5f
         0a2oM0SqHJFVbknYw26SZ8N4D2DVfzvcaDunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9PsKmGgPsTKkLBb3g/jY5/HxZPgchB4hPGH18bC0Lo=;
        b=UAl47eRlxt2UhCDO8HBWZgyTurpRIIIBxtp11HFw3SkeyfQSxm7fQIjg7XCgoI5swK
         IhTgR17xRJGWLKgrhU0Tcscnc1iSjF6Q5QgyqVU0b3jcWKI6M98vG0TM2tmX+M40mNUE
         kGHVZ1BLhBnnRbV7hZbVfe2rzlz4vpOPDpitJZ9OzTaZ01xLWi8Mkoww1GhkZvO2jhh5
         Cf0RdP5fJM+TIzGQ+v+CqM8OzrGas9k5xXJ2zETJAEqi9wjAylRbvpp+C6Wf69AX4ahx
         1tvAzsRa++adH8uxLACL/o89uSwTDZyW/PAiHBI/nWzc9ZyKT8AShCDstn1kXkqw5Ltp
         5MXA==
X-Gm-Message-State: AJcUukc3biZ7amHSn2xydvJMKaRJ3UqQ0ZO2ealcvMROsb4jdoScGOOU
        LwNauE0a3wBeK0kZlKBv4IZ+/+Z6Yde9TQ==
X-Google-Smtp-Source: ALg8bN7ixIYyq/jqwUusdxnjFTjdORjTiX7RCaORCK6XnS2wV8OmW/M/daK2UKZbt4qlEjcxYyGVhw==
X-Received: by 2002:a81:87c3:: with SMTP id x186mr22526821ywf.147.1548711735622;
        Mon, 28 Jan 2019 13:42:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:aa7d])
        by smtp.gmail.com with ESMTPSA id f10sm19386715ywb.26.2019.01.28.13.42.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 28 Jan 2019 13:42:14 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:42:13 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-ID: <20190128214213.GB15349@chrisdown.name>
References: <20190124014455.GA6396@chrisdown.name>
 <20190128210031.GA31446@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128210031.GA31446@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>Hm, it looks a bit suspicious to me.
>
>Let's say memory.low = 3G, memory.min = 1G and memory.current = 2G.
>cgroup_size / protection == 1, so scan doesn't depend on memory.min at all.
>
>So, we need to look directly at memory.emin in memcg_low_reclaim case, and
>ignore memory.(e)low.

Hmm, this isn't really a common situation that I'd thought about, but it seems 
reasonable to make the boundaries when in low reclaim to be between min and 
low, rather than 0 and low. I'll add another patch with that. Thanks

>> +			scan = clamp(scan, SWAP_CLUSTER_MAX, lruvec_size);
>
>Idk, how much sense does it have to make it larger than SWAP_CLUSTER_MAX,
>given that it will become 0 on default (and almost any other) priority.

In my testing, setting the scan target to 0 and thus reducing scope for reclaim 
can result in increasing the scan priority more than is desirable, and since we 
base some vm heuristics based on that, that seemed concerning.

I'd rather start being a bit more cautious, erring on the side of scanning at 
least some pages from this memcg when priority gets elevated.

Thanks for the review!
