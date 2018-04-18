Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeDRPHA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:07:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40915 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeDRPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:06:56 -0400
X-Google-Smtp-Source: AIpwx49GdJ7zHr+OPPdeulkX2dzXWK58NT/EE0r9mwJiVWlAF/EIJLCb7wow3ttTbeyPfc83ZQ/rTw==
Subject: Re: [PATCH v1 3/7] soc: mediatek: reuse read[l,x]_poll_timeout
 helpers
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        marcel@holtmann.org, johan.hedberg@gmail.com
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <2c0d233c658fa6093a18a54e82a3e51340251bc9.1522736996.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <549e6adc-73c1-aa03-93dc-578138729750@gmail.com>
Date: Wed, 18 Apr 2018 17:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c0d233c658fa6093a18a54e82a3e51340251bc9.1522736996.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 09:15 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Reuse the common helpers read[l,x]_poll_timeout provided by Linux core
> instead of an open-coded handling. The name of the local variable
> sram_pdn_ack in scpsys_power_on is renamed to pdn_ack in order to be
> consistent with the one used in scpsys_power_off.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

pushed to v4.17-next/soc

Thanks!

>  drivers/soc/mediatek/mtk-scpsys.c | 91 ++++++++++-----------------------------
>  1 file changed, 23 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index d762a46..f9b7248 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -13,6 +13,7 @@
>  #include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -27,6 +28,9 @@
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> +
>  #define SPM_VDE_PWR_CON			0x0210
>  #define SPM_MFG_PWR_CON			0x0214
>  #define SPM_VEN_PWR_CON			0x0230
> @@ -184,12 +188,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
> -	unsigned long timeout;
> -	bool expired;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -	u32 sram_pdn_ack = scpd->data->sram_pdn_ack_bits;
> +	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
> -	int ret;
> +	int ret, tmp;
>  	int i;
>  
>  	if (scpd->supply) {
> @@ -215,23 +217,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until PWR_ACK = 1 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (1) {
> -		ret = scpsys_domain_is_on(scpd);
> -		if (ret > 0)
> -			break;
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto err_pwr_ack;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto err_pwr_ack;
>  
>  	val &= ~PWR_CLK_DIS_BIT;
>  	writel(val, ctl_addr);
> @@ -246,20 +235,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until SRAM_PDN_ACK all 0 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto err_pwr_ack;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto err_pwr_ack;
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> @@ -289,12 +268,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  {
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
> -	unsigned long timeout;
> -	bool expired;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
>  	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
> -	int ret;
> +	int ret, tmp;
>  	int i;
>  
>  	if (scpd->data->bus_prot_mask) {
> @@ -310,19 +287,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until SRAM_PDN_ACK all 1 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (pdn_ack && (readl(ctl_addr) & pdn_ack) != pdn_ack) {
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto out;
>  
>  	val |= PWR_ISO_BIT;
>  	writel(val, ctl_addr);
> @@ -340,23 +308,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until PWR_ACK = 0 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (1) {
> -		ret = scpsys_domain_is_on(scpd);
> -		if (ret == 0)
> -			break;
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto out;
>  
>  	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
>  		clk_disable_unprepare(scpd->clk[i]);
> 
