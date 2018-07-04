Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA81DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E4124684
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h78Wtcoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E4124684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeGDH6p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:58:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46413 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeGDH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:58:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id s11-v6so4307606wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MK2h390C/8GZpd4A9oUAZu2LFEh44mUGc5l0IEq2a88=;
        b=h78Wtcoa9KSMqBvCyDf0AHW/kbOGYOtLL/ogjeXHPzaHGasrrkPU0JjEFe1rIK29JT
         H79rAY0eW536eW+CXx0ZWx8epU7phCzLuBQcAajnH+scbbtp/SaMXlQynqPXcT0BHe2/
         D7axrmEQg+A6CjmMrcOm9I9bWDFv/ay7g+kLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MK2h390C/8GZpd4A9oUAZu2LFEh44mUGc5l0IEq2a88=;
        b=tquHcuwns4XLp/Ko0tGVfctpjE9VqO4d9/9EtZze1yOKVCTxUvNqI926gj6/9yj2+V
         /evFcL2euwx0neexqvOHqqORjbmuZU2Zz0iPlvH/J3zzDFr6uYOZNV4MA/XskRYkPZ5j
         8cxjob7sGkRyBCeCrCXonKSFKKRCoXVfeiS8bv0bBhGbL2hY5RBtEqnT5O3eJ1/Q//J5
         3Q3xx1uVYTmmLWHONss84WgFMBdTLAlf7wtdsu2/r2/OrpcUYnraS3zI3CFy1wVAI3vM
         S2PDKEOLVfAKH7gjmt0JMlfVvM3QdXsByM7YzpIZTAf93O9IEFYJNwjF5Cln+KuaQ3R/
         O/Yg==
X-Gm-Message-State: APt69E0jsrz92IGU7jhjAn9SD8IgScDX3pR0wSg9hkhFuXLsFkq+n5kK
        aoyK7W4qjRt2yyiCB9CwMB5w8g==
X-Google-Smtp-Source: AAOMgpcKeo3GuHZVf6L2BUy9DjUMowXZDIEi9dD7J37yqjZnoCUQI3YI48w7JChgyj1XXYBrRsKnBA==
X-Received: by 2002:adf:8281:: with SMTP id 1-v6mr807230wrc.234.1530691121934;
        Wed, 04 Jul 2018 00:58:41 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id h2-v6sm2123113wmd.0.2018.07.04.00.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:58:41 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:58:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zumeng Chen <zumeng.chen@gmail.com>
Cc:     rachna@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: ti_am335x_tscadc: Fix struct clk memory leak
Message-ID: <20180704075839.GR20176@dell>
References: <1530678929-24482-1-git-send-email-zumeng.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530678929-24482-1-git-send-email-zumeng.chen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Zumeng Chen wrote:

> Use devm_elk_get() to let Linux manage struct clk memory to avoid the following
> memory leakage report:
> 
> unreferenced object 0xdd75efc0 (size 64):
>   comm "systemd-udevd", pid 186, jiffies 4294945126 (age 1195.750s)
>   hex dump (first 32 bytes):
>     61 64 63 5f 74 73 63 5f 66 63 6b 00 00 00 00 00  adc_tsc_fck.....
>     00 00 00 00 92 03 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<c0a15260>] kmemleak_alloc+0x40/0x74
>     [<c0287a10>] __kmalloc_track_caller+0x198/0x388
>     [<c0255610>] kstrdup+0x40/0x5c
>     [<c025565c>] kstrdup_const+0x30/0x3c
>     [<c0636630>] __clk_create_clk+0x60/0xac
>     [<c0630918>] clk_get_sys+0x74/0x144
>     [<c0630cdc>] clk_get+0x5c/0x68
>     [<bf0ac540>] ti_tscadc_probe+0x260/0x468 [ti_am335x_tscadc]
>     [<c06f3c0c>] platform_drv_probe+0x60/0xac
>     [<c06f1abc>] driver_probe_device+0x214/0x2dc
>     [<c06f1c18>] __driver_attach+0x94/0xc0
>     [<c06efe2c>] bus_for_each_dev+0x90/0xa0
>     [<c06f1470>] driver_attach+0x28/0x30
>     [<c06f1030>] bus_add_driver+0x184/0x1ec
>     [<c06f2b74>] driver_register+0xb0/0xf0
>     [<c06f3b4c>] __platform_driver_register+0x40/0x54
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
