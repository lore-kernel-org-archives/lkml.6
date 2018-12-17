Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5028420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBPC839q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeLQSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:43:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:43:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so13359330wrx.9;
        Mon, 17 Dec 2018 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oBNwkrMH8kwRKGH/6rRWOcDQm8QSaqta6El9c9xPFpc=;
        b=qBPC839q8xrNRZtxuLlyif8qScuckK1AW/jwnDqDk2lnv0D8yIYaxgqx1eT0UHx3O0
         BIAZgWMGNmGGe4n3FozwoV4ZN9cyC0D0jIZY3gab0gaylVD6H9MNe4yUBT0ePw6o8ufg
         LcI5tsJ/WSEgLrZT17eLfzfGblRiskN7+farA0Ul+GOjDc4f/uE4QZache8gvt4Kcxp1
         KYK/feT5Er79UhpfZ4uFZIttitGLDQPL9zP9y1OIBGFObEh+6osj3AWunDcuxKqYfCOa
         Ux8dkeeAFpvOrCa7JtKV6cPo1/Aa0flkcjbEH2R3nts2vnN9/Bk1GEvGCEFRaTXzYYl3
         SwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oBNwkrMH8kwRKGH/6rRWOcDQm8QSaqta6El9c9xPFpc=;
        b=flS8hn88+wPGf70lD1ybHYoT+aXJBPE8pKBb5FrSIO28JMxQ4O9jXdK9ULNi9TdEEI
         4py07UYKoqJ159zrpSJsMCkn7aZlm14kKjPnPtBxwlC4gbJhjvrz5F5CHUZZfSAUfgoC
         moREHPsxMNXvlGkCV+hyuEot9lFk4KKzILWn0ztgeEQrlOMmun4x2e9HstfyLJhsc1Cc
         I3wjawbpW5d5lHxBhgwE8y+hOQDdyvfHgMwCMrQijoHoSOQ+D9DuXSmtolzTjQldKJgU
         Zgl04UsnwDmTnS/ILU+ClYOZ+iQoRmR+yYaZG309kcfR96c4brU2NViQPCrpK2y6FK2e
         MCxA==
X-Gm-Message-State: AA+aEWZJe9B0nffcVakOj9KbEJruB0n3IZhrDY2aNyQpTmr8ccDX1A5e
        pBQdO2oyNjAyXUcDvTmGSJ2nknOl
X-Google-Smtp-Source: AFSGD/VPiqjo6DGbgGwF67786MmvowHrkGPUqwgfr6E/BYqtxWvW7OFzVRblc+copw4Dj07jYjpG0w==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr11276344wrv.161.1545072216874;
        Mon, 17 Dec 2018 10:43:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:9098:392c:b017:10bc? (p200300EA8BCFE3009098392CB01710BC.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:9098:392c:b017:10bc])
        by smtp.googlemail.com with ESMTPSA id b13sm1427439wrn.28.2018.12.17.10.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:43:36 -0800 (PST)
Subject: Re: [RFC PATCH net v3] net: phy: Fix the issue that netif always
 links up after resuming
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543825349-423-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20181217154102.34D9.4A936039@socionext.com>
 <bb910914-73e5-c040-08d5-5f16d259b105@gmail.com>
Message-ID: <a4bec1b7-1899-591a-c3b6-599e3730e2c1@gmail.com>
Date:   Mon, 17 Dec 2018 19:43:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <bb910914-73e5-c040-08d5-5f16d259b105@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 19:41, Heiner Kallweit wrote:
> On 17.12.2018 07:41, Kunihiko Hayashi wrote:
>> Hi,
>>
>> Gentle ping...
>> Are there any comments about changes since v2?
>>
>> v2: https://www.spinics.net/lists/netdev/msg536926.html
>>
>> Thank you,
>>
>> On Mon, 3 Dec 2018 17:22:29 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>
>>> Even though the link is down before entering hibernation,
>>> there is an issue that the network interface always links up after resuming
>>> from hibernation.
>>>
>>> The phydev->state is PHY_READY before enabling the network interface, so
>>> the link is down. After resuming from hibernation, the phydev->state is
>>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>>
>>> This patch adds a new convenient function to check whether the PHY is in
>>> a started state, and expects to solve the issue by changing phydev->state
>>> to PHY_UP and calling phy_start_machine() only when the PHY is started.
>>>
> This convenience function and the related change to phy_stop() are part of
> the following already and don't need to be part of your patch.
> https://patchwork.ozlabs.org/patch/1014171/
> 
>>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>
>>> Changes since v2:
>>>  - add mutex lock/unlock for changing phydev->state
>>>  - check whether the mutex is locked in phy_is_started()
>>>  
>>> Changes since v1:
>>>  - introduce a new helper function phy_is_started() and use it instead of
>>>    checking link status
>>>  - replace checking phydev->state with phy_is_started() in
>>>    phy_stop_machine()
>>>
>>> drivers/net/phy/phy.c        |  2 +-
>>>  drivers/net/phy/phy_device.c | 12 +++++++++---
>>>  include/linux/phy.h          | 13 +++++++++++++
>>>  3 files changed, 23 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>>> index 1d73ac3..f484d03 100644
>>> --- a/drivers/net/phy/phy.c
>>> +++ b/drivers/net/phy/phy.c
>>> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
>>>  	cancel_delayed_work_sync(&phydev->state_queue);
>>>  
>>>  	mutex_lock(&phydev->lock);
>>> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
>>> +	if (phy_is_started(phydev))
>>>  		phydev->state = PHY_UP;
> 
> I'm wondering whether we need to do this. If the PHY is attached,
> then mdio_bus_phy_suspend() calls phy_stop_machine() which does
> exactly the same. If the PHY is not attached, then we don't have
> to do anything. Therefore I think we just have to do the same as
> in mdio_bus_phy_resume():
> 
> if (phydev->attached_dev && phydev->adjust_link)
> 	phy_start_machine(phydev);
> 
> Can you test this?
> 
Sorry for the confusion, this comment is related to the next part
of your patch.

>>>  	mutex_unlock(&phydev->lock);
>>>  }
>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>>> index ab33d17..4897d24 100644
>>> --- a/drivers/net/phy/phy_device.c
>>> +++ b/drivers/net/phy/phy_device.c
>>> @@ -309,10 +309,16 @@ static int mdio_bus_phy_restore(struct device *dev)
>>>  		return ret;
>>>  
>>>  	/* The PHY needs to renegotiate. */
>>> -	phydev->link = 0;
>>> -	phydev->state = PHY_UP;
>>> +	mutex_lock(&phydev->lock);
>>> +	if (phy_is_started(phydev)) {
>>> +		phydev->state = PHY_UP;
>>> +		mutex_unlock(&phydev->lock);
>>> +		phydev->link = 0;
>>> +		phy_start_machine(phydev);
>>> +	} else {
>>> +		mutex_unlock(&phydev->lock);
>>> +	}
>>>  
>>> -	phy_start_machine(phydev);
>>>  
>>>  	return 0;
>>>  }
>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>> index 3ea87f7..dd21537 100644
>>> --- a/include/linux/phy.h
>>> +++ b/include/linux/phy.h
>>> @@ -898,6 +898,19 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>>>  }
>>>  
>>>  /**
>>> + * phy_is_started - Convenience function for testing whether a PHY is in
>>> + * a started state
>>> + * @phydev: the phy_device struct
>>> + *
>>> + * The caller must have taken the phy_device mutex lock.
>>> + */
>>> +static inline bool phy_is_started(struct phy_device *phydev)
>>> +{
>>> +	WARN_ON(!mutex_is_locked(&phydev->lock));
>>> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
>>> +}
>>> +
>>> +/**
>>>   * phy_write_mmd - Convenience function for writing a register
>>>   * on an MMD on a given PHY.
>>>   * @phydev: The phy_device struct
>>> -- 
>>> 2.7.4
>>
>> ---
>> Best Regards,
>> Kunihiko Hayashi
>>
>>
>>
> 

