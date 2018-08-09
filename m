Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901A922393
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHgwsf47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901A922393
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHIWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:36:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37547 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:36:36 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so3007916pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VLDHI77xRcdf2USCuk1/hYpaK4GEm2DzPVhz93htD0s=;
        b=SHgwsf4720X0Sg420wWukwiKIsArcYVpJw5HxcEYd2H4FB8rIBectu3R0l43pn+VhB
         +EYVuobp/13d8SWzJFvLQ8OsXsW/jxl7nFOecgjQADmBaYI+FMOziE2TlY1NIHRlRWa8
         imXbeNXn0/m0WccYRM+thurI3jI9BgDWb76HyoivooKvhcQNs8vJZhFzsSwSW3BEo50F
         7YNw9fjyeSpGvj7lUq1Ne8oxCIaHNhVNnbFQ3z2prSs/IQl26dQYexGhvi0bvkfezTO9
         JWBJD3GVcfV7/eLSYQ7fxrxunHj86VsvpMjcKbhQnVKsj6dtLZxFglHyiaD/Ebr/EB7i
         HBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VLDHI77xRcdf2USCuk1/hYpaK4GEm2DzPVhz93htD0s=;
        b=k7brs30g5AQ47kyF1Wbsn40xNCK6XSdCv8ammYRzw/DpC0PlTcYBNR7/0QTIXzOvr0
         gJW4Gcuwrt52wQHb1iZ8yKqZgBUpj/qonLHxy+H1Odq+uoRvk4TgsGWxove2agdWGzP+
         Q4Nl0H2QapuO1WMH1YLILJTsVIa6uBH7myCMM+IVjvoTDG/wJhUz7pOLULn5l6eW16Lj
         YmaVPNS2P/UUDG5jpwjbeW2FRSxFRJ4X3WmQAfRRvbo4Ktu2dQYWonwwSM5jmwNu8Ens
         7fnE07XgJRs6PchTTy4BptcaR4FoeKYSdigEh1641z1SHPgKT5eogJNaUP5Bsu9QcJHJ
         kvvQ==
X-Gm-Message-State: AOUpUlHCkjFUryrPrNaCX53ZMX4INQHWYkcev12Ed9rdsfYDjl3y37n1
        rI8gxPSJoXVcDvms6xAKGU6CNw==
X-Google-Smtp-Source: AA+uWPwRhYLlmrBrCqwXMaC/iMpsmP8YBJXFK98NhDQSQo+hKokrffkhMVnwd7n0rFbH5byTmL6tLQ==
X-Received: by 2002:a17:902:b28c:: with SMTP id u12-v6mr3277935plr.16.1533845411756;
        Thu, 09 Aug 2018 13:10:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z19-v6sm8699206pgi.33.2018.08.09.13.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 13:10:10 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:10:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
In-Reply-To: <20180808105909.GJ27972@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1808091308210.244858@chino.kir.corp.google.com>
References: <20180730180100.25079-1-guro@fb.com> <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com> <20180731235135.GA23436@castle.DHCP.thefacebook.com> <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com> <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com> <20180807003020.GA21483@castle.DHCP.thefacebook.com> <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
 <20180808105909.GJ27972@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018, Michal Hocko wrote:

> > > > In a cgroup-aware oom killer world, yes, we need the ability to specify 
> > > > that the usage of the entire subtree should be compared as a single 
> > > > entity with other cgroups.  That is necessary for user subtrees but may 
> > > > not be necessary for top-level cgroups depending on how you structure your 
> > > > unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> > > > and you are correct it can be different than oom.group.
> > > > 
> > > > That's not the only thing we need though, as I'm sure you were expecting 
> > > > me to say :)
> > > > 
> > > > We need the ability to preserve existing behavior, i.e. process based and 
> > > > not cgroup aware, for subtrees so that our users who have clear 
> > > > expectations and tune their oom_score_adj accordingly based on how the oom 
> > > > killer has always chosen processes for oom kill do not suddenly regress.
> > > 
> > > Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
> > > this case? This basically means that if memcg is selected as target,
> > > the process inside will be selected using traditional per-process approach.
> > > 
> > 
> > No, that would overload the policy and mechanism.  We want the ability to 
> > consider user-controlled subtrees as a single entity for comparison with 
> > other user subtrees to select which subtree to target.  This does not 
> > imply that users want their entire subtree oom killed.
> 
> Yeah, that's why oom.group == 0, no?
> 
> Anyway, can we separate this discussion from the current series please?
> We are getting more and more tangent.
> 
> Or do you still see the current state to be not mergeable?

I've said three times in this series that I am fine with it.  Roman and I 
are discussing the API for making forward progress with the cgroup aware 
oom killer itself.  When he responds, he can change the subject line if 
that would be helpful to you.
