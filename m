Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DADC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC8E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YM9GLDOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAVUMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:12:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46592 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfAVUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:12:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so11987386ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lzB1F40T0BECSjVk/G6PCWKauVkIgx1ZLhCXr/OL7Go=;
        b=YM9GLDOk+3AYhoaSB9s0WFl3KB6pVvIpBmK0SgWDzOq74gZvD4vwl+v3Vge+G6tkrZ
         5PVx9l7VeUChsX3+PHA6/HsBORkrDvQzlYuAORN7plXWU/NGLCECm2UcriIl6EOZN1xE
         bZi1XQ7llQNoqEwGEOMoZgrcGRJSEekD4ZRLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lzB1F40T0BECSjVk/G6PCWKauVkIgx1ZLhCXr/OL7Go=;
        b=JrgjEaj7g6WGfr1RabJ5ZfwLyQ/OxFJ19f2o5Fy5s4LrO68/q1exACHnD4/rEbe9Xf
         QwDNNbBKIRgElDR3oj1v1/WZjceb+NpcReE9j/7JIChG0GtNplerkz4sblDd4xKNYVkL
         Lc1ZJSPJGkM/1AUd+bLzcB4FwsoYB3/b/6bXKyYqyeXuA/A0x3273zCapYduRYNeyTg0
         sPZ913eA/1DiKD5w7AByh7OjhZkKFGtu6HFPnTqGI8Q+fcVRs/GRnVHJv9H2aTXgXPAp
         ygZfPCP7SE0EuL/jBurkTMjrIL7CkXTpScCjHkTzyvzFx31NY0+ayanlWBSpz1KTrXQB
         coMw==
X-Gm-Message-State: AJcUukdtpl01+b5SPH1OEwjUDiinN9BKFcXFIG1qVi4ZBpiRaDE8/BiM
        dYTrIuXMD2GPbx+UXIBKqCiCdQ==
X-Google-Smtp-Source: ALg8bN6QE0zUBhaoAiv7g5A3LcMyvBk8c5qEm/CIe09HjPpiLCzzM8dFu9PnpMkvv/heAgLgVRvkMQ==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr36296019plq.331.1548187971203;
        Tue, 22 Jan 2019 12:12:51 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l85sm26297518pfg.161.2019.01.22.12.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 12:12:50 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
 <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
 <20190121231105.GA928@bogus>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9b2dd73d-3a38-3a68-d37c-490811ed80ee@broadcom.com>
Date:   Tue, 22 Jan 2019 12:12:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121231105.GA928@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2019-01-21 3:11 p.m., Rob Herring wrote:
> On Tue, Jan 15, 2019 at 04:14:21PM -0800, Scott Branden wrote:
>> Hi Uwe,
>>
>> On 2019-01-12 7:05 a.m., Uwe Kleine-König wrote:
>>> Hello Scott,
>>>
>>> On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
>>>> On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
>>>>> On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
>>>>>> From: Praveen Kumar B <praveen.b@broadcom.com>
>>>>>>
>>>>>> Add new compatible string for new version of pwm-kona
>>>>>>
>>>>>> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
>>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>>>> index 8eae9fe..d37f697 100644
>>>>>> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>>>> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>>>>>>     This controller has 6 channels.
>>>>>>     Required Properties :
>>>>>> -- compatible: should contain "brcm,kona-pwm"
>>>>>> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
>>>>> Is v2 used on a newer generation of kona SoCs? On i.MX these variants
>>>>> are usually named after the first SoC that came with the new variant. Is
>>>>> this sensible here, too?
>>>> It doesn't make as much sense here as different revs of the IP block are
>>>> picked up based on various decisions.
>>>>
>>>> A new SoC could decide to use an old version.
>>> IMHO this is no reason to not use the name of the oldest SoC with this
>>> variant. I don't know how the SoC names are in the broadcom family, but
>>> if they were (in order of age, oldest first):
>>>
>>> 	ant
>>> 	bear
>>> 	crocodile
>>>
>>> and ant and crocodile use the same IP block we would have
>>>
>>> a) with v1, v2:
>>>
>>> 	ant:
>>> 		compatible = "brcm,kona-pwm-v1";
>>> 	bear:
>>> 		compatible = "brcm,kona-pwm-v2";
>>> 	crocodile:
>>> 		compatible = "brcm,kona-pwm-v1";
> Version numbers can be fine, but generally only as fallbacks as even the
> same IP version can be integrated into an SoC differently.
>
> The other issue with versions is they should be meanful such as
> corresponding to version tags in IP repos. Often, I'd guess anything
> with a 'v1' is just what some s/w person made up. Of course, we only
> can really know that for opensource IP or programmable logic IP.
>
> If you do use versions, document what the versioning scheme is.
>
>>> ; and
>>>
>>> b) with the SoC naming:
>>>
>>> 	ant:
>>> 		compatible = "brcm,kona-ant-pwm";
>>> 	bear:
>>> 		compatible = "brcm,kona-bear-pwm";
>>> 	crocodile:
>>> 		compatible = "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";
> This is the recommended practice.
>
>>> (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
>>> defensive.)
> Generally, you should have "brcm,kona-crocodile-pwm" in case there's
> some difference found later. Then you can support the bug or feature
> without a DT change.

No DT change would be necessary in any case.

A check against the SOC type in the driver without additional DT 
compatibility strings could be done.

>
>>> I like b) (with "...-crocodile-...") better than a). crocodile using
>>> "...-ant-..." is not more ugly than crocodile using "...-v1". This is
>>> also a tad more robust because if broadcom releases kona-dolphin and
>>> someone finds a minor difference between the IPs used on ant and
>>> crocodile it depends on the order of these events who gets v3, while
>>> with the SoC naming the result is clear.
>>>
>>> (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
>>> need slight adaption, but I guess you still get what I meant.)
>> Thanks for your thoughts and explanation.
>>
>> It is unfortunate devicetree has no proper guidelines or documentation on
>>
>> binding naming.  In the interest of getting this upstream we can name it
> Surely we've captured that somewhere...

Please point me at such documentation.

There is no consistency in kernel drivers from what I have seen.

>
>> "brcm, omega-pwm".  We can drop kona from the binding name as that
>> architecture
>>
>> is really no more - only IP derived from it is - hence the name kona-v2
>> previously.
>>
>>> Best regards
>>> Uwe
>>>
>>>
>> Cheers,
>> Scott
