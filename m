Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC12081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofkheRAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CC12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeK3R2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:28:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43021 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeK3R2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:28:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so4096381wrs.10;
        Thu, 29 Nov 2018 22:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FXq4hS5QzlV6Jcq+Z0iWOb59RcV1ZR0G+ypEUQ7hOmY=;
        b=ofkheRAzWmJiO5mga9DMiKQVLN98J+L/2syOr0/YehGwK2Crcb3avHab5i4Kw+eAJU
         YN+4McxY6xjFqAO3i+9gsLNwd6HLoGSfFoNI0dhumO79MB9M9eJ2fIzXV4MdP5toR1i/
         dKm9o3l5IJYpI19ix6fvJrl2rM0mhN8gsZ6Lk2R+s5Osfv20WQi2k1nrAX+h6GSmtXl+
         IMj/Ig8dEYZefle8XB+s+qpZe9b0VSVaT9XJW7JVjVzhkUY5Pf9AsRcRCOHwTrdDs0v2
         4V++WevsXUXoJGnEqQLsabYpRHeGJCqdvgFJsE60nSjk9eTxWSDE3cA4vQqZPJa1dwHo
         Qjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXq4hS5QzlV6Jcq+Z0iWOb59RcV1ZR0G+ypEUQ7hOmY=;
        b=MVREAzyK11oyx0pU+aODEOYJAbXHhz2W3hRJfYNrw1OjSwlOcrwPgqF4d09tEJIsmP
         vXTtRDaE4o46LxH4rmqtiy+K+tktR7HRb/ePIIFHglBNVA/xxKAYq9HtuU/pXM/0F86l
         TVnRlCxpIfKbyJvoAFmsH9YlqyjiermP7wzXzH5BQy7lj2N4qkdRe/MgOV53ft77bfd6
         ymEfdHU882lKnsJ5xM/FOA0ExHSYuUe5SQbkJve8Iocttsq/bAGG6/NFB0DmbBPqhK1b
         wjrZCbDSAsCd6VAvrLYDuZ51sjnsKEKCHg7YHBOEQUIgerqO6Pi+UPH/WuRq/QcBN6u4
         g30Q==
X-Gm-Message-State: AA+aEWZ3mbAE3aYxOOLA363/mWHIvvgGHMy3TEObg5cjettv60kRXBqs
        EzMvlhlBAPdFWd61GzmknLGF6LCI
X-Google-Smtp-Source: AFSGD/VPcYTdP9U3ckZsrOk6Sj5P5aTR1T+GOGTR19SQXezDB6eikiXgcq43wb9sPXZ6rXOv7m3lFw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr4041750wrn.109.1543558835467;
        Thu, 29 Nov 2018 22:20:35 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:9a2:5ffe:7427:6680? (p200300EA8BCFE30009A25FFE74276680.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:9a2:5ffe:7427:6680])
        by smtp.googlemail.com with ESMTPSA id t131sm1385035wmt.1.2018.11.29.22.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:20:34 -0800 (PST)
Subject: Re: [RFC PATCH net] net: phy: fix the issue that netif always links
 up after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0499fc01-fce3-26c7-8b42-64788b8bf47b@gmail.com>
 <d32d2d7e-2c78-425a-4016-0aebbf0828ed@gmail.com>
 <20181130133738.813D.4A936039@socionext.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <325a028e-ce95-1055-1b59-ed6120eeb229@gmail.com>
Date:   Fri, 30 Nov 2018 07:20:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130133738.813D.4A936039@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 05:37, Kunihiko Hayashi wrote:
> Hi Heiner Florian,
> 
> Thank you for your comments.
> 
> On Thu, 29 Nov 2018 16:37:48 -0800 <f.fainelli@gmail.com> wrote:
> 
>>
>>
>> On 11/29/2018 2:47 PM, Heiner Kallweit wrote:
>>> On 29.11.2018 09:12, Kunihiko Hayashi wrote:
>>>> Even though the link is down before entering hibernation,
>>>> there is an issue that the network interface always links up after resuming
>>>> from hibernation.
>>>>
>>>> The phydev->state is PHY_READY before enabling the network interface, so
>>>> the link is down. After resuming from hibernation, the phydev->state is
>>>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>>>
>>>> This patch expects to solve the issue by changing phydev->state to PHY_UP
>>>> only when the link is up.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>  drivers/net/phy/phy_device.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>>>> index ab33d17..d5bba0f 100644
>>>> --- a/drivers/net/phy/phy_device.c
>>>> +++ b/drivers/net/phy/phy_device.c
>>>> @@ -309,8 +309,10 @@ static int mdio_bus_phy_restore(struct device *dev)
>>>>  		return ret;
>>>>  
>>>>  	/* The PHY needs to renegotiate. */
>>>> -	phydev->link = 0;
>>>> -	phydev->state = PHY_UP;
>>>> +	if (phydev->link) {
>>>> +		phydev->link = 0;
>>>> +		phydev->state = PHY_UP;
>>>> +	}
>>>>  
>>> Thanks for reporting. I agree that it isn't right to unconditionally set
>>> PHY_UP, because we don't know whether the PHY was started before
>>> hibernation. However I don't think using phydev->link as criteria is
>>> right. Example would be: PHY was started before hibernation, but w/o link.
>>> In this case we want to set PHY_UP to start an aneg, because a cable may
>>> have been plugged in whilst system was sleeping.
> 
> Indeed. I didn't consider the case that the PHY was started but a cable was
> unplugged before hibernation.
> 
>>> So I think, similar to phy_stop_machine, we should use state >= UP and
>>> state != HALTED as criteria, and also phy_start_machine() would need to
>>> be called only if this criteria is met.
>>>
>>> It may make sense to add a helper for checking whether PHY is in a
>>> started state (>=UP && !=HALTED), because we need this in more than
>>> one place.
>>
>> Agreed, that would make sense.
> 
> I agree, too.
> I'll try this in v2 patch that changes the PHY state to PHY_UP and calls
> phy_start_machine(), only when the PHY was started before hibernation.
> If I understand correctly, it will be like that:
> 
> 	phydev->link = 0;
Even this may go into the if clause. If PHY isn't started then
phydev->link should be 0 anyway.

> 	if (phy_is_started(phydev)) {
> 		phydev->state = PHY_UP;
> 		phy_start_machine(phydev);
> 	}
> 
Yes, this is what was meant. Thanks.

> Thank you,
> 
> ---
> Best Regards,
> Kunihiko Hayashi
> 
> 
> 

