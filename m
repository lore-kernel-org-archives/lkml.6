Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeD0KA5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:00:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51353 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeD0KAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:00:55 -0400
X-Google-Smtp-Source: AB8JxZq9wXFl5RLOhTOEmkBkNMMorEZmkI58Am2Cz9D0VzNptCfFBloJkZtezh7FMTahpWAD+30mEg==
Message-ID: <1524823252.4026.124.camel@baylibre.com>
Subject: Re: [PATCH v7 1/7] clk: meson: migrate to
 devm_of_clk_add_hw_provider API
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Apr 2018 12:00:52 +0200
In-Reply-To: <20180426084437.192394-2-yixun.lan@amlogic.com>
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
         <20180426084437.192394-2-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-26 at 16:44 +0800, Yixun Lan wrote:
> There is a protential memory leak, as of_clk_del_provider is
> never called if of_clk_add_hw_provider has been executed.
> Fix this by using devm variant API.
> 
> Fixes: f8c11f79912d ("clk: meson: Add GXBB AO Clock and Reset controller driver")
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/gxbb-aoclk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
> index 9ec23ae9a219..eebb580b9e0f 100644
> --- a/drivers/clk/meson/gxbb-aoclk.c
> +++ b/drivers/clk/meson/gxbb-aoclk.c
> @@ -191,7 +191,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>  			&gxbb_aoclk_onecell_data);
>  }
>  

Applied
Thx
