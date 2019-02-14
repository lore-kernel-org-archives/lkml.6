Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7985222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550159304;
	bh=b/hGCxHbNsYmbDyXm6mSAEvaJ6JvY/9Nh7jKbBLGVlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Octtr+E2Vj/dHYxva9rap5SNKVBNusuGYfuanUNx6ldRUpBoh8x8NRsmWwlFarFHg
	 5U9J7VgInew892HCxQpPlSvM7PGGO0a9MPAVcyMW2SxLvmyFIFoGajmlRx1JvrgHV8
	 /jM/2i4NUEqjLFp5zaYiEPSm9anOoc/PSd/4I+Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395082AbfBNPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:48:23 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41992 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbfBNPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:48:22 -0500
Received: by mail-yb1-f194.google.com with SMTP id j189so2546869ybj.9;
        Thu, 14 Feb 2019 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QGFW0YZBSKtsGjUIJgc2fpvIMga7Q3ct+VW65QSOO8=;
        b=Q3AJ4GSSMc5s1BT5IQWpwcN4EXRpP3/LUlDZDPs0rrsZdqYzSmUI1eXWIurd9MuyEV
         p7uRas7TTsXpBWI6G9OHj9OxDo5KQ84Om1vl1sRh+tkHcEc7hF34RoT/3FXq8NKjjOpB
         mCPExHBGLL1HSWW7/wW/1AtkII7ApdNQhko+UUQl2RUc+zrL0CPTsfaxOp+a1TrQ8tnj
         ysbq8kWRXawIc9zeag2hbZMqXutSkujw0fPP5aL1BASA6pdHGe6tY8q5D+O9i6G9kwXD
         F4YWBj7rbe31nTp7modhpcQSal40pWwa0G6QQ45oPTYMdsK26Uq4tccXhHmYjkkrXjRv
         Lo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QGFW0YZBSKtsGjUIJgc2fpvIMga7Q3ct+VW65QSOO8=;
        b=aLmcDyM4fdocOnTqK8QwR3Hc5ysFS6w5yjyRTA0CWLF+Xt4AW3ij8ipgKRT9Q3qpLu
         Bg+UU456kkrYhnCt6w5ifSOQs1025hI9xgTVC9d+It9lo3sfIZ83ep1GIQspi2wXbnqV
         aKGiNbUHiiGNdfDoNx4TM7HijjQof+qa2Wp6ps0GZ3EcMiXSlqM0+fIOD4GVmrg92SfE
         Wgtpz6/hseI9ILRDS5BSShztSFktZhu0xHpG5HG1J6tuzTq7dHpC5hjw9XFBzXDNeNSA
         +hJzD0HrpN5pkWQrrTrwSq0F7lTzm1OKXlkvm8p5UJMuU15/xFSEgC5tBsNqWiBA3ego
         SA0g==
X-Gm-Message-State: AHQUAuYIkgt5kIcEsgk9HVMyBgXr/Yr0D1/zLLgm+spDYBlav/gwBuoJ
        eTaGDJiBVsoTJtFCGemaadS9ya1S
X-Google-Smtp-Source: AHgI3IaVTEEMRIlX3mit7DTHpGBGjc/3KCzTBYvhGS2zKvbUzqq3JP7YJdm0TShUy8iRJ2D84IJdYg==
X-Received: by 2002:a25:cad1:: with SMTP id a200mr3733920ybg.223.1550159301420;
        Thu, 14 Feb 2019 07:48:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:94e8])
        by smtp.gmail.com with ESMTPSA id 207sm981167ywd.45.2019.02.14.07.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 07:48:20 -0800 (PST)
Date:   Thu, 14 Feb 2019 07:48:17 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 11/15] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190214154817.GN50184@devbig004.ftw2.facebook.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-12-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-12-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 08, 2019 at 10:05:50AM +0000, Patrick Bellasi wrote:
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies, while system wide clamps are defined by a generic
>    interface which does not depends on cgroups
> 
> b) do not enforce any constraints and/or dependencies between the parent
>    and its child nodes, thus relying:
>    - on permission settings defined by the system management software,
>      to define if subgroups can configure their clamp values
>    - on the delegation model, to ensure that effective clamps are
>      updated to consider both subgroup requests and parent group
>      constraints

I'm not sure about this hierarchical behavior.

> c) have higher priority than task-specific clamps, defined via
>    sched_setattr(), thus allowing to control and restrict task requests

and I have some other concerns about the interface, but let's discuss
them once the !cgroup portion is settled.

Thanks.

-- 
tejun
