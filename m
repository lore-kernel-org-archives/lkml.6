Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCAB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVstQBPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfANX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:29:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32891 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfANX3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:29:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so363291plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1pIC5r5deUwQRSpwlJHqSeL3tRU9LeoYzXIxZGRScY8=;
        b=hVstQBPrGMojHpGhJpwZx7GbvPZt3lgqfaDm4oPcaBPQ5PDJlwgBt9H8qqLxaDBdBW
         8/9h1aTpBxI24mG6v5z03RRyclaX1fJVErL/lQZ6GuBSGAAHxrmqtWmlA8zSIxYDI+DE
         kXZemdC7qVj0s2OZuuhetZeiDKMJ/oCb0OHN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pIC5r5deUwQRSpwlJHqSeL3tRU9LeoYzXIxZGRScY8=;
        b=ixlkDbLtKoeoYGQ2lKLgQtD9BA5AO+ZZFfvexupxhJG1xsPTDCIYmlb6QuCNArV2WI
         kSd6U+xNUOc2Lu66rMSjYyHls7IMxwb7Bm1YMC+TrYZgNWYyXIzW4SZBIc8f6290UvBc
         /x427SabbJcvp+Tx8zsvIAKJ6yFUjHC1Sm9sVq3s2Iv7eax9aX5obH3uTYauqeCQQqTa
         lgCVQ3rqxYQO4K01F/5NAfPnVMmveyu5rdFl1+34ikf+EfjskfUEh7EwWS99RiVH33Td
         CH8yvCxvMJb0/URXZg0EeiOTtjQi958al41VNMhA2/2bY/SXgof5MnFW2Xs2515VzaS7
         7Z+w==
X-Gm-Message-State: AJcUukc4b9kKW0vOZp8t2imQmzKucmCTk4DobK6E0QbTzryJqu4oQN1D
        EFuvWE5U+tC+vEEeAFurg0o5TQ==
X-Google-Smtp-Source: ALg8bN67yFvaOLkZdkFCaOcjBUa2tP4fNMwUQOT6khvTHL53OOb3QrPqwFOtPqxjwVrbyJ9NnEeCtQ==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr981677pll.215.1547508573183;
        Mon, 14 Jan 2019 15:29:33 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b7sm2085330pfa.52.2019.01.14.15.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:29:32 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:29:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] soc: qcom: Add AOSS QMP genpd provider
Message-ID: <20190114232930.GE9278@minitux>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-4-bjorn.andersson@linaro.org>
 <154750565372.169631.9416138415370937156@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154750565372.169631.9416138415370937156@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 14:40 PST 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-01-06 00:09:11)
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index dda19471057f..d81256ef5055 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -12,6 +12,15 @@ config QCOM_AOSS_QMP
> >           micro-controller in the AOSS, using QMP, to control certain resource
> >           that are not exposed through RPMh.
> >  
> > +config QCOM_AOSS_QMP_PD
> > +       tristate "Qualcomm AOSS Messaging Power Domain driver"
> > +       depends on QCOM_AOSS_QMP
> > +       select PM_GENERIC_DOMAINS
> > +       help
> > +         This driver provides the means of controlling the AOSSs handling of
> 
> Is that possesive? AOSS's?
> 

That's correct, will fix.

> > +         low-power state for resources related to the remoteproc subsystems as
> > +         well as controlling the debug clocks.
> > +
> >  config QCOM_COMMAND_DB
> >         bool "Qualcomm Command DB"
> >         depends on ARCH_QCOM || COMPILE_TEST
> > diff --git a/drivers/soc/qcom/aoss-qmp-pd.c b/drivers/soc/qcom/aoss-qmp-pd.c
> > new file mode 100644
> > index 000000000000..62b8fcb9d09e
> > --- /dev/null
> > +++ b/drivers/soc/qcom/aoss-qmp-pd.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018, Linaro Ltd
> > + */
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/soc/qcom/aoss-qmp.h>
> > +#include <dt-bindings/power/qcom-aoss-qmp.h>
> > +
> > +struct qmp_pd {
> > +       struct qmp *qmp;
> > +
> > +       struct generic_pm_domain pd;
> > +
> > +       const char *name;
> > +};
> > +
> > +#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
> > +
> > +struct qmp_pd_resource {
> > +       const char *name;
> > +       int (*on)(struct generic_pm_domain *domain);
> > +       int (*off)(struct generic_pm_domain *domain);
> > +};
> > +
> > +static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
> > +{
> > +       char buf[96];
> 
> Is 96 calculated from somewhere? Can it be a define because it's quite
> magical.
> 

This is inherited by downstream, I know it has to be % 4, I'll check and
update accordingly.

Thanks,
Bjorn
