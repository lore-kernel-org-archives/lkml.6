Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FFC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AB021736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548116924;
	bh=BgRWrdJPsTDBpCjR8GuXzFSVVLeYzWlPGF1ACJSTqQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPghg2s7nuUEnZ8jFlOOO5WAmUZmqsX3NuM2MThiIKMgeKuO30PdBnsnGrztqoWGi
	 RcQDE3tdXG33hbfUhsXvFR1Nt080s1XncheADEX1eQkBemXOhwql0WOS73fBq/DDok
	 +ZkatozHlMHATyubNhGGqW+7DqgiGzZE2RT/vuvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfAVA2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:28:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36182 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfAVA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:28:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so22153770otk.3;
        Mon, 21 Jan 2019 16:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MI8wDWO5o3fgwn0cqcjZlaFgL+MlqRfNbEwPvkYT7r4=;
        b=e4BavyQlt/iiywu1Zva48AsCKCouFD1sPETkVnijcn3SWTkkhhlmmpZw5Ro9UKIol5
         M0Soi3ac4FrACCci1IYhupLtIrZyJt5Ma4UCwvr/JkJ7d2Xi0RMi5SMyaxx8WGzTJkf7
         KKYUSINTZF6zMeZKc1PS2ykf9a3mzs1BKKSxBOpRrfUPZHFN3IMXPLU78Yqa9TJ8znTT
         GSEeUmEqLySVae0lwpeT6akkYsw4kZhwnwONOSRyQj4e8z7CoIMfXa7ztkjEK2AR0d5j
         oky+9PIZM+0Js8baULlIzH1YWT+LUZvdFOCbGYQqxipfY2VZi3/Z3GZ6vMZPlABYfEqi
         K/fw==
X-Gm-Message-State: AJcUuke6MtVhoDWaw4sOhwCpe3pBZsZO/B4TItfEmGaOl1XAs4y93+tv
        UxGEflYaKUWRgj6ogMHzyA==
X-Google-Smtp-Source: ALg8bN4gORGwAZrfNu8kXlIHCHCKCR4c5Ah59x59cqLFZzhiqTxftW1eIPnPLTBlbRZvQHSVFLZ7pA==
X-Received: by 2002:a9d:628:: with SMTP id 37mr21447923otn.58.1548116920805;
        Mon, 21 Jan 2019 16:28:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm5960328otl.58.2019.01.21.16.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:28:40 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:28:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Add MSM8976/56 Global Clock Controller (GCC)
 driver
Message-ID: <20190122002839.GA22319@bogus>
References: <65fb363366f651e42d3e97792d5990185823cbc3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fb363366f651e42d3e97792d5990185823cbc3.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 04:03:18PM +0100, AngeloGioacchino Del Regno wrote:
> From 50465f2a4454625aac622bb84dbecdeaf5a50904 Mon Sep 17 00:00:00 2001
> From: "Angelo G. Del Regno" <kholk11@gmail.com>
> Date: Sat, 12 Jan 2019 10:52:18 +0100
> Subject: [PATCH] clk: qcom: Add MSM8976/56 Global Clock Controller (GCC)
>  driver

Looks like your patch is corrupted.

> 
> Add support for the global clock controller found on MSM8976
> and MSM8976 SoCs.
> Since the multimedia clocks are actually in the GCC on these
> SoCs, this will allow drivers to probe and control basically
> all the required clocks.
> 
> Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt    |    1 +
>  drivers/clk/qcom/Kconfig                      |    8 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/gcc-msm8976.c                | 4208 +++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8976.h  |  293 ++

The binding doc and this header should be in a separate patch.

>  5 files changed, 4511 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-msm8976.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h
