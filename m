Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C04C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E420869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549007295;
	bh=dyNTS538hrazd6OfS2Va6IRXqdxouoBadzVWPSctylo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UtQG9LfUENrAZBQV134IVt03sdiDDzrn/pXHyP/vP2TFkDEEtLY2MAIj6RLQzYPUN
	 23SxTKziOwaaJXJfTdn7wD4X/+Yj0+b8IsaxNTvClOwIobJWm9523hzSbXBCC2BQgh
	 zDnqEotdmChvEhowhNfwOb6wsFXliS1AupCiWThI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBAHsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:48:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:35822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfBAHsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:48:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A54EDAF86;
        Fri,  1 Feb 2019 07:48:11 +0000 (UTC)
Date:   Fri, 1 Feb 2019 08:48:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memcg: Handle cgroup_disable=memory when getting
 memcg protection
Message-ID: <20190201074809.GF11599@dhcp22.suse.cz>
References: <20190201045711.GA18302@chrisdown.name>
 <20190201071203.GD11599@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201071203.GD11599@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-02-19 08:12:03, Michal Hocko wrote:
> On Thu 31-01-19 23:57:11, Chris Down wrote:
> > memcg is NULL if we have CONFIG_MEMCG set, but cgroup_disable=memory on
> > the kernel command line.
> > 
> > Fixes: 8a907cdf0177ab40 ("mm, memcg: proportional memory.{low,min} reclaim")
> 
> JFYI this is not a valid sha1. It is from linux next and it will change
> with the next linux-next release.
> 
> Btw. I still didn't get to look at your patch and I am unlikely to do so
> today. I will be offline next week but I will try to get to it after I
> get back.

Btw. I would appreciate if you could post the patch with all fixups
folded for the final review once things settle down.
-- 
Michal Hocko
SUSE Labs
