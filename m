Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728EDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD222086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qVf9KPW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD222086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeLKRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:17:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52503 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeLKRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:17:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so2405314wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=75yFl6t0VNl6aeKQPwOYA9vmVdauYThH+a/zVHyk1HY=;
        b=qVf9KPW7ufg1mhiOVOV9ukDNT606L4vnOvmwKM+QyODjR5A3W6N5wpNMAYWoTvR+iI
         tHiS7EshfrV7+f1kojxBTEWXa49X0DjW6usNLX9udJkP/t3Ob/Q0UHRoVgovXx61Q2tQ
         1QZ4SfCzjYyFN6DvJ/XsZPQvg7MUYDE3ln65pFD5YdqbdJgEa2Xq2wvDbyTG/j6V6jiC
         m7D/9LXfi+cNom5P6VNTno8LJ3yVilpH8TKKgOBnbO7oCQ1biwVUKQ7IMacabGOjaU8x
         eamOorEYgCvUJQ7CLtEGK1InCiGZUVzMMps2dru0LBWNlrkF0M5ptY/WCBtTkHJP5vSj
         Fqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=75yFl6t0VNl6aeKQPwOYA9vmVdauYThH+a/zVHyk1HY=;
        b=e7d8s+wdsvUQgMoEPvDdguKRa4xcl1tdubllM9KDGyQBF+e6OvEcL2/FLTiDoNc0Iu
         DlvdhMPEnLwX3xg/PQiDlLWO7FZlY/pYFqPylTXLIHfYLzH3WCSU0Nb+a05RCNa6EGED
         eiMUHpn0eCsdOI3svvH7LMorfRn8fazmAOB4FdZDxDZt2wk+cvjl8pGFlD9cPTPY6Jv4
         AmIFSu4Ze4DiPSF5XJXxoRYG7OuDAi2dyx3vqT/hJ3IEnzhaprAs8BqbV32C77ruhUXS
         KzwZDh4jUb+i9cLsZBkYE+BUC6amcgWrjpUJVxltkCmtgsHQXjySrUiKu71qoE2gtJh5
         /SlQ==
X-Gm-Message-State: AA+aEWb6wHzi6z+0d5r5bgnAd21oPSqsQgQ94ZlfUGWxdiY1tx1U7U2w
        x5gC9v5gEIK68mCU89MbD1n5vw==
X-Google-Smtp-Source: AFSGD/X23cOw1RneKhFub57TRd9Ur2MpdQD4WlwVOgAzARNURpNzd8lJUNxGbln5ZpRekOux8hFXFw==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr3109373wmd.111.1544548617073;
        Tue, 11 Dec 2018 09:16:57 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id v4sm738924wme.6.2018.12.11.09.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:16:56 -0800 (PST)
Message-ID: <4da764c237b8f752af1dc33a011e2a4b73068f02.camel@baylibre.com>
Subject: Re: [PATCH RESEND v7 4/4] clk: meson: add one based divider support
 for sclk divider
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 18:16:53 +0100
In-Reply-To: <1544457877-51301-5-git-send-email-jianxin.pan@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
         <1544457877-51301-5-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
> When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
> one based divider (div = val), and zero value gates the clock
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/clkc-audio.h |  1 +
>  drivers/clk/meson/sclk-div.c   | 28 ++++++++++++++++++----------
>  2 files changed, 19 insertions(+), 10 deletions(-)

Such a patch should be done earlier in the series, at least before using sclk
in your controller, otherwise thing will be broken in between

In general, I would prefer if you had added two helper function to deal with
the translation between register value and divider value.

Only these function should care about CLK_DIVIDER_ONE_BASED, the rest should
just call them.

This, we will be able to deal the with HI (duty cycle) part as well, which you
completly skiped.

I know your device does not have this, but still the code has to make sense.

> 
> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
> index 0a7c157..9bd6ced 100644
> --- a/drivers/clk/meson/clkc-audio.h
> +++ b/drivers/clk/meson/clkc-audio.h
> @@ -20,6 +20,7 @@ struct meson_sclk_div_data {
>  	struct parm hi;
>  	unsigned int cached_div;
>  	struct clk_duty cached_duty;
> +	u8	flags;
>  };
>  
>  extern const struct clk_ops meson_clk_triphase_ops;
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> index bc64019..d98707b 100644
> --- a/drivers/clk/meson/sclk-div.c
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -24,22 +24,23 @@
>  	return (struct meson_sclk_div_data *)clk->data;
>  }
>  
> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
> -{
> -	return (1 << sclk->div.width) - 1;
> -}
> -
>  static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>  {
> -	return sclk_div_maxval(sclk) + 1;
> +	if (sclk->flags & CLK_DIVIDER_ONE_BASED)
> +		return clk_div_mask(sclk->div.width);
> +	else
> +		return clk_div_mask(sclk->div.width) + 1;

seems over complicated.
why no call clk_div_mask just once, and add 1 if necessary ?

>  }
>  
>  static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long prate, int maxdiv)
>  {
>  	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	int mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;

This is why I want helpers, don't like this above

>  
> -	return clamp(div, 2, maxdiv);
> +	return clamp(div, mindiv, maxdiv);
>  }
>  
>  static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
> @@ -47,7 +48,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  			    struct meson_sclk_div_data *sclk)
>  {
>  	struct clk_hw *parent = clk_hw_get_parent(hw);
> -	int bestdiv = 0, i;
> +	int bestdiv = 0, i, mindiv;
>  	unsigned long maxdiv, now, parent_now;
>  	unsigned long best = 0, best_parent = 0;
>  
> @@ -64,8 +65,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  	 * unsigned long in rate * i below
>  	 */
>  	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +	mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
>  
> -	for (i = 2; i <= maxdiv; i++) {
> +	for (i = mindiv; i <= maxdiv; i++) {
>  		/*
>  		 * It's the most ideal case if the requested rate can be
>  		 * divided from parent clock without needing to change
> @@ -153,10 +155,14 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
>  static void sclk_apply_divider(struct clk_regmap *clk,
>  			       struct meson_sclk_div_data *sclk)
>  {
> +	unsigned int div;
> +
>  	if (MESON_PARM_APPLICABLE(&sclk->hi))
>  		sclk_apply_ratio(clk, sclk);
>  
> -	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
> +	div = (sclk->flags & CLK_DIVIDER_ONE_BASED) ?
> +		sclk->cached_div : (sclk->cached_div - 1);

helpers again.

> +	meson_parm_write(clk->map, &sclk->div, div);
>  }
>  
>  static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -223,6 +229,8 @@ static void sclk_div_init(struct clk_hw *hw)
>  	/* if the divider is initially disabled, assume max */
>  	if (!val)
>  		sclk->cached_div = sclk_div_maxdiv(sclk);
> +	else if (sclk->flags & CLK_DIVIDER_ONE_BASED)
> +		sclk->cached_div = val;
>  	else
>  		sclk->cached_div = val + 1;

same ...

>  


