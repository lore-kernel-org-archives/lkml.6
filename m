Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeEWK5c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:57:32 -0400
Received: from gloria.sntech.de ([95.129.55.99]:43794 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbeEWK5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:57:05 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 03/13] Soc: rockchip: power-domain: add power domain support for rk3036
Date: Wed, 23 May 2018 12:57:00 +0200
Message-ID: <3796690.BWmYtbrbqI@diego>
In-Reply-To: <1527058129-10260-4-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com> <1527058129-10260-4-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. Mai 2018, 08:48:39 CEST schrieb Elaine Zhang:
> From: Caesar Wang <wxt@rock-chips.com>
> 
> This driver is modified to support RK3036 SoC.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

> @@ -102,6 +103,14 @@ struct rockchip_pmu {
>  	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
>  	.active_wakeup = wakeup,			\
>  }

I've added a blank line here, made "Soc" in the subject lower case and
applied it for 4.18 or 4.19 (not sure yet).


Thanks
Heiko

> +#define DOMAIN_RK3036(req, ack, idle, wakeup)		\
> +{							\
> +	.req_mask = (req >= 0) ? BIT(req) : 0,		\
> +	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
> +	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
> +	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
> +	.active_wakeup = wakeup,			\
> +}
