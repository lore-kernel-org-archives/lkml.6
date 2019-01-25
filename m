Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C8C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA735218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548435118;
	bh=8JrNFGkWw7t/v4e0ixH1PXZe8R2BTUISkEejCRD5v74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P676p9dv/zlXwCfSzeHqGkB1ifyVDehbncgeQ50HzNSLp3dbyc/Q4VHfMu15ZqGUX
	 sSSiqTx4zjUBpQSCSPZCutm73RevhVaWLE532BbFb3LbdbWvsAWgjQqFA6B85LMpIt
	 D5MfTYQNH1/MV7q+SUALN4e9aLMZe8KhK67iDBDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAYQv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:51:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38337 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:51:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so4152133ywb.5;
        Fri, 25 Jan 2019 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fx+ssMKA+Ay2K4eIcTnEhxGFGYOBaGx6lV4J25BcMHg=;
        b=cimoxzcpAnB7bCbd6fNtWOQ9t2KVyXX1h+OvBbp5Htq+3KBWNIWcLM0nUHwKTg8hZd
         sQTjOpllIj/vrDiB2bwOE/5lD4IhBPjblIPqgZxdjNnc5tmPY1kpP5PASI8/5Vv+ty6I
         CFQrhRNsHqwhVgUFHr0uZH7aoe/uMk5nTykPbc/Dsfd8W8zCXAmuLYdz2T75z9jEP1ZB
         10xullDgW5P+wrvGBknon1upG+l0cyrMpLIPs6hDWOCRqi5ogKZr3LqUDKEuB58lFtHK
         3MJW9Qd/Ua0hcByDRthnz5a4b5i1CEahSJkkTygqGp+ADTVDL88vvPUS19UulUhKgmpH
         9zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fx+ssMKA+Ay2K4eIcTnEhxGFGYOBaGx6lV4J25BcMHg=;
        b=Zf5lzE86rOuGHgDe1C6zidB5PVca6+lp8CgNctxmburOsbdAquOf4FXXz7LA4f6sPc
         rFNfgLX2xz/VOAuXCK3YJ7125yyO+uxOxew8OkAVwKA+70uAKkm1cLMSsoQY+EB3I7Xs
         5493pHg6zx6uKgR+ATKx/rHT+N5CYCt3s8htQnCr16pZrxK34FgyPH+kDOmFvvxUE1FD
         ez6uPz/JK5SwMSos/LPL9YZ5chn3lDqjFtRNqMnNgdfmkvrIqUnVnNfTSjepW0ZMywKH
         A5bSQWnCCOQLzR5rocTtSIML9/X0w39qveiMpKY2G9t2yT3tYIX3AULSekNiLM8+jGXa
         6eGQ==
X-Gm-Message-State: AJcUukfo9s9dpPWRPOn9d04PdNJJBQ8W76xYt+8TQvh+VkPDy79WIh8H
        3MLSS8ErunAOqPDrnPAKmNk=
X-Google-Smtp-Source: ALg8bN6fZcwhoWDgPh/n3+Koj5w+8ut3BhGZFa/ParDV8JRsECaNH34ySF5rifKm0zCGt2zIO2ctrA==
X-Received: by 2002:a0d:c603:: with SMTP id i3mr11166427ywd.85.1548435115392;
        Fri, 25 Jan 2019 08:51:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id l16sm10964592ywa.25.2019.01.25.08.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 08:51:54 -0800 (PST)
Date:   Fri, 25 Jan 2019 08:51:52 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190125165152.GK50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125074824.GD3560@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Fri, Jan 25, 2019 at 09:42:13AM +0100, Michal Hocko wrote:
> > If you read my sentence again, I'm not talking about the kernel but
> > the surrounding infrastructure that consumes this data. The risk is
> > not dependent on the age of the interface age, but on its adoption.
> 
> You really have to assume the user visible interface is consumed shortly
> after it is exposed/considered stable in this case as cgroups v2 was
> explicitly called unstable for a considerable period of time. This is a
> general policy regarding user APIs in the kernel. I can see arguments a
> next release after introduction or in similar cases but this is 3 years
> ago. We already have distribution kernels based on 4.12 kernel and it is
> old comparing to 5.0.

We do change userland-visible behaviors if the existing behavior is
buggy / misleading / confusing.  For example, we recently changed how
discard bytes are accounted (no longer included in write bytes or ios)
and even how mincore(2) behaves, both of which are far older than
cgroup2.

The main considerations are the blast radius and existing use cases in
these decisions.  Age does contribute to it but mostly because they
affect how widely the behavior may be depended upon.

> > > Changing interfaces now represents a non-trivial risk and so far I
> > > haven't heard any actual usecase where the current semantic is
> > > actually wrong.  Inconsistency on its own is not a sufficient
> > > justification IMO.
> > 
> > It can be seen either way, and in isolation it wouldn't be wrong to
> > count events on the local level. But we made that decision for the
> > entire interface, and this file is the odd one out now. From that
> > comprehensive perspective, yes, the behavior is wrong.
> 
> I do see your point about consistency. But it is also important to
> consider the usability of this interface. As already mentioned, catching
> an oom event at a level where the oom doesn't happen and having hard
> time to identify that place without races is a not a straightforward API
> to use. So it might be really the case that the api is actually usable
> for its purpose.

What if a user wants to monitor any ooms in the subtree tho, which is
a valid use case?  If local event monitoring is useful and it can be,
let's add separate events which are clearly identifiable to be local.
Right now, it's confusing like hell.

> > It really
> > confuses people who are trying to use it, because they *do* expect it
> > to behave recursively.
> 
> Then we should improve the documentation. But seriously these are no
> strong reasons to change a long term semantic people might rely on.

This is broken interface.  We're mixing local and hierarchical numbers
willy nilly without obvious way of telling them apart.

> > I'm really having a hard time believing there are existing cgroup2
> > users with specific expectations for the non-recursive behavior...
> 
> I can certainly imagine monitoring tools to hook at levels where limits
> are set and report events as they happen. It would be more than
> confusing to receive events for reclaim/ooms that hasn't happened at
> that level just because a delegated memcg down the hierarchy has decided
> to set a more restrictive limits. Really this is a very unexpected
> behavior change for anybody using that interface right now on anything
> but leaf memcgs.

Sure, there's some probability this change may cause some disruptions
although I'm pretty skeptical given that inner node event monitoring
is mostly useless right now.  However, there's also a lot of on-going
and future costs everyone is paying because the interface is so
confusing.

Thanks.

-- 
tejun
