Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C695FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FAA2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FAA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeJSAwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:52:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJSAwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:52:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id l1so30429748otj.5;
        Thu, 18 Oct 2018 09:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTUWqaaZ98ytfdqgPeW6No6lKzSAW9xYjVcnxmk1Wcg=;
        b=IgMy+3EQFeLVgXkha5oT3OsngLQJvoNUNwfy5bYGjwcahagum7PnfIIkh8auPtT2oU
         oYbRCuirjy8hI9WZI2PVYwEwu3Rq8gP4kHYg3Eef8XbF1fpZ3TqQsXTgry8A/T6OGppx
         1kTm+SpQmF7i5n7CB+3cwQpkhwCFmScFlAY8qJhNV8Cf/DqJo/J/0vBaXc0ZbXXM25J+
         K33r6FFJaqNgOORRxILIghm7rJaDgJ/b05DxAYLvbIwkM04yoLOt2Xx/oV0RMa4XTXBz
         6zMQWuWa5oqDYNnerTrwGs6uC49ArsPT0JY0avsryj8VxrkZ1r/O6ElwkjKA66OIVJvf
         pNVw==
X-Gm-Message-State: ABuFfohQDj+2tzTw1JtcJ5zSg3TBiVLoNuSaouVYtTDBfVNPkmWQWv40
        zvkgyYkH4i5BDIBhVkjXsQ==
X-Google-Smtp-Source: ACcGV635xyDGSruLE+EvSWdZFNOaI1vy7IAm4eH0gzowoWHHWl8mgWmczk9zpQSSE/ehrN7aiktE/w==
X-Received: by 2002:a9d:1566:: with SMTP id z35mr21274309otz.325.1539881462824;
        Thu, 18 Oct 2018 09:51:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17-v6sm6487735oia.43.2018.10.18.09.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:51:02 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:51:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Message-ID: <20181018165101.GA11562@bogus>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
 <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:09:22PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
> 
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..1f70e5d 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,17 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
> + - ocv-capacity-table-0: An array providing the battery capacity percent
> +   with corresponding open circuit voltage (OCV) of the battery, which
> +   is used to look up battery capacity according to current OCV value.
> +   And the open circuit voltage unit is microvolt.

The order percent and voltage is still not clear. I'd guess one way 
based on the text here, but the example is the opposite. The description 
here must stand on its own.

> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
> + - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
> +   for each of the battery capacity lookup table. The first temperature value
> +   specifies the OCV table 0, and the second temperature value specifies the
> +   OCV table 1, and so on.
>  
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +55,10 @@ Example:
>  		constant-charge-current-max-microamp = <900000>;
>  		constant-charge-voltage-max-microvolt = <4200000>;
>  		factory-internal-resistance-micro-ohms = <250000>;
> +		ocv-capacity-celsius = <(-10) 0 10>;
> +		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> +		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> +		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>  	};
>  
>  	charger: charger@11 {
> -- 
> 1.7.9.5
> 
