Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7EBC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95273218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548440894;
	bh=aIpeptfYyL0l5PwRvDcbK6pFmvDhX6ouucxrUpc27xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f8UQg43NncMK/289406O5qWambFOwyVZjcRrB00SVA8yIzhfcaW0ULcg6uLX9gYYq
	 PXvvoSjQ4cymDOSCQw7Ghrl/sHMQiuo1AW+IW1tz9JqlSxNCSuhLXSvEvM8U0VeLj1
	 rBn7TfMGOcLVgp1t3pMh7MG1sQerEnPqZfSxB3fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfAYS2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:28:13 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41252 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:28:12 -0500
Received: by mail-yb1-f195.google.com with SMTP id y63so4197403ybc.8;
        Fri, 25 Jan 2019 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KND47oB4UJZskQI8jxAjNs+9fiy3pLDDFs2RkvN4z38=;
        b=qW7KobFB8kOYKRY9BwGWo1btTcXtc8skavDL1VI3l87kZnQXRZ2FnGLCBHB6ozDc73
         iXXl37VMG4ga2hDrxuWSDaB/XwzZZhDmraOMkIOwQrb17Nlk7u2zJiHHt1gJuyz+bQTJ
         gflVtTUzwPKDsLFckc5Af8ISyjgXUvKcvwum2VaW/F9JLIO8MnykBSH81u9petfaDY2H
         HkqYcznDg5UwcRScWnxI85dkmPyD6KSuoW8vc+h4t8QTvVWQxgLQcgPNgSlv294kBysC
         z/7ksrB0IBpM9tPsUf3jMV/KQfKUAyW4I2GyW6MGBOA5Fu2JWFVjvuVjtuWCqlekulkb
         ojlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KND47oB4UJZskQI8jxAjNs+9fiy3pLDDFs2RkvN4z38=;
        b=lwHISUpI8P+p+pwOPCguuUSXJqMvSPYZrPRpkZPdMqMChVhCLU12mxljaloLGNpgzE
         Ztmj0T9aYYYOFfkdOQwIJUclI+2pFBvfy96oiwioaZdKLBTw20HMTFjASzqlrCey+i7I
         U8deb5FHFbOya7bu6rKMbnUMbrQqHU325qBie2qgauz9jMq+r5MDXjjycxf96pQOXdUp
         iCaaaGDJTCWJ8FbYwjDs0ZJip0iFh7lFxBVwnEPW85jl4yoKj7jpraHYRP9lyEav8n8I
         S7y66IyjfI9OYhLGn5YDeK2mz9NP1VBtObz0sXWc9JLPtPbg0PvC4b0YoI62XtMAw+Z3
         mJZg==
X-Gm-Message-State: AJcUukcEuzU5fdgTsgh9a6jKfTpgYMHId0Y/pN1fjYoQMuC6c68xftBe
        zGp/i3sDnEWAoFIBxWwxa70=
X-Google-Smtp-Source: ALg8bN75xJCQpIK2wjwy+yhnkWY07DNhoXbmtzKJYc4axxcBDSXgnaOGeNa4ieWaRh+Y3vxKeCpadw==
X-Received: by 2002:a25:3b82:: with SMTP id i124mr11619415yba.183.1548440891311;
        Fri, 25 Jan 2019 10:28:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id a15sm4645358ywh.64.2019.01.25.10.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:28:09 -0800 (PST)
Date:   Fri, 25 Jan 2019 10:28:08 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190125182808.GL50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125173713.GD20411@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Fri, Jan 25, 2019 at 06:37:13PM +0100, Michal Hocko wrote:
> > What if a user wants to monitor any ooms in the subtree tho, which is
> > a valid use case?
> 
> How is that information useful without know which memcg the oom applies
> to?

For example, a workload manager watching over a subtree for a job with
nested memory limits set by the job itself.  It wants to take action
(reporting and possibly other remediative actions) when something goes
wrong in the delegated subtree but isn't involved in how the subtree
is configured inside.

> > If local event monitoring is useful and it can be,
> > let's add separate events which are clearly identifiable to be local.
> > Right now, it's confusing like hell.
> 
> From a backward compatible POV it should be a new interface added.

That sure is an option for use cases like above but it has the
downside of carrying over the confusing interface into the indefinite
future.  Again, I'd like to point back at how we changed the
accounting write and trim accounting because the benefits outweighted
the risks.

> Please note that I understand that this might be confusing with the rest
> of the cgroup APIs but considering that this is the first time somebody
> is actually complaining and the interface is "production ready" for more
> than three years I am not really sure the situation is all that bad.

cgroup2 uptake hasn't progressed that fast.  None of the major distros
or container frameworks are currently shipping with it although many
are evaluating switching.  I don't think I'm too mistaken in that we
(FB) are at the bleeding edge in terms of adopting cgroup2 and its
various new features and are hitting these corner cases and oversights
in the process.  If there are noticeable breakages arising from this
change, we sure can backpaddle but I think the better course of action
is fixing them up while we can.

Thanks.

-- 
tejun
