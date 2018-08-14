Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950572173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQM6cad4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950572173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeHNJZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:25:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeHNJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:25:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so11016495wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8soxgV9OwmU+jUkETOmD1UUkdWra41bj1pB0zgqrVmw=;
        b=ZQM6cad4YeJYJ8LO2PtbBePl0t7/8C1LJlnAuVPTsEL8O9OldU43QN3d3bWh5P/Na3
         3AjoXHBVvUsgwWIemRYXCSCkcGO0ooyupWjGidk5JhPYQflBZOp54BS3iXBOqYNpnzBa
         h2Sh4ytb7CrvOu3+bb3iRLxhxJbF57GT3wH14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8soxgV9OwmU+jUkETOmD1UUkdWra41bj1pB0zgqrVmw=;
        b=knLwesuqgN/Lgd5QeMvFM9TxUTgoBPxm2QaK8A42PoYuCL52bH89SkswYcgZhFwVWN
         nYw/U10OCeJVB7Y9jTVedafnjJa//2C5lG3XbTb+jcxj5VrHxBCernXKUMaQXDIeN+q/
         dI6krzWtoNrhRDfwV9xS3f8yzZoIw/6xF8+WOFZosL456PmLVKmdFUyXWHXFEzyt2iHV
         ByMN/LjssMYWRefkmtn0Qfbf0kG29sL3HqmpopUxRmOpbmRFacS2iRujNrXx+Y8b33cG
         VBHBWR4LXkM1JOapXG8gVp640BHqIeJPPaLrlpYi02hpq45Sgdm1eV8heYi+oBkoI1pm
         /+YQ==
X-Gm-Message-State: AOUpUlEwFOHjEg4Bcct9elLtY5REJdHYChunkvOZyk7YAI6ElqNamfhX
        oQ9yvDd4dEiFNy8I0Unt+vL3wH0mnbRz0Q==
X-Google-Smtp-Source: AA+uWPxc2r+QqT/mnVCbLloFm6iUtaiIi4YmoTgj/mV/zWvVD6jKuyTnxvk6F6pJrT2EO7vH3QLk7A==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr9488323wmk.98.1534228771527;
        Mon, 13 Aug 2018 23:39:31 -0700 (PDT)
Received: from [192.168.0.104] ([31.25.180.182])
        by smtp.googlemail.com with ESMTPSA id c12-v6sm23717009wrr.6.2018.08.13.23.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 23:39:30 -0700 (PDT)
Subject: Re: [PATCH] drivers/thermal/tegra: fix a doule free devce node
To:     zhong jiang <zhongjiang@huawei.com>, ezequiel@collabora.com
Cc:     rui.zhang@intel.com, edubezval@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org
References: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d2987e9f-5cbf-9622-c6b9-b8bc66b3a5a2@linaro.org>
Date:   Tue, 14 Aug 2018 08:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 15:40, zhong jiang wrote:
> Device node iterators will get the return node. Meawhile, It is
> also put the previous device node. An explicit put will cause
> a double put.

What about:

Subject: drivers/thermal/tegra: Fix a double free on the device node

"The function 'for_each_child_of_node' iterates over the node list by
dropping the of_node reference of the previous node.

Calling of_node_put() on the iterator is pointless and leads to an
inconsistent refcounting in addition to a double free. Remove it."

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
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

