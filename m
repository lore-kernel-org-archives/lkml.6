Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7823C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A4E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FJxtzyGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfBAQMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:12:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37464 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfBAQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:12:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so8098211qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quiXn0eW8gENJQ2gJS+neNMOBIo/LLkWdIc48RQXTDM=;
        b=FJxtzyGWgskESR2k9L9isn828AO09+N+HuP3nAaDzFlbGiyI3IkRb+dI95b+qwHsFp
         taGu2/RGTS5RRJ9/Z5NiCbZDursEgcB8TqiiadpPycaR3JpyIY/J9RMNC4UvQwNXYEO6
         fCCT/0zdkELpkSqG/BBHYrSARXYUo/vOIfTH36h9Q2RSZ8lpWN7hgHmn0S0j57ey5ZCU
         IfzwwodbNPzWByHoHSoMWYAg2iOdSzGq83AW/VX9T99e5J6YTDt6Y1qyPudl/hw+d9N3
         aqkMde8RGGcBdEvy/8yMKeq3OfF0pJoavBeMkjiczMWFwZZ9wm9xKrgSQHxuAie9R+5k
         3LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quiXn0eW8gENJQ2gJS+neNMOBIo/LLkWdIc48RQXTDM=;
        b=qkcoLRkN1/Ih+W+maLTVx7dGjDXeV1mpW7eStPW/ZfvIO1xAvLgDueOxxpaEQQssNZ
         R8tYg8laNpOKNI42FAPgZE98Z36dtSnUv5eiJxbaGXII76j0WcUHl2tkM85YVfHuRcID
         Rp1xZMxz6lTd4GHSMue8ad9cgpq8SfmfstRhJTd5hzgslEq1V8jBvp/gK0CLY+oegK2D
         ngiCEnENzsMoENsSYCYCbCUr96gzQfGjLYMETMAHSgMt02oz7orGnzb7jxg7jFFzX0cU
         cTIV5aBsKhEIk7ktirFNkQ9cJmGzRjcSHMfFtx2jviJizGGEj6kJaFcna7jA5Gn4irIb
         HvlQ==
X-Gm-Message-State: AJcUukcTtnTne0s4WgofwssFWo64mF1uWnokYJPuvrI+Xu1E4faczEAx
        HNSmjIt8haJQlYYkuaNAMvsdEw==
X-Google-Smtp-Source: ALg8bN6Xhm8+Dphexj9jdruWmgqh9zBeGrQhRUyClmtGuM2tr8dcjMyszXKsoOq+aWfpv3IWb5Y1gw==
X-Received: by 2002:ac8:2ca9:: with SMTP id 38mr40275308qtw.338.1549037555283;
        Fri, 01 Feb 2019 08:12:35 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id s9sm9706606qta.35.2019.02.01.08.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 08:12:34 -0800 (PST)
Date:   Fri, 1 Feb 2019 11:12:33 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Throttle allocators when failing reclaim over
 memory.high
Message-ID: <20190201161233.GA11231@cmpxchg.org>
References: <20190201011352.GA14370@chrisdown.name>
 <20190201071757.GE11599@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201071757.GE11599@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 08:17:57AM +0100, Michal Hocko wrote:
> On Thu 31-01-19 20:13:52, Chris Down wrote:
> [...]
> > The current situation goes against both the expectations of users of
> > memory.high, and our intentions as cgroup v2 developers. In
> > cgroup-v2.txt, we claim that we will throttle and only under "extreme
> > conditions" will memory.high protection be breached. Likewise, cgroup v2
> > users generally also expect that memory.high should throttle workloads
> > as they exceed their high threshold. However, as seen above, this isn't
> > always how it works in practice -- even on banal setups like those with
> > no swap, or where swap has become exhausted, we can end up with
> > memory.high being breached and us having no weapons left in our arsenal
> > to combat runaway growth with, since reclaim is futile.
> > 
> > It's also hard for system monitoring software or users to tell how bad
> > the situation is, as "high" events for the memcg may in some cases be
> > benign, and in others be catastrophic. The current status quo is that we
> > fail containment in a way that doesn't provide any advance warning that
> > things are about to go horribly wrong (for example, we are about to
> > invoke the kernel OOM killer).
> > 
> > This patch introduces explicit throttling when reclaim is failing to
> > keep memcg size contained at the memory.high setting. It does so by
> > applying an exponential delay curve derived from the memcg's overage
> > compared to memory.high.  In the normal case where the memcg is either
> > below or only marginally over its memory.high setting, no throttling
> > will be performed.
> 
> How does this play wit the actual OOM when the user expects oom to
> resolve the situation because the reclaim is futile and there is nothing
> reclaimable except for killing a process?

Hm, can you elaborate on your question a bit?

The idea behind memory.high is to throttle allocations long enough for
the admin or a management daemon to intervene, but not to trigger the
kernel oom killer. It was designed as a replacement for the cgroup1
oom_control, but without the deadlock potential, ptrace problems etc.

What we specifically do is to set memory.high and have a daemon (oomd)
watch memory.pressure, io.pressure etc. in the group. If pressure
exceeds a certain threshold, the daemon kills something.

As you know, the kernel OOM killer does not kick in reliably when
e.g. page cache is thrashing heavily, since from a kernel POV it's
still successfully allocating and reclaiming - meanwhile the workload
is spending most its time in page faults. And when the kernel OOM
killer does kick in, its selection policy is not very workload-aware.

This daemon on the other hand can be configured to 1) kick in reliably
when the workload-specific tolerances for slowdowns and latencies are
violated (which tends to be way earlier than the kernel oom killer
usually kicks in) and 2) know about the workload and all its
components to make an informed kill decision.

Right now, that throttling mechanism works okay with swap enabled, but
we cannot enable swap everywhere, or sometimes run out of swap, and
then it breaks down and we run into system OOMs.

This patch makes sure memory.high *always* implements the throttling
semantics described in cgroup-v2.txt, not just most of the time.
