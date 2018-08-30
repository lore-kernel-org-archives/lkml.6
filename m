Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F73C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4322073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/kdHnSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4322073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeH3JZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:25:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45724 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3JZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:25:51 -0400
Received: by mail-qt0-f194.google.com with SMTP id g44-v6so8453808qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 22:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3CScztbtZ/psEk7sEi67MYjZ5h13KfG6E/erELe5b0=;
        b=U/kdHnSU3YMAgTz+qFImSxOZzvKH3VsdMJPVNTkOEGJIzb4F03dY20ztVzu6vkS9nX
         GxR+RM53Q9ulOFABIeEH2r8hVPdY3Ws/83TA62aR72eAcWgvhHAfU94iarvlj/GwYeh5
         cXcpSsWob4b5Scwh452dv2yau3Dodz04tGcVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3CScztbtZ/psEk7sEi67MYjZ5h13KfG6E/erELe5b0=;
        b=feeDOHML72+YIQNJ5sMSrD4/V799VW88ByeI5Q7mY7WEZD8zOV8f6uo3Gx+fsD355W
         dw7Ts/EA5T1OUOUDxhwZTN2EPKkUxmH+e8Roo6JlSK6ktyzUYeWJFCcOrzRG+uc9xZ5F
         XQDBRJ9v2SC9Csw/P5WGYKfCAj9vOz/tc4MxcpXcgktrSCd35khv1R98xWDh15XCNatj
         8nd1jBP0GHryuITmCEfw0xIVUK6AhUvOQ3SwvY/aY1bkpmqaeNOGfVx0PzMOhtPt5n3q
         zFg4PoQazawwZuocv+Jzrzm1gevHNAFBlBJGD2WTN/mnh9YQzNREkyUgK4D7tfp7ws9+
         h1QQ==
X-Gm-Message-State: APzg51DQPX5j9eBmBxqxzDrUF46Tb84fpjF/6Yr5PFdWg2VV5yCOkyV7
        AGIfECSc55gQ8g/kV42CzV/U6YOmg3RlkbH/y5bZ1Q==
X-Google-Smtp-Source: ANB0VdYqvR1hF0kiZe0Heyq6UTrj9weqk88IekRpBCd2NY9EwV10F0Y0BGN8Hu4A/6ye4aJn21BlWtCOzUcP2YyMnIE=
X-Received: by 2002:ac8:2f24:: with SMTP id j33-v6mr9816308qta.93.1535606728249;
 Wed, 29 Aug 2018 22:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
 <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
In-Reply-To: <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 30 Aug 2018 10:55:17 +0530
Message-ID: <CAP245DX7tBdOBfB-gZ8+MvdF3bsnNVWys4bjaDf0zObWJV38+Q@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Eduardo Valentin <edubezval@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 3:09 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 18/07/2018 09:49, Amit Kucheria wrote:
> > One thermal zone per cpu is defined
>
> The thermal zones are very close, especially when the CPUs belong to the
> same 'cluster'. Very likely the temperature will propagate from one core
> to another core, so when one core reaches the trip0, there is good
> chance the other cores will be close and cross the trip0 threshold too.

Agreed. Once we have all the thermal and cpufreq bits in place, I'd
like to examine optimisations such as a virtual sensor, using the
coefficients to add weights, etc.

> Having multiple thermal zones, one per CPU, may trigger an interrupts
> storm with the passive polling timer delay.

I'm working on irq support for tsens that should alleviate that.

> Does this board have a cooling device per CPU also ?

As Matthias mentioned, DVFS is per cluster (4 cpus to a cluster).
