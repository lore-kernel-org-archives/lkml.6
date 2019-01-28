Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C13AC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1652148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vc03nv96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfA1VxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:53:19 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43704 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfA1VxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:53:17 -0500
Received: by mail-yw1-f68.google.com with SMTP id n21so7378912ywd.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6fUmvSDmEjz08XKF0ToKqbVBrxXVRyHjyqapg2MBg6Q=;
        b=vc03nv96i0HISo7x2YIJjRidr5L5AP2IUQx6QxFgZmkIVUMJsMRy0c7TK3FrcHSURc
         aDa2L0TK5Pw30lt66CwIUbIRFXTIeZOeR5wYH0y3ZSoefARez89tTF1w08/hIiX/5Rlh
         GJjqcQ7j7h3kqaYtO+gCx58GfCaJU3ZPM0wKth+exXBNTulSBbeSLUaDHI0Ec3OnAg4g
         dByNON9C53Fc1E24EfHoaYt9+4l+UintuPdprpmzY+UswWd8CDo6bAtldH5kxOeofiZ1
         YBz7LQltzMI/JmZH1RSxBWnMzbc62P4Qaj5+NnVugVBXwh5S9CL0bDhvujlyxrbRU3I4
         LuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6fUmvSDmEjz08XKF0ToKqbVBrxXVRyHjyqapg2MBg6Q=;
        b=NvLHYP6xwAhdCp61XzAwVw1+L8FZHuacyCOMO1H3Ntdg4v+6iw4He9BUGHITZO/Vsq
         doVdAPH5plf7Fm90sivoanz89XYGpshzErwnAIcYwTH7tz5hfsDCINYzfQbZ8+Hm6g0I
         Ts6BVNYOn2e4ahT8IDvq+biMZPnf7JORSVU8cDIlaOKGXaOWvxO0IvjSsd79NIcr5iOX
         xJuBUHbosV0no/KdkaexLThz0wY645dl0m+fndkEjKgzTLjoD/j7ccLsFeNDFoQDoQIT
         d/hpMC1vOqcH8xuwYWLU/NY0slTTBvtl6vuY0zGOuXq48tT73Zhy97GkPvMpXXRPaZrn
         rq6Q==
X-Gm-Message-State: AJcUukfzaJkDOiN/21xi3x0Q0071KG3R3NRuyFLziFTNqPkxW0lUN1A7
        HcjkZBHGaZ//zCc6MoP9KXvOKA==
X-Google-Smtp-Source: ALg8bN4OAl6UXpscoGwFFiaBA21eQ202GOZJFhhB7GKXE4/crw3XmlqCZtLMiadTAOmXTDWM+Q1W7g==
X-Received: by 2002:a81:b653:: with SMTP id h19mr22487323ywk.170.1548712396677;
        Mon, 28 Jan 2019 13:53:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:42c8])
        by smtp.gmail.com with ESMTPSA id u4sm24465788ywu.92.2019.01.28.13.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:53:15 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:53:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Arkadiusz =?utf-8?Q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
Message-ID: <20190128215315.GA2011@cmpxchg.org>
References: <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
 <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
 <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
 <20190127083724.GA18811@dhcp22.suse.cz>
 <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
 <20190127114021.GB18811@dhcp22.suse.cz>
 <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Sun, Jan 27, 2019 at 11:57:38PM +0900, Tetsuo Handa wrote:
> From 9c9e935fc038342c48461aabca666f1b544e32b1 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 27 Jan 2019 23:51:37 +0900
> Subject: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
> 
> Arkadiusz reported that enabling memcg's group oom killing causes
> strange memcg statistics where there is no task in a memcg despite
> the number of tasks in that memcg is not 0. It turned out that there
> is a bug in wake_oom_reaper() which allows enqueuing same task twice
> which makes impossible to decrease the number of tasks in that memcg
> due to a refcount leak.
> 
> This bug existed since the OOM reaper became invokable from
> task_will_free_mem(current) path in out_of_memory() in Linux 4.7,
> but memcg's group oom killing made it easier to trigger this bug by
> calling wake_oom_reaper() on the same task from one out_of_memory()
> request.

This changelog seems a little terse compared to how tricky this is.

Can you please include an explanation here *how* this bug is possible?
I.e. the race condition that causes the function te be entered twice
and the existing re-entrance check in there to fail.

> Fix this bug using an approach used by commit 855b018325737f76
> ("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task").
> As a side effect of this patch, this patch also avoids enqueuing
> multiple threads sharing memory via task_will_free_mem(current) path.
