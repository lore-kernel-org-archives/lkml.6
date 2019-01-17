Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F3520859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547720071;
	bh=ypD34mnU0pj/tTowqVMZbklVvRZwlhOP8wlDGp+CMzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1ir97/23BjtzSqlTgbTBF7DdRTz9c/ILkjLZeLcx4V1xrtA+S3jYYGlQeWwGGJBPR
	 D23zIU+fFrji6f9u2aZxp0jbdDUQ5BkuTlf6fGrL+JzF3dJOpQfYCs0I0bEe1YnPyf
	 dldlt7tZQg8xhQJH2KcXeRmKqH4peLTjPUiQnNeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfAQKO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:14:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43474 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAQKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:14:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so10589683otr.10;
        Thu, 17 Jan 2019 02:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9h0YwkfxQwlaGw8Qv9w2vEklaH/txDnyG6QeSQpnQk=;
        b=PvKcAxc5FrM9RrVuovv7OjjxkaibZz/MWuu692x8dxK/ydzA1Qv4GLSk8Ol/lftZwK
         jiFDY13ioehoyz02hiTIe+fXGbb72sBdSm/I7bQbL9KrMAWUX5CRBAWqZESM0nKmdpVB
         PdOErqTEtYf+yQ1SNZHmvZvbDHY8gMJH5skaf8ZWx6rLDBgDNC3cG9LAogVEglJLFdDj
         cHLinIpkMgW2I4OlXLB0QI7SQ7b06uX3JKJoaqObJtpcoYIjIF3D+mvQ9Y3X12n7XTHg
         rjfaKWd5pAjjQUi8HMb3CAW+5nK8WpVoT/K4Pza83FH57MRt+emOZoAVdqs+VDk6jshB
         V2Hw==
X-Gm-Message-State: AJcUukcl4/zdOP3yKjBnSVzKHx3NqzGt/JuBvaB2UWuRgSx8boKCxWJA
        G39lUFvNZeE7X/1dKGY4SMZ8ScC711a46EFVYY0=
X-Google-Smtp-Source: ALg8bN6lre7Lb9QdYWyLzF1L1/2W7CyEcSJNBj/GljFrwE2iANjN3EkC7hylf5X4+4O7fjrdTo6ld2ApR48874Ysme8=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr8554395otg.139.1547720067764;
 Thu, 17 Jan 2019 02:14:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7> <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 11:14:16 +0100
Message-ID: <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:08 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-01-19, 22:04, Amit Kucheria wrote:
> > > Add a flag to be used by cpufreq drivers to tell cpufreq core to
> > > auto-register themselves as a thermal cooling device.
> > >
> > > There series converts over all the drivers except arm_big_little.c.
> > > Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> > > others.
> > >
> > > Things needing fixing:
> > >  - Look at how to detect that we're not in IKS mode in arm_big_little's
> > >    .ready callback.
> >
> > is_bL_switching_enabled() lets you know if IKS is enabled or not.
> > Set/clear flag conditionally before the cpufreq-driver is registered,
> > based on the output of is_bL_switching_enabled().
> >
> > >  - The other pending issue is to fix allmodconfig that leaves us with
> > >    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
> > >    references for functions defined in cpu_cooling.c
> >
> > Okay, that's a terrible thing and the solution looks to be rather
> > difficult.
> >
> > For others who may not be aware of the issue here, currently the
> > cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
> > which uses helpers of the thermal core (CONFIG_THERMAL).
> > CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
> > in Kconfigs.
>
> And CONFIG_CPU_THERMAL is defined under "if THERMAL".
>
> > The cpufreq drivers using the cpu_cooling.c file have this in their
> > Kconfig entry:
> >
> > # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> > #       depends on !CPU_THERMAL || THERMAL
> >
> >
> > This series now places the cpufreq core in place of the cpufreq driver
> > and it messes up everything. It is not just about allmodconfig, but
> > any configuration which makes the compilation fail.
> >
> > What are the solutions we have now ?
> >
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
>
> Sorry, but this makes my teeth hurt.
>
> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
>
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
>
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
then, AFAICS.
