Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D625C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C2C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL0UAfC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C2C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbeKHBYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:24:30 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45530 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeKHBYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:24:30 -0500
Received: by mail-yb1-f195.google.com with SMTP id 131-v6so6994435ybe.12;
        Wed, 07 Nov 2018 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBsAi1/zcZAhn1DpkP41LMbYfHFLfREhipwh3kGR2xo=;
        b=iL0UAfC2UGyt6OXwjIQ/5Oaz2YM3Z6r+yDWkZFh9CR4NqgujrVr1N2KU3ImG/Z2Su+
         JvLXGtsP3GWr3Bj2peJ6/akjTIwlZLkGamlZYu2ONIvkBSHawVd9MefI6idhhkDjZMQ1
         hkHNtSgG0iqhE8SG55a5B+GvJhYIdLaJhUoviHQTsG9sVX7NRvrUmhtPfqYmVupLGQtc
         08jj9Oyh+iT1bdJIP+XpTDiO8CJ9wJLlH/mzecWhS78jqB1PVJ1zdzQu/j1GoQPZaS8R
         uRiJpYgvnzNbNl+5YGvEXdnYeZfxVEHBZ63GEKSTWgpjqDfeDLI9zj2zTqv4DXlfNuh5
         vdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBsAi1/zcZAhn1DpkP41LMbYfHFLfREhipwh3kGR2xo=;
        b=Wa9ozeDMjwEimyx1vT1U+Vbxdp7T9/jl/jJaolYxG+gkFeQRY9PaNSwzc/9zwMqDpa
         JjMw6I1ysohUNMnD1AL6+n3uP/mk0x7i7EoK2dtddOer+bppz6R+JQ+VaFm7grT9pSKY
         vzk3mHVsw7QOQPzagJjbtwIQIvBU/NxQ6MJQL5iaqwE2Q1brEAw5aiZrSdxGeXpcVoWU
         7pPVsPFeQFBJLnd1in34q6vwXKjaxzyo9cooPIkRW8eYkGHvk6/9txlX08fNUH0rA8KH
         ftsm+0eERyni1Myafiucy5U5hbFWFNrczvaC38WDqkp0btHgTiZ0IpCYJNHltTkiRhZ1
         +4Wg==
X-Gm-Message-State: AGRZ1gI1QlbCBY4WTudZriCiby++7xX5mmgzI+kPIvBcjERq0PJwIjND
        0PW0tq2iYDj/FVq7MbnEzzA=
X-Google-Smtp-Source: AJdET5ewwlG+d9ONV5CfpSu55tqe18BPUFIllLoGJHdfNalKsYQ37EZeocFlE+c85JxX0OOdkFLOdw==
X-Received: by 2002:a25:2bc4:: with SMTP id r187-v6mr775283ybr.25.1541606014051;
        Wed, 07 Nov 2018 07:53:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:5c3c])
        by smtp.gmail.com with ESMTPSA id v128-v6sm514312ywf.56.2018.11.07.07.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 07:53:32 -0800 (PST)
Date:   Wed, 7 Nov 2018 07:53:30 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     lizefan@huawei.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v5 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20181107155330.GA2509588@devbig004.ftw2.facebook.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-4-juri.lelli@redhat.com>
 <20180925143416.GD25664@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925143416.GD25664@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 25, 2018 at 04:34:16PM +0200, Juri Lelli wrote:
> It would be great if you could please have a look at the proposed change
> below (and the rest of the set of course :-).

Yeah, looks good to me.  Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

> Another bit that I'd be more comfortable after hearing your word on it
> is this one (discussed over 5/5):
> 
> https://lore.kernel.org/lkml/20180925130750.GA25664@localhost.localdomain/

Can you please loop Waiman Long <longman@redhat.com> into discussion?
He's working on cgroup2 cpuset support which might collide.

Thanks.

-- 
tejun
