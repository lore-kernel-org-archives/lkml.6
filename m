Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0093920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0093920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJLWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:08:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36549 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeJLWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:08:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so10023833oic.3;
        Fri, 12 Oct 2018 07:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwVfaSO92we1ZAmc6v9BDIq47cpl1Ky0G9WYjwEqf/M=;
        b=Ks1aTrUtE04q8xNJIhOG+u7SS15JOsASPX1qLf8jq0NPvmCbXAaq+T16Etw/kWY8OT
         zwY5eyrX4gYiYxM1S//tXjc4jNcRXLLkKVUQ71eSDk5lfK0GOnlk2Q0fml4UkM4LxQU7
         eDkmDMBkaxntHnb3i847TtnQYeYC8I/D+5fXyDYaYyK5IDGmZQOgti9hELFueQDZfkjJ
         1Z/t3Uimfg47U/GtD6Q4IP/1M+nEM7o4J91+vVNEWJ/0qHrfnxtXR1dzibU705SN8M/5
         dceg/Wp6mvE9RMXcqudiNaGPQKz1VoNBjTJ/3CLVfXXURepl6xBTPWi9KIFZ7uOU63Ux
         kI2Q==
X-Gm-Message-State: ABuFfohX0nebgR5B0DEJW3CVkEKRXicQijzyYClwXvxHqikyOw3OW6bo
        QcVqxdwqryBbs8kcd7eSiA==
X-Google-Smtp-Source: ACcGV63GIgonsYiwULSItOPSBLFH8ounXwg9OcflTgmtDQ4JgjQ9PCPCOHQRjK/1korhcOo9cHWROg==
X-Received: by 2002:aca:704:: with SMTP id 4-v6mr3148770oih.119.1539354932180;
        Fri, 12 Oct 2018 07:35:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 31-v6sm369846ota.23.2018.10.12.07.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:35:31 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:35:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 2/4] power: supply: core: Introduce properties to
 present the battery OCV capacity table
Message-ID: <20181012143530.GA28145@bogus>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:26:55PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values. Moreover it also provides some
> helper functions to use the OCV capacity table for users.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++

Please split binding patches.

>  drivers/power/supply/power_supply_core.c           |  125 +++++++++++++++++++-
>  include/linux/power_supply.h                       |   19 +++
>  3 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..cad38df 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,16 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
> + - ocv-capacity-table-0: An array providing the battery capacity percent
> +   with corresponding open circuit voltage (OCV) of the battery, which
> +   is used to look up battery capacity according to current OCV value.
> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0

So it is tubles of (percent, voltage)? What's the units for voltage?

What determines the # of entries for each table? Do all tables have the 
same number of entries?

> + - ocv-capacity-table-temperatures: An array containing the temperature
> +   in degree Celsius, for each of the battery capacity lookup table.
> +   The first temperature value specifies the OCV table 0, and the second
> +   temperature value specifies the OCV table 1, and so on.

This should have unit suffix. Perhaps just "ocv-capacity-celsius" to 
avoid being too long.

>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +54,10 @@ Example:
>  		constant-charge-current-max-microamp = <900000>;
>  		constant-charge-voltage-max-microvolt = <4200000>;
>  		factory-internal-resistance-micro-ohms = <250000>;
> +		ocv-capacity-table-temperatures = <(-10) 0 10>;
> +		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> +		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> +		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>  	};
>  
>  	charger: charger@11 {
