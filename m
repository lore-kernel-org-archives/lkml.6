Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C391C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7BE21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fR9XwG2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfBKTBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46585 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbfBKTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:18 -0500
Received: by mail-yw1-f68.google.com with SMTP id n12so4597265ywn.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s09oajM8sRG6VR42JLX9NXyJV4gfvXuCrn6cD3FbZqw=;
        b=fR9XwG2IpAJnHWw0MPBfz0HAX7xH++BkHbFzdYsjyY2FzzSQFnOya2QKZoELQ/IC5O
         8Dk/hBPxZ0V9ikPopvPDe6YxClqHJSPNu1lZ87Q2cVLMHwm3C8kKQ6WVmLFZXPEsz3HR
         nk0JyG9P2MV9qyR1u2B3Xw3gJO/S9XhKwPznBWi+552PjkO8ma2qfoEUpctr7+xltiHq
         U0S6AsRR2MhGChi8V+igCAz55oV0a1ftWgNSfONzCoxSz9AXXndTZ37wJ/dMBqvXEFXY
         +XOiZ81yTVgf8Ej4uzhR7/jhIkE2VBZSgSaFyAlZwRqoU0RCaJewWGnOx0Db/jxAlBs3
         WMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s09oajM8sRG6VR42JLX9NXyJV4gfvXuCrn6cD3FbZqw=;
        b=TQuhH0BaxvHBjRihirdSSdXqn7AULVVWH1sr8U0A9WP2jR7O0A/BcuCQJsVoID7ZKe
         o0XCK76pT+sVfc38dgOmchh9Ko7NO7ZlgcnlYOAegjtAiTXLf7XV9Y7SoHKcmj+Gum8W
         FcRt6eqOxEv2OMGzgHzO4fc35HDGP/x4ATVeTojJsOZwe8tY+zE+wRwi9nSzJlUrZ6Mi
         6e9kByySD5/pmeWrJtV/h+VezIg8q2WYEpwMYcd9odO5BzTlgpFGLjA0iMyaLbI21BKe
         UhtOHKXNtTgF9xI87nRpqqGs0EovXPqBh38PRMkxRY0WL9buc/JwLry7pcjhJdZCoa8H
         COQg==
X-Gm-Message-State: AHQUAubucF0a/M65yKjn06Q5rSmntg9R5ucwiPj7Kp2GjHD9y0KAiM3C
        88cR3wMXl3RKciat/G9V/E3oVA==
X-Google-Smtp-Source: AHgI3IZLVsFOrLYBm0wpfHBVnBwYPYDxF1jVhbzc5rUhM1jl1nqzmd8gWWaX9ycIHhhicOSxmCRd/w==
X-Received: by 2002:a81:a9ca:: with SMTP id g193mr30060659ywh.52.1549911677658;
        Mon, 11 Feb 2019 11:01:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6e5])
        by smtp.gmail.com with ESMTPSA id h62sm4103600ywe.100.2019.02.11.11.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 11:01:16 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:01:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190211190115.GC13953@cmpxchg.org>
References: <20190208224319.GA23801@chrisdown.name>
 <20190208224419.GA24772@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208224419.GA24772@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:44:19PM +0000, Chris Down wrote:
> memory.stat and other files already consider subtrees in their output,
> and we should too in order to not present an inconsistent interface.
> 
> The current situation is fairly confusing, because people interacting
> with cgroups expect hierarchical behaviour in the vein of memory.stat,
> cgroup.events, and other files. For example, this causes confusion when
> debugging reclaim events under low, as currently these always read "0"
> at non-leaf memcg nodes, which frequently causes people to misdiagnose
> breach behaviour. The same confusion applies to other counters in this
> file when debugging issues.
> 
> Aggregation is done at write time instead of at read-time since these
> counters aren't hot (unlike memory.stat which is per-page, so it does it
> at read time), and it makes sense to bundle this with the file
> notifications.
> 
> After this patch, events are propagated up the hierarchy:
> 
>     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
>     low 0
>     high 0
>     max 0
>     oom 0
>     oom_kill 0
>     [root@ktst ~]# systemd-run -p MemoryMax=1 true
>     Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
>     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
>     low 0
>     high 0
>     max 7
>     oom 1
>     oom_kill 1
> 
> As this is a change in behaviour, this can be reverted to the old
> behaviour by mounting with the `memory_localevents` flag set. However,
> we use the new behaviour by default as there's a lack of evidence that
> there are any current users of memory.events that would find this change
> undesirable.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
