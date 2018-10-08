Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81284C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456492086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zg1K7rH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJHNO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:14:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45247 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJHNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:14:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so9540947plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORVGYACDDJksioL4mhQzxftINsgBI/0RnZPXEjYYFpw=;
        b=Zg1K7rH4yhhjd2v9w9ntjbwGo8NPERM2dmOkCHeBYqDx7FXHHFEGVfUWKhi4RQIShY
         evZSlhiqONc+L6MCVoiBAihxo+HiDY4W4ejxA97Rs5GXzuERERJeo3kM+q+U0kTomjHu
         q+/CN3GSo5nMqw5Xb2GD2GKduAUoYlm0F+Dc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORVGYACDDJksioL4mhQzxftINsgBI/0RnZPXEjYYFpw=;
        b=kE5E8cHmutbJ0yEY1VyMyke0ej0vbxC1gZQ1p8rtJlcx8lEp3n8X9M81IqK9B2TbNy
         36W8xjFnjjcX+UShkLolmaFe2bV9dmafOlKkrbN6+sDO+4mujOX91ZPWdYmt24ZYYBtE
         HY3+TgOJol9a1ZPVdneueGefD5zH3CjY6nmwha8o1A7d5czbb5a3cpYhx8k7+gln/Qxj
         Wr1ajm292HQRFm3B/tyrnbKwW/XVzmTjXVxZGKrsajEig3xpbs5iE9gadmpKrS4UbUUd
         mWeiMr56trGZ4HgaCW79K4bXulorUmWFYxlEdgiVDD808p7bjANXvb61ogRF+1b5fObb
         rf6A==
X-Gm-Message-State: ABuFfog0o1vGyYnLbFkuh5iWu//QPSDHyrzxuzEWnCI3F6sQ1pi52k5c
        sCNTd0V0l4sLyOjaJV9EIMUB3w==
X-Google-Smtp-Source: ACcGV613IqHr8xXvv7DiJhMizs54b3cJPsdHdTzlo7H4kili1TU65ZdVY0PAnn30H21knvziYF0RBg==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2-v6mr22554554plt.133.1538978666686;
        Sun, 07 Oct 2018 23:04:26 -0700 (PDT)
Received: from localhost ([122.172.112.137])
        by smtp.gmail.com with ESMTPSA id p4-v6sm13774834pfg.188.2018.10.07.23.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 23:04:25 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:34:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Message-ID: <20181008060423.cz5qrxfoz2seo2e3@vireshk-i7>
References: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-18, 09:10, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API, and keep the old method there to
> support old dtb.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V2:
> 	Add put node when reading ocotp register done.
>  drivers/cpufreq/imx6q-cpufreq.c | 53 ++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b2ff423..38b67f8 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/pm_opp.h>
> @@ -290,20 +291,33 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>  #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
>  #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
>  
> -static void imx6ul_opp_check_speed_grading(struct device *dev)
> +static int imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> -	struct device_node *np;
> -	void __iomem *base;
>  	u32 val;
> +	int ret = 0;
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> -	if (!np)
> -		return;
> +	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
> +		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
> +		if (ret)
> +			return ret;
> +	} else {
> +		struct device_node *np;
> +		void __iomem *base;
> +
> +		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> +		if (!np)
> +			return -ENOENT;
> +
> +		base = of_iomap(np, 0);

You could have done of_node_put(np); right here and remove the below two calls
to the same.

> +		if (!base) {
> +			dev_err(dev, "failed to map ocotp\n");
> +			of_node_put(np);
> +			return -EFAULT;
> +		}
>  
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		dev_err(dev, "failed to map ocotp\n");
> -		goto put_node;
> +		val = readl_relaxed(base + OCOTP_CFG3);
> +		iounmap(base);
> +		of_node_put(np);
>  	}

-- 
viresh
