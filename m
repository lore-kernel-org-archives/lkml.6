Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BCF20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkPDGX+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BCF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeGWOGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:06:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33469 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbeGWOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:06:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so907904edr.0;
        Mon, 23 Jul 2018 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgUS4xm1e5WSJj/Jyy+wZPUpcInYPddEh4LFAeC3wwg=;
        b=QkPDGX+saKb/iLIQeRBkfzgGzdh/C9grGnDtWqH5YVq2F+UJ45vVBv6YyeCkQXxjhD
         wTwj6e3F00+IawngNqGpqBUuNPuF3MNkXXLDBy8ACleUNRVkt4dPZTeTwTaFjcVJMkfj
         HHXawaWRDGcncCTiQu+77tM3C0B0W0b3skgyGmkLfVKtcVRPe0sLzMzRp72AfR7SWZgg
         j2w0WPTHP4x9rpn6eVLujtxDx7fnhdwSy+pw6N/NmlxJ4VEbt7eaXKR/eoNxdLFvgHqE
         E7KdpRuPrqZYHwSx2azFhWqwcA65DHD46pd7CipUtfJAC9x1uqCm0+IqonhA2+MrbwIX
         WxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgUS4xm1e5WSJj/Jyy+wZPUpcInYPddEh4LFAeC3wwg=;
        b=FE8+yLqYlxZHeJc4lcxgpPF2tbl03uxYh6XdAMmSeegVcmvr2kT5/32y4rwIubDEam
         7WDf61FMVB+JHC5qKjNOs5neGQuHDSOF7uVJacKPtEPeZk6gVqCWY8CT+AIdqYaDEPK1
         uEgdlCZZ382Zy6JMJch8Ang/BHyVu6KvOpfZxCniMVVrWRok2BJVdN8dvNJtTpufofwm
         CfAgdEVSCaZW8Xpsf2gP4H6dZM7mkarBnqiztpt3uMIbOC4eRgGfIQyRlC4oUsvxvZzX
         rR8C9xmOyFHqGlORGL6UrJ8GEAn8Ncc0R0AgXRuYFqzkD8m78/taXgncJ0sLj8p75CPA
         uNNQ==
X-Gm-Message-State: AOUpUlGLy8R+mti9T8FQBXHOMnL3K0PhJxQwfNeCJ5bd6/JX+twV0D0B
        8Vj56ZET43FYHV/0+atfHGA=
X-Google-Smtp-Source: AAOMgpfyEeZJ2HfFqB8kpTzFyhcqqQa1kaMcrF5SDx1EhjqngzM6Y8l7cFWI3adEHK7DCMim3tyrwg==
X-Received: by 2002:a50:a666:: with SMTP id d93-v6mr14544590edc.244.1532351123896;
        Mon, 23 Jul 2018 06:05:23 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id a53-v6sm8436536edd.35.2018.07.23.06.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:05:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, jonathanh@nvidia.co, thierry.reding@gmail.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
Date:   Mon, 23 Jul 2018 16:05:21 +0300
Message-ID: <6750449.onR3KBHYkZ@dimapc>
In-Reply-To: <20180720134532.13148-7-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk> <20180720134532.13148-7-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
> The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
> clocks by making a 2D and 3D mux, and split the divider into the
> standard 2D/3D ones and 2D/3D idle clocks.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/tegra/clk-id.h              |  4 ++++
>  drivers/clk/tegra/clk-tegra-periph.c    | 23 +++++++++++++++++++++--
>  drivers/clk/tegra/clk-tegra30.c         |  8 ++++++++
>  include/dt-bindings/clock/tegra30-car.h |  7 ++++++-
>  4 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
> index b616e33c5255..0d202a70ce66 100644
> --- a/drivers/clk/tegra/clk-id.h
> +++ b/drivers/clk/tegra/clk-id.h
> @@ -91,8 +91,12 @@ enum clk_id {
>  	tegra_clk_fuse_burn,
>  	tegra_clk_gpu,
>  	tegra_clk_gr2d,
> +	tegra_clk_gr2d_mux,
> +	tegra_clk_gr2d_idle,
>  	tegra_clk_gr2d_8,
>  	tegra_clk_gr3d,
> +	tegra_clk_gr3d_mux,
> +	tegra_clk_gr3d_idle,
>  	tegra_clk_gr3d_8,
>  	tegra_clk_hclk,
>  	tegra_clk_hda,
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
> b/drivers/clk/tegra/clk-tegra-periph.c index 47e5b1ac1a69..83967dac93f2
> 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -263,6 +263,21 @@
>  		.flags = _flags,					\
>  	}
> 
> +#define GATE_DIV(_name, _parent_name, _offset,				\
> +		 _div_shift, _div_width, _div_frac_width, _div_flags,	\
> +			     _clk_num, _gate_flags,  _clk_id, _flags)	\
> +	{								\
> +		.name = _name,						\
> +		.clk_id = _clk_id,					\
> +		.offset = _offset,					\
> +		.p.parent_name =  _parent_name,				\
> +		.periph = TEGRA_CLK_PERIPH(0, 0, 0,			\
> +					   _div_shift, _div_width,	\
> +					   _div_frac_width, _div_flags, \
> +				_clk_num, _gate_flags, NULL, NULL),	\
> +		.flags = _flags						\
> +	}
> +
>  #define PLLP_BASE 0xa0
>  #define PLLP_MISC 0xac
>  #define PLLP_MISC1 0x680
> @@ -646,8 +661,12 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, 
tegra_clk_epp),
> MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0,
> tegra_clk_host1x), MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60,
> 0, tegra_clk_mpe), -	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 
21,
> 0, tegra_clk_gr2d), -	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 
24,
> 0, tegra_clk_gr3d), +	MUX("2d_mux", mux_pllm_pllc_pllp_plla, 
CLK_SOURCE_2D,
> 0, TEGRA_PERIPH_NO_DIV | TEGRA_PERIPH_NO_RESET | TEGRA_PERIPH_NO_GATE,
> tegra_clk_gr2d_mux), +	GATE_DIV("2d", "2d_mux", CLK_SOURCE_2D, 0, 8, 1,
> TEGRA_DIVIDER_ROUND_UP,21, 0, tegra_clk_gr2d, 0), +	GATE_DIV("2d_idle",
> "2d_mux", CLK_SOURCE_2D, 8, 8, 1, TEGRA_DIVIDER_ROUND_UP, 0,
> TEGRA_PERIPH_NO_GATE | TEGRA_PERIPH_NO_RESET, tegra_clk_gr2d_idle, 0),
> +	MUX("3d_mux", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 0,

Now that the actual parent clock is specified by the "mux" clock, you have to 
adjust the tegra_clk_init_table accordingly.



