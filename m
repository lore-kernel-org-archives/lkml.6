Return-Path: <ck.hu@mediatek.com>
X-Google-Smtp-Source: AB8JxZrxhJPwxJ42qljz9lrS7yai4Z+bSUDqCCwKKpxfnAVuTYMzWt+PR0gw5pwKhAftIjEapjmL
ARC-Seal: i=1; a=rsa-sha256; t=1525084969; cv=none;
        d=google.com; s=arc-20160816;
        b=qaefa/V10lQrui/ukWRu0FZL0jBST5k5GkbpquEtGktLJpNMfZeBHYJ/ZFhv3erg63
         uu1wosi58nR/yMAfCHG9khH3Jy5zN4AEhNgDkQQ3ta3SnZgNf8bHocmodZSSqBsKyah9
         IWIP3rv6bKkNsNDzLzMx8gVJRubr3nRj6DuePF4aUTrlqxkld5+yOMLKzgizNgQWjXg3
         m/Uxq+1syu4VR4G5x9Fd+qlDEaQuxcoKbU9XpSss8JsEcii7jV+ZHq+XxigzRUUDbSVh
         vGBb5ttiGjze+UN9sNvUrE8G3AkmNCQHRhA2CJ9H+QSIzsojZGgBAcKu7IF1mgSoNI8f
         ws0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=20kL/13eOawciohh7AYlVva5jeLjcK26HDuDQikcbf0=;
        b=FNM1of0Kl10/wy6dtPDg1qqWjl5w3Vwl9VNs1y+1Ipf4w1f1jQ3/ApOsfO6k1z+LSi
         tYQ+s5LHJ7/iu2DCOXff+/GilO+WsU9sxEjsRdBpAp/BAD+EjLrgzxowv942W487CKp9
         uub1IjVLSV/Z6+LThWjC0PsHszcjq5JQHmfX9IU07AOjUxQj/VKLI4hdXXbxSWaavRM/
         kTeiZfzIVfY2gQLUeOBFay0ndwTqoGj7BNUSPUporqCwnx+hEpRFmprHgtWcbTwcIgC4
         AdwdMGUcKPaz17upzWifZhxG+4aMmxVTzoZ3xar6YzAQxK0O0h2qk83Y2mMun3EJFj+p
         cdvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ck.hu@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=ck.hu@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ck.hu@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=ck.hu@mediatek.com
X-UUID: d23e429c040447d1beb2cf9f1afe2cbd-20180430
Message-ID: <1525084962.25456.2.camel@mtksdaap41>
Subject: Re: [v3 04/10] drm/mediatek: mt2701: switch to mfd probing.
From: CK Hu <ck.hu@mediatek.com>
To: <matthias.bgg@kernel.org>
CC: <ulrich.hecht+renesas@gmail.com>, <laurent.pinchart@ideasonboard.com>,
	<p.zabel@pengutronix.de>, <airlied@linux.ie>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<lee.jones@linaro.org>, <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
	<mchehab@kernel.org>, <rdunlap@infradead.org>, <sean.wang@mediatek.com>,
	<linux-clk@vger.kernel.org>, <linux@armlinux.org.uk>,
	<matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Matthias Brugger <mbrugger@suse.com>
Date: Mon, 30 Apr 2018 18:42:42 +0800
In-Reply-To: <b50d32fb140dcf25ac467f0b5e7a84353c8d31d3.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
	 <b50d32fb140dcf25ac467f0b5e7a84353c8d31d3.1524820923.git.mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890788706777550?=
X-GMAIL-MSGID: =?utf-8?q?1599167497264686004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Matthias:


On Fri, 2018-04-27 at 11:23 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> With the mtk-mmsys MFD device in place, we switch the probing for
> mt2701 from device-tree to mfd.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a48e28adad09..88ee35907744 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -386,7 +386,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_drm_private *private;
> -	struct device_node *node;
> +	struct device_node *node, *parent_node, *mmsys_node;
>  	struct component_match *match = NULL;
>  	int ret;
>  	int i;
> @@ -399,12 +399,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
> -	private->config_regs = syscon_node_to_regmap(dev->of_node);
> -	if (IS_ERR(private->config_regs))
> -		return PTR_ERR(private->config_regs);
> +	/* Check if called from mfd */
> +	if (!dev->of_node) {
> +		mmsys_node = pdev->dev.parent->of_node;
> +		private->data = (struct mtk_mmsys_driver_data *)
> +				platform_get_device_id(pdev)->driver_data;
> +		private->config_regs =
> +			syscon_node_to_regmap(mmsys_node);
> +		parent_node = mmsys_node->parent;
> +	} else {
> +		private->config_regs = syscon_node_to_regmap(dev->of_node);
> +		if (IS_ERR(private->config_regs))
> +			return PTR_ERR(private->config_regs);
> +		parent_node = dev->of_node->parent;
> +	}
>  
>  	/* Iterate over sibling DISP function blocks */
> -	for_each_child_of_node(dev->of_node->parent, node) {
> +	for_each_child_of_node(parent_node, node) {
>  		const struct of_device_id *of_id;
>  		enum mtk_ddp_comp_type comp_type;
>  		int comp_id;
> @@ -545,13 +556,17 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  			 mtk_drm_sys_resume);
>  
>  static const struct of_device_id mtk_drm_of_ids[] = {
> -	{ .compatible = "mediatek,mt2701-mmsys",
> -	  .data = &mt2701_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8173-mmsys",
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ }
>  };
>  
> +static const struct platform_device_id mtk_drm_ids[] = {
> +	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
> +
>  static struct platform_driver mtk_drm_platform_driver = {
>  	.probe	= mtk_drm_probe,
>  	.remove	= mtk_drm_remove,
> @@ -560,6 +575,7 @@ static struct platform_driver mtk_drm_platform_driver = {
>  		.of_match_table = mtk_drm_of_ids,
>  		.pm     = &mtk_drm_pm_ops,
>  	},
> +	.id_table = mtk_drm_ids,
>  };
>  
>  static struct platform_driver * const mtk_drm_drivers[] = {
