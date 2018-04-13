Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeDMRSO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:18:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37456 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeDMRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:18:11 -0400
X-Google-Smtp-Source: AIpwx4/HawZ4mB9B7zgiH4YS6IwgpKiPDi3TAeYKm/JhjW2/XSOjlYNDWZRqn5s/mZydZtmBjntQMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180411000120.GD6727@builder>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-5-ilina@codeaurora.org> <20180411000120.GD6727@builder>
Message-ID: <152363988938.51482.11232650494199609730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date: Fri, 13 Apr 2018 10:18:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DHIJO7019291

Quoting Bjorn Andersson (2018-04-10 17:01:20)
> On Thu 05 Apr 09:18 PDT 2018, Lina Iyer wrote:
> 
> >  
> > diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> > new file mode 100644
> > index 000000000000..e3c7491e7baf
> > --- /dev/null
> > +++ b/drivers/soc/qcom/rpmh.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/wait.h>
> > +
> > +#include <soc/qcom/rpmh.h>
> > +
> > +#include "rpmh-internal.h"
> > +
> > +#define RPMH_MAX_MBOXES                      2
> > +#define RPMH_TIMEOUT_MS                      10000
> 
> Just define this in jiffies and you don't need to do msecs_to_jiffies()
> every time you use it.
> 

Put the msecs_to_jiffies() here if you want. The compiler will constant
fold it to the final value, and then we get the same time in seconds no
matter what the jiffies frequency is configured for.
