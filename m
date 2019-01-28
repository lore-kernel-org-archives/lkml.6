Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50F121741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695329;
	bh=sEw2aCXD7t1mNsb5XieikbBeUWnmlRXI6VoEdesH6/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qApOynMwFBmERueGQ3keNFrTsPTGlBmAJRQXnejyFWiUxQU37Uv0rFlWCS5gQ4kOz
	 2iqtXbNg9lp1bnzY5Lay6Z789wdnbacjjWwkKBKcJeGnA7rF91IgjWhxRdGmZU8LRf
	 i/ajIRAFn+lDyTcW2nezsamY7br9BGFNrwXpvJbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfA1RIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:08:48 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43723 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733066AbfA1QMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:05 -0500
Received: by mail-yb1-f196.google.com with SMTP id e12so6878812ybn.10;
        Mon, 28 Jan 2019 08:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7sNEoit16a1lvfySq1HM53gTpeolqrKjGi3YRhbkM6Q=;
        b=N90p1wmW4Un144OHxTHB5bvyZ5q/P+Lb2PmLPmP3xl0nWZc/2QzaTCdkYnYkEDkSjR
         /wVrIvuYPhgsil8RMSYQPfptenZOa4gH322FL6/QQm6MLnhHPKwMvD2oK3LRE0gz4ghx
         LzhQs5Bf74L2OMermppFrL9suvGVTfnVbTtFo9/wY0lCqd7Bi5G7dGkWnDKKawjjd2eg
         c+CFgIeHtz1/fiEOj0dVxBv90ZoFn+XJQu1/1cj2xnAFrhS/SDeO7diQv9pERyfezrfG
         EvA7wPnpUWP7uOjYWjx898TLBGwk7gz/ttcXi/m5IQpgc4yKFv+zulskjicwe8WIA7Na
         ZTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7sNEoit16a1lvfySq1HM53gTpeolqrKjGi3YRhbkM6Q=;
        b=EeknGoUQE9I4jAfALbFvKZT9khb6GiE8iqnyLEVK8dRZ6mhZhr20hiRlVETgSWujiQ
         85rhz2mhAdnioijjXT1SeUMXwLqcp9ANEjbpYuhfGKKPFp9cXR2RtSzWw/YBZa9h2drQ
         2RymEgxAjcHW0pbIi/zBBhE6opUCJVH2Q+CTiUu85qSbmjdAh9r+6PnUIKPkfBaRVA47
         nPly8HWRczko8DGt41odsUr++/E2+F4W3QM2//43rWXw4czR92WFgSq30e4ZualgKER+
         7bzlIyL/8UFFG9ns6KepBSgSSuY1exiwkujURYRjNCDJS7obAPi51Mq60KogZ+qyOglY
         CqOw==
X-Gm-Message-State: AJcUukc/Rc0n9i7oMaelL0j0QvJXYw86KIlHJwniSLx4Xkm5AVwp9+PG
        mNED2qQzTqLlD7KuhW7iY0k=
X-Google-Smtp-Source: ALg8bN6dvRl+QxHCM6Kj5WM6BZyjvyc+4dFpQje6jXxC06hFR/M08ci81YWpJG2aqEcvxS6nTvkWSg==
X-Received: by 2002:a25:d8c2:: with SMTP id p185mr16000278ybg.79.1548691924215;
        Mon, 28 Jan 2019 08:12:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id l7sm12308964ywk.24.2019.01.28.08.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:12:03 -0800 (PST)
Date:   Mon, 28 Jan 2019 08:12:01 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128161201.GS50184@devbig004.ftw2.facebook.com>
References: <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <CALvZod6LFY+FYfBcAX0kLxV5KKB1-TX2cU5EDyyyjvHOtuWWbA@mail.gmail.com>
 <20190128160512.GR50184@devbig004.ftw2.facebook.com>
 <CALvZod5Rrr6ENW5yLNzniFeFmGB=mDRH+guNLmcayTX-_xDAGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Rrr6ENW5yLNzniFeFmGB=mDRH+guNLmcayTX-_xDAGw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 28, 2019 at 08:08:26AM -0800, Shakeel Butt wrote:
> Do you envision a separate interface/file for recursive and local
> counters? That would make notifications simpler but that is an
> additional interface.

I need to think more about it but my first throught is that a separate
file would make more sense given that separating notifications could
be useful.

Thanks.

-- 
tejun
