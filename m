Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA8EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B43620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeGTQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:13:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33495 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGTQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:13:25 -0400
Received: by mail-it0-f65.google.com with SMTP id y124-v6so5490189itc.0;
        Fri, 20 Jul 2018 08:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFA4mjE/HVl8hMBJBWJcu89QJ0NOpYfLuoAZ37I297s=;
        b=BHmQlPW/uxR4c2MGuIx9J7HiF6XDuzQJMMdUVzvVQCeBRGRMF8SUQ6Q10Qz3kKhmy5
         n1ag22aW/ISzTPobE9S2M+UzvVH0KaC/E5p8Q4O1WrvWiQm3ZXQg37oZgHprYPBrrwTo
         7Z9XvucrJUjxYBSQ2QZwddG4Cz8SkBTW9MczT6pSM25PK3q+IFSWkptHjSfIeVcMYo2o
         x2bwXV4YVkvN6QoYLbWEQ3HNCU3VO9T9oXjRGZgh8n7qrizgk+EACVOOKkwt7VnO6m+p
         i5/Hpeq+5va4HoZ6Nixw8lu7O3kKxtTh70wRLoo/0bVNgLADYaXpi3xlPqMiFpUCZowK
         G5HQ==
X-Gm-Message-State: AOUpUlFmU9R3vNTVyNHZexabhpnTGIeGf2OlpZNGfUd4ET4oSnxXYc9g
        /vT9mkolA0r+gx0weAV5zQ==
X-Google-Smtp-Source: AAOMgpfJQqneBgQOtOH2nOLLMvcVQyC9veLwHLXcI/TlAeaw8PoiMu4BO3eFLgB3Hcu9mrQmEOy1LA==
X-Received: by 2002:a02:41d8:: with SMTP id n85-v6mr2264548jad.108.1532100277710;
        Fri, 20 Jul 2018 08:24:37 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v126-v6sm624052iof.31.2018.07.20.08.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:24:37 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:24:36 -0600
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
        Talel Shenhar <tatias@codeaurora.org>
Subject: Re: [PATCH RFC 2/7] mmc: core: devfreq: Add devfreq based clock
 scaling support
Message-ID: <20180720152436.GA4566@rob-hp-laptop>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
 <1531475583-7050-3-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531475583-7050-3-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 03:22:58PM +0530, Sayali Lokhande wrote:
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
> 
> Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
>  drivers/mmc/core/core.c                            | 560 +++++++++++++++++++++
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
>  13 files changed, 1059 insertions(+), 2 deletions(-)
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

This should be a common binding in which case will just a list of 
frequencies be sufficient.

Rob
