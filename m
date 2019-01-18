Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CEA20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3SoNzHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfARMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:39:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfARMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:39:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so14880689wra.6;
        Fri, 18 Jan 2019 04:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aX85GmsmDubEcW1ODoBzE9KC7HLoNTVrutlcQlqhvTY=;
        b=I3SoNzHoFBY21vFTh0fLuNU2BYyb/VWh5Pn1bHWHJK5E+wVypb+/MhJzDl8sRO2HdS
         tf83/k8pXPk+kOOb9bK4WsONW9VkLqdKQCmIBotmKwLc+JI+38mxFTwnwpX+qJHLoGu9
         /2mYxfi73CT6F/KiaNCaBHKG/oSrwpXdHCFQxYVdmQKI26QCf4K68F0S3svm/iAeE21D
         /DquVBXtwJIGjhhyT9Qna4eQd/q8xPQPduow1znxDY+dF8AT7p+aKIjJ/QhHAdesGGmN
         UecpXv3wmR7N/tACyWWGoQZLD6xv+KC4lMUhkUK4kRGPynQmBr6NZxP5Bmttl9txW+R1
         etjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aX85GmsmDubEcW1ODoBzE9KC7HLoNTVrutlcQlqhvTY=;
        b=CjnFBhd/znIyiRQV0R5srB462XffJH2qmcBJiLmSs5GtQsmXpxKuDwRfvu1BmrcJE/
         507ewbsriX3++vRZkDBNz+Ruk2OAV09HWIotIBfKGKlkXISfs5Rly5g3hVUY9MsYxLyb
         lllQllHofAa+ogX+MNWKYn19vXUiAYXal6eVl8QwbZiJUAuiFX9QcCySFR36Z62FIhi8
         m/6ZQjBJcz6Zrn+ZcSmVuXV2JTwR16B4VE+mwWg6SmdrvGXgaucvhzw2ro0+pFtTifvG
         MUh1+BC9kcOTv70JB97Y5lzpq+0SjqOmHsD9ad+XcgTX3TpifhOE+GwzmA7qcxv2BmsD
         6/wQ==
X-Gm-Message-State: AJcUukfuE8uSnk0HxFijRXOZLorl+1XG3Lq2/sVsR4BwOMIFw201XKHa
        Hm/nXKlg+TuWlzU9tMO3A6o=
X-Google-Smtp-Source: ALg8bN43X0ADQ48EAymWM3mQSA6sKFx1wVRTOHxZZIb8eR1RLyI2WPyBEOXUBBACKI+Cf+tJEMWnAA==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr15960189wrw.132.1547815143551;
        Fri, 18 Jan 2019 04:39:03 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id e17sm141178212wri.36.2019.01.18.04.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 04:39:02 -0800 (PST)
Date:   Fri, 18 Jan 2019 13:39:00 +0100
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
Message-ID: <20190118123900.GJ14385@localhost.localdomain>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
 <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/19 15:55, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 2:16 PM Juri Lelli <juri.lelli@gmail.com> wrote:
> >
> > On 11/01/19 10:47, Rafael J. Wysocki wrote:
> > > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This commit introduces the frequency constraint infrastructure, which
> > > > provides a generic interface for parts of the kernel to constraint the
> > > > working frequency range of a device.
> > > >
> > > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > > cpufreq framework already implements such constraints with help of
> > > > notifier chains (for thermal and other constraints) and some local code
> > > > (for user-space constraints). The devfreq framework developers have also
> > > > shown interest [1] in such a framework, which may use it at a later
> > > > point of time.
> > > >
> > > > The idea here is to provide a generic interface and get rid of the
> > > > notifier based mechanism.
> > > >
> > > > Only one constraint is added for now for the cpufreq framework and the
> > > > rest will follow after this stuff is merged.
> > > >
> > > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > > this work and so I have added him as Co-author to the first patch.
> > > > Thanks Matthias.
> > > >
> > > > FWIW, This doesn't have anything to do with the boot-constraints
> > > > framework [2] I was trying to upstream earlier :)
> > >
> > > This is quite a bit of code to review, so it will take some time.
> > >
> > > One immediate observation is that it seems to do quite a bit of what
> > > is done in the PM QoS framework, so maybe there is an opportunity for
> > > some consolidation in there.
> >
> > Right, had the same impression. :-)
> >
> > I was also wondering how this new framework is dealing with
> > constraints/request imposed/generated by the scheduler and related
> > interfaces (thinking about schedutil and Patrick's util_clamp).
> 
> My understanding is that it is orthogonal to them, like adding extra
> constraints on top of them etc.

Mmm, ok. But, if that is indeed the case, I now wonder why and how
existing (or hopefully to be added soon) interfaces are not sufficient.
I'm not against this proposal, just trying to understand if this might
create unwanted, hard to manage, overlap.
