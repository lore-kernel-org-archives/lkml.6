Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C95AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDE4208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4PSO1+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDE4208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeGPKiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37651 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbeGPKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:20 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so20445269itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mbXcwD/3jfnX99XPX+WsZqbeJTbpUf/NagoaklJFiqo=;
        b=K4PSO1+f3Jdm2y86Gj7xEcaQjyCa8U7bfD3ga31vTNmP89+Ql3yO7JiMCIVRF9NMgJ
         fO9hLpP9Pj8jFsChetnCr6SdahqOFmBJZGVs0KjH1ifb1Bm1PtnNnMraGpzeL6EfA0Nq
         5xeKCMpnRnw/MSeL4aYqMYoUa6O05Rv7wh7Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mbXcwD/3jfnX99XPX+WsZqbeJTbpUf/NagoaklJFiqo=;
        b=aQ1qpcnEPIteU6yLtnlcKFY2MDhnS6TnikBHic1+zU2AhewahwqDX/sBnFJ5T+LDeF
         9HjP2ERwPQGHMGegy9CMo1Nfg5dsFrSorycNbNxAiWb6x8S6lbVL9YGzfJ+raGZQ6Ej0
         5dLYuUs79TRKhLIHV8cQLLdzyroj65jNqHVb9KsvroeLXCEWbyBtxTByvnLrslsQiq1T
         u3G8y4byQf0/T0UCUxjpiV4ApC1Hqezq2rDNaT0nwHbnvdc+xnG+jF84Rei/yKlUK+mc
         m6IX2ZMSfL0nykWoddwDnj8N48GMMEAxSsmQxxP+g9geEgG9CaB4WckvKeOE5jhNOPle
         ol4g==
X-Gm-Message-State: AOUpUlHHzG9sf8/dRLFtyXNPi8BAXwJcETHI1j9AZ+ATZSTAKFiVE6cN
        90HLL6HPrz6L/e8m6IwjZ+OMDGDDm/so2D/GdWPXHQ==
X-Google-Smtp-Source: AAOMgpeSrJjrxtLxTG+oXEVNMtKFFQqUSL6G2NMFE0XmzjRdYvQgH4SppSjpykUXvtrzroTG7lj2kSC54jrOO4ApTa4=
X-Received: by 2002:a24:90c4:: with SMTP id x187-v6mr574593itd.97.1531735898806;
 Mon, 16 Jul 2018 03:11:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:38
 -0700 (PDT)
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:38 +0200
Message-ID: <CAPDyKFoe_qeHiMa0QFu7NjTRam_jU6iWYScPPWDZq8V_h-MMKQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Add devfreq based clock scaling support for mmc
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        vbadigan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 July 2018 at 11:52, Sayali Lokhande <sayalil@codeaurora.org> wrote:
> This change adds the use of devfreq based clock scaling to MMC.
> Both eMMC and SD card can use it.
> For some workloads, such as video playback, it isn't necessary
> for these cards to run at high speed. Running at lower frequency,
> in such cases can still meet the deadlines for data transfers.
> Scaling down the clock frequency dynamically has power savings
> not only because the bus is running at lower frequency but also
> has an advantage of scaling down the system core voltage, if supported.
> Provide an ondemand clock scaling support similar to the cpufreq
> ondemand governor having two thresholds, up_threshold and
> down_threshold to decide whether to increase the frequency or
> scale it down respectively as per load.
>
> Sahitya Tummala (1):
>   devfreq: Add new flag to do simple clock scaling
>
> Sayali Lokhande (6):
>   mmc: core: devfreq: Add devfreq based clock scaling support
>   mmc: core: Add sysfs entries for dynamic control of clock scaling
>   mmc: core: add support for devfreq suspend/resume
>   mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
>   mmc: sdhci-msm: Enable clock scaling property
>   mmc: core: Add a debugfs entry to set max clock rate
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
>  Documentation/mmc/mmc-dev-attrs.txt                |  38 ++
>  drivers/devfreq/governor_simpleondemand.c          |  25 +-
>  drivers/mmc/core/core.c                            | 672 +++++++++++++++++++++
>  drivers/mmc/core/core.h                            |   9 +
>  drivers/mmc/core/debugfs.c                         |  90 +++
>  drivers/mmc/core/host.c                            | 163 ++++-
>  drivers/mmc/core/mmc.c                             | 227 ++++++-
>  drivers/mmc/core/sd.c                              |  85 ++-
>  drivers/mmc/host/Kconfig                           |   2 +
>  drivers/mmc/host/sdhci-msm.c                       |  38 ++
>  drivers/mmc/host/sdhci-pltfm.c                     |  11 +
>  drivers/mmc/host/sdhci.c                           |  27 +
>  drivers/mmc/host/sdhci.h                           |   8 +
>  include/linux/devfreq.h                            |   4 +
>  include/linux/mmc/card.h                           |   5 +
>  include/linux/mmc/host.h                           |  70 +++
>  17 files changed, 1475 insertions(+), 9 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Thanks for you patchse! Just wanted to let you know that I am current
in holiday mode, so I needs some more time to review this properly.
Apologize for the inconvenience.

Kind regards
Uffe
