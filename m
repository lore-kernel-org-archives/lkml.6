Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F66C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F35822419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rVDIhFPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F35822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbeKNCmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:42:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKNCmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:42:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so12602350wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=WI2XlcKtzieEKCCJTDRWEQrqfgZIY0nDGhk/m+HOJ2c=;
        b=rVDIhFPXC7Gnl86TVitRT1y3DyX6R3sgPT2Lp75n+XH3xMlxF9x3WbxFhZ48UBp8Bu
         rl4Dg/4Mqd73t29YGapU98JjjwAtfWk/Q6mTgB1sOlWD9j77SYLPWRHtUK/4SO/l1xSj
         MJu4mLqpqk6R6m0/gqF5ATlKV+vs1a6aBFyhp4HDxMsF7uSfJeAhzxqj9+QhSAyvhZT0
         YzA9fy6w/NwXK9GYt3+Cvb+JfSpDlzUpLavKvXHLSi7sNn6YQ1sFiFEn53JpMfEnBYhQ
         y0NYZ09lt0bJoDvk9uroQ3/EqtGsOTRGiWwe9ceVxNixQNgT5Bea2qe6CZdbT2uwyIPe
         qwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=WI2XlcKtzieEKCCJTDRWEQrqfgZIY0nDGhk/m+HOJ2c=;
        b=mleVnc1sl7f+E8hnE036fX6EzgGXnZwfk4p6DI+Q6mGjel8WHCiuTUvvBC9ojPEIBX
         1dXQxe3PbU12NVajzJ6YWNjK2JObI4hdBo6gAe/mmBP+/48TxpYdeaZzkrakaqumTtNg
         smcj1Z2BiCmq9KwxVfjIuXwzsx6Z7F6t7WFmQb6cF6GYJ3Ju+yaFpmUl9MxlxYSRBz21
         EzZJA8fai2BFjbp61hw0ZoQs4WPU278HSxSOOH77oiMxL3rr5+YFhyRQeRisEU4JtH/3
         dfe8cLIMAxfV8XzyTqZmZPjlJf3sss1J7rBz8mdcTirOuGvpUK6ZOHeEdtpaF1j4XOBk
         iT3g==
X-Gm-Message-State: AGRZ1gLgT4Flu7lrEk69Uhst7H/R9sPv1JNP9GLKCqrsDTWBisNzq21J
        jFqI7khRdY+HMPPJOTzWArnusg==
X-Google-Smtp-Source: AJdET5fQ/EoUexkhWKOP2D009kVCX+oBpmwROFIMEJK/oN3WE5KbZNzoyweFfpU/dgbd4oxa0uad6Q==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19-v6mr3630944wmk.151.1542127407394;
        Tue, 13 Nov 2018 08:43:27 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:cb1d:4ce:ea00:2c41:ee84:3757:1dd3])
        by smtp.gmail.com with ESMTPSA id x6-v6sm21835864wrq.52.2018.11.13.08.43.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 08:43:26 -0800 (PST)
Message-ID: <5BEAFF2D.9080105@baylibre.com>
Date:   Tue, 13 Nov 2018 17:43:25 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     stable@vger.kernel.org
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: axg: mark fdiv2 and fdiv3 as critical
References: <20181108093123.21498-1-jbrunet@baylibre.com>
In-Reply-To: <20181108093123.21498-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable team,

Le 08/11/2018 10:31, Jerome Brunet a écrit :
> Similar to gxbb and gxl platforms, axg SCPI Cortex-M co-processor
> uses the fdiv2 and fdiv3 to, among other things, provide the cpu
> clock.
> 
> Until clock hand-off mechanism makes its way to CCF and the generic
> SCPI claims platform specific clocks, these clocks must be marked as
> critical to make sure they are never disabled when needed by the
> co-processor.
> 
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Could this fix go into the next 4.18 and 4.19 stable releases since it hit linus master with commit id d6ee1e7e9004d3d246cdfa14196989e0a9466c16 ?

Thanks,
Neil


> ---
> 
> Hi Stephen,
> 
> If you can put this one in clk-fixes as well, it would be awesome.
> It is basically the same thing as the change you took this Tuesday.
> 
> Since then, we had reports the same problem with SCPI was happening
> on the axg, calling for the same fixup.
> 
> Cheers
> Jerome
> 
>  drivers/clk/meson/axg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index c981159b02c0..792735d7e46e 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -325,6 +325,7 @@ static struct clk_regmap axg_fclk_div2 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div2_div" },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> @@ -349,6 +350,18 @@ static struct clk_regmap axg_fclk_div3 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div3_div" },
>  		.num_parents = 1,
> +		/*
> +		 * FIXME:
> +		 * This clock, as fdiv2, is used by the SCPI FW and is required
> +		 * by the platform to operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) The SCPI generic driver claims and enable all the clocks
> +		 *    it needs
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> 
