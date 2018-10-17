Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B302ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8A52151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8A52151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJQWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:00:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46664 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:00:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id o21so26246472otb.13;
        Wed, 17 Oct 2018 07:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BIbpW0Zmtwqhn5DVGrQurxJjnJs3iG37UzRho7qr5Lk=;
        b=n5jlgtHUgrEGBOISqTGEQVzguL8zMDuXwhjqRnEkRzddgPly9dthskZMCajQbGG6Y0
         3frZkGVkTVOz/owf68M3DzXl2OZtBXKvVy+2r3js5dEiYvOrkSYZorL95DUV7/+gvSNk
         8HCAb9olcga5gvPCxJzzR90inOu0fqW7tDJnCBaR7+C11qUQ7zfoxTMQ24diZyS7j1bw
         JVIB3eKAp28mp/emszPOm0q1UWk+Q4rCk5piQeFC0l4oGKmF/zO5GHHkSVirE6hM7odv
         zSn1hk69y2LP7QDs/zbF3SSD4xR5W7ZTyKX8tz7g9RR3IIqxlhjl6Yv7ugN2gC+n025E
         JKdw==
X-Gm-Message-State: ABuFfojizMj6SQ3lt+OMuREXQ2OwumGMFJDtw4wguCXKC5xdpqiAK4Oo
        5BIdNq/ekAAqeQ1q/jH4yw==
X-Google-Smtp-Source: ACcGV60F91FyDT0EXASNdzi+uaQESxsWNVmze055iF/h2nsXO9yCqmZ9ovM7DJXX61djied7KsIM8A==
X-Received: by 2002:a9d:5b72:: with SMTP id e47mr17649594otj.318.1539785094069;
        Wed, 17 Oct 2018 07:04:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i42sm5891974otb.4.2018.10.17.07.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:04:53 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:04:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, Talel Shenhar <tatias@codeaurora.org>
Subject: Re: [PATCH V1 2/7] mmc: core: devfreq: Add devfreq based clock
 scaling support
Message-ID: <20181017140452.GA7908@bogus>
References: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
 <1539003486-24087-3-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539003486-24087-3-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:28:01PM +0530, Sayali Lokhande wrote:
> This change adds the use of devfreq to MMC.
> Both eMMC and SD card will use it.
> For some workloads, such as video playback, it isn't
> necessary for these cards to run at high speed.
> Running at lower frequency, for example 52MHz, in such
> cases can still meet the deadlines for data transfers.
> Scaling down the clock frequency dynamically has power
> savings not only because the bus is running at lower frequency
> but also has an advantage of scaling down the system core
> voltage, if supported.

Is there really power savings if there's no voltage control?

> Provide an ondemand clock scaling support similar to the
> cpufreq ondemand governor having two thresholds,
> up_threshold and down_threshold to decide whether to
> increase the frequency or scale it down respectively.
> The sampling interval is in the order of milliseconds.
> If sampling interval is too low, frequent switching of
> frequencies can lead to high power consumption and if
> sampling interval is too high, the clock scaling logic
> would take long time to realize that the underlying
> hardware (controller and card) is busy and scale up
> the clocks.

Why the short lines?

> 
> Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +

Bindings should be separate patches.

>  drivers/mmc/core/core.c                            | 556 +++++++++++++++++++++
>  drivers/mmc/core/core.h                            |   7 +
>  drivers/mmc/core/debugfs.c                         |  46 ++
>  drivers/mmc/core/host.c                            |   8 +
>  drivers/mmc/core/mmc.c                             | 200 +++++++-
>  drivers/mmc/core/sd.c                              |  72 ++-
>  drivers/mmc/host/sdhci-msm.c                       |  37 ++
>  drivers/mmc/host/sdhci-pltfm.c                     |  11 +
>  drivers/mmc/host/sdhci.c                           |  27 +
>  drivers/mmc/host/sdhci.h                           |   8 +
>  include/linux/mmc/card.h                           |   5 +
>  include/linux/mmc/host.h                           |  70 +++
>  13 files changed, 1055 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..bd8470a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,6 +26,15 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +- qcom,devfreq,freq-table - specifies supported frequencies for clock scaling.
> +				    Clock scaling logic shall toggle between these frequencies based
> +				    on card load. In case the defined frequencies are over or below
> +				    the supported card frequencies, they will be overridden
> +				    during card init. In case this entry is not supplied,
> +				    the driver will construct one based on the card
> +				    supported max and min frequencies.
> +				    The frequencies must be ordered from lowest to highest.

Why is this qcom specific?

I believe I also saw interconnect binding for SD/MMC. How does that 
relate to this? There should be some coordination of this work.

>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -43,6 +52,7 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +		qcom,devfreq,freq-table = <52000000 200000000>;
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
