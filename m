Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F056C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZkyLmSmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeLTRqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:46:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33115 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388091AbeLTRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:46:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so1276249pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H35Ob/aDnvKZrMzq8WxiX3yR6eN+DYDMAAJ6bDGmWxY=;
        b=ZkyLmSmNaBciIxce9s+GKdrmy2V34xlFcqG8J7luAPRN4/T/WR2s/K3HymGOvNpkH1
         Lje4dAyQ8A/6YJymtn+oUNm5n62aINeFuKjU28D1ZTjQCBo9AVxaphqlRYAL/g6y6/wj
         WI3GqMWLCt3ZG/yKdrDVEkGpHD/P3qHEsoAK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H35Ob/aDnvKZrMzq8WxiX3yR6eN+DYDMAAJ6bDGmWxY=;
        b=c1qEUe2o1x5OhM20fEgjU4zmFi7mYtIydl05nLBKpHL3HjqM00zl/puHwOpbZtFTjW
         qvD8HauZ7m1XGqTmJOcUGLxvUIKlIr9Ye38sRgSGXaa8sg/M3/VJMl1Pef8Hm67XzDNB
         EFlE76itcYLdXfAMKstAKbnI/Tqq8gRVumvpXUD20vxJ4RgwQJFwltSy1XJjTlfHSdGa
         /q/5vzLzteSJS0rSYAfErQdqdm4qs8sd8tJieqylyBhlB1/rh5nrScfA88EZ8N1ZJRvP
         PuxUSqGvj2XRbkaGGrJXzUK4OjVdN/dU+FSd0TOedZ2BpBOn/pvkmjb+jn+aIxMC7e2Y
         3RGQ==
X-Gm-Message-State: AA+aEWa33KaNZPDO3CZdTwjb+p9NK5CC8/kKXxvayDgCeel9pQSO6x8z
        H4fYNGBS132Zbqtoob1y2LDeSQ==
X-Google-Smtp-Source: AFSGD/UMzUOYdkeM0AIPPXBaDyuh9gnLdGomot7L8EBGItC5plXvL56/GEJAvf75TKw9YyZgz9+X0w==
X-Received: by 2002:a63:5f50:: with SMTP id t77mr23979855pgb.76.1545328009708;
        Thu, 20 Dec 2018 09:46:49 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c67sm25988380pfg.170.2018.12.20.09.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:46:49 -0800 (PST)
Subject: Re: [PATCH v3 04/19] mailbox: bcm-flexrm: Use device-managed
 registration API
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
 <20181220172002.9016-5-thierry.reding@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e2fd0c99-1000-618a-a81f-bacfd74b2271@broadcom.com>
Date:   Thu, 20 Dec 2018 09:46:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220172002.9016-5-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine - thanks.

On 2018-12-20 9:19 a.m., Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
>
> Cc: Vikram Prakash <vikram.prakash@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/mailbox/bcm-flexrm-mailbox.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index d7a8ed7d8097..d713271ebf7c 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1665,7 +1665,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>   		mbox->controller.chans[index].con_priv = &mbox->rings[index];
>   
>   	/* Register mailbox controller */
> -	ret = mbox_controller_register(&mbox->controller);
> +	ret = devm_mbox_controller_register(dev, &mbox->controller);
>   	if (ret)
>   		goto fail_free_debugfs_root;
>   
> @@ -1691,8 +1691,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
>   
> -	mbox_controller_unregister(&mbox->controller);
> -
>   	debugfs_remove_recursive(mbox->root);
>   
>   	platform_msi_domain_free_irqs(dev);
