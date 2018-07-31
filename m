Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C18C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669B20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="VZEqmYK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A669B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeGaRcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:32:50 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36827 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbeGaRcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:32:50 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so6323588ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MuLIAqn0YL1Rk9FZ4wf0xPDSx25V5RBg1CqOBf/Of4=;
        b=VZEqmYK8gKRoSDJzUZ/4zUIzodO7XRHfOaEFQY/O98bgxgnmMe1mcgdoMPE+1e0PKP
         e7MC/kA1Fem9UWVMf4hxg9Ki0kcaDOKGgobM2tEIdquxCmKEwMgnUNMLELLiQ6jvhQHc
         g7m18cwA25MGstSB85+ZAyV4aJXX5QiN2LJoOP0+NUXsiItICmGwDzGr9CIXtcqOQf59
         GqUx6P7UtBeUPaoalohMbmlq/VFMQTYIeCO+6JkXflfWz4cZxyKmmjoIA4LqXe786SNB
         G2Htlmi1REzDH24EMm6Q6CNJ6rj+TLFEoWcQ9aYy6HYz3Vy4gn6FCv+yXH+zNpul14IJ
         PT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MuLIAqn0YL1Rk9FZ4wf0xPDSx25V5RBg1CqOBf/Of4=;
        b=A1UcCumY1XLf7urRn7XeesT91Vxo6WaT81pSS9oH41CNXGwp2lql7vGKzhNBx9OET2
         si5Iw0109neHTCjt3HpLiYo+S11BupHKkISoFqK3bPbbnnq6RSAGeA3paVJ+epjmUGwB
         TdzrKfclclZAyKVuTuTDr0DkSv6zdotkb+LNKCgV46KpuXGlQzFpRU+0lhEPHFCEgDjd
         4dK1fnHfQ7i6o5ly+8rVqje1gHrkAjSyDWQpxoD035BgYW4r5XCvrlYEHXBU6OOkIdhy
         hx7F1//M0RGkBELcjQFIgEfe4YvPVvXhQuvq5GLO9aHiinxY0zX4+XtsvdzmUvrwDd7B
         06CQ==
X-Gm-Message-State: AOUpUlESeL1EAr+n2nitbtTVmY6OPy4vhOFTm04cNIASzhkJytv+vzYk
        ouA5K2XXv9p2mqeCZGABYvcrjw==
X-Google-Smtp-Source: AAOMgpcWGM2VFCP8LtxJm6k8Mtu2ifsSe3B/UmuzmR9PHqI2p1ZvXOTYvaL1jG/yHFRVWOn1TT6Rdw==
X-Received: by 2002:a5b:786:: with SMTP id b6-v6mr12328539ybq.160.1533052313092;
        Tue, 31 Jul 2018 08:51:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:f2df])
        by smtp.gmail.com with ESMTPSA id i67-v6sm15123229ywc.27.2018.07.31.08.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:51:51 -0700 (PDT)
Date:   Tue, 31 Jul 2018 11:54:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180731155447.GA28424@cmpxchg.org>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:49:31PM -0700, David Rientjes wrote:
> On Mon, 30 Jul 2018, Roman Gushchin wrote:
> 
> > This is a tiny implementation of cgroup-aware OOM killer,
> > which adds an ability to kill a cgroup as a single unit
> > and so guarantee the integrity of the workload.
> > 
> > Although it has only a limited functionality in comparison
> > to what now resides in the mm tree (it doesn't change
> > the victim task selection algorithm, doesn't look
> > at memory stas on cgroup level, etc), it's also much
> > simpler and more straightforward. So, hopefully, we can
> > avoid having long debates here, as we had with the full
> > implementation.
> > 
> > As it doesn't prevent any futher development,
> > and implements an useful and complete feature,
> > it looks as a sane way forward.
> > 
> > This patchset is against Linus's tree to avoid conflicts
> > with the cgroup-aware OOM killer patchset in the mm tree.
> > 
> > Two first patches are already in the mm tree.
> > The first one ("mm: introduce mem_cgroup_put() helper")
> > is totally fine, and the second's commit message has to be
> > changed to reflect that it's not a part of old patchset
> > anymore.
> 
> What's the plan with the cgroup aware oom killer?  It has been sitting in 
> the -mm tree for ages with no clear path to being merged.
> 
> Are you suggesting this patchset as a preliminary series so the cgroup 
> aware oom killer should be removed from the -mm tree and this should be 
> merged instead?  If so, what is the plan going forward for the cgroup 
> aware oom killer?
> 
> Are you planning on reviewing the patchset to fix the cgroup aware oom 
> killer at https://marc.info/?l=linux-kernel&m=153152325411865 which has 
> been waiting for feedback since March?

I would say it's been waiting for feedback since March because every
person that could give meaningful feedback on it, incl. the memcg and
cgroup maintainers, is happy with Roman's current patches in -mm, is
not convinced by the arguments you have made over months of
discussions, and has serious reservations about the configurable OOM
policies you propose as follow-up fix to Roman's patches.

This pared-down version of the patches proposed here is to accomodate
you and table discussions about policy for now. But your patchset is
highly unlikely to gain any sort of traction in the future.

Also I don't think there is any controversy here over what the way
forward should be. Roman's patches should have been merged months ago.
