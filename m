Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE7C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7EB214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGNhlJP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7EB214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3Jyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:54:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38398 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Jyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:54:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so3879147wmd.3;
        Thu, 29 Nov 2018 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJXwgZluaidOzLaRGIvp1bkiKYMBsyxA9xfZR9qsg0c=;
        b=SGNhlJP63kj7e1M1s0rjzOXn8yQBYTDzPL2P+011usNUvZUV8x+C6I7PWR9I+G3k2Y
         GtvlD49gE2FstPGa2LYQxaXiq87VE44msxwtWHLTFdbluHoYhi97+WBG7JliiEKTBmcV
         yhUihqZCtpEtVV54PAHhKlYKany7OtrwqQAHN7f5Cb0/PaIrHKQG4nTDPc6+yQlymK+h
         qLspqHeJRbvnmuIyEUvjO3skAzzRRwTGeUD6IOCIsW4S5tn1V/SI9+Fo4PJznyAJ19Kz
         797YALu2ZvMT1stQ0Y0XPNViIaJNZQpwmalTP9OJ/KeZZz2dVkV6oWflicapE7F08mW/
         LItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJXwgZluaidOzLaRGIvp1bkiKYMBsyxA9xfZR9qsg0c=;
        b=KtSt809mKc8y08WYN32BK3LG7gBmuomRhipztlYd6VWXYiIjw9rfOa9iY98mlbj5Cf
         ACvC2hnzlzBKMl3Il16xhA6uiEDsesPvcv1EEPDYooiKnFQapq9AAUvIr3QaW9ZjOi1L
         v5H5v3R2yWgja/uKcfvSTp3P4ucFQWkCJ1kueNe6isFoQu8ObI+mcmRyC9WlcIiGvM1P
         bUnSKS+FsG81SRz01/j+TovADItH94Uj9qSKYFqwThI5BD6SgBXdck3WDVNpcWQmd3FX
         1ONtyu8tXNdePz4ZJBuj7MSXqLTHyyvdtb53CCv/6CkjkgAQlxeLq71jVO8tvUFDyXxY
         IsmQ==
X-Gm-Message-State: AA+aEWYksw5mgo/hBWvLr6fKN4myiZhvzGU26OGTZlkZU5yTYx2taP8/
        HnTCpwL2xEf4Vei1U00gZjf1guRi
X-Google-Smtp-Source: AFSGD/U4zj0rEnqol0qRh8F5L/Q/fee7gS+PgtDcAAkDW5bCMQVS/sc0lDnXck7owHEgS6ZcB+tvvQ==
X-Received: by 2002:a1c:57c4:: with SMTP id l187mr3554990wmb.6.1543531665910;
        Thu, 29 Nov 2018 14:47:45 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:4cc2:ecc9:4944:8738? (p200300EA8BCFE3004CC2ECC949448738.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:4cc2:ecc9:4944:8738])
        by smtp.googlemail.com with ESMTPSA id w9sm2997540wme.47.2018.11.29.14.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:47:45 -0800 (PST)
Subject: Re: [RFC PATCH net] net: phy: fix the issue that netif always links
 up after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543479131-14097-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0499fc01-fce3-26c7-8b42-64788b8bf47b@gmail.com>
Date:   Thu, 29 Nov 2018 23:47:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543479131-14097-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.2018 09:12, Kunihiko Hayashi wrote:
> Even though the link is down before entering hibernation,
> there is an issue that the network interface always links up after resuming
> from hibernation.
> 
> The phydev->state is PHY_READY before enabling the network interface, so
> the link is down. After resuming from hibernation, the phydev->state is
> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> 
> This patch expects to solve the issue by changing phydev->state to PHY_UP
> only when the link is up.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/phy/phy_device.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ab33d17..d5bba0f 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -309,8 +309,10 @@ static int mdio_bus_phy_restore(struct device *dev)
>  		return ret;
>  
>  	/* The PHY needs to renegotiate. */
> -	phydev->link = 0;
> -	phydev->state = PHY_UP;
> +	if (phydev->link) {
> +		phydev->link = 0;
> +		phydev->state = PHY_UP;
> +	}
>  
Thanks for reporting. I agree that it isn't right to unconditionally set
PHY_UP, because we don't know whether the PHY was started before
hibernation. However I don't think using phydev->link as criteria is
right. Example would be: PHY was started before hibernation, but w/o link.
In this case we want to set PHY_UP to start an aneg, because a cable may
have been plugged in whilst system was sleeping.

So I think, similar to phy_stop_machine, we should use state >= UP and
state != HALTED as criteria, and also phy_start_machine() would need to
be called only if this criteria is met.

It may make sense to add a helper for checking whether PHY is in a
started state (>=UP && !=HALTED), because we need this in more than
one place.

>  	phy_start_machine(phydev);
>  
> 

