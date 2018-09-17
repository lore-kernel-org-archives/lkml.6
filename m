Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7108ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377C22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="TP07JMBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377C22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIQNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:55:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35605 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIQNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:55:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so12172706edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eoUdoZysojM2yk3fmMIPbpiRI3NgVmtb2C1RAtqSp/o=;
        b=TP07JMBgFYKNjAJffaJQq96q5Cjv4n23BkMhAstPbtUOQtMV4g88H7E1XfFlpjFK1N
         Q6OtKssXioIcorTBHuMMQOxi2E1ERPA7m5EiRdpL9MtFTDKyN/hstbAUxsHypmJtGHUV
         1rh4rFLZAAI1YizV5U5oHAxqZn1QUZNxRxuGH+tYWiqdRfPAc6iWvkIMe6zpGF2wNqla
         GLYRp03xl4nX6zg3JD47Wqp7ULoHoWF50uK6GOqH90je5MGui8RJoUeeH68U4YbAJ1M6
         16j0Ij83w0qB6Ew6M6TnQnoIiB2S35ndlJNVlJRrEf1wjdY4ULQjfUV+2W1VcoYQxkLB
         erOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eoUdoZysojM2yk3fmMIPbpiRI3NgVmtb2C1RAtqSp/o=;
        b=cGkbR7YhiMU/rXHyKEhW8D1psyJVt1WgwJz/cb+Vek6FGEwGDM115ajfwKWFj9IAFE
         Pj/v2jUZyMeFhgzItKRHrmOJt7swxLC/vtpUE72pBE8oTS0AG5bgYi5VarmdRCupmrp0
         RGhT13VbqjpY2Yhv/E3FOY0hD16ys0bxjCwn1tEXQaeGIF6g2k5tZzrTGVLhtvLfB6gR
         sYFrHiRf+fLk7qKX9Hw67ufZzE2mk1Ym7bf51dRLAZsbOJWqTRhrZvfo5kADw+7Qak81
         AkjvyEgIRdQQJSwBu7oORr5c7ONT3rkOwp3ABxsWGAXl7xgx9lzY/iZqZPOxZ1UWt1BF
         6v+Q==
X-Gm-Message-State: APzg51AjBPk4WQ+pxcvlNQ8ZnQ2OJ7m6hloIUKnac38ErqfPOUEtLlSz
        /PKkSGuxMSkPc8lpQ+VQQHp4tA==
X-Google-Smtp-Source: ANB0VdaV9dqbbjtVzidZ+wPWqku8HY/AhHQfMNmuw7lhTbJvuZ2e97yMqQ+6Z/lLbAx/J2EB/agtJg==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr38822857edm.106.1537172925443;
        Mon, 17 Sep 2018 01:28:45 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id 25-v6sm9804913edz.45.2018.09.17.01.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:28:44 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: add SPDX license tag
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1536667716-23004-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <bab74ec8-7a7d-8d4c-51f4-dd2b45c0365e@lightnvm.io>
Date:   Mon, 17 Sep 2018 10:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536667716-23004-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 02:08 PM, Javier González wrote:
> Add GLP-2.0 SPDX license tag to all pblk files
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-cache.c    | 1 +
>   drivers/lightnvm/pblk-core.c     | 1 +
>   drivers/lightnvm/pblk-gc.c       | 1 +
>   drivers/lightnvm/pblk-init.c     | 1 +
>   drivers/lightnvm/pblk-map.c      | 1 +
>   drivers/lightnvm/pblk-rb.c       | 1 +
>   drivers/lightnvm/pblk-read.c     | 1 +
>   drivers/lightnvm/pblk-recovery.c | 1 +
>   drivers/lightnvm/pblk-rl.c       | 1 +
>   drivers/lightnvm/pblk-sysfs.c    | 1 +
>   drivers/lightnvm/pblk-write.c    | 1 +
>   drivers/lightnvm/pblk.h          | 1 +
>   12 files changed, 12 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
> index 77d811962818..74b912ee3c05 100644
> --- a/drivers/lightnvm/pblk-cache.c
> +++ b/drivers/lightnvm/pblk-cache.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 80f0ec756672..a23e965d32fc 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index e05d06bd5b83..2fa118c8eb71 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 532ee0834dad..caed18fabd35 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2015 IT University of Copenhagen (rrpc.c)
>    * Copyright (C) 2016 CNEX Labs
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 070ed53eca07..2f7ce572b29e 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index a7648e12f54f..c26eab2ba8bd 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index aa345a4045aa..16294701a748 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 09015fd8e0f2..c562e1fad243 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index a32790f7b7fc..db55a1c89997 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index e56eeeeb914e..cba83ac43e62 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index a276f25d3931..277abc8633f7 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2016 CNEX Labs
>    * Initial release: Javier Gonzalez <javier@cnexlabs.com>
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 5e4cec453a43..127ee99c3efc 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (C) 2015 IT University of Copenhagen (rrpc.h)
>    * Copyright (C) 2016 CNEX Labs
> 

Applied for 4.20.
