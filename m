Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E102184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLNaX3I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfBLFI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:08:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLFI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:08:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so701174pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 21:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4w2JFlmHwVYxvw3SvixEqMwhXHga5lnBWWoy+6qVC54=;
        b=bLNaX3I5Ij9xwR7dH6JjDLuN0QqDWbHoLEuxbwIyccCKcRnIRjsZNTL6shEk2wIFBQ
         tgaKpfbzCUVDuRqa4/jVlp5SVr1f4CIk2XR5QK6q1KnNa3gyXbnIiMOKs16/KUecx1q/
         eYfyXayzElWM3femrpO21qOZbFXVxp/37NXW2ZhUZNAA5eceh31JUw+7A2vmuSc1eIf8
         w6S8CH2ibcDqck2P/qtq/4X0IRjrtGNc9P3YIhEp8ZDq5lVqJkaw/Cq2s4LNski1NKY5
         oFlimTJdb/l+gjEIzo+tm0mrt9IZjoz8tbcgJtQIRZvfqxEeEPiXnMGbDlxCdl+NhC5k
         TcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4w2JFlmHwVYxvw3SvixEqMwhXHga5lnBWWoy+6qVC54=;
        b=ghX/uyPKL67TzeVZn1VqCEjwgI7fWQ0k+f6Tjh612Ce0V/vNMGqQRDuEy90W2jOtot
         rGQIFYE55AXcrYQ0k6sQB9d66GwoRsXvAy9AZ0m2+/HeP1LHn51e8Oh7sCw1cTWQDmQy
         PD1yrzli2wYn4w0wPU5Iig6aE4dNN8FMZpmySpS9VD0e5eLRJNK/S0GsvRaEUUAt5UCI
         zCuUP0whVVPiJEUqS9Ej7fRYWyGgkRVfnfvScKlduw03uQXrKsg7NVJtBRsSoPXv2MSS
         QAUGowhdTvV5BifQEGer1KDd2xU/R6kxLnn13OSqP7W4VxBvXY6DjEJIJbh3Jm2In9th
         q3qQ==
X-Gm-Message-State: AHQUAubpQVXYNqg2h4E9C09bapCFLfqArGx4foRjJPA/WllCUIFt3Jvi
        w1aLJZ4Hqo1cbL9YtanZKBMX/Q==
X-Google-Smtp-Source: AHgI3Ial8oVjPN1xJxKPD1lYjmTHp+Rry0q64GjWA5RxfLHwSSFgbQVecHof0Ux6R7veiWA543UQ6g==
X-Received: by 2002:a63:2882:: with SMTP id o124mr1958599pgo.446.1549948138210;
        Mon, 11 Feb 2019 21:08:58 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id g14sm23852703pfg.27.2019.02.11.21.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 21:08:57 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:38:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190212050854.p6av2y2iich24wnv@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
 <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
 <20190211095527.5brreiqppn7kk3yt@vireshk-i7>
 <f9f54181-f7bc-6add-2c06-2ed3d6410d01@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f54181-f7bc-6add-2c06-2ed3d6410d01@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-19, 13:22, Marek Szyprowski wrote:
> Hi Viresh,
> 
> On 2019-02-11 10:55, Viresh Kumar wrote:
> > On 11-02-19, 10:52, Marek Szyprowski wrote:
> >> On 2019-02-11 09:44, Viresh Kumar wrote:
> >>> On 07-02-19, 13:22, Marek Szyprowski wrote:
> >>>> Dear All,
> >>>>
> >>>> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> >>>> i2c adapters") added a visible warning for an attempt to do i2c transfer
> >>>> over a suspended i2c bus. This revealed a long standing issue in the
> >>>> cpufreq-dt driver, which gives a following warning during system
> >>>> suspend/resume cycle:
> >>> Marek,
> >>>
> >>> I have sent a patchset which is not directly related to the problem
> >>> you are facing, but it may solve your problem as a side effect. Can
> >>> you please see if that works to solve this issue as well ?
> >>>
> >>> https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u
> >> Thanks for the patch. It indeed solves the problem of the i2c transfer
> >> in cpu hotplug procedure during system resume, although my resources
> >> management rewrite is still valid as a way to fix remaining 'todos' in
> >> the cpufreq-dt driver.
> > Which remaining todos are you talking about ? Sorry I am not able to
> > recall :(
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/cpufreq-dt.c#n347

Ah, okay. Thanks for the pointer.

Ideally we shouldn't be doing anything in probe, like
resources_available(), but we are forced to do it as
subsys_interface_register() doesn't return the errors returned from
cpufreq_add_dev() currently. I tried to fix it once but there were
some complications I believe and then left it.

The main problem is that if cpufreq_online() doesn't find the required
resources and returns -EPROBE_DEFER, it never comes back to the
probe() routine which registers the cpufreq driver. And so we have to
add the duplicate checks in probe() itself before it registers the
cpufreq driver.

Now all we need to do there is to guarantee that the resources are
available when the cpufreq driver registers and so we do it only for
CPU0 currently. Logically speaking, if the resources are available for
CPU0, it will normally be available for any other CPU as well and so
there never was a requirement to test it for other CPUs. And so I left
a FIXME there, so that we know what's going on there in case a
platform comes up for which it doesn't work.

I won't fix it with something like what this patch series tried to do,
rather I would try to make sure that EPROBE_DEFER gets returned from
cpufreq_driver_register() instead.

Thanks.

-- 
viresh
