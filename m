Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B291FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CBB20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEmomjx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CBB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLGSXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:23:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34456 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLGSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:23:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so4717433wrw.1;
        Fri, 07 Dec 2018 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qa24XH3EaFf+Nkn7ea3mzRDaMwsz1E7KXdY5DiZJAtA=;
        b=VEmomjx1zO45TAe9cagt63MnHPv8zwwCkaD0Su9r4yy6ms7PTQzOn7L4JWbxZuZo2l
         sVJspbTC7TjeOIS4R4j7T8CFxTMu6x77Dr4nmeRDH/9r9oBLG2CqzfYfj2Rwc1XjMTwf
         sRdSvlRaTvLlQ1hAl6VBHK955KD0ogO7mVEf8SnGiNpse3aTq915Vk705GGlLXcHs9l9
         nWej7KcETdOBNymQE9duqJ2QsdJlTwJ+o5LI1oc7iZILTTvoSYjx2obOAOmFTBXdlKLJ
         rOZL//6mX0ziCp9KTtTVncqEVaVLMAh4s5RbM4QP7eOd/7YdN6kdnMJflC5K4AoBvw+e
         E66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qa24XH3EaFf+Nkn7ea3mzRDaMwsz1E7KXdY5DiZJAtA=;
        b=sydUvssqS1O3bQnkawIgpz9HKDVMaJ+4BMYaDzoxCSKNNmcGIMGlImwE4DgxJEg305
         TEsEOCDLEbfpIlrw4Sa4sUI283vQa+CL94NyrhqxPTR+Ed8pDhjFx6jwjo0REsAwfgm0
         s1SGtVRg6JgMzR3qbbRhFDZtzE4qf4LEbAKNWVJBT2eTvVUQQwCFHiQGKaqNSclh40w9
         ZhMWHPBELiPZ4a4/jHWTojC9bGfHcZ80sMFV1+U6Aj7KB4WS8zCX/+ySE4cFIma1AcUa
         p6wK56F4bZpj6K2OS84hyEfmbtso38uA5d0HqLPqnJIPGXyanP84+V4RgamVmcgKntE3
         tSWw==
X-Gm-Message-State: AA+aEWYbuwQD4KbYWfSFKJxyng+7KNIR6oSlNkk3vCPf3zBHqlg7363k
        AYBaPgq7Ily1Dbi9EihO420=
X-Google-Smtp-Source: AFSGD/WdA70ZJc83fZr52qOZOB97STGiOwLkrKkqReZTJKUTz9wPs0C0vjo38IxURB8NUWoCCfu38Q==
X-Received: by 2002:adf:f449:: with SMTP id f9mr2771339wrp.40.1544207023377;
        Fri, 07 Dec 2018 10:23:43 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id l15sm4079689wrw.4.2018.12.07.10.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:23:42 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ef6446d0-8b7f-08b1-df99-799f75578474@gmail.com>
Date:   Fri, 7 Dec 2018 19:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 07:17 PM, Sergei Shtylyov wrote:
> Hello!
> 
>    I'd already started the v2 driver review before you posted v3, so here goes...
> 
> On 12/03/2018 12:18 PM, Mason Yang wrote:
> 
>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> [...]
>> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> new file mode 100644
>> index 0000000..ac9094e
>> --- /dev/null
>> +++ b/drivers/spi/spi-renesas-rpc.c
>> @@ -0,0 +1,808 @@
> [...]
>> +#define RPC_CMNCR		0x0000	/* R/W */
>> +#define RPC_CMNCR_MD		BIT(31)
>> +#define RPC_CMNCR_SFDE		BIT(24)
> 
>    This bit is undocumented as of the gen3 manual v1.0. I'd like this to be reflected
> in a comment...

FYI, not even in v1.50 .

-- 
Best regards,
Marek Vasut
