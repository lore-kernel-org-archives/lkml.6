Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQdtf5gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfANWgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:36:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33424 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:36:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so301442pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=FBtGMQQzwkDx7S78ZdCeNlaWOotQ5KuuYCpl9n/rBes=;
        b=oQdtf5gyLkoxaw0wDA6ahRirwi1opkYD10vjK6poRtMWfz3l2r2/8NdipEJKygCc/L
         IaRp94/X0mmdbrnn7GMdwdXzRsNTYxBlxZ5dncfcOh0heEe6JDnDaGJ0EZoVuNrd3U1r
         LTGqfEf4htcyUyDim44VZk8WeaQO6BAwRCNwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=FBtGMQQzwkDx7S78ZdCeNlaWOotQ5KuuYCpl9n/rBes=;
        b=RaqNoKz6Vr/y/myFZlSsoCUPSOU24U/L1xn07QVIAuvQhdRzOOnYs+2MO7lXxnf5Ex
         GRiyKyhEgvPnEWufu6HWtOrOYsGEaPPneuDfNZvrl0u4AMVKA8p4lWdZlWaP9VYt51n+
         YHBKB5BQwNb79moOo0BoCsdt60BQ66s5SXItEv1msPDLztJwLgBsolROfi3rnZszc/ca
         ek5Q4ng25e8OAPtcGlJOrWjv8ZQHqzxV+UnWudBcb7Girc2R0w4Cr5djryj7IM5PVW2S
         wGoglDo5H14Ra+TBu4GLiCDySQ+/C5Aqt7109IVJwpYv9HfoX61DV4toXUx2eZPqvJIb
         i22g==
X-Gm-Message-State: AJcUukd4Wg3jBaCy+1JVhgLR6+7Ag+w/EEVY4FM76sEdqaQmktC7V7oE
        7kXz/tvwrM8wkXUZ17tdkFn7JA==
X-Google-Smtp-Source: ALg8bN4Syh1uQWTUUAlc34Q9FFOUevb5rd3n3iFvH8GMKEsKwS8jyP6agXchdvaHbTlbQRpH2ObUBg==
X-Received: by 2002:a63:7154:: with SMTP id b20mr765022pgn.342.1547505404160;
        Mon, 14 Jan 2019 14:36:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h8sm1453444pgv.27.2019.01.14.14.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:36:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] soc: qcom: Add AOSS QMP communication driver
User-Agent: alot/0.8
In-Reply-To: <20190106080915.4493-3-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org> <20190106080915.4493-3-bjorn.andersson@linaro.org>
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
Message-ID: <154750540229.169631.4962369801600780946@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 14:36:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-06 00:09:10)
> diff --git a/drivers/soc/qcom/aoss-qmp.c b/drivers/soc/qcom/aoss-qmp.c
> new file mode 100644
> index 000000000000..de52703b96b6
> --- /dev/null
> +++ b/drivers/soc/qcom/aoss-qmp.c
> @@ -0,0 +1,313 @@
[...]
> +
> +static int qmp_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct qmp *qmp;
> +       int irq;
> +       int ret;
> +
> +       qmp =3D devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
> +       if (!qmp)
> +               return -ENOMEM;
> +
> +       qmp->dev =3D &pdev->dev;
> +       init_waitqueue_head(&qmp->event);
> +       mutex_init(&qmp->tx_lock);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       qmp->msgram =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(qmp->msgram))
> +               return PTR_ERR(qmp->msgram);
> +
> +       qmp->mbox_client.dev =3D &pdev->dev;
> +       qmp->mbox_client.knows_txdone =3D true;
> +       qmp->mbox_chan =3D mbox_request_channel(&qmp->mbox_client, 0);
> +       if (IS_ERR(qmp->mbox_chan)) {
> +               dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
> +               return PTR_ERR(qmp->mbox_chan);
> +       }
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       ret =3D devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
> +                              "aoss-qmp", qmp);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to request interrupt\n");

Don't we need to free_mbox_channel() all over the place here?

> +               return ret;
> +       }
> +
> +       ret =3D qmp_open(qmp);
> +       if (ret < 0)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, qmp);
> +
> +       if (of_property_read_bool(pdev->dev.of_node, "#power-domain-cells=
")) {
> +               qmp->pd_pdev =3D platform_device_register_data(&pdev->dev,
> +                                                            "aoss_qmp_pd=
",
> +                                                            PLATFORM_DEV=
ID_NONE,
> +                                                            NULL, 0);
> +               if (IS_ERR(qmp->pd_pdev))
> +                       dev_err(&pdev->dev, "failed to register AOSS PD\n=
");
> +       }
> +
> +       return 0;
> +}
[...]
> diff --git a/include/linux/soc/qcom/aoss-qmp.h b/include/linux/soc/qcom/a=
oss-qmp.h
> new file mode 100644
> index 000000000000..32ccaa091a9f
> --- /dev/null
> +++ b/include/linux/soc/qcom/aoss-qmp.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, Linaro Ltd
> + */
> +#ifndef __AOP_QMP_H__
> +#define __AOP_QMP_H__

include <linux/types.h> for size_t usage?

> +
> +struct qmp;
> +
> +int qmp_send(struct qmp *qmp, const void *data, size_t len);
> +
