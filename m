Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F26C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571502145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVJGbrQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571502145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbeLCHVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:21:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46975 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeLCHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:21:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so10915785wrt.13;
        Sun, 02 Dec 2018 23:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sn0cKQ7gIu3agA/rbDcwxLafxGaSuHBuqc0EO2rc7Mk=;
        b=OVJGbrQjUH2hF1jhrDhGeSuEumxUgOZhP+DPIZmy9/A2Nv6wFTnHlqEQ6aJXuyOtYW
         kbPwLMBLG9o6zY4Gy/NJFJkF9x+/2yXlSvLio0uAT8o6Sd3lRYS4nx0qUtoiBj/fnzcZ
         3pruV9fgKe3zQiEDPXkV1hcbNCz2DyVzGkJHlfwolmWCuLzIwGHGbm7Kw5Hj5e0d6LDG
         Ll27pW7LjdByPvs9ff6HxIsw4RaiDK1A1KAphypsXw3FKPwmr5v/S3rW2W22qJiuklu7
         klBDJiENGKpACjV/UaOe68RRnoMoCB6i7fl9jeWuadE7ie/Vm3FBjYrvwCLxZJ5Qt8BP
         Iu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sn0cKQ7gIu3agA/rbDcwxLafxGaSuHBuqc0EO2rc7Mk=;
        b=rLJl84hmi7xHZ67s/l4B9uMT923+MgQqgAobV1MuCtpucmlLgWDmYj8MuoX7etjk2i
         8NsyOVHafrYEowJjRDEGm5ER4LKleaCCYTipPE5KYiCrp4l0Qz2II3ssC6/9IGjVctag
         i/iDptGaE+CKaO1mTRQ77Kd0MQyNUz8nkAPEZBj48sVfw/U4DUK1ly8k1fnLGW+5KHIp
         VxRUveCEIG559cBYqlGWfr38Fy5vDyNmX/sCdIqgXh+dWvWI0SleDwkZ0+5l7d5R7D3C
         IiJO30E3hw55KIzchOjN6ff57xIid2fd+YaRqMSIYCntoFXrodLm5M1kdqQ0GB/zlqDV
         4V0A==
X-Gm-Message-State: AA+aEWYRS8ZlLpwB4xrrCRvRA4g2oqIH1zO1TNUIm4cbzV4LZG9WdUQC
        zPjg87sHG8Q8jv06QQnzGnsXQ9Tq
X-Google-Smtp-Source: AFSGD/W3f67DfUo8FnifmlWT50uhdWIKFRWgz1Y7vt+jLkjwZ5XiQIpu3ldmHQEq6At8dqy1y+s0RA==
X-Received: by 2002:adf:8068:: with SMTP id 95mr12913148wrk.181.1543821662930;
        Sun, 02 Dec 2018 23:21:02 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:9413:c003:3211:9f12? (p200300EA8BCFE3009413C00332119F12.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:9413:c003:3211:9f12])
        by smtp.googlemail.com with ESMTPSA id b16sm10400056wrm.41.2018.12.02.23.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 23:21:02 -0800 (PST)
Subject: Re: [RFC PATCH net v2] net: phy: Fix the issue that netif always
 links up after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <26e04d2e-16e5-ac0b-daab-931b8f5a0103@gmail.com>
 <47b5606c-564c-2fe8-0683-65288dafe028@gmail.com>
 <20181203133512.57D3.4A936039@socionext.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7b8b2a82-d997-9dcd-8e3e-39ed80293e57@gmail.com>
Date:   Mon, 3 Dec 2018 08:20:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203133512.57D3.4A936039@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2018 05:35, Kunihiko Hayashi wrote:
> Hi Florian Heiner,
> 
> On Fri, 30 Nov 2018 19:47:37 +0100 <hkallweit1@gmail.com> wrote:
> 
>> On 30.11.2018 18:46, Florian Fainelli wrote:
>>>
>>>
>>> On 11/30/2018 1:25 AM, Kunihiko Hayashi wrote:
>>>> Even though the link is down before entering hibernation,
>>>> there is an issue that the network interface always links up after resuming
>>>> from hibernation.
>>>>
>>>> The phydev->state is PHY_READY before enabling the network interface, so
>>>> the link is down. After resuming from hibernation, the phydev->state is
>>>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>>>
>>>> This patch adds a new convenient function to check whether the PHY is in
>>>> a started state, and expects to solve the issue by changing phydev->state
>>>> to PHY_UP and calling phy_start_machine() only when the PHY is started.
>>>>
>>>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>  drivers/net/phy/phy.c        |  2 +-
>>>>  drivers/net/phy/phy_device.c |  9 +++++----
>>>>  include/linux/phy.h          | 10 ++++++++++
>>>>  3 files changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>>>> index 1d73ac3..f484d03 100644
>>>> --- a/drivers/net/phy/phy.c
>>>> +++ b/drivers/net/phy/phy.c
>>>> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
>>>>  	cancel_delayed_work_sync(&phydev->state_queue);
>>>>  
>>>>  	mutex_lock(&phydev->lock);
>>>> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
>>>> +	if (phy_is_started(phydev))
>>>>  		phydev->state = PHY_UP;
>>>>  	mutex_unlock(&phydev->lock);
>>>>  }
>>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>>>> index ab33d17..2c39717 100644
>>>> --- a/drivers/net/phy/phy_device.c
>>>> +++ b/drivers/net/phy/phy_device.c
>>>> @@ -309,10 +309,11 @@ static int mdio_bus_phy_restore(struct device *dev)
>>>>  		return ret;
>>>>  
>>>>  	/* The PHY needs to renegotiate. */
>>>> -	phydev->link = 0;
>>>> -	phydev->state = PHY_UP;
>>>> -
>>>> -	phy_start_machine(phydev);
>>>> +	if (phy_is_started(phydev)) {
>>>> +		phydev->link = 0;
>>>> +		phydev->state = PHY_UP;
>>>> +		phy_start_machine(phydev);
>>>> +	}
>>>
>>> Don't you need some of these steps to be performed under phydev->lock
>>> being held? See comment below.
>>>
>> Yes, locking should be done. The old code sets phydev->state
>> w/o holding the lock, I'd says this was wrong.
> 
> Indeed. The phydev->state should be set with locking the mutex even here.
> 
> And it seems that setting phydev->link and calling phy_start_machine() don't
> need to hold the lock. Is it correct?
> 
Yes

>>>>  
>>>>  	return 0;
>>>>  }
>>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>>> index 3ea87f7..c194b45 100644
>>>> --- a/include/linux/phy.h
>>>> +++ b/include/linux/phy.h
>>>> @@ -898,6 +898,16 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>>>>  }
>>>>  
>>>>  /**
>>>> + * phy_is_started - Convenience function for testing whether a PHY is in
>>>> + * a started state
>>>> + * @phydev: the phy_device struct
>>>> + */
>>>> +static inline bool phy_is_started(struct phy_device *phydev)
>>>> +{
>>>
>>> An assert with the phydev->lock mutex being held here would greatly
>>> help, because otherwise this is possibly racy.
>>>
>> Have a look at __phy_resume() to see what is meant with this comment.
> 
> I see. I found that there was a lock detection in this function.
> The phy_is_started() should have the same detection, shouldn't it?
> 
Correct

> Thank you,
> 
>>>> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
>>>> +}
>>>> +
>>>> +/**
>>>>   * phy_write_mmd - Convenience function for writing a register
>>>>   * on an MMD on a given PHY.
>>>>   * @phydev: The phy_device struct
>>>>
>>>
> 
> ---
> Best Regards,
> Kunihiko Hayashi
> 
Heiner
> 
> 

