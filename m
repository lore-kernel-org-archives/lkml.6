Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16539ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rEXdpxUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeGSJ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:27:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeGSJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:27:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so7193325wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDXdExwNO/MxRPPIvzvYhgBwU4B9K2iZDmR9/gTdXUU=;
        b=rEXdpxUpa79Pi8vkRcL3fQ6hPLT0vMugGeQAqitMCUxVOpFa7H/xfURkhKSJEgQBgq
         gfvgQeEeTZKBConmkibTCVnMWKO6+7C3Y6bcbBYvYusQf9VyCp69UiOSllt4PXhSX604
         WTDM/I9Z6je+KK8PvgxiDmlEQSt3E09M6X+f8JpoQOyDilr11AdHYdOqzZiBvBbC6ST3
         NAzi1uuWNi7B8XLWLfB1BViQEkrTsb2/Rl7/tgF4bN/uSuZWzxSPe72Xh+JgcER2uRUR
         ehZOp/3ldq+lrlG96zUSyG9/P0Zu0LcGsYfwwo1oILM81c5ghm4ljijpEME+7+QGhhr+
         djMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDXdExwNO/MxRPPIvzvYhgBwU4B9K2iZDmR9/gTdXUU=;
        b=m/YDknjQCTy0tyiNhZyH8AVxRclffkwj45GTlBjuNpHm1Q2+oVbHe2KxYBn53v9LYW
         DrsKJORuUK+tI4M4sUnBsWI4UhJ7wxHBXc7TPHgh3yvCTIHpi+k9nEhq2EC/1PxaDFEm
         uoNnJ+SayWSJ8Qolw9zH+G+lG8QqyxYlRE4eNmNl2TY9IJmZsKWy7Sj2xji7TRKIk9v8
         3qqi5CdgoPGcGz9OcdMid/FyYoHsAothA2nMHNrE7NTexj5j5wkLrhCiRjKvxWrWy3Aq
         AOlnTe9jI9qqajJx4BzijIuilYaNQlMGSNeRV/+Zc1NIiW5xmk6a1khAhhh9ymeKwVTV
         YoNg==
X-Gm-Message-State: AOUpUlFwMq2jPiboJ6XMPVYcVV2O3tTgWpzScNwgkbgJhFwCsTKwgBEf
        fFVlgjIrb4fDqSsEGBnXmvem/w==
X-Google-Smtp-Source: AAOMgpdFquYB0A4h7bh/O8soEmyVJpYxa4YaFdGGQawITz6Z/Qz0g+AlxRcmF2rNNxHSqDQVqr1Ggw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr6974266wrs.137.1531989938714;
        Thu, 19 Jul 2018 01:45:38 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u185-v6sm3460778wmg.25.2018.07.19.01.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 01:45:38 -0700 (PDT)
Message-ID: <1531989937.26720.22.camel@baylibre.com>
Subject: Re: [PATCH 2/3] clk: meson: clk-pll: remove od parameters
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 19 Jul 2018 10:45:37 +0200
In-Reply-To: <fa95a61b-3fde-1401-e2bc-f3465e5f4417@baylibre.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-3-jbrunet@baylibre.com>
         <fa95a61b-3fde-1401-e2bc-f3465e5f4417@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 10:42 +0200, Neil Armstrong wrote:
> > +static struct clk_regmap gxl_hdmi_pll_od = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_HDMI_PLL_CNTL + 8,
> > +             .shift = 16,
> > +             .width = 2,
> > +             .flags = CLK_DIVIDER_POWER_OF_TWO,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "hdmi_pll_od",
> > +             .ops = &clk_regmap_divider_ro_ops,
> > +             .parent_names = (const char *[]){ "hdmi_pll_dco" },
> > +             .num_parents = 1,
> > +             .flags = CLK_GET_RATE_NOCACHE,
> > +     },
> > +};
> 
> In my code, the GXL OD1 is at bit 21
> 
> > +
> > +static struct clk_regmap gxl_hdmi_pll_od2 = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_HDMI_PLL_CNTL + 8,
> > +             .shift = 22,
> > +             .width = 2,
> > +             .flags = CLK_DIVIDER_POWER_OF_TWO,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "hdmi_pll_od2",
> > +             .ops = &clk_regmap_divider_ro_ops,
> > +             .parent_names = (const char *[]){ "hdmi_pll_od" },
> > +             .num_parents = 1,
> > +             .flags = CLK_GET_RATE_NOCACHE,
> > +     },
> > +};
> 
> 
> In my code, the GXL OD3 is at bit 23
> 
> > +
> >   static struct clk_regmap gxl_hdmi_pll = {
> > -     .data = &(struct meson_clk_pll_data){
> > -             .en = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL,
> > -                     .shift   = 30,
> > -                     .width   = 1,
> > -             },
> > -             .m = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL,
> > -                     .shift   = 0,
> > -                     .width   = 9,
> > -             },
> > -             .n = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL,
> > -                     .shift   = 9,
> > -                     .width   = 5,
> > -             },
> > -             .frac = {
> > -                     /*
> > -                      * On gxl, there is a register shift due to
> > -                      * HHI_HDMI_PLL_CNTL1 which does not exist on gxbb,
> > -                      * so we compute the register offset based on the PLL
> > -                      * base to get it right
> > -                      */
> > -                     .reg_off = HHI_HDMI_PLL_CNTL + 4,
> > -                     .shift   = 0,
> > -                     .width   = 12,
> > -             },
> > -             .od = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL + 8,
> > -                     .shift   = 21,
> > -                     .width   = 2,
> > -             },
> > -             .od2 = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL + 8,
> > -                     .shift   = 23,
> > -                     .width   = 2,
> > -             },
> > -             .od3 = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL + 8,
> > -                     .shift   = 19,
> > -                     .width   = 2,
> > -             },
> > -             .l = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL,
> > -                     .shift   = 31,
> > -                     .width   = 1,
> > -             },
> > -             .rst = {
> > -                     .reg_off = HHI_HDMI_PLL_CNTL,
> > -                     .shift   = 29,
> > -                     .width   = 1,
> > -             },
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_HDMI_PLL_CNTL + 8,
> > +             .shift = 18,
> > +             .width = 2,
> > +             .flags = CLK_DIVIDER_POWER_OF_TWO,
> 
> 
> In my code, the GXL OD3 is at bit 19
> 
> It's only a copy/paste error, the original code had the correct shifts.

Absolutely. Good catch. 

