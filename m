Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ED020657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwVgPhPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfANXyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:54:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39018 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfANXyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:54:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so373197pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=2inEx6PBVZDRPvhu1qW3je2zJJyQ7ROpIDDNj32fzS0=;
        b=mwVgPhPvAiZvRRMu4sCdk/fR55EY3x98X13/Hw5ksbz9F3IMv0tpP70dgJMavgbiC+
         xtazdlJAg68SbrWakgFFwNy/9v0FcOj9ecOM5WLRHubjeAZZm2fKf8L0xJntsSzT4Rkb
         iT7W+vqsHXlQFhyFuI0ToqUti7ciGHfNYhOAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=2inEx6PBVZDRPvhu1qW3je2zJJyQ7ROpIDDNj32fzS0=;
        b=ZEVX9l5z9wA9/0lNgiYu+8pMCcMhKTXb5J0QQIXApkpCQ49dfQ+OV9weIxtuKOc8WR
         TkYAlcHlYwkm0aw+TczyRBykj6jsttomXqJcVo0IuS3ZbASFV+qqCZEnnWxTPEfJMpv7
         Te21aU9qs1pO1NhEmvBu+7qCtG0JhmssDK3nyatd9q8bcYnZwVn6W8fhwENKGIb9WBo2
         mpcucNPC/DyS8IJ3NBkXi8Q/DcB81FjkGqbmXZ8Ng/ol/IA+v84mSd3/55/XamLFpcG5
         00d4ITRYCLri9dB3liShzXuRL7mW3GjzONSmS+nMZP8jolK3JOgHkUejiz0VvaoAgrC3
         nCGw==
X-Gm-Message-State: AJcUukdJAAL10kCUWYoo7MjYS1d9ceNu2tvoetJwy6O/6YZyySHNkObB
        xrq0NA8M9+NFWZDigdLPj/IKWQ==
X-Google-Smtp-Source: ALg8bN4GjP/qA89SbXY5An0q+t0uYOmTyatjDQACGPAigA+sQHSekSR5MLfcuAsGCwQf6YRrZsHkxA==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr1089289plp.336.1547510074575;
        Mon, 14 Jan 2019 15:54:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y71sm2368143pfi.123.2019.01.14.15.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:54:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device node with error
User-Agent: alot/0.8
In-Reply-To: <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Message-ID: <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 15:54:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:04)
> Make it easier to debug devicetree definition in case of errors.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 4bfdb4a1e47d..08c3ccbdacf8 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device=
_node *np)
> =20
>         ret =3D of_property_read_u32(np, "polling-delay-passive", &prop);
>         if (ret < 0) {
> -               pr_err("missing polling-delay-passive property\n");
> +               pr_err("%pOFn: missing polling-delay-passive property\n",=
 np->name);

Not sure you've triggered this code path because it's an error, but I'd
expect it to just be np, not np->name here. It's too bad the compiler
can't catch this.

