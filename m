Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07CC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D4E218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ccNxnvT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfA3TXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:23:49 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46353 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfA3TXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:23:48 -0500
Received: by mail-yb1-f196.google.com with SMTP id 7so261884ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+s3m/wCiQicI56EM9O8sUfe7ZO8/YgchrGdD+iAv9I=;
        b=ccNxnvT224O+7fChZ7Efge3FO8zKw7BrWhwJ7vtYCw2pMhdgeAnuGSy0ooAgXBO//i
         RZodYsnJPpMtZAmiD6BTOM2ZmYll6e8Tx/HpFylbwTK5qpdK3HKp6c8tm3vGNFD5i3eG
         8JiePIfFf14/NPKu2oWsFcTO4Wmr0VywSvdt7lcrunvnDALgrasx6zXTVrEFmG2x+muA
         aIOTrYjcVAI1Zqden7mXBJepzBhvBMPxAagdov+uqKm15pG4iFf8eEdJtEwm3GOlHOKT
         pgPErx42/P7qtYmr8UalnjLRF0Ek8ydI72C2ok/il/IB0bsnSgpJg/sO8ZnlzCxjp1kE
         11Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+s3m/wCiQicI56EM9O8sUfe7ZO8/YgchrGdD+iAv9I=;
        b=nwIJsY+O0e5ILYkAhs2+EWAn38XKqrw8YeqxmHcPGj1lWPR/Y98C59v0UGdgQPUkZo
         JHoBm9IHQQgNtzKMU0q1XRp1rwS0hwSuA943wN240mMtVhs8KZVAAHlxYeWh2rx3gd9m
         2a28PLr3m9NF4sRVv9Kxj9UiAHb2F5HSatHr6uu6qWCZjH8m0xSbVctX7lI+H9fsVrdE
         e3MTS3HIdXG+pMgAW/apn9voWaras7wRxO+5IzrlJnzc9QFYttkfWHgp1rf1q/rkPTkH
         1PA4OyxorQVZHfUcWwJuEf5KaBNB6mGB8aiuJKbW1Ia+7aD/EOFzhU+AwLH3XClrfzXi
         UJNA==
X-Gm-Message-State: AJcUukfcJ0LSHkOX8uE1sREiXtnQAH4FZ7gaYYoAi/dfIUfw72ZNWGwd
        v2W4p5ht9Bo9CTYtR5G1zk+9Cw==
X-Google-Smtp-Source: ALg8bN6f8V7xxI/17rpnmUspeB/aPgmPl/5RN0lt8KISw0wDBoHhd0PgtkFxbAPEvOFgOboGaYeTeg==
X-Received: by 2002:a25:3b82:: with SMTP id i124mr30282584yba.183.1548876227334;
        Wed, 30 Jan 2019 11:23:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id a15sm937081ywh.64.2019.01.30.11.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:23:46 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:23:45 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130192345.GA20957@cmpxchg.org>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128125151.GI18811@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 01:51:51PM +0100, Michal Hocko wrote:
> On Fri 25-01-19 10:28:08, Tejun Heo wrote:
> > On Fri, Jan 25, 2019 at 06:37:13PM +0100, Michal Hocko wrote:
> > > Please note that I understand that this might be confusing with the rest
> > > of the cgroup APIs but considering that this is the first time somebody
> > > is actually complaining and the interface is "production ready" for more
> > > than three years I am not really sure the situation is all that bad.
> > 
> > cgroup2 uptake hasn't progressed that fast.  None of the major distros
> > or container frameworks are currently shipping with it although many
> > are evaluating switching.  I don't think I'm too mistaken in that we
> > (FB) are at the bleeding edge in terms of adopting cgroup2 and its
> > various new features and are hitting these corner cases and oversights
> > in the process.  If there are noticeable breakages arising from this
> > change, we sure can backpaddle but I think the better course of action
> > is fixing them up while we can.
> 
> I do not really think you can go back. You cannot simply change semantic
> back and forth because you just break new users.
> 
> Really, I do not see the semantic changing after more than 3 years of
> production ready interface. If you really believe we need a hierarchical
> notification mechanism for the reclaim activity then add a new one.

This discussion needs to be more nuanced.

We change interfaces and user-visible behavior all the time when we
think nobody is likely to rely on it. Sometimes we change them after
decades of established behavior - for example the recent OOM killer
change to not kill children over parents.

The argument was made that it's very unlikely that we break any
existing user setups relying specifically on this behavior we are
trying to fix. I don't see a real dispute to this, other than a
repetition of "we can't change it after three years".

I also don't see a concrete description of a plausible scenario that
this change might break.

I would like to see a solid case for why this change is a notable risk
to actual users (interface age is not a criterium for other changes)
before discussing errata solutions.
