Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BFC20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjC4u3gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfAPSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:06:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44601 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfAPSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:06:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so3360735plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6K39/QLGsaxRZ05/uOSjLCq/5EeuHt4nUThhnw2J9PM=;
        b=UjC4u3gJvHmJ8Nm6G4D2Mncd9VrNDtydzcTRD/MLw16xOenz0Y1lg19c1ZkEnuwXoG
         pAUQdrHEeTzAG3+xOXM53AGGgV0lJ3STh/CJu3PxNQUYu0HN17oHsIJ8et2JJVMp/rPp
         dkqxEm8AZkTL0G+Us9AfP1jxRiW7bOc/QTuuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6K39/QLGsaxRZ05/uOSjLCq/5EeuHt4nUThhnw2J9PM=;
        b=aI6KmcDPec/Ad8kIHd4T6kPFBqzeXciFiYvObUU0MuphJcKpHzGHd5ULBRM9Wmhbau
         c9CY9ywvnWZNzRIyxXjKxuEesZKEnqSTQJV4uR+b5YxOvbXF55WbU8YRioAGApQl+dxF
         4xa4O6cXvE+bOQvwQlj2VEhWpBQ3l9JAqn0hWB4hr1jdI8AYSSIJ/wOlV26Q9t3QrS3K
         2bIcuUAf/NjRdbxshrJ5/iSw0wvECTzITElc70atDVmFET6gPCtpeu+3zePD9oblamHb
         r6l5vEkvpeDVy6s7GcpwwTZZ3b25Lm0qyw2EeUmiOtaQbYFT8innv6BBU30aMrLpVNze
         9VZg==
X-Gm-Message-State: AJcUukfWtMXHesWJRmkAlaA8XbgBQB9qfHGkfuOmKaSUy/wMfMDt3Rab
        njDwkZ8WPHC1xkVDSxO7KQFPwcKa0MHEDixr
X-Google-Smtp-Source: ALg8bN4ZCT4p2HOk1lg+UmpMu5Fwovrgm8xmlayH0mdHa31bk3nQqLRZSmow33lepw0hz4hTm0mlUw==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr11254413plb.55.1547661992181;
        Wed, 16 Jan 2019 10:06:32 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d68sm9467672pfa.64.2019.01.16.10.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:06:31 -0800 (PST)
Subject: Re: [PATCH -next] soc: bcm: bcm2835-pm: Make local symbol static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <50481a6e-53de-96ef-11c9-421568d7b7e5@broadcom.com>
Date:   Wed, 16 Jan 2019 10:06:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

On 2019-01-15 9:44 p.m., Wei Yongjun wrote:
> Fixes the following sparse warning:
>
> drivers/soc/bcm/bcm2835-power.c:556:32: warning:
>   symbol 'bcm2835_reset_ops' was not declared. Should it be static?
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/soc/bcm/bcm2835-power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> index 4841295..9351349 100644
> --- a/drivers/soc/bcm/bcm2835-power.c
> +++ b/drivers/soc/bcm/bcm2835-power.c
> @@ -553,7 +553,7 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
>   	}
>   }
>   
> -const struct reset_control_ops bcm2835_reset_ops = {
> +static const struct reset_control_ops bcm2835_reset_ops = {
>   	.reset = bcm2835_reset_reset,
>   	.status = bcm2835_reset_status,
>   };
>
>
>
