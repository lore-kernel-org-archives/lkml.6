Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0251C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68688206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFhbXTxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfANX5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:57:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38268 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfANX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:57:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so381785plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=9rTKQ3Op5x/Q6XuwXQNV5aTmauYT7L1RdJdlRcyl7jY=;
        b=eFhbXTxt3zA2Yzrh4bVbfcCcpNrXYDVB1Qv5BQkJjd9xKS5soCIZg4A/Egcg6fbcq7
         svYYo7YjcO5QXiIqPXQOU2cf2FTzJiGJ+r2HqrIKZcGzN8/k6PmHBS7lv8OLbJep+xxA
         hKRW9P41pd8s8jSDfcGid8a6iubdb0xRPVIY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=9rTKQ3Op5x/Q6XuwXQNV5aTmauYT7L1RdJdlRcyl7jY=;
        b=orGaMHXK/P4WSoCWllbkFZCWjv4QY/3/HvdRlVwjE6D57uTZCjFMI2EbJJwkD28wgt
         yRphtfNrP2SzDKXzvzIx2UpysUOq8BgYF5LwwjvQKWsNmopsFyv0ry5Mw/g7PowbtD5O
         7mlbs2Yma73lT32tdidEoXdX+Ny5TztJy/XZiLmemQBG15kjezMKhOQeMd48WPXZfTx3
         1F7V+Clyy0rs8kcitF2pa9fgFzaUpJzB8xiGQJc8Uc7U/RQWClT8FBmL6nW7nMgFH5N8
         G4tgu4FKRn4I8U9oksi1JfTGeMmGAfJARLGxtm4+t7CXsrUaiJljr2uNL+4hvRxFFmY1
         KmTQ==
X-Gm-Message-State: AJcUukd/msLdMiO7pQgHRj/U9TNdddkHhedEMd0fDFW/Ifpy1z/N/gXK
        3k24z7dykorRY87LkwjEbIFZxA==
X-Google-Smtp-Source: ALg8bN4iel7BI9W46QwRpkVzfnAYIpbaJYyTWibaJJ5DDEwbjjJBBuW7R1mpG3eYMEsNvudxvw56Kg==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr1075005pld.337.1547510273652;
        Mon, 14 Jan 2019 15:57:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n7sm2369306pff.36.2019.01.14.15.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:57:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
User-Agent: alot/0.8
In-Reply-To: <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Message-ID: <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 15:57:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:06)
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
>  include/linux/cpufreq.h   |  6 ++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6f23ebb395f1..7faebfc61e60 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -30,6 +30,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
>  #include <trace/events/power.h>
> +#include <linux/cpu_cooling.h>

Maybe this is supposed to be ordered alphabetically? If so, this should
be much higher.

> =20
>  static LIST_HEAD(cpufreq_policy_list);
> =20
> @@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
> =20
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               struct thermal_cooling_device **cdev =3D &policy->cooldev;
> +
> +               *cdev =3D of_cpufreq_cooling_register(policy);
> +       }

This seems to be some complicated way of writing:

		policy->cooldev =3D of_cpufreq_cooling_register(policy);

?

> +
>         pr_debug("initialization complete\n");
> =20
>         return 0;
> @@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
>         if (has_target())
>                 cpufreq_exit_governor(policy);
> =20
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               struct thermal_cooling_device **cdev =3D &policy->cooldev;
> +
> +               cpufreq_cooling_unregister(*cdev);

Similar? I'm confused!

