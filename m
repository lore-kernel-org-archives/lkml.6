Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeDWGmj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:42:39 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:57736 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeDWGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:42:37 -0400
Subject: Re: [PATCH v2] phy: core: Allow phy_pm_runtime_xxx API calls with
 NULL phy
To: Manu Gautam <mgautam@codeaurora.org>
References: <1521525707-23927-1-git-send-email-mgautam@codeaurora.org>
CC: <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8edb158-9286-6877-ce6e-36a421571d8c@ti.com>
Date: Mon, 23 Apr 2018 12:12:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1521525707-23927-1-git-send-email-mgautam@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 20 March 2018 11:31 AM, Manu Gautam wrote:
> phy_init() and phy_exit() calls, and phy_power_on() and
> phy_power_off() already accept NULL as valid PHY reference
> and act as NOP. Extend same concept to phy runtime_pm APIs
> to keep drivers (e.g. dwc3) code simple while dealing with
> optional PHYs.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>

merged, thanks!

-Kishon

> ---
> Changes for v2:
>  - Fixed compilation warning
> 
>  drivers/phy/phy-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 3c31ce5..1fda576 100644
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
>  		return -ENOTSUPP;
>  
> @@ -168,6 +171,9 @@ int phy_pm_runtime_get_sync(struct phy *phy)
>  {
>  	int ret;
>  
> +	if (!phy)
> +		return 0;
> +
>  	if (!pm_runtime_enabled(&phy->dev))
>  		return -ENOTSUPP;
>  
> @@ -181,6 +187,9 @@ int phy_pm_runtime_get_sync(struct phy *phy)
>  
>  int phy_pm_runtime_put(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
> +
>  	if (!pm_runtime_enabled(&phy->dev))
>  		return -ENOTSUPP;
>  
> @@ -190,6 +199,9 @@ int phy_pm_runtime_put(struct phy *phy)
>  
>  int phy_pm_runtime_put_sync(struct phy *phy)
>  {
> +	if (!phy)
> +		return 0;
> +
>  	if (!pm_runtime_enabled(&phy->dev))
>  		return -ENOTSUPP;
>  
> @@ -199,6 +211,9 @@ int phy_pm_runtime_put_sync(struct phy *phy)
>  
>  void phy_pm_runtime_allow(struct phy *phy)
>  {
> +	if (!phy)
> +		return;
> +
>  	if (!pm_runtime_enabled(&phy->dev))
>  		return;
>  
> @@ -208,6 +223,9 @@ void phy_pm_runtime_allow(struct phy *phy)
>  
>  void phy_pm_runtime_forbid(struct phy *phy)
>  {
> +	if (!phy)
> +		return;
> +
>  	if (!pm_runtime_enabled(&phy->dev))
>  		return;
>  
> 
