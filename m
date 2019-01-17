Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82078C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547719733;
	bh=x4fXoaGM40c4FX+ZsXMzJn4tO2Z34H1SCxptQXKrz0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oc2ujpfNLw+lki01ZeRgpN1PyWA/SsAxAt7iyS4+VmNZxsMPM6RtH/s0V1g1Xvup1
	 2LPgXUR8dBHZ2x+0t+bzaP04uGEDAmUUME9WFGYiGbVzB2r22AcMyDLuNbGZz3xBvF
	 tyddD7Jl/vsXDZy6TLGjZX9OHfJj7vvZjtjRy9Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfAQKIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:08:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36705 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfAQKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:08:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so10618311otk.3;
        Thu, 17 Jan 2019 02:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=438LmxlRqmX1Z8nfxUBP4cpRWlXxVI4hUs/MnRI3eXE=;
        b=hILYTuDS5rEVtKsN9IL2RCaii5MlXE5kZiGLDPERsR4F8PsZXNOE59aynk4/YaeVNr
         gRdmoUmiTeM+wLHY7cfvV7LRRMXAsHPiCdjcJ6aV6oBkfrxwcZcSEe+fTFOpFwnm2P4W
         4LGxNlatf78rMSNTS7DuS2P2/Z+xVx+Hl+ftpkPJNwKwBT8K8IBwAVfGcCP3LwE2PDFC
         1/CZGc3HnNML6MjcfGH/TYM8znVLO033Jd/JowIk5HjqEyClOyydzEdKwz6EqL0N4TfE
         vsnDcOOZrtTF4P6QKIdS35Uv1ypcB4B8cNR/iiJ12OdlW+RjsP8e2oKUO9xVrzd60rni
         5uwg==
X-Gm-Message-State: AJcUukfnKUmpcTsoqUTwtqpDHBQr8T2wMtfjhViKRZWDxP/n+AS732Oj
        q8uOcfBuaDB5SzVyQA4499e/q7Qdo5u0Uf9jvuw=
X-Google-Smtp-Source: ALg8bN59jsC+Qkq1M45eC1FC/FMXbtSfl7Cppi3k8YlECf2lKBzLaHoQWqkGl45qIOSiKVTyxolgk0uclTOJxzMxzE4=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr7890302otq.119.1547719729999;
 Thu, 17 Jan 2019 02:08:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org> <20190117054916.dqduckt7larn32av@vireshk-i7>
In-Reply-To: <20190117054916.dqduckt7larn32av@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 11:08:38 +0100
Message-ID: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
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

On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-01-19, 22:04, Amit Kucheria wrote:
> > Add a flag to be used by cpufreq drivers to tell cpufreq core to
> > auto-register themselves as a thermal cooling device.
> >
> > There series converts over all the drivers except arm_big_little.c.
> > Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> > others.
> >
> > Things needing fixing:
> >  - Look at how to detect that we're not in IKS mode in arm_big_little's
> >    .ready callback.
>
> is_bL_switching_enabled() lets you know if IKS is enabled or not.
> Set/clear flag conditionally before the cpufreq-driver is registered,
> based on the output of is_bL_switching_enabled().
>
> >  - The other pending issue is to fix allmodconfig that leaves us with
> >    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
> >    references for functions defined in cpu_cooling.c
>
> Okay, that's a terrible thing and the solution looks to be rather
> difficult.
>
> For others who may not be aware of the issue here, currently the
> cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
> which uses helpers of the thermal core (CONFIG_THERMAL).
> CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
> in Kconfigs.

And CONFIG_CPU_THERMAL is defined under "if THERMAL".

> The cpufreq drivers using the cpu_cooling.c file have this in their
> Kconfig entry:
>
> # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> #       depends on !CPU_THERMAL || THERMAL
>
>
> This series now places the cpufreq core in place of the cpufreq driver
> and it messes up everything. It is not just about allmodconfig, but
> any configuration which makes the compilation fail.
>
> What are the solutions we have now ?
>
> 1. Have following for CONFIG_CPU_FREQ
>        depends on !CPU_THERMAL || THERMAL

Sorry, but this makes my teeth hurt.

>    The platforms which don't need CPU_THERMAL (like x86) should not
>    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
>
>    @amit: If this gets accepted, please update the Kconfig entries for
>    all those drivers to not have above lines anymore.
>
> - Change CONFIG_THERMAL to bool instead of tristate ?
>
> - Anything else ?

The design in the thermal subsystem seems to be upside-down.
Non-modular code should never be made depend on anything only defined
in a module.

Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?
