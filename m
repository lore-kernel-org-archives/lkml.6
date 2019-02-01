Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09545C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E5020844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9OSZsaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfBAJVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:21:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47021 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBAJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:21:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so6192181wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YCsZdyh7/lX8uwl8nqn6f602pkOgosEqZdUih9f5Ixc=;
        b=T9OSZsaCQlxSJ5xQFTWTypWzgWluMg9H3u4TwE+ZpPR/X14M+3cxDK1LVwTXR7vDwr
         BdEDeq+0TPrS5EbaQ2mJiNFNIDupQAmy00QMk/ltK4K+4y/FqVvycM6LY6+CPSRzeLub
         X8MV9nbHQcKadXzfeopyGNiBnyCkkyl2+hTV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YCsZdyh7/lX8uwl8nqn6f602pkOgosEqZdUih9f5Ixc=;
        b=oY5U2R1f5qpaN3nV6UccPrh83APyBfmKWvdJJ2OmzLfp+Js64tgvSGQeO0SpcuWOAW
         UxRuhkxfBBMZF7PJoYUehKTJq5PeKwhA4+Cn6tCcXdKzXiIHUNCv27EscR0e/sKhs/z0
         MTNZvMT3d0D197MoQhGOhUYcbOC/WX5Q1VhzQ8mTww5uIT15/yCva2xWlr508Bwvw597
         3afCoUnfxM27eONGbEzL2RZ6mvYL0NY2yfl8CNLYoOEOn17EA/5J7DaTfwRxtBzhciYf
         YfojUDVryTavRQsKDdPuXBVz2MelZJi5x4luhUyYhjzBFV4322pYZHmbWiCKhjPO31nv
         uhZA==
X-Gm-Message-State: AJcUukd0y68gMsaCg+qad0ntpUfvoaSLhJf2VfDvJTm0Osc4000OjEDf
        EwAe7YXxYKjbfBiVsJuDHxr3tA==
X-Google-Smtp-Source: ALg8bN7FF0v2EVq3dxqgDAyrUIGAExMLvluH0txY8xdNNcN645SNR0tmi9MWKPs1VOMy6E7IQCJfug==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr36578889wrc.0.1549012876670;
        Fri, 01 Feb 2019 01:21:16 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id n6sm2049486wmk.9.2019.02.01.01.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 01:21:16 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:21:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: sec-core: Cleanup formatting to a consistent
 style
Message-ID: <20190201092114.GE783@dell>
References: <1548761153-28114-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548761153-28114-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Krzysztof Kozlowski wrote:

> Cleanup the formatting to have consistent style across the file (only
> white-space issues).  No expected difference in code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/sec-core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index e0835c9df7a1..c3bb53f79e63 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -70,9 +70,11 @@ static const struct mfd_cell s2mps11_devs[] = {
>  };
>  
>  static const struct mfd_cell s2mps13_devs[] = {
> -	{ .name = "s2mps13-regulator", },
> -	{ .name = "s2mps13-rtc", },

I prefer one liners to remain on one line.

>  	{
> +		.name = "s2mps13-regulator",
> +	}, {
> +		.name = "s2mps13-rtc",
> +	}, {
>  		.name = "s2mps13-clk",
>  		.of_compatible = "samsung,s2mps13-clk",
>  	},
> @@ -114,7 +116,8 @@ static const struct mfd_cell s2mpu02_devs[] = {
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id sec_dt_match[] = {
> -	{	.compatible = "samsung,s5m8767-pmic",
> +	{
> +		.compatible = "samsung,s5m8767-pmic",
>  		.data = (void *)S5M8767X,

All of the other changes are fine.

>  	}, {
>  		.compatible = "samsung,s2mps11-pmic",
> @@ -309,8 +312,8 @@ static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
>   * the sub-modules need not instantiate another instance while parsing their
>   * platform data.
>   */
> -static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
> -					struct device *dev)
> +static struct sec_platform_data *
> +sec_pmic_i2c_parse_dt_pdata(struct device *dev)
>  {
>  	struct sec_platform_data *pd;
>  
> @@ -331,8 +334,8 @@ static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
>  	return pd;
>  }
>  #else
> -static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
> -					struct device *dev)
> +static struct sec_platform_data *
> +sec_pmic_i2c_parse_dt_pdata(struct device *dev)
>  {
>  	return NULL;
>  }

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
