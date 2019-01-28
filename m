Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4686EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1627720881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697754;
	bh=6ydOhUsDpV1LdG++aP5SfzE4SgNMmGiNosPiiUPvAo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DjzQfT0HvhBC7m5mMdO+55wDNqobYUkJG8e2MQTUoxq/iJrdemFhWLWs7gCUToMHE
	 w8hwjLTs+pp1y/D8+Q4tuZBs7hUx6ahGNjsBkVs+QrzHzuI5dXDUxQ1pZzRIVZLGcI
	 vEBwHv+fdq3wDPK18STUHMFNobSDZ7UmEUQdRa6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfA1RtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:49:11 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45718 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfA1RtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:49:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so7052525ywd.12;
        Mon, 28 Jan 2019 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RDoi/eLjxnbObU8/lFllv41Z8VtANrIPfKdXbpygwCE=;
        b=lVQH1nAeTUapo+A78necDxJ89EsWzDvsbvfeD3DQE7e36L5IebWuxztHjBVoiEnB3H
         JeYQjUy2zp7nWDkKEDHWbhMsmEV1MFDjEeVeJ8VygkmA3LoR71R+X5dLBG4+lqqUOaWi
         02xvs+8jBWBa+6eYq8LBoIGsolX6zO1GdwGD3IFAMWM8PbB4KrSsY+KxY9yeJ7jCBhY1
         0UCJptuXx2QuyCQjU/AzkD5lNtgIKEWL2Qosqrg5N6HL8+iL2cLg8oWv6QbP1rznpvTm
         cFlCvSg7b/VQb0x4QHr+rmpIWzqsN5L/045u6n82TWmN4rcvRTAXhNjm1X1Hcwgj+I2M
         YJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDoi/eLjxnbObU8/lFllv41Z8VtANrIPfKdXbpygwCE=;
        b=n7kqH0rdb55gBN9ZzxWeMbGjcq9Mn1MvPOtBZIqJNWMZ96IAfLemzAjFT9Y813aC4B
         yV783bzl+z/uyuKQ0g+iXb+GtetqdqxLRa0zlYq1+Qzm2fhaoeCj8Y/Z6SWM/rqxaF9w
         luKkAdTK3mdcl+4T+kaGgIQxyYe6WQSJDKf2qCCvRYxSXfVpvOEWXimd8iOb0BXVYw5f
         4Vn0207B1BoTn2PP7VLr5FLkEovBTf95mwezYRxooj63U1EAqK7e7Voj8ZEbalBiun5R
         LeDMgvzPUl6zVzBIyYdQgbsIAaSTubEPVHWYdGhSGoLHOKL0+qmd85I8TJ+kDHMkFicr
         +v/g==
X-Gm-Message-State: AJcUukdmRng0+AXTxSdE1A6rNd4aNAv779/yg2Y4HHcbT5qtGQZ4UFT2
        bV4mo2HRCA4m7sabolLs3M0=
X-Google-Smtp-Source: ALg8bN4UwYkLurYiTtunS7LxeB7dpx1z6ERbMLfdg4VnL53YCm4TRhvjnIQJ3e8G5n+bKLi2/RRHFA==
X-Received: by 2002:a81:4f97:: with SMTP id d145mr21795942ywb.198.1548697748275;
        Mon, 28 Jan 2019 09:49:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:31a1])
        by smtp.gmail.com with ESMTPSA id n16sm15879617ywn.31.2019.01.28.09.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 09:49:07 -0800 (PST)
Date:   Mon, 28 Jan 2019 09:49:05 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128174905.GU50184@devbig004.ftw2.facebook.com>
References: <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128170526.GQ18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jan 28, 2019 at 06:05:26PM +0100, Michal Hocko wrote:
> Yeah, that is quite clear. But it also assumes that the hierarchy is
> pretty stable but cgroups might go away at any time. I am not saying
> that the aggregated events are not useful I am just saying that it is
> quite non-trivial to use and catch all potential corner cases. Maybe I

It really isn't complicated and doesn't require stable subtree.

> am overcomplicating it but one thing is quite clear to me. The existing
> semantic is really useful to watch for the reclaim behavior at the
> current level of the tree. You really do not have to care what is
> happening in the subtree when it is clear that the workload itself
> is underprovisioned etc. Considering that such a semantic already
> existis, somebody might depend on it and we likely want also aggregated
> semantic then I really do not see why to risk regressions rather than
> add a new memory.hierarchy_events and have both.

The problem then is that most other things are hierarchical including
some fields in .events files, so if we try to add local stats and
events, there's no good way to add them.

Thanks.

-- 
tejun
