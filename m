Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A480C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0295B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TJfjIkH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfAKV2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:28:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40627 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAKV2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:28:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id i6so2782719ybo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PW+iFYKiZXJTOX93yIrYnuspfcNtG9ovkhcDVYkM07w=;
        b=TJfjIkH8TO3Qk/oz9gnIatmU8kPP/dYNSE8g6nonTzrgxX8fkbQ+jPI+niDmjYDrXe
         dmGr9VE0FzgOkHkEKbM5G3srY/JC1PuUQ1GNLlW6NvWZNCGiJ+BD3vtSfO1JwYC1cS+4
         V/x7zmxDGJH7im4xAM8VSxIzabErqi9+yvUMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PW+iFYKiZXJTOX93yIrYnuspfcNtG9ovkhcDVYkM07w=;
        b=odaGPFzKV5yX62MmF7PvjriFrV/DkhIwJMrGLzdEzcf3EFYNxdWU38yi5Aw1qLEXQN
         TauUoonP2STXkqZNOeiMWheyvi0Nx0N25/w6JtRkS7d856xYjInZo9+S6dbUd27UTfvx
         BwMPsadGeY3IuQeobeAPFaGOFF/2EALEsu0cR40c14wGhxqHn3rNwBIHdCw74ZRjToww
         gyo0R0uGY5vHKXjgrr8UvWJ6+Mq/qXsv9C850Pavdfd1WJgyDWBeqHVj59/4cp2vpGxF
         SGvBODEyespI9jShLzcUC6qS3wTId/daPJKTBiQF8Fl6ytzBH/iwZd2wzqBGuD6LHgZO
         pKZA==
X-Gm-Message-State: AJcUukeMbuJfAd3I7zsA/8bxyJk4i3NAs/edUO3Z8o4IHETW36f2JmMA
        XPRkXT6vC7ys91XUl4MtQiCt9DUVPOCx2zy9
X-Google-Smtp-Source: ALg8bN6iQIhBjir5hLQlVAfbqJ7QYklFND9ZiZB4pJlTYGzS5alwjTXx+lmKirBAk8vFXD4vvT5wFA==
X-Received: by 2002:a25:ad28:: with SMTP id y40mr8794374ybi.338.1547242130687;
        Fri, 11 Jan 2019 13:28:50 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m126sm28904083ywd.39.2019.01.11.13.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 13:28:49 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
Date:   Fri, 11 Jan 2019 13:28:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe

On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
> On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
>> From: Praveen Kumar B <praveen.b@broadcom.com>
>>
>> Add new compatible string for new version of pwm-kona
>>
>> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>> index 8eae9fe..d37f697 100644
>> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>>   This controller has 6 channels.
>>   
>>   Required Properties :
>> -- compatible: should contain "brcm,kona-pwm"
>> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
> Is v2 used on a newer generation of kona SoCs? On i.MX these variants
> are usually named after the first SoC that came with the new variant. Is
> this sensible here, too?

It doesn't make as much sense here as different revs of the IP block are 
picked up based on various decisions.

A new SoC could decide to use an old version.

>
> Best regards
> Uwe
>
