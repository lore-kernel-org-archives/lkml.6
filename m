Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F39FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D79D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fx3/pE6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfANUyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:54:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfANUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:54:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so165103pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bNNDGi8G+3A2PTJSlwP2eZj4dWf1yGhPH3nQppllyKo=;
        b=fx3/pE6eriS4ZLrRcSpMC63esvEVaxcRQZ/ZTy6UGuQXxqcQsLHSY3C5jVE/k7CRUM
         IiWo8HQRd2qB7j9jktQZiDF6IeZaB+QhOIC7gN/kqozOoLneml0ZbZZtaYyf18f7WMwm
         McFhg+1sNR1ZpzCnSryCLl1CWJOCRP4u2DjXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bNNDGi8G+3A2PTJSlwP2eZj4dWf1yGhPH3nQppllyKo=;
        b=KPZ8bLXpVKHrlFnasjw2DQd4E8quIkmLSNWHLFc/gkymkped/oGLYKLjYgrnc0/bcB
         s1pLxtvdysjLFPH58VODgcCFO/0HU2HTiOXPdJC2L2E3fyUzloxO8L4EhSQdateiPWHn
         zXByvOUdNzbLSaFd/lZp7IbNVna9/e5J7DAUI4dZE9VFy/h0ZSxvDYTo1hC+7z+AysP/
         qzl+PM22P4t82N+mUVS39bmKMwgUeOePZOgjSp/+jtz88FqdOb0Ix25mbGpYsHQKAtaw
         qcbMnZiJqSg3d4hn2IUpfepYH8mGcdeh5hgl3wUQVU7LMByI5CFb/T61K6sypmEX5QgF
         XwrA==
X-Gm-Message-State: AJcUukdKObUaGmptz6xPnx98ojJt1m/xbWjyqdsQtLau8r22bEAIglTQ
        Q0eM0s/5cPe/Tn4xmOLPnJ0Jfj9pNkKXRw==
X-Google-Smtp-Source: ALg8bN7skfJiBHCdrfZco8pp8OUcbaaygBcZxR8wESqJYYAvmATmmGyiW+E6dDpxsVveFNiDBI5I7Q==
X-Received: by 2002:a63:9c1a:: with SMTP id f26mr360147pge.381.1547499277625;
        Mon, 14 Jan 2019 12:54:37 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 19sm2299407pfs.108.2019.01.14.12.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:54:36 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:54:35 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org,
        dianders@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 04/10] cpufreq: qcom-hw: Register as a cpufreq cooling
 device
Message-ID: <20190114205435.GM261387@google.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <bd172905b0208b958f8c4f239b55ac3e345c60a8.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd172905b0208b958f8c4f239b55ac3e345c60a8.1547481320.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:04:56PM +0530, Amit Kucheria wrote:
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4..ed32849a3d40 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>  
>  static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qcom_cpufreq_hw_target_index,
>  	.get		= qcom_cpufreq_hw_get,

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
