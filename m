Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC025C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD0F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD0F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLDXLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:11:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36882 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:11:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so15904293oia.4;
        Tue, 04 Dec 2018 15:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qJA/lf2BQ+t4mD/2hPPscyxkybJ+i2gt51zx4tVD/Vw=;
        b=llh0OW42cTV/k8uuQGlkyV9kcABgXsUER1S02U6K9kPEZj70+W02JzRj/STkXeQO6o
         xdhL1WsFEuAAXj/uHbLVwX5yBEbLMLpvRQlmXJ5C0wnnb4xDrkGHJC4P9QYxIWrgZn+u
         NjPG2derdPPySRABEMZ3uBSGI1xXg6KoGOqxFbRUa6WSbi7/e7oWaFDzgMCxHD39Lygs
         vpZcy8OyJhnmc0ZQGslihxkMZ4NL8miLjpw85WqqFO1hLKnQe+WyLtKiMWgspLm6Vl1t
         +U84rpqyYfKKBbpF8M/XT1sAXT1HD43VRiSxxT/S8R9a51hb/gRDoypmDb5vUZux5vAA
         XwPQ==
X-Gm-Message-State: AA+aEWa4bsLEDmxf46wR8bFt40HxnofEEAMRiYDN32C80eXeBxUJUKgr
        7ko26dUG6cfgDqma9+jrIQ==
X-Google-Smtp-Source: AFSGD/VDNr5BlwFMNeTRMQ3ls+9GmY4a9vNS1NDB5ZlOmoIfWPH3Xvso6OmYIKMKn6Du50LqTKQ6eA==
X-Received: by 2002:aca:d509:: with SMTP id m9mr13147961oig.82.1543965092967;
        Tue, 04 Dec 2018 15:11:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k207sm15083390oih.58.2018.12.04.15.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:11:32 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:11:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
Message-ID: <20181204231131.GA7366@bogus>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:02:12AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V pinctrl.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> new file mode 100644
> index 0000000..7469189
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> @@ -0,0 +1,33 @@
> +Milbeaut SoCs pin controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
> +- reg: offset and length of the register set.
> +- reg-names: should be "pinctrl", "exiu".
> +- gpio-cells; should be 2.

#gpio-cells

gpio-controller?

> +- interrupt-cells: should be 2.

#interrupt-cells

interrupt-controller?

> +- clocks: phandle to the input clock.
> +- interrupts: three interrupts specifer.
> +- interrupt-names: corresponds "interrupts" factor.
> +
> +Example:
> +	pinctrl: pinctrl@1d022000 {
> +		compatible = "socionext,milbeaut-m10v-pinctrl";
> +		reg = <0x1d022000 0x1000>,
> +			<0x1c26f000 0x1000>;
> +		reg-names = "pinctrl", "exiu";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		clocks = <&dummy_clk>;
> +		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +				"pin-52", "pin-53", "pin-54", "pin-55",
> +				"pin-56", "pin-57", "pin-58", "pin-59",
> +				"pin-60", "pin-61", "pin-62", "pin-63";
> +	}
> -- 
> 1.9.1
> 
