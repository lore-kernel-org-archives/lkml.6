Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2281ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AB5214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm67i6W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AB5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQW7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:59:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:59:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id y2-v6so10592069wma.1;
        Mon, 17 Sep 2018 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ObEr3kmEupLXm+oUJq9cFfW0pzjMidfMtP4N4ng4slQ=;
        b=bm67i6W8xksA7g4SsZsWL6BsN3ylJ5JX8CdA+ifBtVtVgbNyuF+o/JQDIa/8EstZH7
         RK7o1Q/EMe2oEtwBrYpYRPSb+eWORE6en8hUvtKtToWXpI4rjVvYL524y1D0Td69uQiO
         /2x2NGgvSEqinCjIJktnwOgWCDijhhIJQt2WSh411uaOYng5Sp5mSv3dfB3ZzJLW3fUJ
         dZ9QytmVo/FP7vh36XMT+E36G78Oo8sPW2MlJHl5fjoUNOCEcQueV/v8/Gs8mm1x8S5J
         8CwAbRc/FI809lHkzmzrHHGgSGBPFB7y4iccQsNQTqlN/xkIIAkvjNoMCseId/mYBl1A
         OrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ObEr3kmEupLXm+oUJq9cFfW0pzjMidfMtP4N4ng4slQ=;
        b=tEX6ED4LTbbILX2gl9xnBbVTmc9N8v7u5FTeiVfaFddYYqRrKhhv073pNo473VyXa9
         RkIMOKZA/COuDZ7tsE45PZEWoM4uXEUuWpjHBlwUPWQ7MdaZw3duI0e9PIzcoP8Zwtc5
         9cgP/TgqeQ1MDvGc3ZU9grrkB9w8IxgoEua5U22sYwdS642ps6cGmt6MK0HMK7tz0AWD
         K/OCIsZXzSsMY/X2xFk0GU6Dgutwed6UmgnuVarx/9L49o4xYRx5O9t1v+tuqZc9CtxM
         krxeuz0QuXZWdE7L/FRNi7mO/lDW2Q/XzEa1q7NsGj4HMY+sv9WnZUmrYrK4woyFA2NU
         F7mQ==
X-Gm-Message-State: APzg51CZ9K9K/1CuS6HVj9cPqU4KwTluGTGQoN42f2qfHOfMxKgQMRUI
        0jbRLXAtjrp1kZ9umZhbvRkTzD8C
X-Google-Smtp-Source: ANB0VdawnHQjZbgDh5io/xPIjA3Fq13V5LKHx1ULhXR2e1I0Rbha3myj+L2nVDH46CTC9F06u52bIw==
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr12003222wme.122.1537205461124;
        Mon, 17 Sep 2018 10:31:01 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v1-v6sm12310260wrt.34.2018.09.17.10.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 10:31:00 -0700 (PDT)
Subject: Re: [PATCH net] net: phy: sfp: Prevent NULL deference of socket_ops
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20180914230132.23228-1-f.fainelli@gmail.com>
 <20180915073228.GE30658@n2100.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <3abb0233-4234-ca8c-31ac-8a6b9e123064@gmail.com>
Date:   Mon, 17 Sep 2018 10:30:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915073228.GE30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/2018 12:32 AM, Russell King - ARM Linux wrote:
> On Fri, Sep 14, 2018 at 04:01:31PM -0700, Florian Fainelli wrote:
>> In case we have specified a SFP and an I2C phandle in the Device Tree,
>> but we somehow failed to look up the I2C adapter (e.g: the driver is not
>> enabled), we will leave dangling socket_ops, and the sfp_bus will still
>> have been registered. We can then observe NULL pointer dereferences
>> while doing ethtool -m:
>>
>> [   20.218613] Unable to handle kernel NULL pointer dereference at virtual address 00000008
>> [   20.226977] pgd = (ptrval)
>> [   20.229785] [00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
>> [   20.236274] Internal error: Oops: 17 [#1] SMP ARM
>> [   20.241122] Modules linked in:
>> [   20.244278] CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
>> [   20.251013] Hardware name: Broadcom Northstar Plus SoC
>> [   20.256316] PC is at sfp_get_module_info+0x8/0x10
>> [   20.261172] LR is at dev_ethtool+0x218c/0x2afc
>>
>> Specifically guard against that.
> 
> The other alternative to this would be to only set ndev->sfp_bus when
> the bus moves to registered state, which would probably be a saner
> alternative than to add an additional layer of tests.  IOW:

Indeed, your patch works for me:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

> 
>  drivers/net/phy/sfp-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 48ca980f5c96..c4c2b5269216 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -362,6 +362,7 @@ static int sfp_register_bus(struct sfp_bus *bus)
>  	}
>  	if (bus->started)
>  		bus->socket_ops->start(bus->sfp);
> +	bus->netdev->sfp_bus = bus;
>  	bus->registered = true;
>  	return 0;
>  }
> @@ -370,6 +371,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
>  {
>  	const struct sfp_upstream_ops *ops = bus->upstream_ops;
>  
> +	bus->netdev->sfp_bus = NULL;
>  	if (bus->registered) {
>  		if (bus->started)
>  			bus->socket_ops->stop(bus->sfp);
> @@ -451,7 +453,6 @@ static void sfp_upstream_clear(struct sfp_bus *bus)
>  {
>  	bus->upstream_ops = NULL;
>  	bus->upstream = NULL;
> -	bus->netdev->sfp_bus = NULL;
>  	bus->netdev = NULL;
>  }
>  
> @@ -480,7 +481,6 @@ struct sfp_bus *sfp_register_upstream(struct fwnode_handle *fwnode,
>  		bus->upstream_ops = ops;
>  		bus->upstream = upstream;
>  		bus->netdev = ndev;
> -		ndev->sfp_bus = bus;
>  
>  		if (bus->sfp) {
>  			ret = sfp_register_bus(bus);
> 


-- 
Florian
