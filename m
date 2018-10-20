Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CCC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B23F21534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="defTfOWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B23F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJUACp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:02:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeJUACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:02:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id i4-v6so1668559wrr.13;
        Sat, 20 Oct 2018 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDWf/YK3a5fNwa8sjUoNTG/STScEUW/gOMZ8cBb03QY=;
        b=defTfOWDZTJIe6rmJ8p9JP5DpFVToFbTIfFE1sYxfNu0gKfHFdH5jFhNW9KIc65Wyo
         +5uAE7HiznjD4Li1zXg7TAAgjX1gOu5lhaATUgNzZlVERuArxWvYOgcX0izRkGeTT+0c
         CbUm7d8yKplP2mh9l0LDRwofVZguh6z++cSlPGVFo+yQxOJhsUBtTWAVh5SePfF949s3
         ZXo4YB1vqUGGRoDm967y8xF6RU9FMlJuesk2A+ROolj8SknbRb/30h0LzAlP7eHs5T1Z
         m03t4ItB2B/s91wX3qGI7r6K+4tu2myFc/5bgepssPSEJbcS53osj/iv/h0tEmmr8e80
         LWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDWf/YK3a5fNwa8sjUoNTG/STScEUW/gOMZ8cBb03QY=;
        b=jIRnL3crLYK66CB47dI93AOGDzwt9Qwp6AyYpFX0XmfHMVKVIyg+FOsfKcM3bGBmLU
         f/hmmB1gTkV6zOX+MyON4za5/9M/xPP/vds92VvY0mNTCTKm7NNHoIAn1dUc7uD3bzuE
         ajdju/YLGVceeiriqLTaxCM0V4inhGtHa/+IH5jKOgwGA7yF5phVwEsSrQS8lnkZ8BY3
         VtFW5nOl/XSDRYATqvvMU5EGLPzFvVaXGDVJcBlV/z+rfgL4eYM1Awr31ICHdiUXPzmd
         +1me6xTgBlKxtHqiKJrtQ+WHXQA9ulcR3x8oyUdGduf7W1HSdGGhylFvHTwobNXUOEvR
         Ddnw==
X-Gm-Message-State: ABuFfogxf8ovDSqV8gMLoNU/czNVpwUvesDBnsNA6qRN3RK8Y3Z9yGMf
        /zL9Eh4nrGwM/YSbGBKP6FDoX3K8+pU=
X-Google-Smtp-Source: ACcGV62k0uyedoHd+8nYbSELGzklZZADUQNGl2vXaDZNyQt/IwLnLTTjOj2eN3lO/r9N5Mpm3sGIOA==
X-Received: by 2002:adf:b6a0:: with SMTP id j32-v6mr35868968wre.55.1540050709683;
        Sat, 20 Oct 2018 08:51:49 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:c570:5259:d176:b6d7? (p200300EA8BD43F00C5705259D176B6D7.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:c570:5259:d176:b6d7])
        by smtp.googlemail.com with ESMTPSA id e196-v6sm14236198wmf.43.2018.10.20.08.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 08:51:49 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>, davem@davemloft.net,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com> <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com> <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com> <20181018195909.GA11317@Red>
 <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
 <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
 <20181020153922.GC1596@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c8f4f203-b2b6-81ba-2c79-85501a640948@gmail.com>
Date:   Sat, 20 Oct 2018 17:51:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020153922.GC1596@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.2018 17:39, Andrew Lunn wrote:
>>>> I have patched by adding:
>>>> phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
>>
>> Instead of programmatically removing the feature bit it should be
>> possible to do this in the PHY driver configuration. See also
>> this part of phy_probe().
>>
>> 	if (phydrv->features & (SUPPORTED_Pause | SUPPORTED_Asym_Pause)) {
>> 		phydev->supported &= ~(SUPPORTED_Pause | SUPPORTED_Asym_Pause);
>> 		phydev->supported |= phydrv->features &
>> 				     (SUPPORTED_Pause | SUPPORTED_Asym_Pause);
>> 	} else {
>> 		phydev->supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
>> 	}
> 
> Sorry for the late reply. Been on vacation.
> 
> I need to check the datasheet, but it seems like the KSZ9021 does not
> support asym pause. Using the above code is the correct way to solve
> this problem. Look at the bcm63xx.c:bcm63xx_config_init() which does
> this.
> 
I dare to dispute here ;) Above code snippet from phy_probe() will
(try to) set also SUPPORTED_Asym_Pause, because phydrv->features
doesn't include any of the two pause flags.
The statement in bcm63xx_config_init you refer to seems to be a
no-op to me therefore.

I'd say the correct way is to change the PHY config like this:
.features	= PHY_BASIC_FEATURES | SUPPORTED_Pause;
It's exactly the use case the code snippet above covers.

I think the bcm63xx driver would need to be changed.

> I will cook up a patch.
> 
>   Andrew
> 

