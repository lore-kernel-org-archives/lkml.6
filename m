Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F64D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1Cc/BB7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfAKU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:59:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35309 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfAKU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:59:51 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so6361586ywk.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njp5vf4IquyG7FjzRfZTdEcdSKU/h4oc8yA5MyBHjJU=;
        b=1Cc/BB7ZTijZh8NgENDs+quiQLlsEB/RwXggD4otkGLiHnJNDrVCCl3zYsoaDzvVJE
         +kqROyhrKEReL7V4qE3RIHvcbnPgA6qWFBficRDtwx0fqbeqaiup3nZaeKzTjyXnV9+f
         zXo7Z8+ujHOnljGOxOAF//foOnPw0C55Qjts3m/7lSZlQY9KLyljSuWiooQ1yz9rkx6V
         kwMm8VfiThxj6ETEQ9t+DN5IbEjM6PN8mO1dUWmbP7u+yH5uUIs7hMPbljfI8faq/OjP
         3oXOXWLghhFr762GNmV/3a812f5OtS2SwHYLKOgJtMHSgBVae8e3Yt8kt2erYBCxfvKx
         +i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njp5vf4IquyG7FjzRfZTdEcdSKU/h4oc8yA5MyBHjJU=;
        b=rnT1jgOJURpBwvipzWrzyWuqQNEqhRgK5/Mf1UzZchSNuuSA7gpoyGpiZ3dsoz7Jwa
         g6mLxbBMhaB3k8AZQHGHR2CboJwKRAK7nSJWufieBuPbrNOuaA3I7KkXwlIa7LZEmiyR
         Hx4CP6WDMl68E2tnr4oTOVXfSHPwA+/LVFdCx3kRtrD++jlgA16F5646uv3MhY2eksCx
         Ar0bpfuT3XFzVqAC6QN9uTCNpzqLmM0kGWvkRwOpSZn8gOfVBSAQwLd7ezDF/J3XwyX/
         HxgcQXvexF6G7K1a68dZm/dfwtNRRmbQIQqIjaA1Q50+0WpfeC22luFclhVWPnWzOHyq
         QlbQ==
X-Gm-Message-State: AJcUukfNmqmljKrmh3/OAFGHa+BItTPFU5BQoiDVhQdL3Pa1S/Y8yCQc
        fKHUv1e3y3Y4nlbpT2fNQke29g==
X-Google-Smtp-Source: ALg8bN6abUCDDrKGdZqKgtmkDloJAbcXD81c5pcLSJuXd2rFLKL4VQgbMZSw+YquadutVDPlYhbeMQ==
X-Received: by 2002:a81:7c04:: with SMTP id x4mr15619354ywc.264.1547240389726;
        Fri, 11 Jan 2019 12:59:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:107e])
        by smtp.gmail.com with ESMTPSA id w2sm61210501ywl.10.2019.01.11.12.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:59:48 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:59:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memcg: schedule high reclaim for remote memcgs on
 high_work
Message-ID: <20190111205948.GA4591@cmpxchg.org>
References: <20190110174432.82064-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110174432.82064-1-shakeelb@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Thu, Jan 10, 2019 at 09:44:32AM -0800, Shakeel Butt wrote:
> If a memcg is over high limit, memory reclaim is scheduled to run on
> return-to-userland.  However it is assumed that the memcg is the current
> process's memcg.  With remote memcg charging for kmem or swapping in a
> page charged to remote memcg, current process can trigger reclaim on
> remote memcg.  So, schduling reclaim on return-to-userland for remote
> memcgs will ignore the high reclaim altogether. So, record the memcg
> needing high reclaim and trigger high reclaim for that memcg on
> return-to-userland.  However if the memcg is already recorded for high
> reclaim and the recorded memcg is not the descendant of the the memcg
> needing high reclaim, punt the high reclaim to the work queue.

The idea behind remote charging is that the thread allocating the
memory is not responsible for that memory, but a different cgroup
is. Why would the same thread then have to work off any high excess
this could produce in that unrelated group?

Say you have a inotify/dnotify listener that is restricted in its
memory use - now everybody sending notification events from outside
that listener's group would get throttled on a cgroup over which it
has no control. That sounds like a recipe for priority inversions.

It seems to me we should only do reclaim-on-return when current is in
the ill-behaved cgroup, and punt everything else - interrupts and
remote charges - to the workqueue.
