Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BBC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1847C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHQHuBtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBHJJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:09:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42700 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBHJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:09:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so1395091plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ni/+u21eIDK1iHkseXGMBkIz9rKlZZDEwPImdIQZsjk=;
        b=VHQHuBtn9KM2pXGh0XLeEWyfHS2Sz7C/Mpuw4DDzkoVmJWSHK+tYTclfWvbVfm8Wtg
         plmkq08YYXh34/5bDMoTqcPoG8vXzqIANulZjn8mmwv30mRUdV6dEp/YJbziCDSkFnRU
         i3ZfpF8tm0qg/TVBS/TrMfmD3TnbIjZUVkFh8Xc+h9VTYDm1LtoIt8FnQQegLKJl8cnS
         GXx+SLZfOT0LX4xnQg/exNwz/asV5Q1XzWNwPYOm7Zk38S26fNb8IX9vatWOj+XqCKfk
         Oh64wB5x9iBs8gMPY8ixuqVjWCqMv0F7o97hP258mj3+PORYhNN4haHQV0lhU3vRLYeg
         AMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ni/+u21eIDK1iHkseXGMBkIz9rKlZZDEwPImdIQZsjk=;
        b=LxNL5EIxLqmnfuEY4uAzNWjOm7Uhz2ePXcVzmYtftrFySJMmn6Bf42HzLQOHzv07wb
         Io2rcH3V8jhBTPC/Yt+RYeZrzXCqEJ12ZUjfNFUE6cBQ/vf/jPOE9EyJDnyhAHF6wzwC
         +dByrO20lvUun6CXIcIIBG8jqeDkOKrvLT2aNMUX5vSr4MzsnLwYS/Xy7Wt1bjq3IyOB
         cY0puSmERp11X19tRDXA6ln1WnPvs8vrHZBlVcR31EnDwFPhWRYvL6M7Zr0T8qxKVynk
         dzKjtFw/5gytFN93oZ+TUm6bVolE/fHYuhSK1iWItRNwtNv52XERyvRGTBKnDF9JUlVW
         Ur/w==
X-Gm-Message-State: AHQUAuYCP9MX+j1+FIyZ52A4VQudHK9a9UOhCf1o0CvnjKoygFTGzF/S
        dTItXO4rRnQ6mcgmGNK4w8tF5Q==
X-Google-Smtp-Source: AHgI3IaCWgiznFr/sUQ1WE5mAIreyvE9p7T5rcB5NkfnG8bVZmViKiodgFIo0UoZ6AKELvpHkLKlZg==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr20910487pln.224.1549616955034;
        Fri, 08 Feb 2019 01:09:15 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d3sm1713413pgl.64.2019.02.08.01.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:09:14 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:39:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190208090912.43aao5kny42iirum@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-19, 10:47, Rafael J. Wysocki wrote:
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

@Rafael: You are going to provide some more feedback here, right ?

> One immediate observation is that it seems to do quite a bit of what
> is done in the PM QoS framework, so maybe there is an opportunity for
> some consolidation in there.

-- 
viresh
