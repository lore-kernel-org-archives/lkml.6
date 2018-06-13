Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C207C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D153C208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gztB6CdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935828AbeFMWmc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:42:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36597 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935456AbeFMWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:42:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so2348801plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=i/3vTFqnsG9IBWH+DCrxhffwFfeuCCbIuzSs6Xq7dbA=;
        b=gztB6CdVBUuHQfKXt8LahpTOoSJs4qglBTgiej4QsUz1kSKSpZg694VhErW0Iv0+3J
         DT8eRzZsFV2czFJjPP7H6opdZjxKOdFaXrMqKs/dA9rnz1feMIp6A4qRhvwpBZswJRlP
         Q8sLCY1qfm9GqjyPgXrItsLdCKCE92GGZYRS8UgarQeMABTJQss+0drd9xq2AFVh6CFS
         utNoiXAm+DZS3GFRByYaE6gil55ykKAPPjIakRe5wBBw6Ci+3OsFbliXObAieR1YP5R6
         ncJLIySiOs+fRnMhZzXsNk3s7tlNxGIJZjSn4oMaOlyuBEx/pfNggpB2PO5puLqOU57/
         Ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i/3vTFqnsG9IBWH+DCrxhffwFfeuCCbIuzSs6Xq7dbA=;
        b=J3C7oaQJ9GUvB6UduKrQMbZuiayVi2FqPHkkjCsNvR/isvRizjwxvLYOxx5ZECppN2
         Q+5XIDGLRqBlm1sPRM3Qci25oOQVu0V1w5QCpLydm9M5aSmhdhkamdJSo9M37vypEMUp
         tzkcf5b5FQDOYK/UAe7KYj1IbM399byjqQLE5ln9n8JC0r9iFRC/p9bBxoS+7YXfkCg1
         zcVJ18EpVAy38A1xyKG2MXtofxtQUEtHqKD4xlBfz/zh7tnDp1JH7pD7b4Rm4H9+56Ds
         4YKwlV8HJdsLyOj0eyzm/r3i45e/zUssgo65vmiAKB7RnSxxa8FwmA8DZxdIm3lr89UT
         V3Wg==
X-Gm-Message-State: APt69E3WMSJIHjpKm+2bqIB24Xj6PmpeHn8PPukhxhFF36/dEpVbHw8J
        P6zaWmk3phZR54yNfYnNR6xYWA==
X-Google-Smtp-Source: ADUXVKLE5Yc0+pY7TiaBOKTs4OY41uVKgLWsdmkL5R5WswBbcaOiJA3D4jH4hn/L1hfJFE8aUuH4VA==
X-Received: by 2002:a17:902:768a:: with SMTP id m10-v6mr53642pll.293.1528929749710;
        Wed, 13 Jun 2018 15:42:29 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id u8-v6sm6742097pgq.7.2018.06.13.15.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:42:29 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
Organization: BayLibre
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
Date:   Wed, 13 Jun 2018 15:42:28 -0700
In-Reply-To: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Wed, 13 Jun 2018 14:20:21 +0200")
Message-ID: <7hsh5qwbor.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

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

Nice!  this also fixes the boot hang I had noticed on gxm-nexbox-a1
(though MMC still needs to be disabled to fully boot.)

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

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
