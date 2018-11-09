Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE27C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FEC20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfMpjB2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FEC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKJGif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:38:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJGie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:38:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so3218137wre.12;
        Fri, 09 Nov 2018 12:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjiC47mu09Tm8wmDlfD2pLaxgXCXHtrPln6GXxW3maA=;
        b=cfMpjB2YyDbvUGgoAZkBYpz9GyklSpB898Xs9sLoUVellQ07ZWcaKbcECUNjAP9aPq
         lYJWAgo4ZbSV+SvuTnu5K4roBjwH4X9KKWsLS6vATOSzT/7WvKZ4gFrI2GFB7clJMZt3
         g4X0KZ8uCkOA5JPRQsKopsQQ8Zab0gVe0NwFmcZckyPiqAPnQZshANW6KdH7qN2sGE73
         fF4uAceKw6LaIJw1z1GeDtOtj7G+wTxPl03gRxRR1p4NXp4tXwM4LJLAd433jv6KQVqr
         vtLgucW7/EHXa4wij69t4Pz3hYaVOl6GuZ0G+ZpqTFbjH7pCvCdLEDFkqtEWqn2iBbli
         5xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjiC47mu09Tm8wmDlfD2pLaxgXCXHtrPln6GXxW3maA=;
        b=tsD7FaT+9pjXj69/HVrMNReyBxxLNDgkBGldpiSbsPHbBlVkx/Xez/QJYcL4VfHUbN
         jJjee4vzEKwD4Q8JIjb6ujWsOGhxRNGuCZ6VMpLet0z1L3TfUpnccK+luBiw9EdMG+v1
         MYeBWJTN2kYOGHxM9U/G7UGgd+B5coSoO/YqwuGlhwUyDBBKhjIy/j/GGGzOIyEQd7JS
         8ne7WKKcNk8IEFVfayKyC3EWrBnP8TZOWN/xS0Pfnjg8eC9+NnODC69d3UqqlrG92pwd
         72YbZGEkElH77QEGdLMn2acu8f2GNw0E8hwefdJ26oWYeyvuE/Sy6+r64hiXh4WE6wiI
         /4Qw==
X-Gm-Message-State: AGRZ1gIaxE9+fwH/tIl0YyMUGIGy2dgicJPUGL0vIBxUeVOB8/PwOc60
        L1X5h9Uzo5IxQSd08US5JIM=
X-Google-Smtp-Source: AJdET5flKoCdzsOFhXvFzwcudpuvteHEF5vwrzNXHZoAy4YH4jD82AxjZDUIVBtDOXjOgpOqoBFQMA==
X-Received: by 2002:adf:ff4e:: with SMTP id u14-v6mr9433490wrs.232.1541796975953;
        Fri, 09 Nov 2018 12:56:15 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:28f6:f26:503:ad45? (p200300EA8BCFE30028F60F260503AD45.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:28f6:f26:503:ad45])
        by smtp.googlemail.com with ESMTPSA id x8-v6sm18117320wrd.54.2018.11.09.12.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:56:15 -0800 (PST)
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
 <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
Date:   Fri, 9 Nov 2018 21:56:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2018 21:33, Florian Fainelli wrote:
> On 11/9/18 12:22 PM, Heiner Kallweit wrote:
>> On 09.11.2018 21:13, Andrew Lunn wrote:
>>> Hi Heiner
>>>
>>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>>>> +{
>>>> +	return phydrv->config_intr || phydrv->ack_interrupt;
>>>> +}
>>>
>>> Should this be && not || ? I thought both needed to be provided for
>>> interrupts to work. 
>>>
>>> 	   Andrew
>>>
>> I've seen at least one driver which configures interrupts in
>> config_init and doesn't define a config_intr callback
>> (ack_interrupt callback is there)
> 
> That driver should probably be fixed, while it most likely does not make
> any significant difference during probe/connect, since config_init() and
> config_intr() are virtually happening at the same time, this is not
> necessarily true when disconnecting from the PHY where we really want
> config_intr() to effectively disable the interrupts and not leaving
> something enabled that would now become unmaskable, because no more
> driver attached.
> 
Found the driver: It's the IP101A/G in icplus.c
It should be easy to fix the behavior and move the interrupt config
to a config_intr callback. But the last real changes to the driver
have been done 6 years ago, so I'm not sure there's anybody out
there who can test.

>> Intention of this check is not to ensure that the driver defines
>> everything to make interrupts work. All it states:
>> If at least one of the irq-related callbacks is defined, then
>> we interpret this as indicator that the PHY supports interrupts.
> 
> I agree with Andrew here, that this should be an AND here, both
> callbacks must be implemented for interrupts to work correctly.
> 

