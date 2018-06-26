Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71660C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2918E267C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggJPD2B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2918E267C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934416AbeFZJaL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:30:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38063 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934129AbeFZJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:30:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so8250452ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Jnf7218AXUCjBmCe8t2os8+VXaqMn12ZaVbFxWeItI=;
        b=ggJPD2B/RkiX6POL/fiduO3MfYuswxlHq1fTnElaQZ17h5eyoayvGqmTmElRs2Q395
         dgE/OI+HWyyKCpNaZ3WJCSXG4nCvwVD8l8XpKkWIITYwou87cyiAACFszKxn0r44eG8I
         +JHoxT6uQItjzr/WhQUegL6FPmwEG1oiSRWcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Jnf7218AXUCjBmCe8t2os8+VXaqMn12ZaVbFxWeItI=;
        b=Nh1MTA0l8HUK4JwBmVKDDaPZDeFzFzCgVDtBnAnejFg1Tsf65A8+XeAhtBqkcT1TOs
         j5N5rVN3CvVQuCyS6TLeJbLXTVdm607/G5yWtBgKw3Qjaz5JKQDV2VWShYsw9dCDLxh6
         8t28Nfiq/xuWWJaGu31cD/mSkcvQ4fOL586aqcmJWFjkgfOmNhPxdi8dI+A4Z6j9Z2vn
         2o2T7lK70z68HCmvVUmGK2duJ7dkkSAl1Ivccazo1Fs88xzrJi+Blm7IHBOX05JK52uA
         sZ/2hyi2jduZcy0wgprnhUNmAwR0be6AuX1TMRcqTCONbZwo/oLez6HLDFvR1luRevw8
         lV5Q==
X-Gm-Message-State: APt69E3NfoH6l+49f57OCLEowdUwpPUwHfo4tDzFlxEU8REDpoXq3ggv
        CMFFtRa0Gz1ssXkwwnJBEQ3D7g==
X-Google-Smtp-Source: ADUXVKIbMkmx48aZOCo6Otpf3UqrZ1pysXi4Lz8uPN3+SU3a0uuqsgBhAbOGTLursAiYx5Sfdn4JGg==
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr586341ljg.93.1530005406357;
        Tue, 26 Jun 2018 02:30:06 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q16-v6sm246828lfi.68.2018.06.26.02.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:30:05 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:30:03 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/12] ASoC: qdsp6: q6adm: use
 of_platform_populate/depopulate()
Message-ID: <20180626093003.GB25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:08AM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6adm.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
> index 9983c665a941..932c3ebfd252 100644
> --- a/sound/soc/qcom/qdsp6/q6adm.c
> +++ b/sound/soc/qcom/qdsp6/q6adm.c
> @@ -64,7 +64,6 @@ struct q6adm {
>  	struct aprv2_ibasic_rsp_result_t result;
>  	struct mutex lock;
>  	wait_queue_head_t matrix_map_wait;
> -	struct platform_device *pdev_routing;
>  };
>  
>  struct q6adm_cmd_device_open_v5 {
> @@ -588,7 +587,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
>  static int q6adm_probe(struct apr_device *adev)
>  {
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  	struct q6adm *adm;
>  
>  	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
> @@ -605,22 +603,12 @@ static int q6adm_probe(struct apr_device *adev)
>  	INIT_LIST_HEAD(&adm->copps_list);
>  	spin_lock_init(&adm->copps_list_lock);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "routing");
> -	if (dais_np) {
> -		adm->pdev_routing = of_platform_device_create(dais_np,
> -							   "q6routing", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6adm_remove(struct apr_device *adev)
>  {
> -	struct q6adm *adm = dev_get_drvdata(&adev->dev);
> -
> -	if (adm->pdev_routing)
> -		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
> +	of_platform_depopulate(&adev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 
