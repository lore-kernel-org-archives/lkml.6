Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23867ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D242081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ltY5e1ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D242081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeKHXKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:10:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39621 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHXKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:10:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so21266589wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YTyI5WSAfJxff7r7dg4IeAfXpnFBXRO9/6Rn6HJHcJ0=;
        b=ltY5e1olAlPYi1++Gs6S9/X1dwdCA3nfY8ivSqBO7VZ+U2pUpQ/YOH2Mle1HbFyd0m
         qUhxovP1+DDirvQOLOqCbqIEncLmjhQh4x2O+qtoPGbPmB6LjEuPwnC654EZW5r+Etb0
         FeurEFI/O47KT2E1ICwiwJ4GyQGgLEWWONmR7DA3/g7IFpd6OyZmB8MWpd2CYjfSYveF
         +hZZZg4+GVwhqj4bTLu7PxJvbgU2eYla9z0Ur+fvfOJOrGIWsA3B2A8rksBGftfg9Dad
         5bUTBo3fN1lLWiQSGjipunY4HAee6wBUCKzle6pwxqgq+EG5RcolVbqtpnZ5jBf7rtu4
         yzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YTyI5WSAfJxff7r7dg4IeAfXpnFBXRO9/6Rn6HJHcJ0=;
        b=ppmhu+b5pGYIy47kvdSz9eLqAPkoaFlFu3Jo4qe7TKHCZtjBCyn8KhIrsKfk8lDgBK
         p75vBWMfyxo/rng8IPG6mMRhPx/4ADuGIII+UNePeps+vVDCATI8JD6PD/SQ2bU3j6xJ
         QzzyckgQ71YIbR0D8oK4Pr+ti9k1vFWjqiS1sxZcoC+ycRdERcqYC8cGBw/PxLY5oAJw
         N4o8LTp7cJ0sZwfTiXLj8byapxMdehT4Vx4aENLRkJ5uDxTO9HQGbpf0KBQq76N1P6k1
         XrbSQeSwRAD3lUN94Mr/QWzjWzcmIbQGaxzrcQR/STQ2o+ZkZ/zu069FLJsKkFKU9SaE
         j5Tw==
X-Gm-Message-State: AGRZ1gJUtP+O1fHMHcLuyqFMerrU8hbCgbsdSQDppBe0jNEvnpE1YxU9
        qT28OMUHsY4yFW9Oam5luHzZ5g==
X-Google-Smtp-Source: AJdET5f9hbZ54zlxzoeLq5GsnkmWpToSkP3qHewQ5CsvqJi82R2MXh8MCe5JmRIclFh0mKd686EWdA==
X-Received: by 2002:adf:9b84:: with SMTP id d4-v6mr3980710wrc.240.1541684079598;
        Thu, 08 Nov 2018 05:34:39 -0800 (PST)
Received: from boomer.baylibre.com ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e7-v6sm3373635wra.10.2018.11.08.05.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:34:38 -0800 (PST)
Message-ID: <1157f0a9419eea01c099d8dc08d7757593720286.camel@baylibre.com>
Subject: Re: [PATCH v4 0/2] clk: meson-g12a: Add EE clock controller driver
From:   jbrunet@baylibre.com
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 08 Nov 2018 14:34:37 +0100
In-Reply-To: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 21:15 +0800, Jian Hu wrote:
> Changes since v3 at[4]
> -add fixed clocks clk_regmap definition

Jian,

When replying to the v1 of your clk_ao patchset : 
https://patchwork.kernel.org/patch/10562563/#22177627

I have explained that I would like to stop taking clock (such as xtal) from
nowhere. Clocks (even the xtal) should be properly claimed through DT.
I have specifically asked this to be taken into account for the EE controller.

If you need an exemple on how to get the input clock from DT to your
controller, please have look at the axg audio clock controller.

This comment does not appear to be addressed in this version. 
Please make sure you have addressed all the comments of past reviews before
reposting

Thx

> 
> Changes since v2 at[2]
> -fix fixed clocks's descriptions
> -fix aligment
> -add enable bit for plls base on [3] patches
> -add fixed clock gate bit
> 
> Changes since v1 at[1]
> -fix typo of 'Everything'.
> -change the word 'AmLogic' to 'Amlogic'
> -squash patch 1 and 2.
> -delete usless message of "Trying obsolete regs".
> -delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
> -rebase on top of the "next/drivers" branch, and add g12a clock patch.
> -add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
>  g12a_sd_emmc_c_clk0_sel.
> 
> [1]
> https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
> [2]
> https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
> [3]https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
> [4]
> https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com
> 
> Jian Hu (2):
>   dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
>   clk: meson-g12a: Add EE Clock controller driver
> 
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
>  drivers/clk/meson/Kconfig                          |   10 +
>  drivers/clk/meson/Makefile                         |    1 +
>  drivers/clk/meson/g12a.c                           | 1134
> ++++++++++++++++++++
>  drivers/clk/meson/g12a.h                           |  128 +++
>  include/dt-bindings/clock/g12a-clkc.h              |   93 ++
>  6 files changed, 1367 insertions(+)
>  create mode 100644 drivers/clk/meson/g12a.c
>  create mode 100644 drivers/clk/meson/g12a.h
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 


