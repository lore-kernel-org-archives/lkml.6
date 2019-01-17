Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547736928;
	bh=N2HYeH6mHxP/yO8c9bxtPPQl8N3D6FtQoulXTsajARU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ElmXZaEgN5il173aS6N1yf2NeLFDk3iNBe7rHsHHLHTGJBYJNRI7CYJ4pX4V6zl3P
	 aeMY6tQ8/o2aDUXoB4De+GonkkuRJagfnyzjyCykbWAv+kztb16M+ZnQM0J+WlwcZX
	 hqwqmvN7cFIlWzg7SRo4OnJbFuqrjYs/uxybjf5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfAQOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:55:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42147 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfAQOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:55:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so11315796otk.9;
        Thu, 17 Jan 2019 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2HYeH6mHxP/yO8c9bxtPPQl8N3D6FtQoulXTsajARU=;
        b=BalQnyYW1wNVcwHMc3GMcA0gwoDlHqqNYh0zAUabwAzzdu2mG1Nbqq/l49GfQCGE0B
         tj4lUDXxTmhvjNObL0LQxMPYJZmAsy3dl5MpA04JBFKX0MnZM5Yj3aSHCDEJgS4XiYIQ
         z4JMb2lapPAWDroL+xOb3L6Hc/Skl0LMP7Lg89ryPJXLALs92IMo0TgdvJDnXUlXbkbq
         52xSgkIkI+TbAfUf9GyDzzuvBNZHZfSbz3DMszf0tVGU8GhPnAPqTJoaXmKXbSlXP9Fj
         ZUbyN4A/Enj3tcIuNOiTwaW7NWaYMbnYM6fd8MyiPGhpvo6fHFsRQQhhDzRD13WXQvuN
         lF4g==
X-Gm-Message-State: AJcUukfzYpdKxUOyFXk1OXBnZLx6yszPFTm6SmzIdr2YMPndnX2XWlla
        9rJlf3q+yX8AfN9loUeT32FnJQRn4lA2jwRQDsg=
X-Google-Smtp-Source: ALg8bN7xgxQHFVL88shlgsS73MipEZAZO/uOZMQh5kKTa7rkPdW6AawYhYgIXFXRFgQLKB9XsIgStj3mbnHuuc/7+WI=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr8414473ota.244.1547736924605;
 Thu, 17 Jan 2019 06:55:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547197612.git.viresh.kumar@linaro.org> <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
In-Reply-To: <20190117131631.GA14385@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 15:55:12 +0100
Message-ID: <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:16 PM Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 11/01/19 10:47, Rafael J. Wysocki wrote:
> > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > This commit introduces the frequency constraint infrastructure, which
> > > provides a generic interface for parts of the kernel to constraint the
> > > working frequency range of a device.
> > >
> > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > cpufreq framework already implements such constraints with help of
> > > notifier chains (for thermal and other constraints) and some local code
> > > (for user-space constraints). The devfreq framework developers have also
> > > shown interest [1] in such a framework, which may use it at a later
> > > point of time.
> > >
> > > The idea here is to provide a generic interface and get rid of the
> > > notifier based mechanism.
> > >
> > > Only one constraint is added for now for the cpufreq framework and the
> > > rest will follow after this stuff is merged.
> > >
> > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > this work and so I have added him as Co-author to the first patch.
> > > Thanks Matthias.
> > >
> > > FWIW, This doesn't have anything to do with the boot-constraints
> > > framework [2] I was trying to upstream earlier :)
> >
> > This is quite a bit of code to review, so it will take some time.
> >
> > One immediate observation is that it seems to do quite a bit of what
> > is done in the PM QoS framework, so maybe there is an opportunity for
> > some consolidation in there.
>
> Right, had the same impression. :-)
>
> I was also wondering how this new framework is dealing with
> constraints/request imposed/generated by the scheduler and related
> interfaces (thinking about schedutil and Patrick's util_clamp).

My understanding is that it is orthogonal to them, like adding extra
constraints on top of them etc.
