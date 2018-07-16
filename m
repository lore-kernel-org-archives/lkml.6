Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586CBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B49208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B49208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGPWOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:14:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35780 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:14:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id i12-v6so77720777oik.2;
        Mon, 16 Jul 2018 14:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXyaFNm4FzYa/u6i0VUST7NzYpJ/i6ZkI5VwEONsaW8=;
        b=gwhkq43ulG9V++TwuwdepeDpGF4B/yeIuWrZhOkKsQE5sxIUnj9EZczBofyd9AKQRO
         z/y5B0BIIkzyCtlHaPrqVSBXrTmLHZBh4tLnKYO+Y7lppwANFlFYQSekclq6aqSejQ3F
         EaSp/55CxlyXgoAWRHDeESDILJ+jD1pMeXKcSrrdeQkkbG5komMJgBtrX1YXlbHo2MtH
         D4HGOO/6186zu4nciAmoIybLpIrngfw79Z5OkLwJGb3Ojxbb7lkFddSCjPA9mQcdIpCt
         gyFRf+2uXZWv33EoyIc6sRWXTYDc0UGPuru3cEgOXrle+xEL3jrJPhwJN8EwXVIZZRLb
         Ll5Q==
X-Gm-Message-State: AOUpUlHxOTWMfL/k2hGfB/2Npq7OvW3AANFQi5q/2mNxuH0Z8DZXYOzy
        PHFGHGLQuHzlGnZWYoAezULQ63o=
X-Google-Smtp-Source: AAOMgpcz6kggZPCdp7JFEtMyzLEJIZ6ai0B94uNZJeoOuoXlPS5S9C0fr2Ek8bREIGIGTIWFHSGovg==
X-Received: by 2002:aca:417:: with SMTP id 23-v6mr1108530oie.90.1531777518412;
        Mon, 16 Jul 2018 14:45:18 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q205-v6sm21233385oia.7.2018.07.16.14.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:45:17 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:45:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
Message-ID: <20180716214516.GA31738@rob-hp-laptop>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:21:49PM +0200, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/soc/amlogic/clk-measure.txt       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> new file mode 100644
> index 0000000..ba9183a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> @@ -0,0 +1,15 @@
> +Amlogic Internal Clock Measurer
> +===============================
> +
> +The Amlogic SoCs contains an IP to measure the internal clocks.
> +The precision is multiple of MHz, useful to debug the clock states.

What a simple yet useful debug tool.

> +
> +Required properties:
> +- compatible: Shall contain "amlogic,meson-gx-clk-measure"
> +- reg: base address and size of the Clock Measurer register space.
> +
> +Example:
> +	clock-measure@8758 {
> +		compatible = "amlogic,meson-gx-clk-measure";
> +		reg = <0x0 0x8758 0x0 0x10>;

This doesn't really look like its own block though. Can't the parent 
device instantiate the driver for this?


> +	};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
