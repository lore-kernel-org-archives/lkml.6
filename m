Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7954C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FFD20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P7aTqG5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FFD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeGaJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:34:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35140 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeGaJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:34:29 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so12191461iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Th8JuV6znK63Ni7tCdwyMOX6Hyf+l5IYLWS8jUtL9r4=;
        b=P7aTqG5lwcjjliD3P+vysV3EQ2F7rFSTCpt855IurfLPmrF9kgISIe+fh3Ykhsk8Z0
         6isoQWeMWa2/2jpjD6oevg91/G9xrM0JrCUrIAg+WyJpHd/zf6B42T8Gz1nZ65lcG3Ee
         dUf1bjqopWjqQ8S4TjlIVClPkYbhCW1IiMP23dQA2ZawrLsY0DF5nVlAwUupFkoNt5Zx
         NhFXCAZiNN5cZK7G5q9vyOdiyzMFTW9Eg+n+LLSjep4fowKFOGF10qKaMzIxWlq35p+L
         JKJLK/ZHyldZZghuDueB5e8Up9t8TIRWe88U7po+nVto6KlgVWQ+hqKooYH/yWD2bvAt
         OSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Th8JuV6znK63Ni7tCdwyMOX6Hyf+l5IYLWS8jUtL9r4=;
        b=eqRYZK2yTUdF8nMvkgV04JWRbHa39VX+TPnZPwO3kfwqbJeNXkbo+ASwxf+VkQhYyL
         8yh9uUPveMiOKBf9eCrZZNdqcPyZDtS7stRIJFLaYRyRUey/bl6Xe4ZxVpjOpv0LG/N9
         ahTjibjN4QpGYPSV/laLOqZv5pPXDLpmhXfwZq00Wh3ix93Y3aYcw16pMQAMfrAqXv1d
         0XS81UVFyUqhfpzNLpwa7UKz/BVTpzuHoFkvrClRijLzPAIEP52NjmKcJhjrdHw75UvN
         UwT852FVLPa6FIMwoFC46U8DAAdiLNp8pALYHOr6614dRdsl6wc+OvAhIUVrR8fo9ETF
         9KkQ==
X-Gm-Message-State: AOUpUlFTkczh97V1bpXHGjupX47jnKFzRtd/G12xIpYFsQmCmKSNJY5D
        vhJj6THrdd4rzFktkJQLVEQNKVXF6ivfRX9c2+tNAw==
X-Google-Smtp-Source: AAOMgpfeuwnhQ0KNtGlqOVuoIq8Crg/EpK+sl+2AjgY4yNTOWumm8auzBQdZXkLppae0hcLfIFXGQAl+iPkQvNbjqto=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr15752690ioj.258.1533023724849;
 Tue, 31 Jul 2018 00:55:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 00:55:24
 -0700 (PDT)
In-Reply-To: <20180731042539.GE5090@builder>
References: <20180621073706.22812-1-brgl@bgdev.pl> <20180621073706.22812-2-brgl@bgdev.pl>
 <20180731042539.GE5090@builder>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 31 Jul 2018 09:55:24 +0200
Message-ID: <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-31 6:25 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
> On Thu 21 Jun 00:37 PDT 2018, Bartosz Golaszewski wrote:
>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Switch to using the reset framework instead of handcoded reset routines
>> we used so far.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Sekhar,

can you take this through your tree or is it already too late?

Bart

> Regards,
> Bjorn
>
>> ---
>>  drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
>> index b668e32996e2..76c06b70a1c6 100644
>> --- a/drivers/remoteproc/da8xx_remoteproc.c
>> +++ b/drivers/remoteproc/da8xx_remoteproc.c
>> @@ -10,6 +10,7 @@
>>
>>  #include <linux/bitops.h>
>>  #include <linux/clk.h>
>> +#include <linux/reset.h>
>>  #include <linux/err.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> @@ -20,8 +21,6 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/remoteproc.h>
>>
>> -#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
>> -
>>  #include "remoteproc_internal.h"
>>
>>  static char *da8xx_fw_name;
>> @@ -72,6 +71,7 @@ struct da8xx_rproc {
>>       struct da8xx_rproc_mem *mem;
>>       int num_mems;
>>       struct clk *dsp_clk;
>> +     struct reset_control *dsp_reset;
>>       void (*ack_fxn)(struct irq_data *data);
>>       struct irq_data *irq_data;
>>       void __iomem *chipsig;
>> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>       struct device *dev = rproc->dev.parent;
>>       struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>>       struct clk *dsp_clk = drproc->dsp_clk;
>> +     struct reset_control *dsp_reset = drproc->dsp_reset;
>>       int ret;
>>
>>       /* hw requires the start (boot) address be on 1KB boundary */
>> @@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>               return ret;
>>       }
>>
>> -     davinci_clk_reset_deassert(dsp_clk);
>> +     ret = reset_control_deassert(dsp_reset);
>> +     if (ret) {
>> +             dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
>> +             clk_disable_unprepare(dsp_clk);
>> +             return ret;
>> +     }
>>
>>       return 0;
>>  }
>> @@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>  static int da8xx_rproc_stop(struct rproc *rproc)
>>  {
>>       struct da8xx_rproc *drproc = rproc->priv;
>> +     struct device *dev = rproc->dev.parent;
>> +     int ret;
>> +
>> +     ret = reset_control_assert(drproc->dsp_reset);
>> +     if (ret) {
>> +             dev_err(dev, "reset_control_assert() failed: %d\n", ret);
>> +             return ret;
>> +     }
>>
>> -     davinci_clk_reset_assert(drproc->dsp_clk);
>>       clk_disable_unprepare(drproc->dsp_clk);
>>
>>       return 0;
>> @@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>       struct resource *bootreg_res;
>>       struct resource *chipsig_res;
>>       struct clk *dsp_clk;
>> +     struct reset_control *dsp_reset;
>>       void __iomem *chipsig;
>>       void __iomem *bootreg;
>>       int irq;
>> @@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>               return PTR_ERR(dsp_clk);
>>       }
>>
>> +     dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
>> +     if (IS_ERR(dsp_reset)) {
>> +             if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
>> +                     dev_err(dev, "unable to get reset control: %ld\n",
>> +                             PTR_ERR(dsp_reset));
>> +
>> +             return PTR_ERR(dsp_reset);
>> +     }
>> +
>>       if (dev->of_node) {
>>               ret = of_reserved_mem_device_init(dev);
>>               if (ret) {
>> @@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>       drproc = rproc->priv;
>>       drproc->rproc = rproc;
>>       drproc->dsp_clk = dsp_clk;
>> +     drproc->dsp_reset = dsp_reset;
>>       rproc->has_iommu = false;
>>
>>       ret = da8xx_rproc_get_internal_memories(pdev, drproc);
>> @@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>        * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>>        * held in reset at the time it is called.
>>        */
>> -     ret = davinci_clk_reset_assert(drproc->dsp_clk);
>> +     ret = reset_control_assert(dsp_reset);
>>       if (ret)
>>               goto free_rproc;
>>
>> --
>> 2.17.1
>>
