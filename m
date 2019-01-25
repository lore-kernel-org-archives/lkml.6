Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABBA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548437838;
	bh=Ypucz0x/ozKzFHjOI9rgbEu/0yNFmEkXvSWTLymsSPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jNejwqFAZ90/5sOhJTXAN6uNCQHjbuCdn+1lv3HF9yN36l2YBt/7kmfSRGvFUM91T
	 ZROC/y+BjlgccJZcTIY409hT14Ovu+/NUTOY/8bjW1mLj0CqjicXbNBBLJiQ1NuX+u
	 bA/o89IhltQSz9xEKnpwzH0O+XfOGNoUIQjCeHTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfAYRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:37:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfAYRhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:37:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5F19ABCB;
        Fri, 25 Jan 2019 17:37:14 +0000 (UTC)
Date:   Fri, 25 Jan 2019 18:37:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190125173713.GD20411@dhcp22.suse.cz>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125165152.GK50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 08:51:52, Tejun Heo wrote:
[...]
> > I do see your point about consistency. But it is also important to
> > consider the usability of this interface. As already mentioned, catching
> > an oom event at a level where the oom doesn't happen and having hard
> > time to identify that place without races is a not a straightforward API
> > to use. So it might be really the case that the api is actually usable
> > for its purpose.
> 
> What if a user wants to monitor any ooms in the subtree tho, which is
> a valid use case?

How is that information useful without know which memcg the oom applies
to?

> If local event monitoring is useful and it can be,
> let's add separate events which are clearly identifiable to be local.
> Right now, it's confusing like hell.

From a backward compatible POV it should be a new interface added.
Please note that I understand that this might be confusing with the rest
of the cgroup APIs but considering that this is the first time somebody
is actually complaining and the interface is "production ready" for more
than three years I am not really sure the situation is all that bad.
-- 
Michal Hocko
SUSE Labs
