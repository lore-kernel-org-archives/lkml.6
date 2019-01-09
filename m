Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72545206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lgDNnwe9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GDiZls7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfAIOjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:39:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbfAIOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:39:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83E4860886; Wed,  9 Jan 2019 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547044760;
        bh=ie0zQ4IZp/V+gwwLHzCQn94h6p3uHu8W66low3Um+UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgDNnwe9nvllFkV7jgcygpiDu17SHsmU7BeqBaH/yqNPWRLctI7ncPYCG/Newf5DG
         xzKqJVVyjhXEyteC1NCXJHXQfdZYSTRxKzE0+XU1u5c9RAWindcd/vSRHz77Jarc1A
         DqUJbdnvpy4zDqbgIC+wEsXlH/GVAkNGgEgWf/aU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AC96C6063A;
        Wed,  9 Jan 2019 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547044759;
        bh=ie0zQ4IZp/V+gwwLHzCQn94h6p3uHu8W66low3Um+UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDiZls7DfPLFE+GEvsbv1XjkBuXQyC/lcYoGafJHsrYcDKtQOBrM7dDbu6FcWbXtj
         nanV6vbrTUnB9zBtTylovsJlAcyTNZGC1sBviQa4YktYJ776HNSnLwIcJy8pkaITvT
         4ieq2CGOrtI7PrjF0rGDZ48TjRayE2n3Y4NgVe2k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 20:09:19 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 4/7] remoteproc: q6v5-mss: Vote for rpmh power domains
In-Reply-To: <20190106080915.4493-5-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-5-bjorn.andersson@linaro.org>
Message-ID: <e23a079aa090b393666c413d57440765@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
With the changes suggested below:

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Sibi Sankar <sibis@codeaurora.org>

On 2019-01-06 13:39, Bjorn Andersson wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> With rpmh ARC resources being modelled as power domains with 
> performance
> state, we need to proxy vote on these for SDM845.
> Add support to vote on multiple of them, now that genpd supports
> associating mutliple power domains to a device.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> [bjorn: Drop device link, improve error handling, name things "proxy"]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> This is v3 of this patch, but updated to cover "loadstate". v2 can be
> found here:
> https://lore.kernel.org/lkml/20180904071046.8152-1-rnayak@codeaurora.org/
> 
> Changes since v2:
> - Drop device links, as we can do active and proxy votes using device 
> links
> - Improved error handling, by unrolling some votes on failure
> - Rename things proxy, to follow naming of "proxy" and "active"
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 115 ++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
> b/drivers/remoteproc/qcom_q6v5_mss.c
> index 01be7314e176..62cf16ddb7af 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -25,6 +25,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -131,6 +133,7 @@ struct rproc_hexagon_res {
>  	char **proxy_clk_names;
>  	char **reset_clk_names;
>  	char **active_clk_names;
> +	char **proxy_pd_names;
>  	int version;
>  	bool need_mem_protection;
>  	bool has_alt_reset;
> @@ -156,9 +159,11 @@ struct q6v5 {
>  	struct clk *active_clks[8];
>  	struct clk *reset_clks[4];
>  	struct clk *proxy_clks[4];
> +	struct device *proxy_pds[3];
>  	int active_clk_count;
>  	int reset_clk_count;
>  	int proxy_clk_count;
> +	int proxy_pd_count;
> 
>  	struct reg_info active_regs[1];
>  	struct reg_info proxy_regs[3];
> @@ -321,6 +326,41 @@ static void q6v5_clk_disable(struct device *dev,
>  		clk_disable_unprepare(clks[i]);
>  }
> 
> +static int q6v5_pds_enable(struct q6v5 *qproc, struct device **pds,
> +			   size_t pd_count)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < pd_count; i++) {
> +		dev_pm_genpd_set_performance_state(pds[i], INT_MAX);
> +		ret = pm_runtime_get_sync(pds[i]);
> +		if (ret < 0)
> +			goto unroll_pd_votes;
> +	}
> +
> +	return 0;
> +
> +unroll_pd_votes:
> +	for (i--; i >= 0; i--) {
> +		dev_pm_genpd_set_performance_state(pds[i], 0);
> +		pm_runtime_put(pds[i]);
> +	}
> +
> +	return ret;
> +};
> +
> +static void q6v5_pds_disable(struct q6v5 *qproc, struct device **pds,
> +			     size_t pd_count)
> +{
> +	int i;
> +
> +	for (i = 0; i < pd_count; i++) {
> +		dev_pm_genpd_set_performance_state(pds[i], 0);
> +		pm_runtime_put(pds[i]);
> +	}
> +}
> +
>  static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int 
> *current_perm,
>  				   bool remote_owner, phys_addr_t addr,
>  				   size_t size)
> @@ -690,11 +730,17 @@ static int q6v5_mba_load(struct q6v5 *qproc)
> 
>  	qcom_q6v5_prepare(&qproc->q6v5);
> 
> +	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, 
> qproc->proxy_pd_count);
> +	if (ret < 0) {
> +		dev_err(qproc->dev, "failed to enable proxy power domains\n");
> +		goto disable_irqs;
> +	}
> +
>  	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
>  				    qproc->proxy_reg_count);
>  	if (ret) {
>  		dev_err(qproc->dev, "failed to enable proxy supplies\n");
> -		goto disable_irqs;
> +		goto disable_proxy_pds;
>  	}
> 
>  	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
> @@ -791,6 +837,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  disable_proxy_reg:
>  	q6v5_regulator_disable(qproc, qproc->proxy_regs,
>  			       qproc->proxy_reg_count);
> +disable_proxy_pds:
> +	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
>  disable_irqs:
>  	qcom_q6v5_unprepare(&qproc->q6v5);
> 
> @@ -1121,6 +1169,7 @@ static void qcom_msa_handover(struct qcom_q6v5 
> *q6v5)
>  			 qproc->proxy_clk_count);
>  	q6v5_regulator_disable(qproc, qproc->proxy_regs,
>  			       qproc->proxy_reg_count);
> +	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);

we should call proxy pds_disable on mba_reclaim
as well:

ret = qcom_q6v5_unprepare(&qproc->q6v5);
if (ret) {
   ...
   q6v5_pds_disable(...);
}

>  }
> 
>  static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device 
> *pdev)
> @@ -1181,6 +1230,45 @@ static int q6v5_init_clocks(struct device *dev,
> struct clk **clks,
>  	return i;
>  }
> 
> +static int q6v5_pds_attach(struct device *dev, struct device **devs,
> +			   char **pd_names)
> +{
> +	size_t num_pds = 0;
> +	int ret;
> +	int i;
> +
> +	if (!pd_names)
> +		return 0;
> +
> +	while (pd_names[num_pds])
> +		num_pds++;
> +
> +	for (i = 0; i < num_pds; i++) {
> +		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
> +		if (IS_ERR(devs[i])) {
> +			ret = PTR_ERR(devs[i]);
> +			goto unroll_attach;
> +		}
> +	}
> +
> +	return num_pds;
> +
> +unroll_attach:
> +	for (i--; i >= 0; i--)
> +		dev_pm_domain_detach(devs[i], false);
> +
> +	return ret;
> +};
> +
> +static void q6v5_pds_detach(struct q6v5 *qproc, struct device **pds,
> +			    size_t pd_count)
> +{
> +	int i;
> +
> +	for (i = 0; i < pd_count; i++)
> +		dev_pm_domain_detach(pds[i], false);
> +}
> +
>  static int q6v5_init_reset(struct q6v5 *qproc)
>  {
>  	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
> @@ -1322,10 +1410,18 @@ static int q6v5_probe(struct platform_device 
> *pdev)
>  	}
>  	qproc->active_reg_count = ret;
> 
> +	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
> +			      desc->proxy_pd_names);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to init power domains\n");

Should be "Failed to attach proxy power domains"

> +		goto free_rproc;
> +	}
> +	qproc->proxy_pd_count = ret;
> +
>  	qproc->has_alt_reset = desc->has_alt_reset;
>  	ret = q6v5_init_reset(qproc);
>  	if (ret)
> -		goto free_rproc;
> +		goto detach_proxy_pds;
> 
>  	qproc->version = desc->version;
>  	qproc->need_mem_protection = desc->need_mem_protection;
> @@ -1333,7 +1429,7 @@ static int q6v5_probe(struct platform_device 
> *pdev)
>  	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, 
> MPSS_CRASH_REASON_SMEM,
>  			     qcom_msa_handover);
>  	if (ret)
> -		goto free_rproc;
> +		goto detach_proxy_pds;
> 
>  	qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
>  	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -1344,10 +1440,12 @@ static int q6v5_probe(struct platform_device 
> *pdev)
> 
>  	ret = rproc_add(rproc);
>  	if (ret)
> -		goto free_rproc;
> +		goto detach_proxy_pds;
> 
>  	return 0;
> 
> +detach_proxy_pds:
> +	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
>  free_rproc:
>  	rproc_free(rproc);
> 
> @@ -1364,6 +1462,9 @@ static int q6v5_remove(struct platform_device 
> *pdev)
>  	qcom_remove_glink_subdev(qproc->rproc, &qproc->glink_subdev);
>  	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
>  	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
> +
> +	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +
>  	rproc_free(qproc->rproc);
> 
>  	return 0;
> @@ -1388,6 +1489,12 @@ static const struct rproc_hexagon_res sdm845_mss 
> = {
>  			"mnoc_axi",
>  			NULL
>  	},
> +	.proxy_pd_names = (char*[]){
> +			"cx",
> +			"mx",
> +			"mss",
> +			NULL
> +	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = true,
>  	.version = MSS_SDM845,

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
