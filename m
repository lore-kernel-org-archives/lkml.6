Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 24C11C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBA9208B9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FU6dlcha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBA9208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935511AbeFMM0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:26:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36298 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935286AbeFMM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:26:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so5045853wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZOUiFiH+eKOKgNFs/Quy9ff4S9KxsNX8/6m8X9i+Es=;
        b=FU6dlcharZ5pkwKkVN+B+DSfAY6iCB/sYO7+VWuuC6iX02K/Nx2X6QRN4Wgu27srbJ
         pTrfT35hv0zmmR5wdz9958uikhmFeDZVh+rshaBWCComVRRTfgPrBa87Vvz7O5JSQgsh
         2fNOT7wgtuuv7nUrunrJHQ8rg5HsBOEJsCxOyTCEH0L88nXgqLVbAG3tJ2O3Eesyp+So
         SjjgOC34Laapuj0ME35hGP+u5zH/eIVgUHimHHMe0OkyzKhrO6qMzJy+wqqktWzylB87
         mrZDsytn4pZPW8RoAqjtSS2iSOgte9fV+vBKWPqsAJ3tMEmxomwhSp2NXk41vj8BTRJU
         LZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZOUiFiH+eKOKgNFs/Quy9ff4S9KxsNX8/6m8X9i+Es=;
        b=sqyLEvTS4WG2vPITR6FY5miAK+StpN8JjmAaAMQtV1xZwZuod6SOChkiqsUDK+R9Lx
         hEBGSW32XSIdE8wNb9/Dv21JDkNo34ZgTIP+FSHqdJWPoA46FgPt77qW4OO3CNxb5HRO
         Q7mOYSP+p8fmHCc4Nue1G5N97WwlRLoSfxpzit7W01Iq6PDHWsB3NxD3SYmlkiVzui7H
         aX1U0ABixUUZTRkftT1cpym44cAw7RU+TlWo6e6sxi7GgPq8rJeAny272u6QE2RWV3Zp
         4ecUwpF6DwMxEeaFyaI8a1zuP2kIzHYpwfYwib1FAjPoY84zvrWkfThCaagVqBlJlRtD
         M88g==
X-Gm-Message-State: APt69E2k+VD6XMcxlTWk+wxE8jge5Jp2ryL2PwIdA8InGu+L+DacWLmK
        6k5Jgo8AIGhRIaI4QG2T4NHOjQ==
X-Google-Smtp-Source: ADUXVKIDQuBV6hYZGRcKTgfKwFmVJQECdNlPnZR9o99MdKOUxdX7HZPWGgyZZDOXsdMq+4mxbOI8vw==
X-Received: by 2002:a1c:6d02:: with SMTP id i2-v6mr3177307wmc.62.1528892772995;
        Wed, 13 Jun 2018 05:26:12 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t13-v6sm3636006wro.62.2018.06.13.05.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:26:12 -0700 (PDT)
Message-ID: <1528892771.2292.2.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 14:26:11 +0200
In-Reply-To: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 14:20 +0200, Neil Armstrong wrote:
> On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> seems to be dependent on the FCLK_DIV2 to be operationnal.
> 
> The issue occured since v4.17-rc1 by freezing the kernel boot when
> the 'schedutil' cpufreq governor was selected as default :
> 
>   [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
>   domain-0 init dvfs: 4
>   [   12.087757] hctosys: unable to open rtc device (rtc0)
>   [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>   [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> 
> But when disabling the MMC driver, the boot finished but cpufreq failed to
> change the CPU frequency :
> 
>   [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
> 
> A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> the first bad commit.
> This commit added support for the missing clock gates before the fixed PLL
> fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> all the unused fixed dividers, thus disabled a critical clock path for
> the SCPI Co-Processor.
> 
> This patch simply sets the FCLK_DIV2 gate as critical to ensure
> nobody can disable it.
> 
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Good catch !
We'll probably have to check the axg family as well

> ---
>  drivers/clk/meson/gxbb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index b1e4d95..0e053c1 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -511,6 +511,7 @@ static struct clk_regmap gxbb_fclk_div2 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div2_div" },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  

