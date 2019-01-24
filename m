Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C014C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A2D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UpO1W59K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfAXSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:23:32 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45649 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfAXSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:23:31 -0500
Received: by mail-yb1-f195.google.com with SMTP id n78so2743834yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnNHJQWasIH8ZZGAghYWs1cLQc8v0FeaohIo7b3m2Xs=;
        b=UpO1W59KzBPUdYXozLMYbpPfsOUDVZyeBT4VNzyjJMCY/l6K3zJWWABEBEeRWkuRHU
         moaYIPc8Ndy6AhIYKdEVPAcsxqb7GKa3Uvi2WaT0YOH/ZgP62bvGHFeDML/RDP+/M4wH
         LG8Jv5nZSnzZmA3NYAEkC9h0EK2afBSQapanqLiboWqKMgGgh3Qcy4zmk0HnLhhJtDiU
         AsNi76Rm/cKHHjev068aGpWbJCLD9IJQmZOOC7MVccJiUOfb8f2CO1ZL6Qq+yOtltZXj
         aKcUuF9GSaNpHjQHFlKd4c2Yb0yTIrcXVKncNb0+y0QwM9zIplkaE+poacFzbo1cYYYF
         Nz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnNHJQWasIH8ZZGAghYWs1cLQc8v0FeaohIo7b3m2Xs=;
        b=LpIh/G3XMLEY/n413/CYk2cUluqY0Vc4jq7nxNVa3sAjX2Ef96ez1zEN9WRTd80zXk
         +y9N6VBHeCTV4vWfhnOV5D8QR/0cOw0eMTo5dSNJo5+dKgGTLl3Etyfx1sh7nvcvJL5i
         oEgaO+n1nLA2JMl5+XjzNX3/4Y3Vl7TQiDoe5582MS4W2ke4wVoUcnp7ROH6Rt9L6FVu
         pCzbC/tjVt+5N63xKxNSgiNwP1xrdLiad63G+o7uyDrkB5fLCeeUxLdC+Rnv+LAgzfUJ
         rdHtCJdWmqs7sdlPRtsGzkzRnRJewq36JHQO9u4k2ibgGrdDjc+9fgnZWpS4oXUnLLZQ
         WqOw==
X-Gm-Message-State: AJcUukc4wdOaAcpFkdcBoeLnt94ash6I4l4McaZM6Hwae3W9H7dHa66q
        GcuOZ7d3lcW3ZHDrjfhSdRYcMA==
X-Google-Smtp-Source: ALg8bN5o+dJ1DdVVYaOQaqUiMIh5Twn9VNOS+OqJ/LisCgfGjJCP5XKV3liKcS5qsHsEGWbh3oPuPQ==
X-Received: by 2002:a25:2512:: with SMTP id l18mr7109379ybl.91.1548354210306;
        Thu, 24 Jan 2019 10:23:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9b5d])
        by smtp.gmail.com with ESMTPSA id w1sm9523228ywd.49.2019.01.24.10.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:23:29 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:23:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124182328.GA10820@cmpxchg.org>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124170117.GS4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 06:01:17PM +0100, Michal Hocko wrote:
> On Thu 24-01-19 11:00:10, Johannes Weiner wrote:
> [...]
> > We cannot fully eliminate a risk for regression, but it strikes me as
> > highly unlikely, given the extremely young age of cgroup2-based system
> > management and surrounding tooling.
> 
> I am not really sure what you consider young but this interface is 4.0+
> IIRC and the cgroup v2 is considered stable since 4.5 unless I
> missrememeber and that is not a short time period in my book.

If you read my sentence again, I'm not talking about the kernel but
the surrounding infrastructure that consumes this data. The risk is
not dependent on the age of the interface age, but on its adoption.

> Changing interfaces now represents a non-trivial risk and so far I
> haven't heard any actual usecase where the current semantic is
> actually wrong.  Inconsistency on its own is not a sufficient
> justification IMO.

It can be seen either way, and in isolation it wouldn't be wrong to
count events on the local level. But we made that decision for the
entire interface, and this file is the odd one out now. From that
comprehensive perspective, yes, the behavior is wrong. It really
confuses people who are trying to use it, because they *do* expect it
to behave recursively.

I'm really having a hard time believing there are existing cgroup2
users with specific expectations for the non-recursive behavior...
