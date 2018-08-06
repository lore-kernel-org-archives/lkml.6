Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB807C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E198208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRcYakCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E198208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbeHGCKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:10:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39382 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeHGCKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:10:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so16121824wmq.4;
        Mon, 06 Aug 2018 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B3rsPEdb5Hpz4RchKdgBtO0OTELLFpI8qp1QdKfH8Dw=;
        b=FRcYakCZOCTxAiVLjQCJFPRelCVxXLSPLpsmMYTxphb6hBg8xvkfzTe1CMeuzzC5cW
         DOZzZIbUblIOw0ZDZQNX3TeFar72UzZWoZnlfN3vwXfFquUCK6EKJIQPDhvSXEohmHLu
         sZQoqF4wnE7AlfFhbG19SSfOxJ7gN3lVw5pZTlv/A9dHODcRS7SpQ9DsxsEDdsaDzdgU
         OLcXa/l7mao+OIwBXf0tNbLrWzJJUzUvhbn4etPZjprpSpBhjMYw7wmiAO26m6eUSvik
         P4k4p2ipK86ThqaaXsxeSSqjw0kyYQIj65evkf9gFLQ33IpGHjpaH3aRPeOvN9RxHfkt
         OyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3rsPEdb5Hpz4RchKdgBtO0OTELLFpI8qp1QdKfH8Dw=;
        b=RVy9CJKzABvfSrLPLehWXuM8q6Q4VJOsJolmPM8NOPpNylSD9NP8H5gFpVuMQpMdVA
         OHzY93MHwIgTC/59nRGVYVZ5529HoaNXjXov6pejaTeIlNPEBma6gbtPN3e7BFj8+dMm
         o++H0cJGVFYK0mefF3LiOkt9idDPJlWUrBnVIn1Q0BmJAL91rxFYRnvflPKhj0ze9eab
         yTq63sdV2Kb4naSmojcAJiyU550eKHJZsd/JN1frI+2MOa3C6biQc7q0LJgYd7nWf4um
         1UkX5RIfsFL6FPFR1m+1+KNrnpEWrn/9Aop4y7Qga3kbCnb3I/PKUlP3SlQIB9Nzqa2e
         q/XQ==
X-Gm-Message-State: AOUpUlEaW3yMCEpSIR/iNYHJ20LZoqHOfR9slZ42XZJK2E9Uz7r+vaor
        E2cWPxv3Wqvy2d06TQJVt9easRuY
X-Google-Smtp-Source: AA+uWPzo4XeaebpwWb9rz0taaAF88ICfCDWEX9oogiu+iygdO7R4NemgFrpqRoTUdoAH6fFn1ITCsA==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr115833wmf.17.1533599912335;
        Mon, 06 Aug 2018 16:58:32 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id i205-v6sm115325wmf.30.2018.08.06.16.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 16:58:31 -0700 (PDT)
Subject: Re: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign
 mtd->dev.parent, not mtd->owner
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-2-jmkrzyszt@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
Date:   Tue, 7 Aug 2018 01:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180806222918.12644-2-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> Fix missing mtd->dev.parent assignment and drop useless mtd->owner.

You fail to explain why this fix is required.

> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 2a8872ebd14a..af313c620264 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -162,7 +162,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	}
>  
>  	ams_delta_mtd = nand_to_mtd(this);
> -	ams_delta_mtd->owner = THIS_MODULE;
> +	ams_delta_mtd->dev.parent = &pdev->dev;
>  
>  	/*
>  	 * Don't try to request the memory region from here,
> 


-- 
Best regards,
Marek Vasut
