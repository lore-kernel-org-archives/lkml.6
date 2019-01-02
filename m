Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00240C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DB521871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfABIOR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:14:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33547 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfABIOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:14:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43V3jc5g04z9v0lq;
        Wed,  2 Jan 2019 09:14:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ji2xEjdDqvVd; Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43V3jc46Xnz9v0ln;
        Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 5D1D7913; Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: from 37.168.207.163 ([37.168.207.163]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 02 Jan 2019 09:14:12 +0100
Date:   Wed, 02 Jan 2019 09:14:12 +0100
Message-ID: <20190102091412.Horde.y2c3R1S1rMxnqDcnPLDPaA4@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, leoyang.li@nxp.com, qiang.zhao@nxp.com
Subject: Re: [PATCH v5] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
In-Reply-To: <1546446223-17184-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Hao <peng.hao2@zte.com.cn> a écrit :

> From: Wen Yang <wen.yang99@zte.com.cn>
>
> Currently there are some issues with the ucc_of_parse_tdm function:
> 1, a possible null pointer dereference in ucc_of_parse_tdm,
> detected by the semantic patch deref_null.cocci,
> with the following warning:
> drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 2, dev gets modified, so in any case that devm_iounmap() will fail
> even when the new pdev is valid, because the iomap was done with a
>  different pdev.
> 3, there is no driver bind with the "fsl,t1040-qe-si" or
> "fsl,t1040-qe-siram" device. So allocating resources using devm_*()
> with these devices won't provide a cleanup path for these resources
> when the caller fails.
>
> This patch fixes them.
>
> Suggested-by: Li Yang <leoyang.li@nxp.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Zhao Qiang <qiang.zhao@nxp.com>
> CC: David S. Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> ---

In order to ease review, could add the list of changes between each  
version of the patch ? Usually we do it at this place so that it is  
available for reviewers but not part of the commit text.

Christophe

>  drivers/net/wan/fsl_ucc_hdlc.c | 62  
> +++++++++++++++++++++++++++++++++++++++++-
>  drivers/soc/fsl/qe/qe_tdm.c    | 55 -------------------------------------
>  2 files changed, 61 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 839fa77..f30a040 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1057,6 +1057,54 @@ static const struct net_device_ops uhdlc_ops = {
>  	.ndo_tx_timeout	= uhdlc_tx_timeout,
>  };
>
> +static int hdlc_map_iomem(char *name, int init_flag, void __iomem **ptr)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +	struct resource *res;
> +	static int siram_init_flag;
> +	int ret = 0;
> +
> +	np = of_find_compatible_node(NULL, NULL, name);
> +	if (!np)
> +		return -EINVAL;
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		pr_err("%pOFn: failed to lookup pdev\n", np);
> +		of_node_put(np);
> +		return -EINVAL;
> +	}
> +
> +	of_node_put(np);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto error_put_device;
> +	}
> +	*ptr = ioremap(res->start, resource_size(res));
> +	if (!*ptr) {
> +		ret = -ENOMEM;
> +		goto error_put_device;
> +	}
> +
> +	/* We've remapped the addresses, and we don't need the device any
> +	 * more, so we should release it.
> +	 */
> +	put_device(&pdev->dev);
> +
> +	if (init_flag && siram_init_flag == 0) {
> +		memset_io(*ptr, 0, resource_size(res));
> +		siram_init_flag = 1;
> +	}
> +	return  0;
> +
> +error_put_device:
> +	put_device(&pdev->dev);
> +
> +	return ret;
> +}
> +
>  static int ucc_hdlc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -1151,6 +1199,15 @@ static int ucc_hdlc_probe(struct  
> platform_device *pdev)
>  		ret = ucc_of_parse_tdm(np, utdm, ut_info);
>  		if (ret)
>  			goto free_utdm;
> +
> +		ret = hdlc_map_iomem("fsl,t1040-qe-si", 0,
> +				     (void __iomem **)&utdm->si_regs);
> +		if (ret)
> +			goto free_utdm;
> +		ret = hdlc_map_iomem("fsl,t1040-qe-siram", 1,
> +				     (void __iomem **)&utdm->siram);
> +		if (ret)
> +			goto unmap_si_regs;
>  	}
>
>  	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
> @@ -1159,7 +1216,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
>  	ret = uhdlc_init(uhdlc_priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to init uhdlc\n");
> -		goto free_utdm;
> +		goto undo_uhdlc_init;
>  	}
>
>  	dev = alloc_hdlcdev(uhdlc_priv);
> @@ -1188,6 +1245,9 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
>  free_dev:
>  	free_netdev(dev);
>  undo_uhdlc_init:
> +	iounmap(utdm->siram);
> +unmap_si_regs:
> +	iounmap(utdm->si_regs);
>  free_utdm:
>  	if (uhdlc_priv->tsa)
>  		kfree(utdm);
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..76480df 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -44,10 +44,6 @@ int ucc_of_parse_tdm(struct device_node *np,  
> struct ucc_tdm *utdm,
>  	const char *sprop;
>  	int ret = 0;
>  	u32 val;
> -	struct resource *res;
> -	struct device_node *np2;
> -	static int siram_init_flag;
> -	struct platform_device *pdev;
>
>  	sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
>  	if (sprop) {
> @@ -124,57 +120,6 @@ int ucc_of_parse_tdm(struct device_node *np,  
> struct ucc_tdm *utdm,
>  	utdm->siram_entry_id = val;
>
>  	set_si_param(utdm, ut_info);
> -
> -	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-si");
> -	if (!np2)
> -		return -EINVAL;
> -
> -	pdev = of_find_device_by_node(np2);
> -	if (!pdev) {
> -		pr_err("%pOFn: failed to lookup pdev\n", np2);
> -		of_node_put(np2);
> -		return -EINVAL;
> -	}
> -
> -	of_node_put(np2);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(utdm->si_regs)) {
> -		ret = PTR_ERR(utdm->si_regs);
> -		goto err_miss_siram_property;
> -	}
> -
> -	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-siram");
> -	if (!np2) {
> -		ret = -EINVAL;
> -		goto err_miss_siram_property;
> -	}
> -
> -	pdev = of_find_device_by_node(np2);
> -	if (!pdev) {
> -		ret = -EINVAL;
> -		pr_err("%pOFn: failed to lookup pdev\n", np2);
> -		of_node_put(np2);
> -		goto err_miss_siram_property;
> -	}
> -
> -	of_node_put(np2);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(utdm->siram)) {
> -		ret = PTR_ERR(utdm->siram);
> -		goto err_miss_siram_property;
> -	}
> -
> -	if (siram_init_flag == 0) {
> -		memset_io(utdm->siram, 0,  resource_size(res));
> -		siram_init_flag = 1;
> -	}
> -
> -	return ret;
> -
> -err_miss_siram_property:
> -	devm_iounmap(&pdev->dev, utdm->si_regs);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ucc_of_parse_tdm);
> --
> 2.9.5


