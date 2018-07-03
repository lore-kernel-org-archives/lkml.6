Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95956C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519E9249C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E9249C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbeGCQv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:51:56 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40020 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932410AbeGCQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:51:54 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so5164583oie.7;
        Tue, 03 Jul 2018 09:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBs1maIYDMZO+36cSG4e8VCZSRVYH39XH2ie5QV3ivs=;
        b=PXCNCwwcR9aIVHgTQpeAeIo9qZOo3kBNbbX0oSOT0uSJwLiwjzE0v3EV9fxWKkPwdZ
         r0cycEQlC8C+cNPw1oWvBP1LhlgFGEASZohzRn8AcvHXhGt0UiK9RQzwmuSeGEY055fP
         oFyNMGxA09Ay41eAGJRbMu3ulAjbe0KuzsWpYP1RgF4PQIJmBgTzbjF/O8viSIpzm7oT
         Fw00/Gt5gNaD74QG/+fgvvsGUoLSAjxF5kfY1ZXukOXZDzhiSEOJFDGFYoxhuhKTMzwy
         UxgukBIY9upGu0OfD1a1jIQiULMHR/4e1714bsTGfI8sbAavV6k3NAdFF3a40qGqz/Oc
         9Qqg==
X-Gm-Message-State: APt69E1FiEUuiQ+AbYKXPmxNUVqjfy8emGDDhFV0LwWNTfighsKZjNk0
        tXn0DuO7ql5k+WEv7OhVdA==
X-Google-Smtp-Source: AAOMgpcyZtJO9E1h67U7/suHDOisQ77cnLmVMUdn8xqaj5+MMRcL+O9C87BSgSs+HArlBq3aryuObg==
X-Received: by 2002:aca:f5d1:: with SMTP id t200-v6mr14876493oih.12.1530636713668;
        Tue, 03 Jul 2018 09:51:53 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r3-v6sm667535oig.49.2018.07.03.09.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:51:52 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:51:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Jason M Biils <jason.m.bills@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Milton Miller II <miltonm@us.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH linux-next v6 04/13] dt-bindings: Add a document of PECI
 adapter driver for ASPEED AST24xx/25xx SoCs
Message-ID: <20180703165148.GA11628@rob-hp-laptop>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194024.20771-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621194024.20771-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:40:24PM -0700, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document of PECI adapter driver for ASPEED
> AST24xx/25xx SoCs.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Milton Miller II <miltonm@us.ibm.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.txt  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> new file mode 100644
> index 000000000000..8c35f905589d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> @@ -0,0 +1,57 @@
> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> +
> +Required properties:
> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
> +		      - aspeed,ast2400-peci: ASPEED AST2400 family PECI
> +					     controller
> +		      - aspeed,ast2500-peci: ASPEED AST2500 family PECI
> +					     controller

Just this is sufficient:

Should be one of: 
	"aspeed,ast2400-peci"
	"aspeed,ast2500-peci"

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +- reg               : Should contain PECI controller registers location and
> +		      length.
> +- #address-cells    : Should be <1> required to define a client address.
> +- #size-cells       : Should be <0> required to define a client address.
> +- interrupts        : Should contain PECI controller interrupt.
> +- clocks            : Should contain clock source for PECI controller. Should
> +		      reference the external oscillator clock in the second
> +		      cell.
> +- resets            : Should contain phandle to reset controller with the reset
> +		      number in the second cell.
> +- clock-frequency   : Should contain the operation frequency of PECI controller
> +		      in units of Hz.
> +		      187500 ~ 24000000
> +
> +Optional properties:
> +- msg-timing        : Message timing negotiation period. This value will
> +		      determine the period of message timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- addr-timing       : Address timing negotiation period. This value will
> +		      determine the period of address timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
> +		      time will be divided into 16 time frames. This value will
> +		      determine the time frame in which the controller will
> +		      sample PECI signal for data read back. Usually in the
> +		      middle of a bit time is the best.
> +		      0 ~ 15 (default: 8)
> +- cmd-timeout-ms    : Command timeout in units of ms.
> +		      1 ~ 60000 (default: 1000)
> +
> +Example:
> +	peci0: peci-bus@0 {
> +		compatible = "aspeed,ast2500-peci";
> +		reg = <0x0 0x60>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <15>;
> +		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +		resets = <&syscon ASPEED_RESET_PECI>;
> +		clock-frequency = <24000000>;
> +		msg-timing = <1>;
> +		addr-timing = <1>;
> +		rd-sampling-point = <8>;
> +		cmd-timeout-ms = <1000>;
> +	};
> -- 
> 2.17.1
> 
