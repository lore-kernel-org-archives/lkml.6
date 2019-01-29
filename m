Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43ECC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DA920844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOOP8wXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfA2Sv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:51:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50532 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfA2Sv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:51:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so19043848wmd.0;
        Tue, 29 Jan 2019 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gp5o5NSOBO9aWWIRTmIPAbiHwV6f8KBIJlmyAYTUOiM=;
        b=nOOP8wXSsoANDTNj8xzVAcyXf7ePbWV48wescVzh/mcqPJYbMXbGuDggXFXyPpTARz
         KM+uMcVtdE9xMYiFlJX8M54uayQP6EGKGVpHzHWyq/yAyFBWgwIkh+Fxyh2eqC0gt4TY
         nDXjzY6Zui0cVWpokS/LTm4j0GIL9R4rRkaWIrP5xX358lU/KJhqyWqn2yBgLZjkjHzI
         hFalApcPfXQPFwwWiCIvII/P/vcHaD1JG+3zslsQ/QGSpJBcAMMn5VCJPtRRcz7Mz78G
         xL8KYX+AugbLc2V/GLdesiwHj4CD83N2D1CzUlfHrx29HSNF4LmQbu2J0K0NoT40PRG6
         9Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gp5o5NSOBO9aWWIRTmIPAbiHwV6f8KBIJlmyAYTUOiM=;
        b=rS1YENbLB3KBDN5aK6LUmnSTNMhe/UX27tncd+2eeOSJHAjE8WMVfsU+TfujeRG2m+
         iQYxTLWBxkqYEIoQetvgTzDyeIFP4Esau2qxV/jopa2P05vHYoFjzDrNVIoSgGePljL9
         S7p3G+IUiktYANJNu7mdJ4gtEZQQuG9vfqvZxytfErLPMwm/MtRogGYdLxIRtp8yCCoR
         o4ccXteSd0wtnvyvWLr3oY8bnc1Wi60xzcJs02+CxIRllTWm1TwN/bjzH92Hw/GDbpW3
         DHbSf297hqyNozDcP0zZvtWvPw3xPRv955OddXaEHp2BKM//ep43G5gO1JcPrOkBbCia
         GjEA==
X-Gm-Message-State: AJcUukfBSig/hQ/TvrFPBr2gA2tGRdHuHHTcj1nbotO73FFp5BcZCezf
        6ZL1cU+NuWqy+CnmRp27NrWiKOCd
X-Google-Smtp-Source: ALg8bN7qMLPllFIpjPyAb9Q6tq2zV7zrHgVXDEc273eh9m9HvVdiP3VXzg99rPtpQxGV09rsdtD4qQ==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr23451645wmg.42.1548787885232;
        Tue, 29 Jan 2019 10:51:25 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:ec14:5b59:80e3:7bca? (p200300EA8BF1E200EC145B5980E37BCA.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:ec14:5b59:80e3:7bca])
        by smtp.googlemail.com with ESMTPSA id l20sm252801793wrb.93.2019.01.29.10.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:51:24 -0800 (PST)
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <59aa73fd-9cdc-8db8-b58e-ed106b084637@gmail.com>
 <20190129174035.GA25929@ulmo>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <043ec556-5859-c229-6324-c598d0210063@gmail.com>
Date:   Tue, 29 Jan 2019 19:51:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129174035.GA25929@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.2019 18:40, Thierry Reding wrote:
> On Fri, Jan 25, 2019 at 07:34:31PM +0100, Heiner Kallweit wrote:
>> On 25.01.2019 11:18, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> If the system was booted using a device tree and if the device tree
>>> contains a MAC address, use it instead of reading one from the EEPROM.
>>> This is useful in situations where the EEPROM isn't properly programmed
>>> or where the firmware wants to override the existing MAC address.
>>>
>> I rarely see DT-configured boards with RTL8168 network. Do you add this
>> patch because of a specific board?
>> And you state "if EEPROM isn't properly programmed": Did you come across
>> such a case?
> 
> We use these Realtek chips on some of our boards that customers can
> either purchase individually and integrate into their own designs or
> they can get the module as part of a product.
> 
> In order to easily allow customers to reprogram the device (they may
> want to do that if integrating the module into their own products), a
> so-called ID EEPROM is part of the module that stores various bits of
> information. The ethernet MAC address is part of that EEPROM.
> 
> Typically the ID EEPROM will contain a valid MAC address if the module
> is part of a product, but if customers purchase the module individually,
> it is expected that they use a MAC address from their own pool.
> 
> Typically early boot firmware will load the MAC address from the EEPROM
> and store it in the ethernet device's device tree node so that the MAC
> address programmed into the ID EEPROM will be used by the ethernet
> device at runtime.
> 
Thanks for the explanation.

>> In general the patch is fine with me, I just want to understand the
>> motivation. One further comment see inline.
>> As of today we already have the option to set a MAC from userspace
>> via ethtool.
>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>> Based on net-next.
>>>
>>>  drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
>>>  1 file changed, 22 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>>> index f574b6b557f9..fd9edd643ca5 100644
>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>> @@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>>>  	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
>>>  }
>>>  
>> [...]
>>> @@ -7252,20 +7268,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  	u64_stats_init(&tp->rx_stats.syncp);
>>>  	u64_stats_init(&tp->tx_stats.syncp);
>>>  
>>> -	/* Get MAC address */
>>> -	switch (tp->mac_version) {
>>> -		u8 mac_addr[ETH_ALEN] __aligned(4);
>>> -	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
>>> -	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
>>> -		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
>>> -		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
>>> +	/* get MAC address */
>>> +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
>>> +		rtl_read_mac_address(tp, mac_addr);
>>> +
>>> +	if (is_valid_ether_addr(mac_addr))
>>
>> Here array mac_addr may be uninitialized (if platform defines no MAC
>> and chip version is not covered by the switch statement).
> 
> Good point. I can memset() mac_addr to make sure it is invalid, rather
> than undefined, for chip versions that are not covered.
> 
An empty initializer would work as well.

> Thierry
> 
Heiner
