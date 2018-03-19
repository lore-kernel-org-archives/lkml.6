Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeCSIr1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:47:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:47:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Mar 2018 14:17:22 +0530
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] phy: core: Allow phy_pm_runtime_xxx API calls with NULL
 phy
In-Reply-To: <1521191452-30089-1-git-send-email-mgautam@codeaurora.org>
References: <1521191452-30089-1-git-send-email-mgautam@codeaurora.org>
Message-ID: <a34e1f1038e667e0ee9a568e7b8ff3ce@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 14:40, Manu Gautam wrote:
> phy_init() and phy_exit() calls, and phy_power_on() and
> phy_power_off() already accept NULL as valid PHY refernece
> and act as NOP. Extend same concept to phy runtime_pm APIs
> to keep drivers (e.g. dwc3) code simple while dealing with
> optional PHYs.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/phy-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 09ac8af..48b9615 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -153,6 +153,9 @@ int phy_pm_runtime_get(struct phy *phy)
>  {
>  	int ret;
> 
> +	if (!phy)
> +		return 0;
> +
>  	if (!pm_runtime_enabled(&phy->dev))

Were we already trying to dereference a NULL here?
That shouldn't be good i guess.
Kishon, do we not expect phys to be NULL here?

<snip>

regards
Vivek
