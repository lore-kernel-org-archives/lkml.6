Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D31217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521998;
	bh=A4ja4HTcsByf/U7YpS1F/SraQtgmrpMbvBGvjm/nZjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tyQWWctpDJJFU0Ev0UJj6dS6tAyvxLN8DK/RERb6D9eWaPb2tCd4RzQfVf0UZZUWW
	 9JnlIDhuGHJgY6fLP35d1F8OQQwW3UeyZ5WG/0mPAYuB9nkz5XwBygyiub6HtNjt0q
	 5loRSKDh+g/eWLn/qeu/4Jpwfen0+GDz9/F71C1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfBRUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:33:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34045 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfBRUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:33:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so30573901oty.1;
        Mon, 18 Feb 2019 12:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvm3pH6cxtlAzN/9pwY/UuTRQR4gOgeaCA1EXwFSEI0=;
        b=X9Q68lVk6nq6LvGC83uYNddq3rky2TK9acRs2Un6HdRucmOL6RoNHCyk885XaYAro0
         7jyGDZkfeX2JFGEvIpYiFaAKQzzMyn0JuKOvaJS92CDbTpBwgrbHu/MwTcQm0tAR1ImU
         +jebbmZJMUcJHrGv1EIKkoQvi4z16TKgIl+rmIQIxdh2L9Eoqh/T3s0CvLcFYLI6wxsp
         ObyzNEy7+L7tLUWPmhHMPRlbeJ+OjXRgKGe88B+WqoELX6r1TXw0qNS2WgIZZhVRFo27
         GLE0O6OOeR6+S0Fb9vjyXZCwdMm1fXU5sdM9XUWBVTrOXLgiuFbGyPlcEeF1Fa0zLjPq
         aTKw==
X-Gm-Message-State: AHQUAuY/l7ZcdbbAOaBEtbwIPr4zw5A/etVzbV2qS9lhVIu0cQZaZLtL
        OL2jGPjRjM3SwnGoVmg3tw==
X-Google-Smtp-Source: AHgI3Ibf/QXjyDT/pIoAftowZtC9vT947lxnYME7IUo62b3yCBZjVwZPA7CTaXerWL5VjXS+D5JJCg==
X-Received: by 2002:a9d:644b:: with SMTP id m11mr15741262otl.90.1550521995426;
        Mon, 18 Feb 2019 12:33:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z5sm3506779otm.14.2019.02.18.12.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:33:14 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:33:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        edubezval@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 04/12] of: Add bindings of gpu hw throttle for Tegra
 soctherm
Message-ID: <20190218203314.GB12911@bogus>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-6-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545118484-23641-6-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:34:36PM +0800, Wei Ni wrote:
> Add "nvidia,gpu-throt-level" property to set gpu hw
> throttle level.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 17 +++++++++++++++--
>  include/dt-bindings/thermal/tegra124-soctherm.h    | 22 ++++++++++++++++++----
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> index ab66d6feab4b..cf6d0be56b7a 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> @@ -52,6 +52,15 @@ Required properties :
>          Must set as following values:
>          TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
>          TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
> +      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.

Also, why not just use percents like nvidia,cpu-throt-percent?

> +        It is the level of pulse skippers, which used to throttle clock
> +        frequencies. It indicates gpu clock throttling depth and can be
> +        programmed to any of the following values which represent a throttling
> +        percentage:
> +        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
> +        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>          See ./thermal.txt for a description of this property.
