Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF11C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615CE20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+Pg1N6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615CE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeJ2TMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:12:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53301 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeJ2TMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:12:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id l26-v6so7604051wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=78/LbgHWSj19fwf6QFJ3yiqXolHVngkl8Abx0aGyBHE=;
        b=T+Pg1N6pitNSeyZKberM+TcNAnmorqu6Y288rmS2GilUqaVu6d7rOYsfU/VUZDCInn
         FoJnKpbTzSXaU1rq05rzQEhmvMSoynnrdYt7lYDd+kb5OumlvkCakX7PCIozDdPYI0or
         FW78cu0FX4bZOe+gauvJslO09fkfUdJX+GIgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78/LbgHWSj19fwf6QFJ3yiqXolHVngkl8Abx0aGyBHE=;
        b=K9+FmuL6/Fw53jv2AGWQ+RFtHn/0HKiNCccLmno7wguEjWoD3RueRY8y/o8Rah+1nw
         QsvmpTZnewDCvAa3c1plOUGdnGKymYJ7JXfIZdTtWPFpIYHiCFKuY15maE3nNFKFCrnS
         35roo+nzt0JPFLZi5Ya2NZ4+fG6HvhNaHDvuc5I8aCLBZqklAGFbj/bRbGipn3NK7Mn/
         qN5wQXcY6H3kkrP1BNREraHKeVzG19gQrLiudQeLl+ugUnsbIqJb1bQtyvd4vPQ+Qbtg
         etPpJVSNcv5BB9TvgMYM6AGhHDY8P6zwG8jJDsozm7hsJSEwa74Gc7TxVIYX7aYbEVRs
         iXqw==
X-Gm-Message-State: AGRZ1gLiWxfRGJAz96tTVCKs/l/YPZqSJPdhLxu7+r8h40K9jYXaK2uB
        J/UxstCBTlavWllHYUt0paxDo8Qg1Ns=
X-Google-Smtp-Source: AJdET5cn5IgG3HO0blT+5oU7jW4901bJMfYy3iUIMpOK0MMe0eAkrUpWIqfZ5QjYYC/yFb0lvrneEA==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr12932280wmd.90.1540808647718;
        Mon, 29 Oct 2018 03:24:07 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 64-v6sm26753027wrr.64.2018.10.29.03.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:24:06 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: qoriq: add multiple sensors support
To:     andy.tang@nxp.com, rui.zhang@intel.com
Cc:     edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181029093119.33971-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <27f5210f-d305-3d04-8fff-722623cb065c@linaro.org>
Date:   Mon, 29 Oct 2018 11:24:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029093119.33971-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2018 10:31, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> The QorIQ Layerscape SoC has several thermal sensors but the current
> driver only supports one.
> 
> Massage the code to be sensor oriented and allow the support for
> multiple sensors.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

With the fix below:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

[ ... ]

> +	ret = qoriq_tmu_register_tmu_zone(pdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register sensors\n");
> +		ret = -ENODEV;
> +		goto err_iomap;
>  	

	if (ret) {
		dev_err(&pdev->dev, "Failed to register sensors\n");
		goto err_iomap;
	}


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

