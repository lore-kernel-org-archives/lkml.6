Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B506BC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BD82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdHGICxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfAUJkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:40:10 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44171 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfAUJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:40:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so6686620uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSWR7w0OVZPwACykRLjCu6ZeRa5KERexPDfjFokmknQ=;
        b=gdHGICxXtvHw//Tnc0iUbv6j1DC/hoX7CpSEUlAHcu2ApypfGg766SvCmMHUY7QTpg
         v2zkHh8hIJ2rIjlEIfWg8BjZXvgj2Ih0+7whgdlyBkep9CxHM3JdXy1RkrM1c4jqf7Gq
         0iVHctLpSnVN1DLPG0sfc/NxMoiArDXjxIQZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSWR7w0OVZPwACykRLjCu6ZeRa5KERexPDfjFokmknQ=;
        b=F1KR+oEP8QPU7A6UTOasd+BFL7oScOPonFpjXCE/IhXF7oAvdcl1FXWOi+xN78kwZU
         HvhmOlkVOBdgwyeFg9/B/3ii0kjCjTHmmwIU72+G/2gsFUK8DkzUSNS8EIDNYtdf+40t
         /ga5Eq223zSlzOIK0p0iC4T3pTrycfITh/eUFfmZckMGGstPU6/24kONo8MkvEBMIRkN
         +rptO11gxei5THQbJnnFmdZSQ90eiobpI9aMYdfQdVbUMJ5MjFuQwjRKDWTTACrxjspD
         DXSlAQa7SZAr1vZ7tU/lTLIvsJbLsnT2Zt5vAy8KnXRFAvDZiCu2XSwHaUUNZOYUZnZn
         x2Fw==
X-Gm-Message-State: AJcUukc6SQ4ppW8Xofb+T/OCUhKwwUIxK8piIJKvM0O5vkuuHG6rvOFH
        sEMvKioP8ljABugVvTehPAdtyqV3vMmJq+50nOqvJg==
X-Google-Smtp-Source: ALg8bN7I8NpXSMfH27mFDYxquoyG247br2H0GYyy/oFRssXsjWpQrBvpnLGQsqWOi7Nf+1SKgt2TeJ7wZsssg/OTgrs=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr11473643uap.2.1548063609249;
 Mon, 21 Jan 2019 01:40:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
 <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
In-Reply-To: <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 15:09:58 +0530
Message-ID: <CAHLCerNqZny+KSs-S-+KbpdGjxtB4wafygAY4M7oNc8kvEqT2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device
 node with error
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-14 02:21:04)
> > Make it easier to debug devicetree definition in case of errors.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/of-thermal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > index 4bfdb4a1e47d..08c3ccbdacf8 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
> >
> >         ret = of_property_read_u32(np, "polling-delay-passive", &prop);
> >         if (ret < 0) {
> > -               pr_err("missing polling-delay-passive property\n");
> > +               pr_err("%pOFn: missing polling-delay-passive property\n", np->name);
>
> Not sure you've triggered this code path because it's an error, but I'd
> expect it to just be np, not np->name here. It's too bad the compiler
> can't catch this.

Not sure what happened here in the refactor before sending but good
catch. Fixed now.

Thanks,
Amit
