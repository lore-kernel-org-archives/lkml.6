Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE7204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="seR4in71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABE7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeKBWMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:12:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51314 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKBWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:12:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so1937203wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cHE3B9mtOR8PbpfiQvYBO+fwkN4qt2SpdjzD+aBqjVk=;
        b=seR4in71bzLCJMlCTmLaD4vpb4UbZMO/JB2dUD3iuvMA2xdaxx7B2sYahHRA16r+Fr
         ZYgzaEJWlkYOvQknQ3Myftff4FA9i7gGG7J9J0OOAwTzFtQKU6p9bVNyQlF20CCdjI6z
         LA3I/qf5TCa/E1wnWjWkdZQTk1N4PD3LGyL4PymBgvBG1lhsCxIRXdsYZTfEgw1wd9U5
         TvFOYC983J2OWvRG/Y17i/mE7YaUw+YFedT00KOZJHSjvZ03ZVVHoTnxdmGAeCX8KZYW
         mrDUzfbY6eTYcPSoSPFYJmUmHA24JYDZsG7DEHeo1951ErVKpr5E2c8wLUNGuaH4pJHg
         tBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cHE3B9mtOR8PbpfiQvYBO+fwkN4qt2SpdjzD+aBqjVk=;
        b=KxbwHDuEP3crMAW9G+n5WE0yZ9HYVlCmPi8LG8b5Wy/so1oQ+yMxXNf/bO0/kezlzb
         wiKlwmHvfDmsW19O013YjFlKN/4Nfhm0xzUylXK+FsJitRCCyJnvYmhxHWVvs+vLCnnr
         R7ljp+BmXe1ObeUiQjbMzvhqM3gauyexcmEoR7Sp/HLUjILKNSwYVlWj1ZUYSkGjWbfU
         4NXccnOplD4wYnwq0plJnSTPBzzLVLibueF1BMh2E7hDN3DPurWmsYNakA7/CUbCDYk6
         JvZCcex2MOeNK1E3Px1z3tjoUBuncB+z7g6oYfHGDW5cHPuPg/5hAiB1WMK9aEv7oM4n
         MIrw==
X-Gm-Message-State: AGRZ1gL8RTUMu5CkWtoOgyppIrynMYkikLVGO8IotQVLmGEkX7Q4QxRG
        08lDoUhjNdbBQQKkSq4y4N9EQA==
X-Google-Smtp-Source: AJdET5c6/o4NpfZYrPVYVtaUsQT2B37XB1nxCLqHdOZUZmSdECnqxZtVSjiwL+rPQfoVHlGCyr5Oew==
X-Received: by 2002:a1c:c4f:: with SMTP id 76-v6mr733307wmm.6.1541163916868;
        Fri, 02 Nov 2018 06:05:16 -0700 (PDT)
Received: from boomer.baylibre.com ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b127-v6sm6306838wme.43.2018.11.02.06.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:05:15 -0700 (PDT)
Message-ID: <ce0a3e6bf6ef438987f3ad390c2aa1bccc75f5ea.camel@baylibre.com>
Subject: Re: [PATCH v6 3/3] clk: meson: add sub MMC clock controller driver
From:   jbrunet@baylibre.com
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 02 Nov 2018 14:05:14 +0100
In-Reply-To: <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
         <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 00:30 +0800, Jianxin Pan wrote:
> +struct meson_sclk_div_data  mmc_clkc_div_data = {
> +       .div = {
> +               .reg_off = SD_EMMC_CLOCK,
> +               .shift   = (0),
> +               .width   = (6),
> +       },
> +       .hi = {
> +               .reg_off = 0,
> +               .shift   = 0,
> +               .width   = 0,
> +       },
> +};

Jianxin,

When replying to v5: https://patchwork.kernel.org/patch/10646723/#22288117
I think I have clearly explained that:
a. sclk needs some change you want to use it for the eMMC (not done )
b. you can't declare sclk statically like that since there is cached data in
it and this would forbib multiple instance of the controller which is not
acceptable for this pariticular controller

This is just not adressed in your series.

Also some comments from Martin about useless definition were already given on
past version.

Seeing this, I did not review the rest of series.
Please make sure you have addressed all the comments of past reviews before
reposting. It is OK to ask questions if things are unclear.

Jerome


