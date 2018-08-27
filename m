Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF16A208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5Y/W6ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF16A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH0USd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:18:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53152 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeH0USd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:18:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so8633476wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X8BzcDoIUboAksfxy4r25xzEFsF30Ykwsc4Ce8oEt48=;
        b=N5Y/W6gaYCzLQrbb7dLJK+f2+ShaQKDU73Vx8+verAhVmBaE6YL5fX8RVXgA0P3C0I
         iBsmL3Gk5gF/IZHwyy5bH9xvVCi6m/5EmFsg1jiwukjiuXbZbHRvhFayisdWktX94NA/
         4eJmV7sLNU+AaA/3sziQrIZJ9cEDRLsos3rtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8BzcDoIUboAksfxy4r25xzEFsF30Ykwsc4Ce8oEt48=;
        b=oxEaJpK+t/I5qAK1lXmmGjmilCuzl+l/Ie8n2YnUgYFMwtCdMBBIrPYwIRo46Z0FFu
         26KKgSmD83pUv/aG5/kDTWqoZNyxUGugrUdGfUthGy6LbwDHLpxCVZkWjuIhi/5zZHms
         7WDaEt2/ckZyKSOj97BI2gXQb/T0d68ku7dP8oMi0xFAXGjNBck29QGjYuKzE5mcJXs8
         kgVp7GDIszvWl66HKLJIhrNwni40smcP/YLtlrmhr0OiPp9ETBdKFd7RuD7OXNbSdKWN
         oRLMl3myTVHR8sMK8b6q5Fyn7YQfHIYF88YeqVDge9DWKcXaJzTfyj2Ut8380E31HeLm
         kIyw==
X-Gm-Message-State: APzg51CdiGvdw9VfSm578OIa5yC9jmMgKeIdmlXQVxGkEKn4NlBCaQVL
        WcGbxuBB16ykqY2zg7E8QMM6uw==
X-Google-Smtp-Source: ANB0VdYLOAz0QCdwBh684p9vhZNzHD0p4yaxaj+kzoXjXdAgZWuKbfes2F9kZpNz7wq6JLmOhDpAlQ==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12-v6mr6389365wmf.57.1535387473623;
        Mon, 27 Aug 2018 09:31:13 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 198-v6sm17846325wmm.0.2018.08.27.09.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 09:31:12 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/thermal/tegra: Fix a double free on the device
 node
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        ezequiel@collabora.com
References: <1535376738-14035-1-git-send-email-zhongjiang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b450ad67-ac22-03ea-677c-34b254ffa976@linaro.org>
Date:   Mon, 27 Aug 2018 18:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535376738-14035-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2018 15:32, zhong jiang wrote:
> The function 'for_each_child_of_node' iterates over the node list by
> dropping the of_node reference of the previous node.
> 
> Calling of_node_put() on the iterator is pointless and leads to an
> inconsistent refcounting in addition to a double free. Remove it.
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> v1->v2: According to Daniel's suggestion. I modify the subject and commit log.
> 
>  drivers/thermal/tegra/soctherm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110..3aa55c9 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -980,7 +980,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  		tcd = thermal_of_cooling_device_register(np_stcc,
>  							 (char *)name, ts,
>  							 &throt_cooling_ops);
> -		of_node_put(np_stcc);
>  		if (IS_ERR_OR_NULL(tcd)) {
>  			dev_err(dev,
>  				"throttle-cfg: %s: failed to register cooling device\n",
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

