Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFDC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp3mWAxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFDC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJZEiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:38:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44452 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeJZEiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:38:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id b22-v6so2396559qtr.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mizI89neMF+oOT95qJ3dMnMvsUc3iuyqz4sLb2OW93s=;
        b=Pp3mWAxcHmohG6hCAJJY/sUeKEiNyUKw9If6BQrJexiI35X6Cl6f3I1CYRXVwCzfSW
         J5HJxYN20rhOj83384PgrgLUiEIhqUUXDAQMn8sSFSjYDEWHd7+967z+sTbFZwdxzHqZ
         gWxSIgMsPsbQ3wUU18TnBFoKWoUvbiS85sGC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mizI89neMF+oOT95qJ3dMnMvsUc3iuyqz4sLb2OW93s=;
        b=W9ZH3HD8+EEqRzOEX3oujp2UIqVHWlSJ99xmC9nDOWfobHny6xf4fjLlTsGqEYFgh9
         O0SEJtRs13jZb0wPU61T6Tj10XMWukpoCQDvgIjHVPGtni34rNwDDh9JHAolsrErjRVS
         pm2VAWvlbP0fwc87igkYYv3C6/Y+iJX87S1uzgHpgG7ZzHyONvN9FBtlibcfASOSVSK5
         OkG5Aq4sMSMWiOMR2mCHZwk+G3kc0tqXqp8MA39SgcOQglEOxo1uAO/rjy09uYy4kF5z
         SIm6AcfDg2A8UzogQCoB6tWzmwcyLzJleZiLqbJFUmJqyt55Ev1+f6kojdyR7QMvl4pG
         4gaA==
X-Gm-Message-State: AGRZ1gIs/csnXak8ZYTUne/4EC7dledVmUFp5g4MM1u/s5kx3gyxA+J+
        tXlkQ3Fr4qMzjuB1ognM/m1+el+XKXwUTlixKGy2FA==
X-Google-Smtp-Source: AJdET5cXr0mNgK6YdJ8/hky0urcJfB6xSG5ggLAEYgERWdwhO3R3yMRU9RC+6lcTXD+g84XRr3qut6XUgmj4RKMQ7rU=
X-Received: by 2002:ac8:c0b:: with SMTP id k11-v6mr638264qti.31.1540497831919;
 Thu, 25 Oct 2018 13:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
 <20181025192501.GZ22824@google.com>
In-Reply-To: <20181025192501.GZ22824@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Oct 2018 01:33:40 +0530
Message-ID: <CAP245DUFi1UWqnVfgxdeZHVHSx9Sn3z3AqVp_x5GGHHAvwAjyA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] arm64: dts: sdm845: enable tsens thermal zones
To:     mka@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Amit,
>
> vaguely related question, since you are working on SDM845 thermal
> stuff: Do you have plans to add CPU cooling devices? I raised the
> point during the review of the CPUfreq HW, however there was no
> clear answer: https://lore.kernel.org/patchwork/patch/966833/#1164748
> The driver is still under development/review, but I wonder what the
> path forward is.
>

Hi Matthias,

I plan to but the OSM driver doesn't work well enough for me to send
out that patch yet. I responded with my findings on the v9 posting
where it seems to get stuck at the high OPP. It'd be nice if somebody
else could confirm (or refute) this behaviour.

Regards,
Amit
