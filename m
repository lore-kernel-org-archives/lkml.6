Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2034ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A1A2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQS3n+aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGTBKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:10:49 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36561 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:10:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id a132-v6so5347604qkg.3;
        Thu, 19 Jul 2018 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3oVAMJUM5Zjf++w+a0YASj08fnYMlMrMdcQlU1D95NY=;
        b=gQS3n+aUlQuaXRBXgGarSRz1PkjVfBH3EpDvb0flwlapFrpVu9b7FooDv3e5cAtjkD
         OsTxxjCGC8yx6uC7I0QKQFeh2ndrnA8rL5PPpLIlEHptP0+HWu23ZFEFcdahkbcSG4go
         9EqJ6vG2JPqAWf1qKMuadWTjZKKyV+9hd/XyWGJJ5+CrbQCd02tvNRLF1RDt9A23avLS
         CCntpQ2xy3jYkkiO30F92lv5mYR26XETnGViwKqNFpCH6+IAQcPInXxSw1jCNmDqtkR4
         5XNgC2EgVnSosTjAZDK+g1xudu7rmPbwIHQ0TZDSjVoMOavUciwp65F+aevdOxP8UzGe
         fQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oVAMJUM5Zjf++w+a0YASj08fnYMlMrMdcQlU1D95NY=;
        b=OsaHzGnA97b9/jwwWp6z/pwAls61CqikGd74nNDi1JcgPvWrMPQSkgH7wVZFRRAO4V
         ucNn5qTdSBQnDpkwFc9xprk4TPOScu/hJp09C3vF3e7lGMbl2Mlqz+XISWSjvQ+CwyU/
         rRyt2Kn13HYe8zlG3/iYc5d9dW4MuE55oZULWb+9ve1kkT09yioU+R7yuwJk8yTTdc4U
         9zvvNihLpGEkjeTD1xeycBjHS6u1EISKfZijfejyd66wFIkMeQqsuo+ujrQmStjSIvGG
         Zi3usupuh8D1hSbJrtwcOwziM3Z1PAse6mbQn6jDqcbhnJlmzDJXQUVTEaIXbYL0XLUg
         TKwg==
X-Gm-Message-State: AOUpUlFVp9s9L9ijo4AVEwEUsJf0wqqP/gLgCDNCd7H6Ik9KfBxGcu2e
        afF7KoSCe/69t6nGfVOy15NEDdH4yhg=
X-Google-Smtp-Source: AAOMgpdC06JKN17lxLvmwox9p5wBo7PzNiR9IwiLBW6N7hcZP/4DJZSK0D81L7OMRcByUANSmESL3w==
X-Received: by 2002:a37:b682:: with SMTP id g124-v6mr1639754qkf.237.1532046313153;
        Thu, 19 Jul 2018 17:25:13 -0700 (PDT)
Received: from [10.0.2.15] (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [99.245.240.231])
        by smtp.gmail.com with ESMTPSA id j86-v6sm577442qkh.60.2018.07.19.17.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 17:25:12 -0700 (PDT)
Subject: Re: [PATCH] rapidio: remove redundant pointer md
To:     Colin King <colin.king@canonical.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org
References: <20180711082346.5223-1-colin.king@canonical.com>
From:   Alexandre Bounine <alex.bou9@gmail.com>
Message-ID: <801e392b-c5ba-2857-c0af-157c65171bfe@gmail.com>
Date:   Thu, 19 Jul 2018 20:25:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180711082346.5223-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>


On 2018-07-11 04:23 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer md is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'md' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index a8cb8d2f2abb..cbe467ff1aba 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1006,7 +1006,6 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
>   static int rio_mport_wait_for_async_dma(struct file *filp, void __user *arg)
>   {
>   	struct mport_cdev_priv *priv;
> -	struct mport_dev *md;
>   	struct rio_async_tx_wait w_param;
>   	struct mport_dma_req *req;
>   	dma_cookie_t cookie;
> @@ -1016,7 +1015,6 @@ static int rio_mport_wait_for_async_dma(struct file *filp, void __user *arg)
>   	int ret;
>   
>   	priv = (struct mport_cdev_priv *)filp->private_data;
> -	md = priv->md;
>   
>   	if (unlikely(copy_from_user(&w_param, arg, sizeof(w_param))))
>   		return -EFAULT;
> 
