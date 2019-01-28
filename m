Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA6AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE842148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690118;
	bh=F01t7fcJPB4qykaxamN6DdqxQkejZ7D4tfVXygJb7+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GvpOdvaKhMF+oIdo4riqdBat9gZz3dw65S9wICDVG6Sfj47T7e7ftzBJPU520WbF4
	 /CgJUvySODaefEnj1rkGwvaXgYmUBo3uEbXd9Xni9bBmwz719+tWDiDj1hzq2d7+4P
	 EuPqHN09/q4DBf3I2pMvexjaEDV8ptkDyF9/dXQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA1Plz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:41:55 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37787 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1Plz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:41:55 -0500
Received: by mail-yb1-f196.google.com with SMTP id 2so6834231ybw.4;
        Mon, 28 Jan 2019 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPBPoBOwIobapi6oC16zq6H6TFfwJ/3I28jXaGw7G7E=;
        b=u2H/PyOQXKHj3iK3PpnDcwvm6ncSmV+EqOAB3hUtcVKQdikPGsRkySFxZP/Ndmf/7r
         ubxpAytZAOZ4sbfd2Zwo4w1DwKJufOrluB98Eq03/6O8+a3SBvf4kJw4LbPD7oift2uK
         4eWzC4te3BWZvtS33vhNSitykED9QWq/zHWOkrC4aO+NJGY9RwfpHcA87AWSQkP8uxOx
         qLwB7xRdKYlmYE0kpTooNI0oi+jmc2KuWbVo/rUBHLnjWEDqUHcKfb/AYm6Yh5JkhJst
         90t9UPeKLs6HXbN4iJY0JPQB8PlJVJyBS0CpqXqslaBbAB9veaL8WCt3uBIbVBMviRgA
         TeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPBPoBOwIobapi6oC16zq6H6TFfwJ/3I28jXaGw7G7E=;
        b=jJdmWJbnkQpJnmJgrrOxCrZ7fWIMiN+KzwCzsjupsXgTVfBTeIm1+7mI1mKhT22k4A
         0FjRoPayiBI21P1FPhfON+JXnZwQxFdJPBYX8m9aq02IlvFBa2BIaMZjZdoL9bJtxp0T
         2mbNCgd8s5Xr2M/MYD0gc5xuub0ADi6b877gv+kD2pQ2pj/wGFEqKSrUp2icxSGlSist
         Xo29t/sNjsYr23kb3DHHS/mCxicTmCd0SjlkPFHZ8NJ8vPQzBjicTk1+LV16H/FnuRAl
         v5vnwF/m6v8gKTmRSfyeDvzgd7Ghf+X84ynBak/KsFojDnhqdpmPvFqH2R3xPB9Q1XTH
         nNXQ==
X-Gm-Message-State: AJcUukcWYeks+KDwZV7tid0L+1UDsKPuf2A2Pg58ZR3j0zbGXKOl8cSg
        BZZenQQO8chF4lh0DYW73BQ=
X-Google-Smtp-Source: ALg8bN73/dYluNC7oZ9IyVILwCWZwMJCg7bUJ+97bgGx7vm4QNtUbIq442PhfueU+X819UDoIu3DIw==
X-Received: by 2002:a25:e90f:: with SMTP id n15mr21500266ybd.39.1548690113671;
        Mon, 28 Jan 2019 07:41:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id f188sm12623878ywc.70.2019.01.28.07.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 07:41:52 -0800 (PST)
Date:   Mon, 28 Jan 2019 07:41:50 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
References: <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128151859.GO18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jan 28, 2019 at 04:18:59PM +0100, Michal Hocko wrote:
> How do you make an atomic snapshot of the hierarchy state? Or you do
> not need it because event counters are monotonic and you are willing to
> sacrifice some lost or misinterpreted events? For example, you receive
> an oom event while the two children increase the oom event counter. How
> do you tell which one was the source of the event and which one is still
> pending? Or is the ordering unimportant in general?

Hmm... This is straightforward stateful notification.  Imagine the
following hierarchy.  The numbers are the notification counters.

     A:0
   /   \
  B:0  C:0

Let's say B generates an event, soon followed by C.  If A's counter is
read after both B and C's events, nothing is missed.

Let's say it ends up generating two notifications and we end up
walking down inbetween B and C's events.  It would look like the
following.

     A:1
   /   \
  B:1  C:0

We first see A's 0 -> 1 and then start scanning the subtrees to find
out the origin.  We will notice B but let's say we visit C before C's
event gets registered (otherwise, nothing is missed).

But, no matter where you put C's event and notification, the
followings hold.

1. A's count will be different from what was seen before.
2. There will be another notification queued on A.

IOW, it's guaranteed that we'll notice and re-scan if we don't see C's
event this time.  The worst that can happen is scanning spuriously but
that's true even for local events.

This isn't a novel thing.  It's how aggregated stateful notifications
usually work (e.g. a lot of hardware interrupts behave this way).  The
notification is just saying "something might have changed here, please
take a look" and the interlocking is achieved by following specific
orders when propagating and reading the events.

> I can imagine you can live with this model, but having a hierarchical
> reporting without a source of the event just sounds too clumsy from my
> POV. But I guess this is getting tangent to the original patch.

It seems like your opinion is mostly based on misunderstanding.  Let's
keep the discussion focused on API stability.

Thanks.

-- 
tejun
