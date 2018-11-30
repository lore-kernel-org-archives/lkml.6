Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92257C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAD120989
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur0jzCXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAD120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeK3Lp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:45:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36020 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeK3Lp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:45:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so1707105pgm.3;
        Thu, 29 Nov 2018 16:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9YnmMGtiQt7vV6PVLL0TqNIGcbSiI0xeXgdTKrUYKc=;
        b=ur0jzCXlsi3FYVjTMe9xKwolPG8/0FBHNQrCv0XUqtYbAMLN821zsRpCmAqez59/TA
         a0G6bYzeIYPIjqNoT5gvabqCMl/6zF1yTqgV7ViiY3UuTNG5DNWUm2QPAd+pNZlqdoCw
         K1nVM68Od15E1FWPxXtFx9emoCXuQCH2u9nzGED8z5nBw8ASjMlrAVn9F5pZKA48aoAK
         VhRDzFR0YoFJx5r9SHZbid0BpPOJDKpBugz65EHQqtGv4wuSNK77nkcgGXufBo6vyAF8
         Aug7QKS8NiyyhOKHxDATguq6yMh/0ODybZjC50GhYcUXe4u9RzXwOj2iBnC99q/WFtIj
         GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o9YnmMGtiQt7vV6PVLL0TqNIGcbSiI0xeXgdTKrUYKc=;
        b=A0e4ZM4vLZnPNBsfBuh+EL1iuzN1y9js/BxvNVlpsZt3/jyD+UQWChJ9uoDovtTxyY
         6iPVUAnxj6nuOTpahj7CrvfkZ/vQPhQIOF9Sihw3ipm0i01y1KdHZkmwD6AQoN6bAMwJ
         eNB2eDoedcumEzi8+x8ljPKOGVm7UEimpbrks+xD6euGEkK7ngb59100uLk9dzgGQabw
         zPwbEtzydtQw6Sc2sfyl+n+XuE7U3Ge/7AD5SEfn6Wa8BiIzIPQ9mdRFa0fLx5FX42MY
         SpsTI1Qeo2GMWHfqlorrkU/OqSQd5y4JqIpf6wY34PPgLaYhP81UoGzJzQwTkMB/fzhZ
         NH9w==
X-Gm-Message-State: AA+aEWZT2FC3fzpeVHz01PTDnzs4eZzwjUGNq97Kdbe2w/10lo3zpNxT
        +gXv3yhHxuaMldnh04atkMNcbCFH
X-Google-Smtp-Source: AFSGD/X4Ro7qcujobHiX9bZLcmK9cRk+cUGahY2tc+/dZslNNGmxKZFcK4QON2LCjAUKinOPxm4epw==
X-Received: by 2002:aa7:868f:: with SMTP id d15mr3476121pfo.225.1543538283628;
        Thu, 29 Nov 2018 16:38:03 -0800 (PST)
Received: from [172.16.162.148] ([4.14.189.5])
        by smtp.gmail.com with ESMTPSA id e65sm4598784pfc.74.2018.11.29.16.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 16:38:02 -0800 (PST)
Subject: Re: [RFC PATCH net] net: phy: fix the issue that netif always links
 up after resuming
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543479131-14097-1-git-send-email-hayashi.kunihiko@socionext.com>
 <0499fc01-fce3-26c7-8b42-64788b8bf47b@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <d32d2d7e-2c78-425a-4016-0aebbf0828ed@gmail.com>
Date:   Thu, 29 Nov 2018 16:37:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0499fc01-fce3-26c7-8b42-64788b8bf47b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2018 2:47 PM, Heiner Kallweit wrote:
> On 29.11.2018 09:12, Kunihiko Hayashi wrote:
>> Even though the link is down before entering hibernation,
>> there is an issue that the network interface always links up after resuming
>> from hibernation.
>>
>> The phydev->state is PHY_READY before enabling the network interface, so
>> the link is down. After resuming from hibernation, the phydev->state is
>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
>>
>> This patch expects to solve the issue by changing phydev->state to PHY_UP
>> only when the link is up.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>  drivers/net/phy/phy_device.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index ab33d17..d5bba0f 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -309,8 +309,10 @@ static int mdio_bus_phy_restore(struct device *dev)
>>  		return ret;
>>  
>>  	/* The PHY needs to renegotiate. */
>> -	phydev->link = 0;
>> -	phydev->state = PHY_UP;
>> +	if (phydev->link) {
>> +		phydev->link = 0;
>> +		phydev->state = PHY_UP;
>> +	}
>>  
> Thanks for reporting. I agree that it isn't right to unconditionally set
> PHY_UP, because we don't know whether the PHY was started before
> hibernation. However I don't think using phydev->link as criteria is
> right. Example would be: PHY was started before hibernation, but w/o link.
> In this case we want to set PHY_UP to start an aneg, because a cable may
> have been plugged in whilst system was sleeping.
> 
> So I think, similar to phy_stop_machine, we should use state >= UP and
> state != HALTED as criteria, and also phy_start_machine() would need to
> be called only if this criteria is met.
> 
> It may make sense to add a helper for checking whether PHY is in a
> started state (>=UP && !=HALTED), because we need this in more than
> one place.

Agreed, that would make sense.
-- 
Florian
