Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A94C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6070621848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyB0C6kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbeLQDx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:53:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeLQDx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:53:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so5451535plb.10;
        Sun, 16 Dec 2018 19:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J4dI8m1fcRNCW+YsdRAhm8+jl/emh7cCQEO63STjzV4=;
        b=AyB0C6kU22Th0cpI1I+7q/Xq5afW6Cx7tfdTsHS87d/2LxX4CyO6X4ScIqncMm7BJI
         9ps7jdgNDRqNqWWjRJ0ZGFPCnYC2ubphOEPgV/44+m4B++bQlly/XY95NB/ZlZNR+S+Q
         kn/98q4HRL35jyvCAR8DZkz5J5n8OXSKSdlnyW1hDBDGG1FcR+6h8opCsUuHaeK0gqei
         Zn/G9Io1T+0yXZp8qUtVFSdBVRBgcir1V2TXFo7RIr28MPtbcRRJ/JwuRzOfLjLm8x+t
         N+jAYKb8jUC9bQ2H0dqqNqoGvdOsZHKmCDvZxuR0zVO/HiZRNjmd58d5NDQT8wTqXw0C
         s3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4dI8m1fcRNCW+YsdRAhm8+jl/emh7cCQEO63STjzV4=;
        b=pP3KO8kj6wXk00QVn1m0vTS5vw9TurGJtPOPdnp51F1aeGqf0tw/0aFdhenNo/+PnA
         +c7K5VHYekGxXTMzieDaUMKrcc3ET4vyH5lNWN0lVFIa1aPXkehm0is365r2jByNDins
         fcsy1+5708krS5hO/vDYPEmRfmIQCevKcydSsFf76o2q11YwsKR4fU+79o6LA6+qIuNm
         su+auxNRtmZXdIiOTJ+3BV1UaadlngzmYJU0mLxzHZnuoqJF0LxQ68NbJNRNiP91UZAO
         AvEZ7YTC7xm0j+CScdZMDgkNFNnsbpWa4O/izL/iioP2s+kBZjka3m1R/Df79GsxHFxC
         V1+g==
X-Gm-Message-State: AA+aEWaONWVRDtIHyDSwqRu37Z/cTkWGIXg8w7mIHKJQZUMBSPb4ooTD
        z8gfZyXUo8om1/NMwD2Z3gA=
X-Google-Smtp-Source: AFSGD/UuZGALPRNDEqtcPHmN7IJrZYqMOU6w7AvNs7RwrBkfX3Ner4JoVyMOyR77un2cyc7zllP2iQ==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr11528032plr.237.1545018806362;
        Sun, 16 Dec 2018 19:53:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 89sm18256180pfl.120.2018.12.16.19.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 19:53:25 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-watchdog@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
 <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
 <1545017947.7782.1.camel@mtkswgap22>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
Date:   Sun, 16 Dec 2018 19:53:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545017947.7782.1.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/18 7:39 PM, Ryder Lee wrote:
> Hi Matthias,
> 
> On Sun, 2018-12-16 at 11:31 +0100, Matthias Brugger wrote:
>>
>> On 07/11/2018 08:10, Ryder Lee wrote:
>>> This updates dt-binding documentation for MT7629 SoC
>>>
>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> index 859dee1..8682d6a 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> @@ -8,6 +8,7 @@ Required properties:
>>>   	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>>>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>>>   	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
>>> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>>>   
>>>   - reg : Specifies base physical address and size of the registers.
>>>   
>>>
> 
> Could you take this through your tree?
> 

Why ? We usually take watchdog binding updates through the watchdog tree.

Guenter
