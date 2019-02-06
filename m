Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DA0C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A75217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDoCTtws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfBFBd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:33:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37262 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfBFBd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:33:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so2366173plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 17:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/5A3onHfF6tK1CzO7JYcJTF9O9rJI8e/ET7lAfTEYA=;
        b=cDoCTtwsITdpEV00nsatOe9JQPPig1wGfW7TQ/uYsCIeV50296VVdepkFfqezNM++q
         cBHpgHbyZI2ruNC6BK78DPnRThSMkrLP3wJmdwLQwIIZCUlNWCm9FHwQ+2T8JwwtyguI
         z75fKzcdnG8TXYBsI543i3aMLKQnTwMYfjZbmqIItvJsbiHs77+tVgXCPutTOJDlgs2A
         TNpJzPwLZjYB3M9ZvHlvXIChMasRifNrLH9GmtDWXj5KqFsD3ogGKqsAwAZj3ntJRE2m
         tOafjBvlk1qAnrVL3pFERDdvvYtIl9OJlnZvYsUrUtYMHRXVH4q893J/R+I7RDRsVe2o
         a15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/5A3onHfF6tK1CzO7JYcJTF9O9rJI8e/ET7lAfTEYA=;
        b=hVLe9nx4pYjA1PiZpR0pzwo8dfvUPz7ECVabO3SK0pCujRFQkkPrV6d2xDVATlpxrB
         RtXG7U/SWxcwIHlB4QKxKDZWJGt0zHRNVWI/yDsmUt+ofD2KDRgv7NUrTZRN21GFYFwe
         JLQBhLhjXVpY4KJWdhdLPkfesUSy6r3ODp8sp22qmTJAs5zPle2tO9OJkRPtYKzRJ7Nk
         MVtraHGi5qfVcmasJeCjX7Xd3BBZB9IkGfkOqBhzqy9bBH0XtJTMsXNJGwQURikWZvBT
         g+psz8C1DDNhrq1olthJvKPzqFt9amv9ZGEatwSJbtbtf1Pg7YU13jimsnKrOuzo9lgf
         Upeg==
X-Gm-Message-State: AHQUAuaUYpA8cmjpVG0PnzJUl0qaAv5p83BLOSV5uBBW+h9tfboU3wRq
        mQ5xD1iy6ECKlZyitFPEbOfpdg==
X-Google-Smtp-Source: AHgI3IamCkTzftxIPboH17GsGeSYx8VsMsC/UyH5/lYm3UEJA7lmtvuvKm0mCAAgmR2dXj99RuPZJA==
X-Received: by 2002:a17:902:1486:: with SMTP id k6mr7264586pla.49.1549416806274;
        Tue, 05 Feb 2019 17:33:26 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x2sm6169070pfx.78.2019.02.05.17.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 17:33:25 -0800 (PST)
Date:   Tue, 5 Feb 2019 17:33:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
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
Subject: Re: [PATCH v5 05/10] soc: qcom: Add AOSS QMP communication driver
Message-ID: <20190206013322.GA24861@tuxbook-pro>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
 <20190131003933.11436-6-bjorn.andersson@linaro.org>
 <CAD=FV=U617Q6RFPnJaRoNEf=hr1ag9qqon2M-msbQD483tmicg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U617Q6RFPnJaRoNEf=hr1ag9qqon2M-msbQD483tmicg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Feb 15:36 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Wed, Jan 30, 2019 at 4:40 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > +++ b/drivers/soc/qcom/aoss-qmp.c
> > @@ -0,0 +1,317 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018, Linaro Ltd
> > + */
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/soc/qcom/aoss-qmp.h>
> > +
> > +#define QMP_DESC_MAGIC                 0x0
> > +#define QMP_DESC_VERSION               0x4
> > +#define QMP_DESC_FEATURES              0x8
> > +
> > +#define QMP_DESC_UCORE_LINK_STATE      0xc
> > +#define QMP_DESC_UCORE_LINK_STATE_ACK  0x10
> > +#define QMP_DESC_UCORE_CH_STATE                0x14
> > +#define QMP_DESC_UCORE_CH_STATE_ACK    0x18
> > +#define QMP_DESC_UCORE_MBOX_SIZE       0x1c
> > +#define QMP_DESC_UCORE_MBOX_OFFSET     0x20
> > +
> > +#define QMP_DESC_MCORE_LINK_STATE      0x24
> > +#define QMP_DESC_MCORE_LINK_STATE_ACK  0x28
> > +#define QMP_DESC_MCORE_CH_STATE                0x2c
> > +#define QMP_DESC_MCORE_CH_STATE_ACK    0x30
> > +#define QMP_DESC_MCORE_MBOX_SIZE       0x34
> > +#define QMP_DESC_MCORE_MBOX_OFFSET     0x38
> 
> I sure wish something in this file told me what a mcore and a ucore
> were.  The only thing I can think of is that an "m" core is two "u"
> cores flipped upside down and placed really close to each other.
> ...if we had 6 upside down "u" cores we'd have an "mmm" core.  Mmm,
> core.
> 

I had to look at the code again to figure out which side was which, so
I'll add a comment here to indicate which is which.

> 
> > +static int qmp_open(struct qmp *qmp)
> > +{
> > +       int ret;
> > +       u32 val;
> > +
> > +       ret = wait_event_timeout(qmp->event, qmp_magic_valid(qmp), HZ);
> 
> I'm a totally noob here, but I'm curious: what kicks this event?  Do
> we just assume that an IRQ is pending already when the probe()
> function is called?  Maybe you could add a comment?
> 
> ...or maybe you never actually get an IRQ here and just rely on the
> magic value being right at boot in which case we should just check
> qmp_magic_valid()
> 
> ...or maybe you never actually get an IRQ here and this is equivalent
> to msleep(1000) followed by a check of qmp_magic_valid()?
> 

This must be me misinterpreting the downstream driver, the magic is
already in place when we enter here.

> 
> > +       if (!ret) {
> > +               dev_err(qmp->dev, "QMP magic doesn't match\n");
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       val = readl(qmp->msgram + QMP_DESC_VERSION);
> > +       if (val != QMP_VERSION) {
> > +               dev_err(qmp->dev, "unsupported QMP version %d\n", val);
> > +               return -EINVAL;
> > +       }
> > +
> > +       qmp->offset = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_OFFSET);
> > +       qmp->size = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_SIZE);
> > +       if (!qmp->size) {
> > +               dev_err(qmp->dev, "invalid mailbox size 0x%zx\n", qmp->size);
> 
> nitty nit: Can you do "%#zx" to avoid the need for the 0x?
> 

Didn't know I could do that, but that said this is conditional on
!qmp->size, so I'm dropping the 0x0 from the error...
> 
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Ack remote core's link state */
> > +       val = readl(qmp->msgram + QMP_DESC_UCORE_LINK_STATE);
> > +       writel(val, qmp->msgram + QMP_DESC_UCORE_LINK_STATE_ACK);
> > +
> > +       /* Set local core's link state to up */
> > +       writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
> > +
> > +       qmp_kick(qmp);
> > +
> > +       ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp), HZ);
> > +       if (!ret) {
> > +               dev_err(qmp->dev, "ucore didn't ack link\n");
> > +               goto timeout_close_link;
> > +       }
> > +
> > +       writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
> > +
> > +       ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp), HZ);
> 
> Again maybe a noob question, but what kicks the interrupt here?  Is
> the other side looping waiting to see us write "QMP_STATE_UP" into
> "QMP_DESC_MCORE_CH_STATE" and then it sends us another interrupt?
> ...or are we just getting lucky that the condition is right to begin
> with?
> 

I guess it does, but I think there is a kick inbetween here in the
downstream driver, I'll add one for good measure.

> 
> > +       if (!ret) {
> > +               dev_err(qmp->dev, "ucore didn't open channel\n");
> > +               goto timeout_close_channel;
> > +       }
> > +
> > +       /* Ack remote core's channel state */
> > +       val = readl(qmp->msgram + QMP_DESC_UCORE_CH_STATE);
> > +       writel(val, qmp->msgram + QMP_DESC_UCORE_CH_STATE_ACK);
> 
> nit: the readl() is silly here.  Just before this you called
> qmp_ucore_channel_up() and that confirmed that the value you're
> getting here is exactly equal to "QMP_STATE_UP".  Just write that.
> 

Right

> 
> > +static int qmp_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res;
> > +       struct qmp *qmp;
> > +       int irq;
> > +       int ret;
> > +
> > +       qmp = devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
> > +       if (!qmp)
> > +               return -ENOMEM;
> > +
> > +       qmp->dev = &pdev->dev;
> > +       init_waitqueue_head(&qmp->event);
> > +       mutex_init(&qmp->tx_lock);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(qmp->msgram))
> > +               return PTR_ERR(qmp->msgram);
> > +
> > +       qmp->mbox_client.dev = &pdev->dev;
> > +       qmp->mbox_client.knows_txdone = true;
> > +       qmp->mbox_chan = mbox_request_channel(&qmp->mbox_client, 0);
> 
> nit: your code would be simplified a bit if you created
> devm_mbox_request_channel() in a prior patch.
> 
> 
> > +       if (IS_ERR(qmp->mbox_chan)) {
> > +               dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
> > +               return PTR_ERR(qmp->mbox_chan);
> > +       }
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
> > +                              "aoss-qmp", qmp);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to request interrupt\n");
> > +               mbox_free_channel(qmp->mbox_chan);
> > +               return ret;
> > +       }
> > +
> > +       ret = qmp_open(qmp);
> > +       if (ret < 0) {
> > +               mbox_free_channel(qmp->mbox_chan);
> > +               return ret;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, qmp);
> > +
> > +       if (of_property_read_bool(pdev->dev.of_node, "#power-domain-cells")) {
> > +               qmp->pd_pdev = platform_device_register_data(&pdev->dev,
> > +                                                            "aoss_qmp_pd",
> > +                                                            PLATFORM_DEVID_NONE,
> > +                                                            NULL, 0);
> > +               if (IS_ERR(qmp->pd_pdev))
> > +                       dev_err(&pdev->dev, "failed to register AOSS PD\n");
> 
> nit: I'd prefer dev_warn() for serious but non-fatal errors.  This
> appears to be non-fatal since it doesn't cause you to return an error.
> 
> ...ideally the error message should indicate that the error is being ignored.
> 

I think it makes more sense to keep this as dev_err() and actually
fail probe on this. Will update.

> 
> I'm also not 100% sure why the "aoss_qmp_pd" needs to be broken up as
> a separate driver.  I guess there is expectation that there will be
> more sub-drivers that use qmp_send() and that stuffing them all in the
> same driver would be too much?  It sure seems like your life would be
> simplified if they were just one driver though unless you think
> someone would want to enable "AOSS_QMP" without enabling
> "AOSS_QMP_PD".
> 

I think splitting them in different files makes a lot of sense, whether
they should be separate drivers or just linked to one chunk that's food
for thought.

> 
> > +static int qmp_remove(struct platform_device *pdev)
> > +{
> > +       struct qmp *qmp = platform_get_drvdata(pdev);
> > +
> > +       platform_device_unregister(qmp->pd_pdev);
> 
> Presumably the above should be prefixed with:
> 
> if (!IS_ERR(qmp->pd_pdev))
> 
> ...since it appears that the probe will return with no error if you
> fail to register the pd_pdev and thus you need to handle it being an
> error in remove.
> 

Let's just make sure this doesn't happen.

> 
> > +       mbox_free_channel(qmp->mbox_chan);
> > +       qmp_close(qmp);
> 
> nit: I always expect that remove should be in the opposite order of
> probe.  That means qmp_close() should be before mbox_free_channel().

You're right.

Thanks,
Bjorn
