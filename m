Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A726C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000E2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeGaXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:04:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42054 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:04:12 -0400
Received: by mail-io0-f194.google.com with SMTP id g11-v6so14295813ioq.9;
        Tue, 31 Jul 2018 14:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xWgSSZMU1Vb4uQ3vAr9DJu9XRuM567DM/2ZOehY6cgQ=;
        b=Th4hnhZIpfas70ZhwiLUI/QHw4RgMbRmDI7Eh+LoHeOBanRG/8IfOksYPQ7NPZvzry
         8Vgit3agPAnKr0DTxt0vQTPqagSYmIZIX4e2Qlf9uuWR/7i+j84IKBKnEPlzP/gONZzg
         N32dhf4EN8zzn2zo2WTtf1FLxWdBw15wTFqQCyhPS2XQKZhPHl7WddJQUF1qHzXQ7cKx
         ML36cyFVmAm/BhAwxtmsEfXuSblDxyerKbdZ+ZtAy25ph1Amu0Yg8rxUcJTdvfbv7NRf
         UUXONdEYgsqABTQ8CaIV9AhJ+PnaT34I1RYvKNapvkztWNAR8140Kq2uS1u9wHSGQcml
         d84g==
X-Gm-Message-State: AOUpUlGsB9DbzJvSHiqUGTOta6uRmaYrEr59e3Wnqawu7UfCATXmpKVw
        sQbJxqc0VN/7GKTly9i56w==
X-Google-Smtp-Source: AAOMgpdnzDicMKMtP4dmxdN9ZfkT2DX8lfmkNseBJW3qwnH/EDrt04uUAOs3MWaH79d+joFE6NZdbQ==
X-Received: by 2002:a6b:c409:: with SMTP id y9-v6mr1235470ioa.77.1533072115928;
        Tue, 31 Jul 2018 14:21:55 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 82-v6sm2492168itm.2.2018.07.31.14.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:21:55 -0700 (PDT)
Date:   Tue, 31 Jul 2018 15:21:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 15/15] clk: pistachio: Fix wrong SDHost card speed
Message-ID: <20180731212154.GA17395@rob-hp-laptop>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-16-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180722212010.3979-16-afaerber@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 11:20:10PM +0200, Andreas Färber wrote:
> From: Govindraj Raja <Govindraj.Raja@imgtec.com>
> 
> The SDHost currently clocks the card 4x slower than it
> should do, because there is a fixed divide by 4 in the
> sdhost wrapper that is not present in the clock tree.
> To model this, add a fixed divide by 4 clock node in
> the SDHost clock path.
> 
> This will ensure the right clock frequency is selected when
> the mmc driver tries to configure frequency on card insert.
> 
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/clk/pistachio/clk-pistachio.c     | 3 ++-
>  include/dt-bindings/clock/pistachio-clk.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
> index c4ceb5eaf46c..1c968d9a6e17 100644
> --- a/drivers/clk/pistachio/clk-pistachio.c
> +++ b/drivers/clk/pistachio/clk-pistachio.c
> @@ -44,7 +44,7 @@ static struct pistachio_gate pistachio_gates[] __initdata = {
>  	GATE(CLK_AUX_ADC_INTERNAL, "aux_adc_internal", "sys_internal_div",
>  	     0x104, 22),
>  	GATE(CLK_AUX_ADC, "aux_adc", "aux_adc_div", 0x104, 23),
> -	GATE(CLK_SD_HOST, "sd_host", "sd_host_div", 0x104, 24),
> +	GATE(CLK_SD_HOST, "sd_host", "sd_host_div4", 0x104, 24),
>  	GATE(CLK_BT, "bt", "bt_div", 0x104, 25),
>  	GATE(CLK_BT_DIV4, "bt_div4", "bt_div4_div", 0x104, 26),
>  	GATE(CLK_BT_DIV8, "bt_div8", "bt_div8_div", 0x104, 27),
> @@ -54,6 +54,7 @@ static struct pistachio_gate pistachio_gates[] __initdata = {
>  static struct pistachio_fixed_factor pistachio_ffs[] __initdata = {
>  	FIXED_FACTOR(CLK_WIFI_DIV4, "wifi_div4", "wifi_pll", 4),
>  	FIXED_FACTOR(CLK_WIFI_DIV8, "wifi_div8", "wifi_pll", 8),
> +	FIXED_FACTOR(CLK_SDHOST_DIV4, "sd_host_div4", "sd_host_div", 4),
>  };
>  
>  static struct pistachio_div pistachio_divs[] __initdata = {
> diff --git a/include/dt-bindings/clock/pistachio-clk.h b/include/dt-bindings/clock/pistachio-clk.h
> index 039f83facb68..77b92aed241d 100644
> --- a/include/dt-bindings/clock/pistachio-clk.h
> +++ b/include/dt-bindings/clock/pistachio-clk.h
> @@ -21,6 +21,7 @@
>  /* Fixed-factor clocks */
>  #define CLK_WIFI_DIV4			16
>  #define CLK_WIFI_DIV8			17
> +#define CLK_SDHOST_DIV4			18

Does this clock really need to be exposed in DT?

>  
>  /* Gate clocks */
>  #define CLK_MIPS			32
> -- 
> 2.16.4
> 
