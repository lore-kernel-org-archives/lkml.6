Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39963C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7CC22395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfk5lID7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7CC22395
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeHIXy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:54:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41376 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeHIXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:54:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so6704854ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gJL9OMkWpIPjsuM+E8wtsRYuyXN1gY7mlpd+fKbo9xI=;
        b=lfk5lID77jLRmXDQbfNXSy2GaDMWVyNBWWP9+pBYzqUY1SsVTm0o0DL2cqQWk4Tewn
         XALE3VgY0nVkvLPHyOYMt7hgzLr9vGvEglYEh7GOkb8YEiYL8SVCrxorTaJOtbG6duB2
         +L1DMCJQ91AhBo/0R7spZJUYfu/8yrUP48a5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gJL9OMkWpIPjsuM+E8wtsRYuyXN1gY7mlpd+fKbo9xI=;
        b=lCD7pCJBXIqbVo+g0P4ou9mvMOLgb7cHqq5UMW7Lh5ucsKwAQb61v+Gq+HRY9eUVIW
         O4AMSRsNmk0WNMYomuPXZDKIbkpSS3bKZzxOU5uRu+ws6M1HdS2VszjqggPfCXyULpHi
         mxA8evogeiDGtNhP+iXpk5WF96VEHTma5qec26YjlHP0xQbRt7n1beW6cdwCP7FRZ0Zf
         eg+NIOjah0oHjDVVFE3nXD3tF5UiiLmkCfRljv2Y5BYMSQnrIPJqZ6V0dfYhpalMlWp9
         o6gG2u3yM3KGtsfkYbL5crMwZRUOXTHO+dcCO6KumIHOH/a6JZt2hpK68fOQDC67+6Gx
         ocJQ==
X-Gm-Message-State: AOUpUlGo6FXxTxlQtdgnol214Inwngo5WVFmO/d97HTNpluPUXHVfeBl
        M3FGkvjiLG39kzV08UMaoY9EsmZGa7M=
X-Google-Smtp-Source: AA+uWPzqlNmeTSpqd5sVR3E5R3A6Bz7htkK9oCYi/ac72XS4Cw/1fAOXhAwjevznS8MBA8SDW8EwLQ==
X-Received: by 2002:a25:7207:: with SMTP id n7-v6mr2215675ybc.518.1533850096233;
        Thu, 09 Aug 2018 14:28:16 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id d6-v6sm3412133ywa.85.2018.08.09.14.28.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 14:28:14 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id y203-v6so6700638ywd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:28:13 -0700 (PDT)
X-Received: by 2002:a1f:3653:: with SMTP id d80-v6mr2487353vka.79.1533850093215;
 Thu, 09 Aug 2018 14:28:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 14:28:12 -0700 (PDT)
In-Reply-To: <20180731185917.176074-3-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org> <20180731185917.176074-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Aug 2018 14:28:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us-Cp6AEUfbNbAuRwri4y1opiGY6O+HHModserppYdxQ@mail.gmail.com>
Message-ID: <CAD=FV=Us-Cp6AEUfbNbAuRwri4y1opiGY6O+HHModserppYdxQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 31, 2018 at 11:59 AM, Matthias Kaehlcke <mka@chromium.org> wrot=
e:
> There are three thermal stages defined in the PMIC:
>
> stage 1: warning
> stage 2: system should shut down
> stage 3: emergency shut down
>
> By default the PMIC assumes that the OS isn't doing anything and thus
> at stage 2 it does a partial PMIC shutdown and at stage 3 it kills
> all power. When switching between thermal stages the PMIC generates an
> interrupt which is handled by the driver. The partial PMIC shutdown at
> stage 2 can be disabled by software, which allows the OS to initiate a
> shutdown at stage 2 with a thermal zone configured accordingly.
>
> If a critical trip point is configured in the thermal zone the driver
> adjusts the stage 1-3 temperature thresholds to (closely) match the
> critical temperature with a stage 2 threshold (125/130/135/140 =C2=B0C).
> If a suitable match is found the partial shutdown at stage 2 is
> disabled. If for some reason the system doesn't shutdown at stage 2
> the emergency shutdown at stage 3 kicks in.
>
> The partial shutdown at stage 2 remains enabled in these cases:
> - no critical trip point defined
> - the temperature of the critical trip point is < 125=C2=B0C
> - the temperature of the critical trip point is > 140=C2=B0C and no
>   ADC channel is configured (thus the OS is not notified when the critica=
l
>   temperature is reached)
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v6:
> - fixed condition to check if ADC is configured in
>   qpnp_tm_update_critical_trip_temp()
> - changed =C2=B0C in logs to C
> - removed needless evaluation of qpnp_tm_write() return value in
>   qpnp_tm_update_critical_trip_temp()
> - move assignment of chip->initialized to true to qpnp_tm_init(),
>   where the lock is held
> - call thermal_zone_device_update() after initialization is
>   completed
> - split some #define + comment in two lines to avoid exceeding
>   chars per line limit
> - removed extra closing parenthesis in qpnp_tm_get_temp()
> - remove unnecessary parentheses around conditions in
>   qpnp_tm_update_critical_trip_temp() and qpnp_tm_get_critical_trip_temp(=
)
> - fixed indentation of call devm_thermal_zone_of_sensor_register() call
>   in qpnp_tm_probe()
>
> Changes in v5:
> - patch added to the series
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 158 ++++++++++++++++++++++---
>  1 file changed, 140 insertions(+), 18 deletions(-)

I won't claim to have spent too much time in the thermal framework,
but from what I can tell everything looks supergreat now.  FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

One minor comment I'd have is that I personally would have ordered
this in the series before the patch ("dt-bindings: thermal:
qcom-spmi-temp-alarm: Improve thermal zone in example") just because
that patch only really makes sense after this one lands.  ...but I
don't think it's terribly important.


-Doug
