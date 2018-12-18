Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A86C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7560214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBFRGP25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeLRGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:44:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:44:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so14618097wrt.13;
        Mon, 17 Dec 2018 22:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5u5+vBxgD9xlHeoHbKSPKD3Kjqv8tr1Txk+1XYLZEk=;
        b=BBFRGP25wKb4ziGNOEaa1u9bzCgo7zLo+7dToki/u5R3wdYWQf0xof23Z9b8uvsQyF
         ds8LQPyH87En9jT7EZKRwG/SCnRzr/51SD00HpI7PhGGALGh0j9aYAOILpR1bkY4POCD
         EvsDpW+Fo4HyFN3f5fHa526simA674t0lqATivZHcX0lxwEkFecxxfelVR+sRR6FCQcD
         06IjaewoTcMBvbwYOz6WoScHf8/OiysG8HO6fRSwrtH5xVsSkhYsweUp0lW0B/FBVs5R
         eQ+4Gu+BA1+JAzMubmXW8dczbLG8qWbG/FUDer3VL2AhtGIlq+xc/OghNTyrViewZyDy
         v9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5u5+vBxgD9xlHeoHbKSPKD3Kjqv8tr1Txk+1XYLZEk=;
        b=h8c3ie96O6rbGackXADdxoa4MXrJ7KiyYk8shuaAvK0D5FYuvFDNM4P5mBbE7szPoQ
         muCnw+E6DJZZWE7fEHWLRv4Bm5xu4wEpwMVJ1h+mDvmFkzLbkTAHauv3iQIt41Yw+sCG
         kAhAEQd5Pw99tWW+Fs03iJPdceZ/V58npIKWtItNCaxYKqT15nTj/q6eGuSPtRGmLRE3
         AyA3i0ITnRTC/QAoyf7Nrik16jdCsLs6jD4vLpuOSqyV+1QbcG8ShrAVJT68FDN0uRcw
         0y3DdyMtyKtChderL3Qqhb+GbKW24sjheZxWB1bejL0NsY2TuC+i7QIsycbcozm7g0dF
         4RhQ==
X-Gm-Message-State: AA+aEWamEGnuh2pY++UDbJXIVex+2J4pTm8JlT6+9lmaPJ2ESCZfK0Qo
        BiBjlnO6SX2Wr9eXtjPdVlCpNQqB
X-Google-Smtp-Source: AFSGD/W534s5IU7Bqw8vwueUFwHYVPr1wSp4dwmWUMqnTzHDzUjYqQlgaLRPMnqdMpHhNoI84I+4zQ==
X-Received: by 2002:adf:8421:: with SMTP id 30mr13840225wrf.153.1545115478920;
        Mon, 17 Dec 2018 22:44:38 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:7dc8:fdf9:8ce2:1e74? (p200300EA8BCFE3007DC8FDF98CE21E74.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:7dc8:fdf9:8ce2:1e74])
        by smtp.googlemail.com with ESMTPSA id f18sm1436934wrs.92.2018.12.17.22.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 22:44:38 -0800 (PST)
Subject: Re: [RFC PATCH net v3] net: phy: Fix the issue that netif always
 links up after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <bb910914-73e5-c040-08d5-5f16d259b105@gmail.com>
 <a4bec1b7-1899-591a-c3b6-599e3730e2c1@gmail.com>
 <20181218152507.F2C6.4A936039@socionext.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fcfb1597-e8f4-27c6-ae8c-646fd43c846d@gmail.com>
Date:   Tue, 18 Dec 2018 07:44:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218152507.F2C6.4A936039@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.2018 07:25, Kunihiko Hayashi wrote:
> Hi Heiner,
> 
> On Mon, 17 Dec 2018 19:43:31 +0100 <hkallweit1@gmail.com> wrote:
> 
>> On 17.12.2018 19:41, Heiner Kallweit wrote:
>>> On 17.12.2018 07:41, Kunihiko Hayashi wrote:
>>>> Hi,
>>>>
>>>> Gentle ping...
>>>> Are there any comments about changes since v2?
>>>>
>>>> v2: https://www.spinics.net/lists/netdev/msg536926.html
>>>>
>>>> Thank you,
>>>>
>>>> On Mon, 3 Dec 2018 17:22:29 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>>> Even though the link is down before entering hibernation,
>>>>> there is an issue that the network interface always links up after resuming
>>>>> from hibernation.
>>>>>
>>>>> The phydev->state is PHY_READY before enabling the network interface, so
>>>>> the link is down. After resuming from hibernation, the phydev->state is
>>>>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>>>>
>>>>> This patch adds a new convenient function to check whether the PHY is in
>>>>> a started state, and expects to solve the issue by changing phydev->state
>>>>> to PHY_UP and calling phy_start_machine() only when the PHY is started.
>>>>>
>>> This convenience function and the related change to phy_stop() are part of
>>> the following already and don't need to be part of your patch.
>>> https://patchwork.ozlabs.org/patch/1014171/
> 
> I see. I'll follow your patch when necessary.
> 
>>>>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>> ---
>>>>>
>>>>> Changes since v2:
>>>>>  - add mutex lock/unlock for changing phydev->state
>>>>>  - check whether the mutex is locked in phy_is_started()
>>>>>  
>>>>> Changes since v1:
>>>>>  - introduce a new helper function phy_is_started() and use it instead of
>>>>>    checking link status
>>>>>  - replace checking phydev->state with phy_is_started() in
>>>>>    phy_stop_machine()
>>>>>
>>>>> drivers/net/phy/phy.c        |  2 +-
>>>>>  drivers/net/phy/phy_device.c | 12 +++++++++---
>>>>>  include/linux/phy.h          | 13 +++++++++++++
>>>>>  3 files changed, 23 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>>>>> index 1d73ac3..f484d03 100644
>>>>> --- a/drivers/net/phy/phy.c
>>>>> +++ b/drivers/net/phy/phy.c
>>>>> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
>>>>>  	cancel_delayed_work_sync(&phydev->state_queue);
>>>>>  
>>>>>  	mutex_lock(&phydev->lock);
>>>>> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
>>>>> +	if (phy_is_started(phydev))
>>>>>  		phydev->state = PHY_UP;
>>>
>>> I'm wondering whether we need to do this. If the PHY is attached,
>>> then mdio_bus_phy_suspend() calls phy_stop_machine() which does
>>> exactly the same. If the PHY is not attached, then we don't have
>>> to do anything. Therefore I think we just have to do the same as
>>> in mdio_bus_phy_resume():
>>>
>>> if (phydev->attached_dev && phydev->adjust_link)
>>> 	phy_start_machine(phydev);
> 
> Agreed.
> 
> Although the original code changed phydev->state,
> it seems that it's only enough to
> - call phy_stop_machine() in mdio_bus_phy_suspend()
> - call phy_start_machine() in mdio_bus_phy_resume() and mdio_bus_phy_restore()
> if the PHY is attached.
> 
>>> Can you test this?
> 
> I tested your code instead of applying my entire patch, and I confirmed
> that the code solved the issue in my environment.
> 
> Do you make new patch instead of my patch?
> (and I can add Reported-by: for the issue and Tested-by:)
> 
Up to you. It's fine with me if you submit the patch, but I can also do it
and mention you in Reported-by and Tested-by. Just let me know.

> Thank you,
> 
> 
>>>
>> Sorry for the confusion, this comment is related to the next part
>> of your patch.
>>
>>>>>  	mutex_unlock(&phydev->lock);
>>>>>  }
>>>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>>>>> index ab33d17..4897d24 100644
>>>>> --- a/drivers/net/phy/phy_device.c
>>>>> +++ b/drivers/net/phy/phy_device.c
>>>>> @@ -309,10 +309,16 @@ static int mdio_bus_phy_restore(struct device *dev)
>>>>>  		return ret;
>>>>>  
>>>>>  	/* The PHY needs to renegotiate. */
>>>>> -	phydev->link = 0;
>>>>> -	phydev->state = PHY_UP;
>>>>> +	mutex_lock(&phydev->lock);
>>>>> +	if (phy_is_started(phydev)) {
>>>>> +		phydev->state = PHY_UP;
>>>>> +		mutex_unlock(&phydev->lock);
>>>>> +		phydev->link = 0;
>>>>> +		phy_start_machine(phydev);
>>>>> +	} else {
>>>>> +		mutex_unlock(&phydev->lock);
>>>>> +	}
>>>>>  
>>>>> -	phy_start_machine(phydev);
>>>>>  
>>>>>  	return 0;
>>>>>  }
>>>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>>>> index 3ea87f7..dd21537 100644
>>>>> --- a/include/linux/phy.h
>>>>> +++ b/include/linux/phy.h
>>>>> @@ -898,6 +898,19 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>>>>>  }
>>>>>  
>>>>>  /**
>>>>> + * phy_is_started - Convenience function for testing whether a PHY is in
>>>>> + * a started state
>>>>> + * @phydev: the phy_device struct
>>>>> + *
>>>>> + * The caller must have taken the phy_device mutex lock.
>>>>> + */
>>>>> +static inline bool phy_is_started(struct phy_device *phydev)
>>>>> +{
>>>>> +	WARN_ON(!mutex_is_locked(&phydev->lock));
>>>>> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>>   * phy_write_mmd - Convenience function for writing a register
>>>>>   * on an MMD on a given PHY.
>>>>>   * @phydev: The phy_device struct
>>>>> -- 
>>>>> 2.7.4
>>>>
>>>> ---
>>>> Best Regards,
>>>> Kunihiko Hayashi
>>>>
>>>>
>>>>
>>>
> 
> ---
> Best Regards,
> Kunihiko Hayashi
> 
> 
> 

