Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229E1218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoXHq943"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYS0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:26:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37729 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:26:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so7519882wmd.2;
        Fri, 25 Jan 2019 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZrT/JltL6GSuNbhhLYVb6Y5S+YKxBcyFoglMpnpIFks=;
        b=NoXHq943EK4k2Fh8pndCx6opV+BpypmUgsiLyVXQ87hwJGXa8B5Cg1LlnvsB5Dok4O
         cTee+2oULCn11WJLQyRHO1cmgKb22p+QEUt3ZxmlKzSObN5KjYk7b6uSHdLxigHZUuxY
         /uZsG5AWmByEtJeaRSoyg/vhOfYVaJidQO7mD10NXaVRvGL8ejjxcpZs3oUszLxrBnj9
         wYjZWlbM4kMCgNm03WQex/6Bm+H514X3ErpawetRXFKSmwuZtWTN4RJdqXA3HJ9Jd6q2
         YB68QUfyIcWP1lwlv0/7Uijd/aug6ybZUpoFaY1TvQ9lG1Tu+fzQsD84ZUvp/lvdzAU1
         bTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZrT/JltL6GSuNbhhLYVb6Y5S+YKxBcyFoglMpnpIFks=;
        b=LwPuOTZ4sYjhWeWoWFoT2Cgbe9Z7KfH89TqARKeonEE2ZFJRianSoqhiJQXuc7Z2xD
         CANi6Tp5dPzfZ5MjH+qLNlQS2reJVj4mYxNH1RoeJ8dClMvUDSFR6Qtt09hNob8omQ7O
         VDYwQNLZQ5mnfX/a1FKKJON3z5Hr3Dp+5ETMlBUtvAf2djDEzWME9JQ43rVhPhZe7VzG
         OZ0WNb38wX19+j9Xif7D5uhlOz5/97ItxrEENcfARlo4wNkLLPu9ZI8Bq1LMDgcpGuJv
         5shmEwwq+2HbZEZWD0QbCdaX8eS3TvlFj/lgyvLr78+0Yo89PTWyoOkdLpi9a7Jv2Trh
         ekmg==
X-Gm-Message-State: AJcUukfW4PMau7eRj3ikqnGxF0eKs7uLLS1WCDzVymWNMdKSxXLswMHW
        mjuJv+RIp1SWM74ango6tGABHh13
X-Google-Smtp-Source: ALg8bN6WnJHZDurizk2CYsuQUlYwHE3QLnA+9CrmwvM6xCPZ0ic0ORSiQF52JyssacUTAp3WSFoiCA==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr7540521wmj.129.1548440807573;
        Fri, 25 Jan 2019 10:26:47 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad? (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
        by smtp.googlemail.com with ESMTPSA id 125sm114789368wmm.26.2019.01.25.10.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:26:46 -0800 (PST)
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
To:     Andrew Lunn <andrew@lunn.ch>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <20190125145711.GF12962@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <42d32783-c433-b859-6ba4-f2864f034871@gmail.com>
Date:   Fri, 25 Jan 2019 19:26:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125145711.GF12962@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2019 15:57, Andrew Lunn wrote:
> On Fri, Jan 25, 2019 at 11:18:14AM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> If the system was booted using a device tree and if the device tree
>> contains a MAC address, use it instead of reading one from the EEPROM.
>> This is useful in situations where the EEPROM isn't properly programmed
>> or where the firmware wants to override the existing MAC address.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>> Based on net-next.
>>
>>  drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
>>  1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>> index f574b6b557f9..fd9edd643ca5 100644
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>>  	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
>>  }
>>  
>> +static void rtl_read_mac_address(struct rtl8169_private *tp,
>> +				 u8 mac_addr[ETH_ALEN])
>> +{
>> +	/* Get MAC address */
>> +	switch (tp->mac_version) {
>> +	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
>> +	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
>> +		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
>> +		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>>  DECLARE_RTL_COND(rtl_link_list_ready_cond)
>>  {
>>  	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
>> @@ -7148,6 +7163,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
>>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  {
>>  	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
>> +	u8 mac_addr[ETH_ALEN] __aligned(4);
> 
> Hi Thierry
> 
> Maybe now would be a good time to cleanup this __aligned(4), pointer
> aliasing, etc?
> 
Andrew, for my understanding: What do you think is wrong with the 
alignment requirement? It was introduced because we do a 32 bit access
to the start address of the array and want to avoid an unaligned access.

>> +	/* get MAC address */
>> +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
>> +		rtl_read_mac_address(tp, mac_addr);
>> +
> 
> Maybe that could be made more readable with:
> 
>       err = eth_platform_get_mac_address(&pdev->dev, mac_addr);
>       if (err)
>       	 	rtl_read_mac_address(tp, mac_addr);
> 
> Thanks
> 	Andrew
> .
> 

