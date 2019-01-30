Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499220881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1F6L8af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfA3VEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:04:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfA3VEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:04:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so383483pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXaZZCzb4lxN0M10ctsL+maHDKL7MpdrKm+q3n6znSM=;
        b=E1F6L8afej4fNaHsE4J0ZW5lXWYeIGhNjBNDio6Px6HtntwAVNVD5LYlknSlytd862
         1VPH4NT0v3it5SP5b7vaVWeCPp7TpyLSPuWHSUwVryGwULQFXgwdhy7B7zPKIjbY+fM2
         m9Gvjz+CUgZiuS3L354L/LQ8+Wu4VqDBluB0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXaZZCzb4lxN0M10ctsL+maHDKL7MpdrKm+q3n6znSM=;
        b=NduPKaLphg1UrdicVfp2LdEK7b5679RxK6GaRv2LYPj/1Tn5xUzT1rlcRmqR8D7Pxn
         SH4mSIKYRUFbBQlQjCRGx2IX5bs58wVQo9xKA/ktT6s6fU/i5WrHvtYO+OfW1OXxBQsn
         ai/K/fmndP1gYxdyD5PxD1jMncoolq6LfavAk9ZFW6WXl/TOMSbmxeIJsLRubXJazXtk
         fZua1uJ0RKXC4ZntfN3a0qP4wZk2LoMpZojNAhZAUgJnw8T/7j8/bkmuOR7zlycNHUvQ
         j9XH1ThlBUNZYQbIgmHzwKBc5z3B8Xo2PwmuDLiRkTLxmpyCJKcz/KEfn6XPL4CvMR4R
         +mvA==
X-Gm-Message-State: AJcUukcIU2TdTFPY+/tHBFn7jHJfleKa9ycMKT5Ndjjs7VYNCGGsb9c+
        sfKAEPUhH+X2UByK1UoDMkl2Fw==
X-Google-Smtp-Source: ALg8bN5PfoERrPz+IwZTYYcR1N6zfCxxJIWK57n2Ev77xmlnhvc9UcNdei49eCwhg2o2c+WO1M0MjA==
X-Received: by 2002:a63:5964:: with SMTP id j36mr28957238pgm.210.1548882258200;
        Wed, 30 Jan 2019 13:04:18 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm3654344pfi.102.2019.01.30.13.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 13:04:17 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:04:15 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     briannorris@chromium.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v3] remoteproc: qcom: Add support for parsing fw dt
 bindings
Message-ID: <20190130210415.GV31919@minitux>
References: <20190114195001.7016-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114195001.7016-1-sibis@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 11:50 PST 2019, Sibi Sankar wrote:

> Add support for parsing "firmware-name" dt bindings which specifies
> the relative paths of mba/modem/pas image as strings. Fallback to
> the default paths for mba/modem/pas image on -EINVAL.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Applied,

Thanks,
Bjorn

> ---
> 
> v3:
>  * Fixed minor code style issues
>  * Add comments for firmware blob name generation
>    and use sprintf instead
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 47 +++++++++++++++++++++++-------
>  drivers/remoteproc/qcom_q6v5_pas.c |  9 +++++-
>  2 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index c86dc40cfb8c..41e92a025d21 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -188,6 +188,7 @@ struct q6v5 {
>  	bool has_alt_reset;
>  	int mpss_perm;
>  	int mba_perm;
> +	const char *hexagon_mdt_image;
>  	int version;
>  };
>  
> @@ -860,17 +861,26 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	phys_addr_t min_addr = PHYS_ADDR_MAX;
>  	phys_addr_t max_addr = 0;
>  	bool relocate = false;
> -	char seg_name[10];
> +	char *fw_name;
> +	size_t fw_name_len;
>  	ssize_t offset;
>  	size_t size = 0;
>  	void *ptr;
>  	int ret;
>  	int i;
>  
> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
> +	fw_name_len = strlen(qproc->hexagon_mdt_image);
> +	if (fw_name_len <= 4)
> +		return -EINVAL;
> +
> +	fw_name = kstrdup(qproc->hexagon_mdt_image, GFP_KERNEL);
> +	if (!fw_name)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&fw, fw_name, qproc->dev);
>  	if (ret < 0) {
> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
> -		return ret;
> +		dev_err(qproc->dev, "unable to load %s\n", fw_name);
> +		goto out;
>  	}
>  
>  	/* Initialize the RMB validator */
> @@ -918,10 +928,11 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  		ptr = qproc->mpss_region + offset;
>  
>  		if (phdr->p_filesz) {
> -			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
> -			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
> +			/* Replace "xxx.xxx" with "xxx.bxx" */
> +			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
> +			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
>  			if (ret) {
> -				dev_err(qproc->dev, "failed to load %s\n", seg_name);
> +				dev_err(qproc->dev, "failed to load %s\n", fw_name);
>  				goto release_firmware;
>  			}
>  
> @@ -960,6 +971,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  
>  release_firmware:
>  	release_firmware(fw);
> +out:
> +	kfree(fw_name);
>  
>  	return ret < 0 ? ret : 0;
>  }
> @@ -1075,9 +1088,10 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  	unsigned long i;
>  	int ret;
>  
> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
> +	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
>  	if (ret < 0) {
> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
> +		dev_err(qproc->dev, "unable to load %s\n",
> +			qproc->hexagon_mdt_image);
>  		return ret;
>  	}
>  
> @@ -1253,6 +1267,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	const struct rproc_hexagon_res *desc;
>  	struct q6v5 *qproc;
>  	struct rproc *rproc;
> +	const char *mba_image;
>  	int ret;
>  
>  	desc = of_device_get_match_data(&pdev->dev);
> @@ -1262,8 +1277,14 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (desc->need_mem_protection && !qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	mba_image = desc->hexagon_mba_image;
> +	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
> +					    0, &mba_image);
> +	if (ret < 0 && ret != -EINVAL)
> +		return ret;
> +
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
> -			    desc->hexagon_mba_image, sizeof(*qproc));
> +			    mba_image, sizeof(*qproc));
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "failed to allocate rproc\n");
>  		return -ENOMEM;
> @@ -1272,6 +1293,12 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
> +	qproc->hexagon_mdt_image = "modem.mdt";
> +	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
> +					    1, &qproc->hexagon_mdt_image);
> +	if (ret < 0 && ret != -EINVAL)
> +		return ret;
> +
>  	platform_set_drvdata(pdev, qproc);
>  
>  	ret = q6v5_init_mem(qproc, pdev);
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index b1e63fcd5fdf..cfdafd68e2cd 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -258,6 +258,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	const struct adsp_data *desc;
>  	struct qcom_adsp *adsp;
>  	struct rproc *rproc;
> +	const char *fw_name;
>  	int ret;
>  
>  	desc = of_device_get_match_data(&pdev->dev);
> @@ -267,8 +268,14 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (!qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	fw_name = desc->firmware_name;
> +	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
> +				      &fw_name);
> +	if (ret < 0 && ret != -EINVAL)
> +		return ret;
> +
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
> -			    desc->firmware_name, sizeof(*adsp));
> +			    fw_name, sizeof(*adsp));
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>  		return -ENOMEM;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
