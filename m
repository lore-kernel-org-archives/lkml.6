Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d1mWFGanGVvkDQAAmS7hNA
	; Thu, 07 Jun 2018 21:46:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EB6C06074D; Thu,  7 Jun 2018 21:46:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo1n/j9D"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EF68601C3;
	Thu,  7 Jun 2018 21:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF68601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFGVq4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:46:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52931 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeFGVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:46:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so20622237wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=afyNQ7DC6BFXdcHIZn15VBOCbiTfPJsvKy7EaILFEPM=;
        b=eo1n/j9DUeeFLWbfl7LaSmfkBLrHybGkIg4BAa2JcGdcUQ/gETVS8jo5JDW+SBWjoW
         41XpCAlqk5Ow0iayLQotPUIdpp33qeQUvpYB5J59Wfqh36EMS5DlZlmiGHMy34EdoYoH
         hTpfEhWLeKz4YfZ1bVy7UY15khCd2VaZu7C58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=afyNQ7DC6BFXdcHIZn15VBOCbiTfPJsvKy7EaILFEPM=;
        b=VD+On2H9Gef6vD4nvxXrsEtyeVongKSlc/63eb1rQ6FPZ49e1ql+z61L+Dl/9X8fzg
         ppZumdhYzahmUniEEXUzj/JqnItmkpsIBrY5CX2tTJaXXl6oZj9OJ9/N/ym2K4xOdpAa
         MHpJdsvwIU7etpm+l47T5lNZoyYke7r1F5iz4H17D6OEllCzcUcmomy+s7kRJrOlHEIw
         HsPJ4nIXzS3lFsI3rvP3/KTeLXV2Yvs7CJouGxJTZ80qmLLt73LqVfgA9jP2botTbM+9
         ddE+15p7B9eQibNAmIRhuiQYObjrwAaUpHMNEQUPXoVQXimmXHNcDaO5DSqhkAlmYrQM
         pgwg==
X-Gm-Message-State: APt69E2GChlpV4eWAxfvFQG1u5z67GVtg7j7RwFStxRM865t/4o3OOy9
        bgMh0cpHHt11BvuCcBbxebPMm+7n50VwFCTX5oUmFQ==
X-Google-Smtp-Source: ADUXVKLYy0H0r0K7Qe5SYFMKnCZ7XBv9bb/4HmPP0/OD+AsInYlYqjoshpaVgXHbCwda8NPaX79XKwkm4dhJ5CT1jP8=
X-Received: by 2002:a50:ec19:: with SMTP id g25-v6mr4218352edr.242.1528408013399;
 Thu, 07 Jun 2018 14:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 14:46:53 -0700 (PDT)
In-Reply-To: <20180605210710.22227-15-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com> <20180605210710.22227-15-kim.phillips@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Jun 2018 15:46:53 -0600
Message-ID: <CANLsYkwMmNFHUnJ-Qo9cGxbVG=1zT=26G9Jq+modve5s3shueg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] coresight: allow the coresight core driver to be
 built as a module
To: Kim Phillips <kim.phillips@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 June 2018 at 15:07, Kim Phillips <kim.phillips@arm.com> wrote:
> Allow to build coresight as a module.  This enhances
> coresight developer efficiency by allowing the development to
> take place exclusively on the target, and without needing to
> reboot in between changes.
>
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>   be called coresight by the Makefile
> - modules can have only one init/exit, so we add the core bus
>   register/unregister function calls to the etm_perf init/exit
>   functions, since coresight.c does not have etm_pmu defined.
> - add a MODULE_DEVICE_TABLE for autoloading on boot
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig             |  5 ++++-
>  drivers/hwtracing/coresight/Makefile            |  7 +++++--
>  .../coresight/{coresight.c => coresight-core.c} |  6 ------
>  .../hwtracing/coresight/coresight-etm-perf.c    | 17 ++++++++++++++++-
>  4 files changed, 25 insertions(+), 10 deletions(-)
>  rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (99%)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 181a44ea2d61..c05b265f7731 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -2,7 +2,7 @@
>  # Coresight configuration
>  #
>  menuconfig CORESIGHT
> -       bool "CoreSight Tracing Support"
> +       tristate "CoreSight Tracing Support"
>         select ARM_AMBA
>         select PERF_EVENTS
>         help
> @@ -12,6 +12,9 @@ menuconfig CORESIGHT
>           specification and configure the right series of components when a
>           trace source gets enabled.
>
> +         To compile this driver as a module, choose M here: the
> +         module will be called coresight.
> +
>  if CORESIGHT
>  config CORESIGHT_LINKS_AND_SINKS
>         tristate "CoreSight Link and Sink drivers"
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 45d7a0f34170..ed2d4bcb017b 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -2,8 +2,11 @@
>  #
>  # Makefile for CoreSight drivers.
>  #
> -obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
> -obj-$(CONFIG_OF) += of_coresight.o
> +obj-$(CONFIG_CORESIGHT) += coresight.o
> +coresight-objs := coresight-core.o  coresight-etm-perf.o
> +ifeq ($(CONFIG_OF), y)
> +coresight-objs += of_coresight.o
> +endif
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  coresight-tmc-objs := coresight-tmc-core.o coresight-tmc-etf.o \
>                       coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight-core.c
> similarity index 99%
> rename from drivers/hwtracing/coresight/coresight.c
> rename to drivers/hwtracing/coresight/coresight-core.c
> index 1c941351f1d1..f96258de1e9b 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -948,12 +948,6 @@ struct bus_type coresight_bustype = {
>         .name   = "coresight",
>  };
>
> -static int __init coresight_init(void)
> -{
> -       return bus_register(&coresight_bustype);
> -}
> -postcore_initcall(coresight_init);
> -
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
>         int i;
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 0fe7e43ea1c4..ceac9aee4a82 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -472,6 +472,10 @@ static int __init etm_perf_init(void)
>  {
>         int ret;
>
> +       ret = bus_register(&coresight_bustype);
> +       if (ret)
> +               return ret;
> +
>         etm_pmu.capabilities            = PERF_PMU_CAP_EXCLUSIVE;
>
>         etm_pmu.attr_groups             = etm_pmu_attr_groups;
> @@ -494,4 +498,15 @@ static int __init etm_perf_init(void)
>
>         return ret;
>  }
> -device_initcall(etm_perf_init);
> +postcore_initcall(etm_perf_init);
> +
> +static void __exit etm_perf_exit(void)
> +{
> +       perf_pmu_unregister(&etm_pmu);
> +       bus_unregister(&coresight_bustype);
> +}
> +module_exit(etm_perf_exit);

I see the perf functionality as an accessory to the core rather than
the other way around.  Initialisation in the core code should be
driving the PMU registration.

> +
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight tracer driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.0
>
