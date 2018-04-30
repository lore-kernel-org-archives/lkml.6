Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeD3Nv5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:51:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33159 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbeD3Nvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:51:55 -0400
X-Google-Smtp-Source: AB8JxZqYzKIbkzUZjIvdgoU1eRGjU1WHTkdxlJ1HhfNhw5DAAH5Qt2z0+eH6uA+qK/M0DO370DOgrg==
Date: Mon, 30 Apr 2018 19:21:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] pinctrl: actions: fix missing break in
 PIN_CONFIG_DRIVE_STRENGTH case.
Message-ID: <20180430135149.mn4ywt6i73ocoobk@linaro.org>
References: <20180430132259.9938-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430132259.9938-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 02:22:59PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing break in case PIN_CONFIG_DRIVE_STRENGTH leading to
> a fall-through to the PIN_CONFIG_SLEW_RATE case that performs different
> checks against *arg. This looks like an unintentional missing break so
> add in the break.
> 
> Detected by CoverityScan, CID#1468456, 1468459 ("Missing break in switch")
>

Thanks for fixing!
 
> Fixes: 513d7a2f7e0f ("pinctrl: actions: Add Actions S900 pinctrl driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> 

Thanks,
Mani

> ---
>  drivers/pinctrl/actions/pinctrl-owl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 928b40f71a3c..ee090697b1e9 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -406,6 +406,7 @@ static int owl_group_pinconf_arg2val(const struct owl_pingroup *g,
>  		default:
>  			return -EINVAL;
>  		}
> +		break;
>  	case PIN_CONFIG_SLEW_RATE:
>  		if (*arg)
>  			*arg = OWL_PINCONF_SLEW_FAST;
> @@ -441,6 +442,7 @@ static int owl_group_pinconf_val2arg(const struct owl_pingroup *g,
>  		default:
>  			return -EINVAL;
>  		}
> +		break;
>  	case PIN_CONFIG_SLEW_RATE:
>  		if (*arg)
>  			*arg = 1;
> -- 
> 2.17.0
> 
