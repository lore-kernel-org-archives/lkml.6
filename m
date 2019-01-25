Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE58218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxn4oxby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfAYSLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:11:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfAYSLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:11:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so11288145wrt.4;
        Fri, 25 Jan 2019 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LcZBTUaR/gu9w0ADLki+ban5xfy/RC6VcmLL6Dl34b8=;
        b=hxn4oxbyD9PYawSe53grMNLSgIJ4uF5Blcc3pnFIOqC0NxlKrperxpDxDGLV2pwEbJ
         rdHrkWaGwt/saPY+YkZGLz+203/vE2/LR5yMaVyiVhs3xcRAiGGWoKU1DFZ6h00wIaS6
         /KeHw1dfxNZwEW/6bSGHuGdQ99zgY3v8HBJCykW3dwfl9l6LtdJw2Oy9vII4Ifov2/lQ
         aJLdEw+Znb/mKmjnFDvEBzH65/X0O7HJhzhnJlM4hz9b+Reoofcqp0fO1rw89RtErtTd
         BP7lvh9zRUfrmiZz/MwDlsJPOoF8xZLobTha03EqkfFPeKerKEnbpfeY7QtwiDM8nXwd
         gAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LcZBTUaR/gu9w0ADLki+ban5xfy/RC6VcmLL6Dl34b8=;
        b=hhonosZ/22K4MGbeAfsv4e7I56x+Bw3s685TLZ/XZWMAmpY8Fn7+a/SXf2vxTqav3x
         orWAdwDCpFJNJzM0zoN8Lu2o8lKBSK9tEAHA9hVFCwdjkh7/mRaS6vVyl7hk9RuTBRM3
         3CI1urG5SwlG47kcL5qT43EM5w0fa0dh3XH4DSWgr3OP7Wldcv7LSx38OfxmHHxNq1c5
         s6TcG1R3MGbeJdD8vi28MGratQEPRy85zjsZyf+bYEsHm3UulzS/c3thQ3KVF/ETNbUD
         R4WzxXPLi+UVHW/t0fZCtEkWHgun7FKtGRoAp0idh5k4m88E4bl1kRW13uJlLIrMzM8a
         g3jw==
X-Gm-Message-State: AJcUuke7CjfyeT+Mo0z+0JrnjlwZbHqE7YCOatkp6S98w1e7nuEM5SnM
        bcJAl+VJn4saUGkrknIcs2UH40q7
X-Google-Smtp-Source: ALg8bN6JWGI7tw0iOkuFIkNmfYkgGDLUY1652ILhsOmNScEQd0HlwfTLdrqF8RO9BNGELiWsm+dAKA==
X-Received: by 2002:adf:afdc:: with SMTP id y28mr12186881wrd.275.1548439895190;
        Fri, 25 Jan 2019 10:11:35 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad? (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
        by smtp.googlemail.com with ESMTPSA id o15sm81251006wrp.12.2019.01.25.10.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:11:34 -0800 (PST)
Subject: Re: [PATCH] net: phy: at803x: Use helpers to access MMD PHY registers
To:     Andrew Lunn <andrew@lunn.ch>, Carlo Caione <ccaione@baylibre.com>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125123510.20511-1-ccaione@baylibre.com>
 <20190125150013.GG12962@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a7f5531b-902b-2849-02a5-a4ec8660e06d@gmail.com>
Date:   Fri, 25 Jan 2019 19:11:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125150013.GG12962@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2019 16:00, Andrew Lunn wrote:
> On Fri, Jan 25, 2019 at 12:35:10PM +0000, Carlo Caione wrote:
>> Libphy provides a standard set of helpers to access the MMD PHY
>> registers. Use those instead of relying on custom driver-specific
>> functions.
> 
> Hi Carlo
> 
> Maybe deja vu, but i thought a similar patch went by recently?
> 
Andrew, maybe you mean this one?

9b420eff9fcf ("net: phy: micrel: use phy_read_mmd and phy_write_mmd")

> Anyway,
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 
>>
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>> ---
>>  drivers/net/phy/at803x.c | 16 +++-------------
>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
>> index f9432d053a22..23ba76f8d950 100644
>> --- a/drivers/net/phy/at803x.c
>> +++ b/drivers/net/phy/at803x.c
>> @@ -39,9 +39,6 @@
>>  #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
>>  #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
>>  #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
>> -#define AT803X_MMD_ACCESS_CONTROL		0x0D
>> -#define AT803X_MMD_ACCESS_CONTROL_DATA		0x0E
>> -#define AT803X_FUNC_DATA			0x4003
>>  #define AT803X_REG_CHIP_CONFIG			0x1f
>>  #define AT803X_BT_BX_REG_SEL			0x8000
>>  
>> @@ -168,16 +165,9 @@ static int at803x_set_wol(struct phy_device *phydev,
>>  		if (!is_valid_ether_addr(mac))
>>  			return -EINVAL;
>>  
>> -		for (i = 0; i < 3; i++) {
>> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
>> -				  AT803X_DEVICE_ADDR);
>> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
>> -				  offsets[i]);
>> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
>> -				  AT803X_FUNC_DATA);
>> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
>> -				  mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
>> -		}
>> +		for (i = 0; i < 3; i++)
>> +			phy_write_mmd(phydev, AT803X_DEVICE_ADDR, offsets[i],
>> +				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
>>  
>>  		value = phy_read(phydev, AT803X_INTR_ENABLE);
>>  		value |= AT803X_INTR_ENABLE_WOL;
>> -- 
>> 2.19.1
>>
> .
> 

