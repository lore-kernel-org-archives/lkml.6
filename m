Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBCC20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARGOINqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbeL1Qwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:52:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33537 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbeL1Qwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:52:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so14921926lfc.0;
        Fri, 28 Dec 2018 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyN2jjV4a3iL7JkpvCXZuC0MioWZXQV2d1wEZbmUNtM=;
        b=ARGOINqVhFyBRkNuOeOM/40D5YfV01mAujXnbgFjbPbw6rzjY5exq4IX8Q/ojmBiXJ
         n6K9s0sWUKRFb9JcG83SLbxAeJfFCpYAYeftZn1GmiqWnkZep50mHLEPUqpxS8D5POxM
         Ds/iVyD9cp09y6x8OG+THH92ReQT2AZexaaS9HxlSM86LBUTE7fSg57Mmg5wZc6/1lVd
         sprBTWboPxoUfOF63sbaTbCJi8qB1vIQ8DZBWTD+Nkz7ro/HOCzXaGaNj+SSPYog2oga
         rRCi52vw7MJKSEGY0ecm0ihYq67FznMVJ2KuXNgAhXpIMFMECCydeKLLaDetsopqohBn
         fTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyN2jjV4a3iL7JkpvCXZuC0MioWZXQV2d1wEZbmUNtM=;
        b=gAnEFXLRET+0LIcIX1fR7Vi7CcUOZTIXWDXaDoqCDkP1yH8My3GI0+cPxgObZseqNo
         lnxyvp0WO5+UNz8sHy6WXHb2TWR79g+IwKpqQTDwug1RkDviq73HDIxQ6RZ4FEwlsmYT
         Q0zdWKKe+jHquV1SQckXf0e3Bjc7V14upAaxT1ZHftoQzKvJNTOj3AqcK3eCGrzOIbEt
         QjtGBujNdaK3+qEgq124FuHrFNoQ+wrBcSUixfT3faSa/7xpRQPqh5tdfOePf1zgCPkl
         cSz2KmADB3bZaId5UcwEQyYg8/gNTIrhCkY3NYCVTD7Pt/IOprSxafw3oF54Z/FNJhmp
         +07w==
X-Gm-Message-State: AA+aEWbqZhl4QCXogPHGWjWoQVpvb+5iDa6ca6h7cM64p8YI13jwAIyR
        2Ls0FcBSkI8dgdwxZztJ5NNIHYN/
X-Google-Smtp-Source: AFSGD/VVePv2LE57H74If7NcgjBzQ3edRX4weiExEb2OIsZ8ESVvL6Vr0KmaSYRZlvkHEPP6Xi52bw==
X-Received: by 2002:a19:c115:: with SMTP id r21mr14310428lff.144.1546015952857;
        Fri, 28 Dec 2018 08:52:32 -0800 (PST)
Received: from [192.168.1.18] (dkv156.neoplus.adsl.tpnet.pl. [83.24.25.156])
        by smtp.gmail.com with ESMTPSA id d2sm8207572lfg.16.2018.12.28.08.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:52:32 -0800 (PST)
Subject: Re: [PATCH] leds: fix a missing check of return value of lp55xx_read
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181226041823.73950-1-kjlu@umn.edu>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <333a5518-ad9d-868c-a5b6-731e10c053ea@gmail.com>
Date:   Fri, 28 Dec 2018 17:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181226041823.73950-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On 12/26/18 5:18 AM, Kangjie Lu wrote:
> When lp55xx_read() fails, "status" is an uninitialized variable and thus
> may contain random value; using it leads to undefined behaviors.
> 
> The fix inserts a check for the return value of lp55xx_read: if it
> fails, returns with its error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/leds/leds-lp5523.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
> index a2e74feee2b2..fd64df5a57a5 100644
> --- a/drivers/leds/leds-lp5523.c
> +++ b/drivers/leds/leds-lp5523.c
> @@ -318,7 +318,9 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
>   
>   	/* Let the programs run for couple of ms and check the engine status */
>   	usleep_range(3000, 6000);
> -	lp55xx_read(chip, LP5523_REG_STATUS, &status);
> +	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
> +	if (ret)
> +		return ret;
>   	status &= LP5523_ENG_STATUS_MASK;
>   
>   	if (status != LP5523_ENG_STATUS_MASK) {
> 

Applied to fixes-for-4.21 branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
