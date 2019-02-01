Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB25A218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m77P1M9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfBAXgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:36:54 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38126 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:36:53 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so2773359uaa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiPYWM3oI1ipdDjewvUIT7RwPnfKO62LKog/wvcjUeM=;
        b=m77P1M9ZJmYni63AYpRArzE1wWTPbjVarBeHeWmxjTHLqIAtO2aOYheSnH1EXzjm0x
         wBnj+ap/mPwfZDSA3Mk4tGmQv+5WU+kPqEe8y5C6c+DtRtADcB6zzyorrCEEY8hs/CMx
         w9DGxlZnFNVRcINM9kTR0Dpe0aOsC7r3VoS6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiPYWM3oI1ipdDjewvUIT7RwPnfKO62LKog/wvcjUeM=;
        b=U7tdmKyE1UagSUsLxclDxRM3F8EsIJK33nlbmF9MdWnsVr9EFVKeyfTCHp8Yt4ML3z
         IqSWxiurdHJG8sHuHQ/By69eQjxteBA2Yj/ttJ17Fob2/3PO6h9Ga0xjsC3a4XmnqO1F
         rvSFsSGBMBACNoSY7kgq+TCO8qFW2d7Qe7l1dT1Rfkavcjm/LL6UUWxK7UWZYILhzRTf
         vrhiBZhvVTIfT/wvhqOVg15j6IGcsuUhmCLym92ia9pQ9HZNj9RaXx4Y8r8GIs2CR4Zw
         Vgc3o+gCVGuKg7MGQysm0jnMa6dDAdq5mqLCqGE7Omy1bCKcBizJemdw/x1X5ime+tIH
         qcgg==
X-Gm-Message-State: AJcUukcPusARnaC1lRklEuMR2eSxfrPGEcMufgE/z/nHHRotp02cqaK3
        Gp+zt2jRP1Oy18Bz+MSWrbBsBllfmHU=
X-Google-Smtp-Source: ALg8bN5PoxsZt6vtuLPiRwgJn5i4jeBE0wSCLxzAC2MvusGFxUDF6ryxTJxgZfN/8nM5aJWq9g6fZg==
X-Received: by 2002:ab0:645:: with SMTP id f63mr16650735uaf.106.1549064212043;
        Fri, 01 Feb 2019 15:36:52 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id l10sm10535508vkl.54.2019.02.01.15.36.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 15:36:51 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id h128so1975692vkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:36:50 -0800 (PST)
X-Received: by 2002:a1f:1e09:: with SMTP id e9mr17634063vke.18.1549064210320;
 Fri, 01 Feb 2019 15:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20190131003933.11436-1-bjorn.andersson@linaro.org> <20190131003933.11436-6-bjorn.andersson@linaro.org>
In-Reply-To: <20190131003933.11436-6-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Feb 2019 15:36:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U617Q6RFPnJaRoNEf=hr1ag9qqon2M-msbQD483tmicg@mail.gmail.com>
Message-ID: <CAD=FV=U617Q6RFPnJaRoNEf=hr1ag9qqon2M-msbQD483tmicg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] soc: qcom: Add AOSS QMP communication driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 30, 2019 at 4:40 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> +++ b/drivers/soc/qcom/aoss-qmp.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Ltd
> + */
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/aoss-qmp.h>
> +
> +#define QMP_DESC_MAGIC                 0x0
> +#define QMP_DESC_VERSION               0x4
> +#define QMP_DESC_FEATURES              0x8
> +
> +#define QMP_DESC_UCORE_LINK_STATE      0xc
> +#define QMP_DESC_UCORE_LINK_STATE_ACK  0x10
> +#define QMP_DESC_UCORE_CH_STATE                0x14
> +#define QMP_DESC_UCORE_CH_STATE_ACK    0x18
> +#define QMP_DESC_UCORE_MBOX_SIZE       0x1c
> +#define QMP_DESC_UCORE_MBOX_OFFSET     0x20
> +
> +#define QMP_DESC_MCORE_LINK_STATE      0x24
> +#define QMP_DESC_MCORE_LINK_STATE_ACK  0x28
> +#define QMP_DESC_MCORE_CH_STATE                0x2c
> +#define QMP_DESC_MCORE_CH_STATE_ACK    0x30
> +#define QMP_DESC_MCORE_MBOX_SIZE       0x34
> +#define QMP_DESC_MCORE_MBOX_OFFSET     0x38

I sure wish something in this file told me what a mcore and a ucore
were.  The only thing I can think of is that an "m" core is two "u"
cores flipped upside down and placed really close to each other.
...if we had 6 upside down "u" cores we'd have an "mmm" core.  Mmm,
core.


> +static int qmp_open(struct qmp *qmp)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = wait_event_timeout(qmp->event, qmp_magic_valid(qmp), HZ);

I'm a totally noob here, but I'm curious: what kicks this event?  Do
we just assume that an IRQ is pending already when the probe()
function is called?  Maybe you could add a comment?

...or maybe you never actually get an IRQ here and just rely on the
magic value being right at boot in which case we should just check
qmp_magic_valid()

...or maybe you never actually get an IRQ here and this is equivalent
to msleep(1000) followed by a check of qmp_magic_valid()?


> +       if (!ret) {
> +               dev_err(qmp->dev, "QMP magic doesn't match\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       val = readl(qmp->msgram + QMP_DESC_VERSION);
> +       if (val != QMP_VERSION) {
> +               dev_err(qmp->dev, "unsupported QMP version %d\n", val);
> +               return -EINVAL;
> +       }
> +
> +       qmp->offset = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_OFFSET);
> +       qmp->size = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_SIZE);
> +       if (!qmp->size) {
> +               dev_err(qmp->dev, "invalid mailbox size 0x%zx\n", qmp->size);

nitty nit: Can you do "%#zx" to avoid the need for the 0x?


> +               return -EINVAL;
> +       }
> +
> +       /* Ack remote core's link state */
> +       val = readl(qmp->msgram + QMP_DESC_UCORE_LINK_STATE);
> +       writel(val, qmp->msgram + QMP_DESC_UCORE_LINK_STATE_ACK);
> +
> +       /* Set local core's link state to up */
> +       writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
> +
> +       qmp_kick(qmp);
> +
> +       ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp), HZ);
> +       if (!ret) {
> +               dev_err(qmp->dev, "ucore didn't ack link\n");
> +               goto timeout_close_link;
> +       }
> +
> +       writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
> +
> +       ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp), HZ);

Again maybe a noob question, but what kicks the interrupt here?  Is
the other side looping waiting to see us write "QMP_STATE_UP" into
"QMP_DESC_MCORE_CH_STATE" and then it sends us another interrupt?
...or are we just getting lucky that the condition is right to begin
with?


> +       if (!ret) {
> +               dev_err(qmp->dev, "ucore didn't open channel\n");
> +               goto timeout_close_channel;
> +       }
> +
> +       /* Ack remote core's channel state */
> +       val = readl(qmp->msgram + QMP_DESC_UCORE_CH_STATE);
> +       writel(val, qmp->msgram + QMP_DESC_UCORE_CH_STATE_ACK);

nit: the readl() is silly here.  Just before this you called
qmp_ucore_channel_up() and that confirmed that the value you're
getting here is exactly equal to "QMP_STATE_UP".  Just write that.


> +static int qmp_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct qmp *qmp;
> +       int irq;
> +       int ret;
> +
> +       qmp = devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
> +       if (!qmp)
> +               return -ENOMEM;
> +
> +       qmp->dev = &pdev->dev;
> +       init_waitqueue_head(&qmp->event);
> +       mutex_init(&qmp->tx_lock);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(qmp->msgram))
> +               return PTR_ERR(qmp->msgram);
> +
> +       qmp->mbox_client.dev = &pdev->dev;
> +       qmp->mbox_client.knows_txdone = true;
> +       qmp->mbox_chan = mbox_request_channel(&qmp->mbox_client, 0);

nit: your code would be simplified a bit if you created
devm_mbox_request_channel() in a prior patch.


> +       if (IS_ERR(qmp->mbox_chan)) {
> +               dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
> +               return PTR_ERR(qmp->mbox_chan);
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
> +                              "aoss-qmp", qmp);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to request interrupt\n");
> +               mbox_free_channel(qmp->mbox_chan);
> +               return ret;
> +       }
> +
> +       ret = qmp_open(qmp);
> +       if (ret < 0) {
> +               mbox_free_channel(qmp->mbox_chan);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, qmp);
> +
> +       if (of_property_read_bool(pdev->dev.of_node, "#power-domain-cells")) {
> +               qmp->pd_pdev = platform_device_register_data(&pdev->dev,
> +                                                            "aoss_qmp_pd",
> +                                                            PLATFORM_DEVID_NONE,
> +                                                            NULL, 0);
> +               if (IS_ERR(qmp->pd_pdev))
> +                       dev_err(&pdev->dev, "failed to register AOSS PD\n");

nit: I'd prefer dev_warn() for serious but non-fatal errors.  This
appears to be non-fatal since it doesn't cause you to return an error.

...ideally the error message should indicate that the error is being ignored.


I'm also not 100% sure why the "aoss_qmp_pd" needs to be broken up as
a separate driver.  I guess there is expectation that there will be
more sub-drivers that use qmp_send() and that stuffing them all in the
same driver would be too much?  It sure seems like your life would be
simplified if they were just one driver though unless you think
someone would want to enable "AOSS_QMP" without enabling
"AOSS_QMP_PD".


> +static int qmp_remove(struct platform_device *pdev)
> +{
> +       struct qmp *qmp = platform_get_drvdata(pdev);
> +
> +       platform_device_unregister(qmp->pd_pdev);

Presumably the above should be prefixed with:

if (!IS_ERR(qmp->pd_pdev))

...since it appears that the probe will return with no error if you
fail to register the pd_pdev and thus you need to handle it being an
error in remove.


> +       mbox_free_channel(qmp->mbox_chan);
> +       qmp_close(qmp);

nit: I always expect that remove should be in the opposite order of
probe.  That means qmp_close() should be before mbox_free_channel().
