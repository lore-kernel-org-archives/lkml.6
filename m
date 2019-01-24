Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEF52184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548343290;
	bh=eJRXXx9o8+CvHKSHeEZDWr9+6bvGjrOXBXYSUTFTo9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S821VhV4Z0dK9qwJJwefd6XmZSWcbVDjHqfhnxNJKoooTi9WlwmKgwoG7IVQT+pn1
	 ltPhlZJnqYkNmBTsdbRSZwGqg0iu0WuNHc0Nr6+WMVO5yWeWTHZAF2pA9lb5HlqvDO
	 8V4gJflBpvMWDh3BBA7tNcrMBsvluT4PCa72qoA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAXPV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:21:28 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38138 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfAXPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:21:27 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so2548269ywb.5;
        Thu, 24 Jan 2019 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHh6o8jn5g3tJ8EvMOq/zvMTuQRF5UWPWeqXachkSho=;
        b=ilOnDM8ll9pxsLgqR2XzLXRMetdJw86ka4AcMniC8p52iV6zbSbAPjjzUt9S1pFVxM
         RG54FaX6Fu0FURglgfSe5vsP+2EBeMksbHpMOYUz732zHg25PXAt/PsWsn5Tp37LZwSP
         GygS4W7IdvL0uwu19h43JDoQmrPdVwzxItlVmxORX6uR/t0soxTfgsHUDmBQbBpvQUjx
         fMZK77CA13TcCnwvKQ3vu5urs9np9Z1aavhPYgLNzJ/u5pcU40iw4/AxKqOTCinIBc5v
         z2q9JOfcI0TqKCNE2/BQCkV0eS5bEULEWI7DV0JMYu8oUwbg9e2xI9pT6ZO5LjgabUvI
         aoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHh6o8jn5g3tJ8EvMOq/zvMTuQRF5UWPWeqXachkSho=;
        b=UuEBn5xV8MbB+ic1AXOyVSGu5fR3mWATkm+sIughfMMYmhfnqxfvIKdiL52rvyZSXL
         Q2VfltceIVZ41GYKl5i2x5TMDd+eldrWbcoexZKTzu4epvpfMbvzACICNIHDeM5FR9ki
         N9BSIRD2oIlQpGk0nvoYX7XJAeyobzhbjRbPj5PCAEfgpL70yPt1oORCVBIFVBNGzukS
         F7C7EKHgca3yb3vmGsuUW9+uZA4znzDT+lMRtYhNmxf3cOGRjLwKh4AsWXdQKU0EBYxW
         o/qDpmAUoa9S0Zq8nmrvbAa6VhIny7sjLKpWpRI7INAQxHJkNeNB47nk7aHiAGQBln5l
         6TQg==
X-Gm-Message-State: AJcUukeaIYMIM/2LSJw6zJ15fpok9+VVHwX5KI2y+AGhCi4nDWuWOC4T
        HJCWo//imbExMRn7qgsOEYQ=
X-Google-Smtp-Source: ALg8bN7oWNmiav+tCxdtrfFty9go6IzYRtO2ksJTnotVbBaOXT8AH6BJcY/bqOcs1aZTwcfGx30eyQ==
X-Received: by 2002:a81:2994:: with SMTP id p142mr6897844ywp.453.1548343286441;
        Thu, 24 Jan 2019 07:21:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:a8a7])
        by smtp.gmail.com with ESMTPSA id k62sm9235932ywk.84.2019.01.24.07.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 07:21:24 -0800 (PST)
Date:   Thu, 24 Jan 2019 07:21:22 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124152122.GG50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124082252.GD4087@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Thu, Jan 24, 2019 at 09:22:52AM +0100, Michal Hocko wrote:
> I do not think we can do that for two reasons. It breaks the existing
> semantic userspace might depend on and more importantly this is not a
> correct behavior IMO.

This is a valid concern but I'll come back to this later.

> You have to realize that stats are hierarchical because that is how we
> account. Events represent a way to inform that something has happened at
> the specific level of the tree though. If you do not setup low/high/max

This isn't true.  e.g. cgroup.events's populated event is
hierarchical.  Everything in cgroup should be hierarchical by default.

> limit then you simply cannot expect to be informed those get hit because
> they cannot by definition. Or put it other way, if you are waiting for
> those events you really want to know the (sub)tree they happened and if
> you propagate the event up the hierarchy you have hard time to tell that
> (you would basically have to exclude all but the lowest one and that is
> an awkward semantic at best.

I don't think it's a good idea to argue this for each piece of
information.  Again, everything should be hierarchical unless there
are clear and strong reasons against; otherwise, we end up with random
mix of hierarchical and flat behaviors, something that we want to
avoid the most - remember .use_hierarchy?.

> Maybe we want to document this better but I do not see we are going to
> change the behavior.

I beg you to reconsider.  This was a clear oversight and the cgroup2
usage is still relatively limited.  We sure can add local-specific
counters if needed but must not mix local and hierarchical counters
without a clear way to tell what's what.

Thanks.

-- 
tejun
