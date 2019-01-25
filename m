Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4982218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548434257;
	bh=Wa8YGjA70uRv8lcXPJo00o/NWb87JGR4yVBHa3yfXtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ymhly3/1ZannL65N8C+5DFWbaUUtGuXb8o8ZVm/RABbczvv2JX2DJek5oAUXT9k6c
	 EXfwVI+qC9yNh/5OKqp10vA3Qqs0H2sOOZywrfyqCOv2WAW86mc3v4rm6k8d8kYbko
	 01/nUFxf8C5mCXExBR+lmTHA3L6EDXAN4aj4TL2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfAYQhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:37:35 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36976 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:37:35 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so4139037ywc.4;
        Fri, 25 Jan 2019 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RYL7pbha6AtxQjHD3ZK0n6qiStyqrgkMrnAlVCP0NNE=;
        b=hZvlbsqyaKWNVGRewUWJIxOTzlUYhWS2zbX7SH2tizlgJpQpx60Q9lFUr1KAvxcC/o
         1hPJlxzXj2+3gfQcXN2m7hvMawtI4t9aj1dEem45TLpkEql/eZmnG/q1Rj1mzVyhtxwr
         HV7sN0Yf6DRbhWtZYwjdL3tBn7xcNcxE0m4fXAVJgEjZPCK1VAIW74UMrRR1vLSuVj0h
         HyosUDdb9lBIVd02NWUS0S1pWyvOPCIyUMbdo++pIUAlLLlAg3hl9wVbLnyV7iSiBQWQ
         Cmfs2mFJwxet2D8u3OAyjG/l6Soc19pDLR4LD+aJZAPHD4x6jylVAxQ/YGkiG692WER7
         s73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RYL7pbha6AtxQjHD3ZK0n6qiStyqrgkMrnAlVCP0NNE=;
        b=grp19tW/nbo3bDcd8fRB8zEyFb5W9KxS0YOnVn/s1ox0ZLWlxXTHQcw8jmq8bwLSvA
         Ob54BhFhYKIaXGJSN7tzP0tiuaWt6/M+40IdoOwZmJa3JdlMHyxPfwM/19a8o8DLs1ZE
         dS/QUueHudkFcoRMGmJCtod0Z4p58lfps5asELBoNS2ycc/O9Vp49PIWHN6+pN1uhqIA
         8tll35zCR+um61zbYM+9Xl5Xz3FsWa7A3jAGqNj5T9bu3D8VD8BoEj/zNoDqPXYD/Nit
         PVvPVPKwHGVFsosidfege9i1VTsnPIJ2rxWhHF4yEv7AYH5iFctskFOEFbzHQuEnJ8AS
         ZLYA==
X-Gm-Message-State: AJcUukfo81jlbaPyyQ29tUJD48XxAyJWWcSsSd/RJRPlUmPjMYRk/KpZ
        prxn/9zFmmv258PupRuu9k4=
X-Google-Smtp-Source: ALg8bN6sgnHZX7knHYbGpxaRfjiI2fQMJ5uI/FNsinsGrbevn28z84ir4BlsluB5YpbixjVnQSajIQ==
X-Received: by 2002:a81:d845:: with SMTP id n5mr11854141ywl.486.1548434253786;
        Fri, 25 Jan 2019 08:37:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id b129sm10282016ywc.106.2019.01.25.08.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 08:37:32 -0800 (PST)
Date:   Fri, 25 Jan 2019 08:37:31 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Arkadiusz =?utf-8?Q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>
Cc:     cgroups@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        Jay Kamat <jgkamat@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pids.current with invalid value for hours [5.0.0 rc3 git]
Message-ID: <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
References: <df806a77-3327-9db5-8be2-976fde1c84e5@gmail.com>
 <20190117122535.njcbqhlmzozdkncw@mikami>
 <1d36b181-cbaf-6694-1a31-2f7f55d15675@gmail.com>
 <96ef6615-a5df-30af-b4dc-417a18ca63f1@gmail.com>
 <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 08:52:11AM +0100, Arkadiusz Miśkiewicz wrote:
> On 24/01/2019 12:21, Arkadiusz Miśkiewicz wrote:
> > On 17/01/2019 14:17, Arkadiusz Miśkiewicz wrote:
> >> On 17/01/2019 13:25, Aleksa Sarai wrote:
> >>> On 2019-01-17, Arkadiusz Miśkiewicz <a.miskiewicz@gmail.com> wrote:
> >>>> Using kernel 4.19.13.
> >>>>
> >>>> For one cgroup I noticed weird behaviour:
> >>>>
> >>>> # cat pids.current
> >>>> 60
> >>>> # cat cgroup.procs
> >>>> #
> >>>
> >>> Are there any zombies in the cgroup? pids.current is linked up directly
> >>> to __put_task_struct (so exit(2) won't decrease it, only the task_struct
> >>> actually being freed will decrease it).
> >>>
> >>
> >> There are no zombie processes.
> >>
> >> In mean time the problem shows on multiple servers and so far saw it
> >> only in cgroups that were OOMed.
> >>
> >> What has changed on these servers (yesterday) is turning on
> >> memory.oom.group=1 for all cgroups and changing memory.high from 1G to
> >> "max" (leaving memory.max=2G limit only).
> >>
> >> Previously there was no such problem.
> >>
> > 
> > I'm attaching reproducer. This time tried on different distribution
> > kernel (arch linux).
> > 
> > After 60s pids.current still shows 37 processes even if there are no
> > processes running (according to ps aux).
> 
> 
> The same test on 5.0.0-rc3-00104-gc04e2a780caf and it's easy to
> reproduce bug. No processes in cgroup but pids.current reports 91.

Can you please see whether the problem can be reproduced on the
current linux-next?

 git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Thanks.

-- 
tejun
