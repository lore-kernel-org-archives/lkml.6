Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E524C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i701QxE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIKQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:29:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38305 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:29:55 -0400
Received: by mail-io0-f195.google.com with SMTP id y3-v6so3236909ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a06u9VEzdgMyJZDde3cwmqiP+8kBeTLIEVYt858+oyQ=;
        b=i701QxE9iZZZDo46yIROpO4KtT16qlA+Y2Np58sP5t+hSIJBAp5DUsHyfY2zVNUE+U
         yKLe0MO3bRoGAfL5lveLn6N68foFqYpY/DxJ9E+9vwN0C2t5R6gR7M2lZukeVsirxyyB
         7sFWmFTg/LWDUBpbWM8c4LvEteEB2FRVo311Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a06u9VEzdgMyJZDde3cwmqiP+8kBeTLIEVYt858+oyQ=;
        b=mlLnnVjlZyead+/w0dkTp2vqbBjrellAr0kp8c61b8LCqeARNroIw9hkfzyBlmLjrB
         TQAtR1NND8ceYyCBhxdxoIRD3iZYdD8HNMnKtWfK0RewHmHrSpi1JvA/uBrVxS/QZdNE
         zhat/xLzOGRG6E23KKjDGF1VJKNcXdCK6haah9Tr0Z7AVVeA4krVpEDcIbf1kkT0LUqI
         97ZmuUJLXq/63pSy1ESXF8gXRJtllAPXw+zoYABq5g1vNV7wMc/o0z1k0Dz8r/3TK7BI
         Sq/AgchuMTU6SVVTE0pDdMZnLr8YrYFmDO164Z+GBBXuVNnUg4brXjrs/8IvAU2H9YgH
         4nog==
X-Gm-Message-State: APzg51Bt3v9a+8PxjKqNcoIDpX1vFp68Okag1RmlDnyQHcWKzWoZE7Xn
        lOoLMQFUW6OMwMKeDuyO/Vu7VUgx1rOe5NkdUqKi1g==
X-Google-Smtp-Source: ANB0VdYepJvKVHmNmw4bN3y6vAMCgakNClfIOZZJKAlFq+2DJcSOWMkP9FcQjX+EeEbUYENY1KJpESn6OvT3J8lmiXA=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr20210671iou.218.1536665459658;
 Tue, 11 Sep 2018 04:30:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 04:30:59
 -0700 (PDT)
In-Reply-To: <20180904071046.8152-1-rnayak@codeaurora.org>
References: <20180904071046.8152-1-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Sep 2018 13:30:59 +0200
Message-ID: <CAPDyKFryn-AYq_+imCsoLHRpC8WXqp_TAVLUkbu6WLrgk0O0Ng@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: q6v5: Add support to vote for rpmh power domains
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, sibis@codeaurora.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Viresh

On 4 September 2018 at 09:10, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> With rpmh ARC resources being modelled as power domains with performance
> state,
> we need to proxy vote on these for SDM845.
> Add support to vote on multiple of them, now that genpd supports
> associating
> mutliple power domains to a device.

I guess it's fair to mention that the votes are, at this point, done
for maximum performance!?

Is that really needed in the long run? I mean, I guess you should walk
through the OPP library to find the needed performance level? No?

>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> Changes in v2:
> * Drop the perf vote along with disabling the powerdomain
> * pm_suspend_ignore_children() to not mess with runtime PM of children
> * Detach powerdomains as part of .remove and in error path during probe,
> issue reported by Brian Norris <briannorris@chromium.org>
> * Use dev_pm_domain_attach_by_name() api
>
>  drivers/remoteproc/qcom_q6v5_pil.c | 111 ++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index d7a4b9eca5d2..f4b3a9b09a5d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -25,6 +25,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -131,6 +133,7 @@ struct rproc_hexagon_res {
>         char **proxy_clk_names;
>         char **reset_clk_names;
>         char **active_clk_names;
> +       char **pd_names;
>         int version;
>         bool need_mem_protection;
>         bool has_alt_reset;
> @@ -155,9 +158,11 @@ struct q6v5 {
>         struct clk *active_clks[8];
>         struct clk *reset_clks[4];
>         struct clk *proxy_clks[4];
> +       struct device *pd_devs[3];
>         int active_clk_count;
>         int reset_clk_count;
>         int proxy_clk_count;
> +       int pd_count;
>
>         struct reg_info active_regs[1];
>         struct reg_info proxy_regs[3];
> @@ -316,6 +321,40 @@ static void q6v5_clk_disable(struct device *dev,
>                 clk_disable_unprepare(clks[i]);
>  }
>
> +static int q6v5_powerdomain_enable(struct device *dev, struct device **devs,
> +                                  int count)

Looks like passing the qproc struct, rather than a couple of its
member could simplify the code a bit. No strong opinion though.

> +{
> +       int i;
> +
> +       if (!count)
> +               return 0;
> +
> +       if (count > 1)
> +               for (i = 0; i < count; i++)
> +                       dev_pm_genpd_set_performance_state(devs[i], INT_MAX);
> +       else
> +               dev_pm_genpd_set_performance_state(dev, INT_MAX);
> +
> +       return pm_runtime_get_sync(dev);
> +}
> +
> +static int q6v5_powerdomain_disable(struct device *dev, struct device **devs,
> +                                   int count)

Ditto.

> +{
> +       int i;
> +
> +       if (!count)
> +               return 0;
> +
> +       if (count > 1)
> +               for (i = 0; i < count; i++)
> +                       dev_pm_genpd_set_performance_state(devs[i], 0);
> +       else
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +
> +       return pm_runtime_put(dev);
> +}
> +
>  static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
>                                    bool remote_owner, phys_addr_t addr,
>                                    size_t size)
> @@ -792,11 +831,18 @@ static int q6v5_start(struct rproc *rproc)
>
>         qcom_q6v5_prepare(&qproc->q6v5);
>
> +       ret = q6v5_powerdomain_enable(qproc->dev, qproc->pd_devs,
> +                                     qproc->pd_count);
> +       if (ret < 0) {
> +               dev_err(qproc->dev, "failed to enable power domains\n");
> +               goto disable_irqs;
> +       }
> +
>         ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
>                                     qproc->proxy_reg_count);
>         if (ret) {
>                 dev_err(qproc->dev, "failed to enable proxy supplies\n");
> -               goto disable_irqs;
> +               goto disable_powerdomains;
>         }
>
>         ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
> @@ -920,6 +966,8 @@ static int q6v5_start(struct rproc *rproc)
>         q6v5_regulator_disable(qproc, qproc->proxy_regs,
>                                qproc->proxy_reg_count);
>
> +disable_powerdomains:
> +       q6v5_powerdomain_disable(qproc->dev, qproc->pd_devs, qproc->pd_count);
>  disable_irqs:
>         qcom_q6v5_unprepare(&qproc->q6v5);
>
> @@ -972,7 +1020,7 @@ static int q6v5_stop(struct rproc *rproc)
>                          qproc->active_clk_count);
>         q6v5_regulator_disable(qproc, qproc->active_regs,
>                                qproc->active_reg_count);
> -
> +       q6v5_powerdomain_disable(qproc->dev, qproc->pd_devs, qproc->pd_count);
>         return 0;
>  }
>
> @@ -1063,6 +1111,48 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
>         return i;
>  }
>
> +static int q6v5_powerdomain_attach(struct device *dev, struct device **devs,
> +                                  char **pd_names)
> +{
> +       int i = 0, num_pds;
> +
> +       if (!pd_names)
> +               return 0;
> +
> +       while (pd_names[i])
> +               i++;
> +
> +       num_pds = i;
> +
> +       if (num_pds > 1) {
> +               for (i = 0; i < num_pds; i++) {
> +                       devs[i] = dev_pm_domain_attach_by_name(dev,
> +                                                              pd_names[i]);
> +                       if (IS_ERR(devs[i]))
> +                               return PTR_ERR(devs[i]);
> +                       if (!device_link_add(dev, devs[i], DL_FLAG_STATELESS |
> +                                            DL_FLAG_PM_RUNTIME))
> +                               return -EINVAL;
> +               }
> +       }
> +
> +       pm_suspend_ignore_children(dev, true);
> +       pm_runtime_enable(dev);
> +
> +       return num_pds;

I would rather add error handling in this function, as that's makes it
more obvious of what goes on. Moreover, it seems like you forgot to
remove the device link in the error path, that also needs to be fixed.

> +};
> +
> +static void q6v5_powerdomain_detach(struct q6v5 *qproc)
> +{
> +       int i;
> +
> +       if (qproc->pd_count > 1)
> +               for (i = 0; i < qproc->pd_count; i++)
> +                       dev_pm_domain_detach(qproc->pd_devs[i], true);
> +
> +       pm_runtime_disable(qproc->dev);
> +}
> +
>  static int q6v5_init_reset(struct q6v5 *qproc)
>  {
>         qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
> @@ -1192,6 +1282,14 @@ static int q6v5_probe(struct platform_device *pdev)
>         }
>         qproc->active_reg_count = ret;
>
> +       ret = q6v5_powerdomain_attach(&pdev->dev, qproc->pd_devs,

I would rather pass qproc instead of qproc->pd_devs and also leave
q6v5_powerdomain_attach() to set qproc->pd_count. In that way the
error handling in q6v5_powerdomain_attach() should becomes more
straight forward.

> +                                     desc->pd_names);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Failed to init power domains\n");
> +               goto free_rproc;
> +       }
> +       qproc->pd_count = ret;
> +
>         ret = q6v5_init_reset(qproc);
>         if (ret)
>                 goto free_rproc;
> @@ -1219,6 +1317,7 @@ static int q6v5_probe(struct platform_device *pdev)
>         return 0;
>
>  free_rproc:
> +       q6v5_powerdomain_detach(qproc);
>         rproc_free(rproc);
>
>         return ret;
> @@ -1228,6 +1327,8 @@ static int q6v5_remove(struct platform_device *pdev)
>  {
>         struct q6v5 *qproc = platform_get_drvdata(pdev);
>
> +       q6v5_powerdomain_detach(qproc);
> +
>         rproc_del(qproc->rproc);
>
>         qcom_remove_sysmon_subdev(qproc->sysmon);
> @@ -1258,6 +1359,12 @@ static const struct rproc_hexagon_res sdm845_mss = {
>                         "mnoc_axi",
>                         NULL
>         },
> +       .pd_names = (char*[]){
> +                       "cx",
> +                       "mx",
> +                       "mss",
> +                       NULL
> +       },
>         .need_mem_protection = true,
>         .has_alt_reset = true,
>         .version = MSS_SDM845,
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Kind regards
Uffe
