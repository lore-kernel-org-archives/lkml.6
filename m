Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19BFC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECCD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547721284;
	bh=VwjO+GD3sbIouf/y/EUSOahFLnK0XnAjGSPgCtXGV8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cUQ64vV3nTldXOw7HpzwlYeD2/3AM4wNrZxP1FfSj6xKKb7qjBRiAIWwyW7DexbUj
	 G8mS1Ru+5pbd7LfKehEvxdZWkmnIAmATw1I8jbok31SZZFaxoETJeKHOKhcxJdLYEi
	 nnMgSa0Y/uq3YhAt6JeJi0ZqmzAIo2MvSB6fFae8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfAQKem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:34:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44432 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfAQKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:34:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so5729463oig.11;
        Thu, 17 Jan 2019 02:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/X7I4hChurfKwIsKCyCVX6URaTM3HKeWIQA34lQpPM=;
        b=S6RSvCIS7NAcTsPZMyTJwvEa/2Md+OSFzZJVvsdZuJe4wUC0s3oFGGfiXC6IGvkBMx
         1Y3WxdB0fuoyjmFRZpMZDtlZevZ+qLRd8BtEwEwd2HWu4L5efPkchb+iMmzRTAVR9ZWy
         3z7fgBNdsuNlYPjkrGPQRm/GH6J418zMhrjC3VKSaKf7crgGK90crmpwiq/tFsLOmBwS
         oHDEk4dyNrcGsZgMhjDB/U1Wg/Ma/uMjcz+8cltLZvezu21Cs4EUaixUV2sw2nOq52Ml
         1uHmgEliOlq4BHzKHQw3kk245mqBRYJrmsQjZZ+d4zwshUmk5KZKTQCs4C+wILGhTPIj
         XfZw==
X-Gm-Message-State: AJcUukc8Z3J+8vgRBcIy/+NfyiQWEHXC8DHR2EsUmnqx9GMeCpddSrSn
        V4+j0g93LBR2oObXHWbwO5sh2OwNUh21UmaqQ38=
X-Google-Smtp-Source: ALg8bN7WAkw6Kn9SGnvjNQDG+OpULKePVCwEl0YEIs3ZMD4R0QG520LJ2j0EP8HdxitZ9m6vKc8gKVi+hIjTc1C6ojI=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr7576108oia.95.1547721280038;
 Thu, 17 Jan 2019 02:34:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
 <20190117055730.7hxe37ngcubo6htw@vireshk-i7>
In-Reply-To: <20190117055730.7hxe37ngcubo6htw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 11:34:28 +0100
Message-ID: <CAJZ5v0j2-RPckRigk+gjo4ffiB+04VE_v6Dnw90E-Q7X2knpvA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        bjorn.andersson@linaro.org, Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 6:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-01-19, 15:51, Amit Kucheria wrote:
> > Make it clear that it is a failure if the cpufreq driver was unable to
> > register as a cooling device. Makes it easier to find in logs and
> > grepping for words like fail, err, warn.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index dfd23245f778..6fff16113628 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
> >
> >               cdev = __cpufreq_cooling_register(np, policy, capacitance);
> >               if (IS_ERR(cdev)) {
> > -                     pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
> > +                     pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
> >                              policy->cpu, PTR_ERR(cdev));
> >                       cdev = NULL;
> >               }
>
> Always keep such cleanup patches at the top, so the maintainers can
> pick them up easily even if the entire series doesn't get in.

Actually, if nothing in the series depends on this change and this
change doesn't depend on anything in the series, why is it part of the
series at all?
