Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B0C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554A2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547200071;
	bh=joi+/qu2KggeRT2QhMBkDtuLD1QQgr/tYr51hq8fGfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FjzOP0DP2WHBVVeJ6GUDy7/HrdNpejE6szBqiOxDhcvdAM37sNuhs6boqkAQX9aRc
	 JffOScSlSkP+F3ptYK4tsikILC9tco/r2je6bp9a+ipJMddugnsy9/tS7o0uvEiI6e
	 HG+ZnGFS/zzkfNmIIiC17qacONaO2YTdINPjv6Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfAKJru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:47:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37668 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:47:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so11737187oia.4;
        Fri, 11 Jan 2019 01:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joi+/qu2KggeRT2QhMBkDtuLD1QQgr/tYr51hq8fGfE=;
        b=GLBhcnFFe39duuF2YhAqtzJgFWDboyEiLLDEzzpdsmSzP7t2oUaSTNtwHxGl1kpfOz
         +dp7HCM9yYSFWVISg7v/qsBn8pe7apPU/FAAR9qVKFxm4uEavQOAnVGhCeTU0lDianfO
         7QSEdyuoNSgPVPaResf/GcNldAPnRb6WXekAL0S+VByD0snLwvx0vo2sWSj7XSixOOIm
         b2qZ9qga9wtNZH64FaJJxMy1etM02Oghnrnj8Ll7N4cBKamqYeAul2dMrQsE5vVcL+9o
         2Gl4BMpg3zadUxggUp7DZ4etK66rZE8GHefYbEr2u4Q6Pw6FNRc9ebZGQGapmlebrs5S
         LFOQ==
X-Gm-Message-State: AJcUukdU8cX8Om84NMbQsJXL0jtUvXAOzIzCazJ1AeAnL9y9AQzr13WZ
        l2tZySwwnweM00m9SdR/ySFH7r7Ia7V3kPfbshM=
X-Google-Smtp-Source: ALg8bN4BRPTdyyzB3EOX3fxzFFHv17XhCduNRZAsjxehc8MqWrNTj+YbEtO6eJCUMWos+V0ptv1W+o0H0jipLk0yQek=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr9078666oia.95.1547200068692;
 Fri, 11 Jan 2019 01:47:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547197612.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jan 2019 10:47:37 +0100
Message-ID: <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> This commit introduces the frequency constraint infrastructure, which
> provides a generic interface for parts of the kernel to constraint the
> working frequency range of a device.
>
> The primary users of this are the cpufreq and devfreq frameworks. The
> cpufreq framework already implements such constraints with help of
> notifier chains (for thermal and other constraints) and some local code
> (for user-space constraints). The devfreq framework developers have also
> shown interest [1] in such a framework, which may use it at a later
> point of time.
>
> The idea here is to provide a generic interface and get rid of the
> notifier based mechanism.
>
> Only one constraint is added for now for the cpufreq framework and the
> rest will follow after this stuff is merged.
>
> Matthias Kaehlcke was involved in the preparation of the first draft of
> this work and so I have added him as Co-author to the first patch.
> Thanks Matthias.
>
> FWIW, This doesn't have anything to do with the boot-constraints
> framework [2] I was trying to upstream earlier :)

This is quite a bit of code to review, so it will take some time.

One immediate observation is that it seems to do quite a bit of what
is done in the PM QoS framework, so maybe there is an opportunity for
some consolidation in there.

Cheers,
Rafael
