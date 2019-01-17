Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYV8Mkim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfAQNQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:16:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34687 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:16:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so1045868wmd.1;
        Thu, 17 Jan 2019 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbHkGjrwcKb0NuTw5WydDOQqTO6/1obTSoZfynLnP+E=;
        b=GYV8Mkim59chUp5Uwv0l5MpF6Dhzj44p3HpNVzt6WkpvlI1o6yYrCvP6xdqOArXthx
         7OeXsxc+dKmgVI/f4i6ey2ce/o9jSPKouenS3BfkJp+LCxJZDaUQxRBF/H+lrYFiziZD
         Ye+aP5IjVUdrQCkKvN5CbkPpHPt2P+GT3Eaa5L0g7CDBza8jVcgOssJs+eccLSD/cuZA
         sNXzXYvQ8/+fwcehDTL7RxmlovgKx1hoN3O8BKbFjvxwZFX4wu/8TIaVCYfSVAXCs25F
         EavZbgH4rD3QbjSYKUSjYsECRBsQMKeDq7pdSXu2fDXgl77rfy0XpRgOuZVxOf9MfOR2
         VryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbHkGjrwcKb0NuTw5WydDOQqTO6/1obTSoZfynLnP+E=;
        b=jF2oXCXaijnY564Dzc6OtYo93XPArD5GV1QFA++YYujMMXuMn3Mcwamb1hFpaOPI2F
         whUAagGHjkbivebxKkqrsi9dx4unxQ6rtMV7CeVbmgoXKsYUCndJa4lrJaamEDqrNEMv
         pT/01TPomUT407RGMBRn1DPvrEKaxY/QGOUDUP1NEYTMEp9DvWdVxgipp5mMaZhj4kQ/
         QlNWN2SWeEcfj0sV8nouxwOdlh+uiBOz/0RG9vMjT6FOHDuRzVvo4txbPvH8481aaXOz
         kFQOwZenb8UUvVe4azXYnEObtcwKLgfpZaCoRty7TbeyXYsJ4UpHaJPqio702ASGn5Tb
         jCeQ==
X-Gm-Message-State: AJcUukeSD6d/SJoRsJaBKul/Z+X1NqmX4Di2VirBh6v+g335pk0s7EGf
        6QaREdeT9ZSqnrTsZ9QQbWk=
X-Google-Smtp-Source: ALg8bN7jC9MuhtVzMpbWIahaditaGu77lxQkYuVt3EAYIDCd1VQjchLgSx6yHnLczLeBc9Nbj2Fx7g==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr9395359wmk.44.1547730994826;
        Thu, 17 Jan 2019 05:16:34 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id q9sm123835287wrp.0.2019.01.17.05.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 05:16:33 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:16:31 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190117131631.GA14385@localhost.localdomain>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 10:47, Rafael J. Wysocki wrote:
> On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi,
> >
> > This commit introduces the frequency constraint infrastructure, which
> > provides a generic interface for parts of the kernel to constraint the
> > working frequency range of a device.
> >
> > The primary users of this are the cpufreq and devfreq frameworks. The
> > cpufreq framework already implements such constraints with help of
> > notifier chains (for thermal and other constraints) and some local code
> > (for user-space constraints). The devfreq framework developers have also
> > shown interest [1] in such a framework, which may use it at a later
> > point of time.
> >
> > The idea here is to provide a generic interface and get rid of the
> > notifier based mechanism.
> >
> > Only one constraint is added for now for the cpufreq framework and the
> > rest will follow after this stuff is merged.
> >
> > Matthias Kaehlcke was involved in the preparation of the first draft of
> > this work and so I have added him as Co-author to the first patch.
> > Thanks Matthias.
> >
> > FWIW, This doesn't have anything to do with the boot-constraints
> > framework [2] I was trying to upstream earlier :)
> 
> This is quite a bit of code to review, so it will take some time.
> 
> One immediate observation is that it seems to do quite a bit of what
> is done in the PM QoS framework, so maybe there is an opportunity for
> some consolidation in there.

Right, had the same impression. :-)

I was also wondering how this new framework is dealing with
constraints/request imposed/generated by the scheduler and related
interfaces (thinking about schedutil and Patrick's util_clamp).

Thanks,

- Juri
