Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C478C21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C478C21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeI1ADh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:03:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39063 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI1ADh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:03:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id c12-v6so3389777otl.6;
        Thu, 27 Sep 2018 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opI7Sye5yL4RSrSfntxIglMzQQxBp0lGtYEpA+tZ47Y=;
        b=aI0UMw1pocBM+cigCJQ00iHwMjcnyQX77Or666NreHvAPYnp2Sf8oT/od5G4i+mDtW
         qQuYSlC5MP4iwKkI//iLsKpJMQl/g+frfisUqNbcPMRJpzzgUW2/x6avdbxtF5adXSsW
         Sg5Xr/8Xb0Sr1IEBcSPRzfnSHn6hhQVwDfHpqobDCqScmgphFCcLeJ8dt+Qx5+ypTIL2
         a3T7GfPHIn2NbgHZL2YIoH4a1/xyioBOd+pWhvbriArBjLkR0cQX34DxO2qpZayxPiXe
         iLM7BhO81T0B/nYpoGl0rNEB4FBRuc8gfxKj9KSbRHm6r43x/HjYcsOBg2kg/Q76QkSV
         6fBA==
X-Gm-Message-State: ABuFfogYFyZ4MVGpUqBwK2773+cdf43h5+t72IqI/3xcxgBWuQ4QCr19
        D1sAB95lLxb03WDG20Pbgw==
X-Google-Smtp-Source: ACcGV62DPYJK1UQWSw9CnIY2xBb1rdvCeC3qQ1JJ3/TArIf+GInwk0B+N+C7trV0OJSaIha9EoHYTQ==
X-Received: by 2002:a9d:2555:: with SMTP id j21-v6mr1408083otd.125.1538070254490;
        Thu, 27 Sep 2018 10:44:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o75-v6sm1118782ota.27.2018.09.27.10.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:44:13 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:44:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180927174413.GB7587@bogus>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925225930.31886-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 03:59:29PM -0700, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v4->v5:
>  * Replaced "input-id" with "reg" and added address-cells and size-cells
>  * Replaced "input-label" with "label"
>  * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
> v3->v4:
>  * Removed the attempt of putting labels in the node names
>  * Added a new optional label property in the child node
>  * Updated examples accordingly
> v2->v3:
>  * Added a simple subject in the line 1
>  * Fixed the shunt resistor value in the example
> v1->v2:
>  * Dropped channel name properties
>  * Added child node definitions.
>  * * Added shunt resistor property in the child node
>  * * Added status property to indicate connection status
>  * * Changed to use child node name as the label of input source
> 
>  .../devicetree/bindings/hwmon/ina3221.txt     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> new file mode 100644
> index 000000000000..e17a897f4803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,49 @@
> +Texas Instruments INA3221 Device Tree Bindings
> +
> +1) ina3221 node
> +  Required properties:
> +  - compatible: Must be "ti,ina3221"
> +  - reg: I2C address
> +
> +  Optional properties:
> +  = The node contains optional child nodes for three channels =
> +  = Each child node describes the information of input source =
> +
> +  - #address-cells: Required only if a child node is present. Must be 1.
> +  - #size-cells: Required only if a child node is present. Must be 0.
> +
> +  Example:
> +
> +  ina3221@40 {
> +          compatible = "ti,ina3221";
> +          reg = <0x40>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          [ child node definitions... ]
> +  };
> +
> +2) child nodes
> +  Required properties:
> +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> +
> +  Optional properties:
> +  - label: Name of the input source
> +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> +  - status: Should be "disabled" if no input source

Don't need to explicitly list status.

> +
> +  Example:
> +
> +  input@0 {
> +          reg = <0x0>;
> +          status = "disabled";
> +  };
> +  input@1 {
> +          reg = <0x1>;
> +          shunt-resistor-micro-ohms = <5000>;
> +  };
> +  input@2 {
> +          reg = <0x2>;
> +          label = "VDD_5V";
> +          shunt-resistor-micro-ohms = <5000>;
> +  };

Please combine the examples into one complete example.

Rob
