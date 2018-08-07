Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA66C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872F321A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqVb8Tql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872F321A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHGEkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:40:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40005 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeHGEku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:40:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so7072607pgp.7;
        Mon, 06 Aug 2018 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k/ev//CVAmqkuhZatnnXrQrbXQckHgxDmUhlEQzUcNE=;
        b=TqVb8TqlDUHURudDcjI0qWECNoCcVCIbtUnN0Xn9SNDA1X8JfgcD5nqjmaRusTLa3Q
         iFtBGI2sTvbHc0sHaw3kR8oa6t/Yg+rIbJq+Jyhy/t8f2OyevHTM0OktSduDr6jPaoYD
         ro/SgRpMiakNu3hTJUMhyaxLLIg6dm7ib6jfWmz0IkIXUImDPNHv/xbtK6qO/KX4Kjve
         ivhC83WIu1C/OVQCuVXpabP15XIndZxl4zJRsk05j4br25QbHNZZ5WyuBFGP08sFQ/lD
         MhAQtKNTxqv2beKN/kaYhyLLeP1HfX9efRK9nKtneVLVYWnPmWgpgj4Lt7UTFxxybxQ0
         haug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/ev//CVAmqkuhZatnnXrQrbXQckHgxDmUhlEQzUcNE=;
        b=Zjwe28YT4JVFuu9mjwZdR4RCrGl1FBVnHibSzg1pjdqIW4tTNzSxoV3aqrrrvgP6ER
         O4LKaNEuLUQlqTS+eEwZV811Cz7zzD8hFYCeArXzqHCNevOpcOFoOPhnAo4u5AXCR14Q
         QPVuRIDHvjpKvkMSCMl1cQRQHq8jw7Quiq7xQzt0+X578J8c+tpbWK9I2m4Ulw+Kd2mn
         hi1qkuMpYgyj2S2Q3/jiP6xBF9X+7e7yoyJ1Iz3r99Nhp1IwoJEQMHGBjplcL82Hh0TE
         qIjYv/SiF1C6q7dRQHeyLGeazQgbr0B0xCOyFP/M4K09n/rLBcAc1B/gFa6083mKvq+j
         nE2g==
X-Gm-Message-State: AOUpUlEEigZgshTSYKhd7SNgnW9cyDzyZMfhFta+uUES+9oLg3pHVBB/
        IECFcCXNrzLK7J6+kX3z82dzKjqR
X-Google-Smtp-Source: AAOMgpeJUXC7U6s029bxVcQyo5ADIa/tGUgwIcyX2+wi+7VI1Hkie8KMOyCfpB8ZDbXFL/1gmjMSGA==
X-Received: by 2002:a63:5b0d:: with SMTP id p13-v6mr17008595pgb.202.1533608929046;
        Mon, 06 Aug 2018 19:28:49 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k64-v6sm105684pfg.141.2018.08.06.19.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 19:28:48 -0700 (PDT)
Subject: Re: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
To:     Jerry.Hoemann@hpe.com
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
 <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
 <20180806231901.GA32467@anatevka.americas.hpqcorp.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d1a220f1-e7ca-c4f5-9a2b-cbd622da536c@roeck-us.net>
Date:   Mon, 6 Aug 2018 19:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806231901.GA32467@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 04:19 PM, Jerry Hoemann wrote:
> On Sat, Aug 04, 2018 at 06:13:20PM -0700, Guenter Roeck wrote:
>> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
>>> Print module parameters when the driver is loaded.
>>>
>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>> ---
>>>    drivers/watchdog/hpwdt.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
>>> index 8a85ddd..f098371 100644
>>> --- a/drivers/watchdog/hpwdt.c
>>> +++ b/drivers/watchdog/hpwdt.c
>>> @@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
>>>    	}
>>>    	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
>>> -			", timer margin: %d seconds (nowayout=%d).\n",
>>> -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
>>> +		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
>>> +		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
>>> +		pretimeout ? "on" : "off");
>> When touching that, you might as well address
>>
>> WARNING: quoted string split across lines
> 
> 
> k. Think I'll split into two dev_info calls as line is too long
> to fit into 80 chars w/o splitting.
> 
> 
>>
>> Why did you add a space before ':' ? Personal preference ?
> 
> I think you're referring to "timeout : %d seconds".  Bad editting when
> going from "timer margin:" to "timeout :".  I'll fix.
> 

Yes, that is what I referred to.

> If you referring to the spaces around the ternary operator, that is
> in coding-style although checkpatch accepts w/o spaces around the
> operators.
> 
Nope, those spaces are desirable.

Guenter
