Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31946ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6088208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6088208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeGPWeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:34:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36554 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeGPWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:34:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so77816519oie.3;
        Mon, 16 Jul 2018 15:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOYdShU+PCLicfLMaMRpL0Y8xIOY3AdzI2cZZ0rGm2w=;
        b=XCCxwGhmZtexI7JSF0g6SlmPYWA9CpDwVZU5jrZSHhxqtWkEor23MZiFkbdpSE2KYs
         8rZApqzTLl4jCxcWjS8e4Li4NpNOXvK2D0B5dxTKEdF4YBfqks+kSHvhZvh4AYPTKYov
         Iq74aYIBnmxG4pWQVuaJmet2/RLcmsM+8hUL29IGPwr45yF++FA9UDAZqqfWRuIXJ9wo
         IzEhH5fyUinhvcZfwcPOATkCBT5i0o/ymVtCdWqra6b8T7stmUvufZbA6XHFi4YOXLSW
         FcwY4BkixuPo7OJGIcpewx6YhxLSVMkPYKg/3TUnnaXikRK/jcgciDssbnHfezB8J7g2
         IX9g==
X-Gm-Message-State: AOUpUlEcdFp1s/y6wokJwQERwiY2huXo68F3b2G6FTjWQo2vRNgU/L3i
        zXN5HYsCbuy7MFt4hjxGBQ==
X-Google-Smtp-Source: AAOMgpe5CFAFmQjAhcp1HBHHu4aJod6HqS0DBVt18r6DqLII9bi3VHtfsMH5J81RV521GUUUMAJfkg==
X-Received: by 2002:aca:a12:: with SMTP id 18-v6mr1147597oik.292.1531778677162;
        Mon, 16 Jul 2018 15:04:37 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id z196-v6sm65279721oig.12.2018.07.16.15.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:04:36 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:04:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 1/2] dt-bindings: amlogic: Add support for GXL S805X and
 the P241 board
Message-ID: <20180716220435.GA22633@rob-hp-laptop>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
 <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 11:50:42AM +0200, Neil Armstrong wrote:
> The S805X is a variant of the Amlogic Meson GXL SoC family with the
> following physical limitations :
> - No SDCard interface
> - No GPIOCLK pins
> - No USB OTG ID pin (but Gadget feature can stil be forced)
> - No 5V regulator
> - Reduced ADC inputs (only ADC0 and ADC1)
> - GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
>   GPIOX_15, GPIOH_3 are no more exposed on the package
> 
> Amlogic exposes the following SW limitations :
> - HDMI max resolution should be 1080p60, VPU clock should be downgraded
> - Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
> - CPU speed should be limited by SCPI OPP table to 1.2GHz
> - DRAM interface is limited to DDR4 16bit up to 1GiB
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
