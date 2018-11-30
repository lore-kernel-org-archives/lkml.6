Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E466C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNpbs8U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E466C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeLAF6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:58:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55042 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:58:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id z18so6838545wmc.4;
        Fri, 30 Nov 2018 10:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rF4Pfy5RoNbnkTsERaQReBugwZFvzeB3IKiFlH+BmbY=;
        b=uNpbs8U5nmURax26mtGpqkB2snhCGDWGreTuD6Sq0B8eJ/h9ihaT0ueabRpWi9QU+f
         c7wgQq0i4xh+YvOI2i20ygO3pU5OC5ZWzNPAiCMunOxgZB4N5Hk2fAnOm2LRGGcbOuA2
         nHUPYq1I3Q/pTR0uk66vqJLGpICnjb2CPJ/Sk5uJqvW3tcFjni9NC6AdgrSMcINFoJak
         uNwmU7W5/cDYS1uHvUx+SfYSIn0qyolBgAoC3mnusOw38C9Nt4YyqT8gIF2G5Vd6sKxn
         VOLLytVN4zmvFfAnbbLP5L0CuFvSNULL31NE+GiIIwWtNz6WmbfJjLpo568izJszHiuq
         Lpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rF4Pfy5RoNbnkTsERaQReBugwZFvzeB3IKiFlH+BmbY=;
        b=UE9y3mg99a+N6IBw4uu4S9wZzdnJ953mgWSat3NpCUDlsoFnCakdh4WckbICNIlRua
         v0llMK0oDqIhOFn4GIi/Z7UX2YEkR9z/kcMoUdB29ANyQuKCu9rjbzN9J+9qraimwgHf
         rHwMaStN4hlwyTi9qa2J2H2ItEX0EOT8Gi4Df/SzgQf0cvDsniXVbScuP7o4lRMjhdOk
         71sSs2yl8t5bRTB1BwxJK8RD8guzFkS37XVgWjP0w4duW/P81tmy1EvDZPdqo03UxdAi
         O5Olq75hJlJlvr6V7E21A1x+YuvWBVd3pBVX4XDMI5lmYGwT5bIN9S6FBHFGu9zs8qnb
         g+QQ==
X-Gm-Message-State: AA+aEWZDnxzbvffdXsPlRDrNv0XzvTXyrbYZDGsUsM1D4Ey1JtBndGM7
        lHNTffffPLdOCxfrvBJfkASincp8
X-Google-Smtp-Source: AFSGD/Wc+UrgbBjzdu3WhUc41BCAQo8slYcI/LaD/Umotni0MqSivI5wwkEQD8CnLkU9dZI6BEbXeQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6601313wmi.61.1543603667660;
        Fri, 30 Nov 2018 10:47:47 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:3105:e649:62ed:321? (p200300EA8BCFE3003105E64962ED0321.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:3105:e649:62ed:321])
        by smtp.googlemail.com with ESMTPSA id y34sm12828227wrd.68.2018.11.30.10.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:47:47 -0800 (PST)
Subject: Re: [RFC PATCH net v2] net: phy: Fix the issue that netif always
 links up after resuming
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543569916-8714-1-git-send-email-hayashi.kunihiko@socionext.com>
 <26e04d2e-16e5-ac0b-daab-931b8f5a0103@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <47b5606c-564c-2fe8-0683-65288dafe028@gmail.com>
Date:   Fri, 30 Nov 2018 19:47:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <26e04d2e-16e5-ac0b-daab-931b8f5a0103@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 18:46, Florian Fainelli wrote:
> 
> 
> On 11/30/2018 1:25 AM, Kunihiko Hayashi wrote:
>> Even though the link is down before entering hibernation,
>> there is an issue that the network interface always links up after resuming
>> from hibernation.
>>
>> The phydev->state is PHY_READY before enabling the network interface, so
>> the link is down. After resuming from hibernation, the phydev->state is
>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>
>> This patch adds a new convenient function to check whether the PHY is in
>> a started state, and expects to solve the issue by changing phydev->state
>> to PHY_UP and calling phy_start_machine() only when the PHY is started.
>>
>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>  drivers/net/phy/phy.c        |  2 +-
>>  drivers/net/phy/phy_device.c |  9 +++++----
>>  include/linux/phy.h          | 10 ++++++++++
>>  3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index 1d73ac3..f484d03 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
>>  	cancel_delayed_work_sync(&phydev->state_queue);
>>  
>>  	mutex_lock(&phydev->lock);
>> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
>> +	if (phy_is_started(phydev))
>>  		phydev->state = PHY_UP;
>>  	mutex_unlock(&phydev->lock);
>>  }
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index ab33d17..2c39717 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -309,10 +309,11 @@ static int mdio_bus_phy_restore(struct device *dev)
>>  		return ret;
>>  
>>  	/* The PHY needs to renegotiate. */
>> -	phydev->link = 0;
>> -	phydev->state = PHY_UP;
>> -
>> -	phy_start_machine(phydev);
>> +	if (phy_is_started(phydev)) {
>> +		phydev->link = 0;
>> +		phydev->state = PHY_UP;
>> +		phy_start_machine(phydev);
>> +	}
> 
> Don't you need some of these steps to be performed under phydev->lock
> being held? See comment below.
> 
Yes, locking should be done. The old code sets phydev->state
w/o holding the lock, I'd says this was wrong.

>>  
>>  	return 0;
>>  }
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index 3ea87f7..c194b45 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -898,6 +898,16 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>>  }
>>  
>>  /**
>> + * phy_is_started - Convenience function for testing whether a PHY is in
>> + * a started state
>> + * @phydev: the phy_device struct
>> + */
>> +static inline bool phy_is_started(struct phy_device *phydev)
>> +{
> 
> An assert with the phydev->lock mutex being held here would greatly
> help, because otherwise this is possibly racy.
> 
Have a look at __phy_resume() to see what is meant with this comment.

>> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
>> +}
>> +
>> +/**
>>   * phy_write_mmd - Convenience function for writing a register
>>   * on an MMD on a given PHY.
>>   * @phydev: The phy_device struct
>>
> 

