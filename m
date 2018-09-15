Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC87ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4FF2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+nM16ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4FF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIPCVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:21:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41482 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:21:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so5818349pfk.8;
        Sat, 15 Sep 2018 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CIzX8R40LTEByC71wIQlNlgn/JeLR0NxZB/DdOCH8t4=;
        b=I+nM16iaSEtc0Xdpe7l41hM//hWbVKWAL/EPxwVMhvgtOvcHx8phTvaRBnk+vbNuZG
         aIZal+ZSi1crnmMz3Yjz6rNJ2HlHP4JVtAt++dFYcB6ob0Gsey6CvfEertodJbuuHADw
         Noxm/LvrvlXsCTBzNT9HlERO3MUZb2uEfFSJm9fWRTmxNQIG6z8iSfjrxi0hxU/xer0h
         aUTy3lGTmh0xbWu4Sa5CP3nYQQf1LwmceJf3GCKAQkdKmrrm9i7Veg5VQqtSG76IaQYV
         R0L18Kfv5+QMljIubC1Zu7Z7IzAW6pstBClPCvwj+eQDcND2p1aTRbwKadru21f/FE+y
         o87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIzX8R40LTEByC71wIQlNlgn/JeLR0NxZB/DdOCH8t4=;
        b=SkYSRWCvC8yXnskr3aXi//dAieAeb6IHUqTyto+PL+U6zl2qZeaYg0+HJ29ESpHJA1
         4cTTYFijOTOoJkW8PkHVcF6qqwUT+cFJKAtbOkUpRJYen9wZiyywACZgQD196zAp5o77
         2dUG27TLDS7dEMS7I1XPOh8tFpm24HMeB5i/0y9eLCr3vAsP/E601udJY0qN0ZwqAZ7K
         o4GhZCT7ax7O/3MtZH9aSROomuRTeKL4Keyfh/JqijMnHpNyQCAkAfBQdfUhwalmvWtL
         D/CjWxq8LHeKRAvRhIGBMYElHyTjEMbrjQ5boDgLurUK46Eo6rwrV05LWh1KkqZ9cYGL
         rsRg==
X-Gm-Message-State: APzg51Cg9dmtTb4ACfBusxXKADAbWNN/rSKyIisIJzjuIDLP4cDerw63
        O94yJ4m9XciBhVALlBOkg2Tg+0di
X-Google-Smtp-Source: ANB0VdbDosGXS5LVIN2ov7sKfIbzhpMFOWwx6JwEr8XguzKgYYhm82UqYy6cBdo2ZVv0helcIJ+EGw==
X-Received: by 2002:a63:1125:: with SMTP id g37-v6mr17295488pgl.187.1537045270260;
        Sat, 15 Sep 2018 14:01:10 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id g21-v6sm19891456pfe.41.2018.09.15.14.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:01:09 -0700 (PDT)
Subject: Re: [PATCH net-next 2/5] net: phy: mscc: Add EEE init sequence
To:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <64809c5f01f3c6407257553a286b82949cef1ac0.1536913944.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1321f1a0-57af-a059-f78a-a699da94c064@gmail.com>
Date:   Fri, 14 Sep 2018 19:21:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <64809c5f01f3c6407257553a286b82949cef1ac0.1536913944.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:33, Quentin Schulz wrote:
> From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> Microsemi PHYs (VSC 8530/31/40/41) need to update the Energy Efficient
> Ethernet initialization sequence.
> In order to avoid certain link state errors that could result in link
> drops and packet loss, the physical coding sublayer (PCS) must be
> updated with settings related to EEE in order to improve performance.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

[snip]

> +	vsc85xx_tr_write(phydev, 0x0f82, 0x0012b00a);

Can you just make this an array of register + value pair? That would be
less error prone in case you need to update that sequence in the future.

With that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
