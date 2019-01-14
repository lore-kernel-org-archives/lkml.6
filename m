Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF063C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8TH0YP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfANWk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:40:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:40:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so287853pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=WLM5dNyoTozbSd88yUgecKq6QyU7aVPi4GfRYy8UReI=;
        b=h8TH0YP7JGX2HERs2Xbopr3IY+BaCgskhvbbnmskeHAayxvDvHycazUMlkBSvpLUUi
         Gccje91dblSoB+9bqGaSTgSGPF0G8ADg46rSdjznDntLdy/c6xAl97+oOZpA1b4B2LPC
         sTnOI8QeKZeMtfE0BhXygtDJ62lsmomLd2mhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=WLM5dNyoTozbSd88yUgecKq6QyU7aVPi4GfRYy8UReI=;
        b=SiDj7K0sohAP2g3C3IAiUkX+RY/3QqAdT+wE7f/tYKJbKD1HBWHk1BemCvWaKPF+17
         NMvLLge3zj3ussyjnWdR4b2Mu6f1qh520aomzpxS7HCl9R6oLsMw2fFZy93guYn0QOmh
         k9PS6THOeOaAAxOQ/MrbYtXCPCubakMZojFjGMVDfLkuQz1lQlZWpP2y1CzejEvtPd8D
         taMC6ynlQoaYinBFlc+2/evEFRJhFW7c0E9XfPQi5SK6648jtvShjnMrsTmZdQVMAbPI
         I46GmmltmnnWemSGk5IxuOkhzRpPZjKovh/J69AzHk20tURWF+RGH6WiNniI2R9U7H9i
         +apQ==
X-Gm-Message-State: AJcUuke253lGqeMa9ZehXKm0qvED5sCzUI1SzpWnOnX7bvsdpzB1z02U
        4lr7F9evFUW4cI4lU+usNlCz/Shry66HNA==
X-Google-Smtp-Source: ALg8bN4JtA78uSzTBd+UQ+u6Hg8nkOyULo8MaGvvgNBBbaVhNeGE7jStT909BOVz02+KhNvO0WuWIA==
X-Received: by 2002:a62:6408:: with SMTP id y8mr767786pfb.202.1547505655487;
        Mon, 14 Jan 2019 14:40:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e123sm1468751pgc.58.2019.01.14.14.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:40:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] soc: qcom: Add AOSS QMP genpd provider
User-Agent: alot/0.8
In-Reply-To: <20190106080915.4493-4-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org> <20190106080915.4493-4-bjorn.andersson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154750565372.169631.9416138415370937156@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 14:40:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-06 00:09:11)
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index dda19471057f..d81256ef5055 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -12,6 +12,15 @@ config QCOM_AOSS_QMP
>           micro-controller in the AOSS, using QMP, to control certain res=
ource
>           that are not exposed through RPMh.
> =20
> +config QCOM_AOSS_QMP_PD
> +       tristate "Qualcomm AOSS Messaging Power Domain driver"
> +       depends on QCOM_AOSS_QMP
> +       select PM_GENERIC_DOMAINS
> +       help
> +         This driver provides the means of controlling the AOSSs handlin=
g of

Is that possesive? AOSS's?

> +         low-power state for resources related to the remoteproc subsyst=
ems as
> +         well as controlling the debug clocks.
> +
>  config QCOM_COMMAND_DB
>         bool "Qualcomm Command DB"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/aoss-qmp-pd.c b/drivers/soc/qcom/aoss-qmp-p=
d.c
> new file mode 100644
> index 000000000000..62b8fcb9d09e
> --- /dev/null
> +++ b/drivers/soc/qcom/aoss-qmp-pd.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Ltd
> + */
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/soc/qcom/aoss-qmp.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
> +
> +struct qmp_pd {
> +       struct qmp *qmp;
> +
> +       struct generic_pm_domain pd;
> +
> +       const char *name;
> +};
> +
> +#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
> +
> +struct qmp_pd_resource {
> +       const char *name;
> +       int (*on)(struct generic_pm_domain *domain);
> +       int (*off)(struct generic_pm_domain *domain);
> +};
> +
> +static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
> +{
> +       char buf[96];

Is 96 calculated from somewhere? Can it be a define because it's quite
magical.

