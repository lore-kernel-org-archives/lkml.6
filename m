Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D40C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A68217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icz2BBu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfAIVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:55:08 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36810 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:55:08 -0500
Received: by mail-wr1-f48.google.com with SMTP id u4so9235838wrp.3;
        Wed, 09 Jan 2019 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ahukTzBEbhXwCucJcDL2Qob/kcdvGrSZ4Z71NTWHxn0=;
        b=Icz2BBu4sIFrJRAq3SWh8ylZyEo7IIvE8KXFBZdV51nqpZdSXgaBF3FIqAZhJOy/UN
         qKdzb8EeywElLx4dYsfcyUYQbdnF35mhS9cQXcdx3+XE5CQHOeqRp1M79X9uMeM8Kz6Z
         LS2tHKIYDkkbIRIWS7e3ZT3OS2EwNFQykKJ9YU2lyK20CQbHXpYOBL0Vp+RbA9ucjFrJ
         du5BhWE0aEB7XOiXjMVjcWw9n4pl69dJ1tR3nUXDTKuZdpsZJWZ/Um1CaZIDBfMZH8wY
         FiNE8e2EyjtsFvAvDv6E8V5O5Ljyi9JGPGZlZoBJ5JG8105hi7vAgXKcdfJ4OePhtsQg
         DYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ahukTzBEbhXwCucJcDL2Qob/kcdvGrSZ4Z71NTWHxn0=;
        b=aRzgN56BzZ+5do1TwTFlBZ9CO7RLCJXb8/fOUb9nJTKierWZikOY5S6AwV5VAFS89f
         CwhaHn7RZE3Kiax++5Ukf8BkcxzO+fWJUmYYD4DnznNiiA6Lvut5oJPrgjZPWSOe2cjo
         L4H+JigPD9jn2mTLTq0Cx2S4E8sOUet7xJL3xz2UzyIPcCLCODfqdKnfGabjLOKH/zsF
         gGiVXi50qBATboVujCAoxW3ENMPVIVrPfmQqe6RObeOV7qyeMJ1X/badhWEf0kcCYC/U
         TOP7gYF2oZu1Q/g1h+EI1Wc4jY0W2/+vPcuLrDY7r0MbxYTiPdsHIbGcPb7LJejg6dnu
         dg4w==
X-Gm-Message-State: AJcUukemGEM0OEfMhTuruAr80iMK6Cg/Tw58SA4um63hXI07MovBxr4c
        CjmiY8D56FA5FZRy71sfPBw9xn9z
X-Google-Smtp-Source: ALg8bN46/Ob4KlkZl7u2Lrfs3NeO9iAAOYWSJ72TD6cwB564PP+Q/kLZzbd8uxmWqotYcbQ1hHzVxA==
X-Received: by 2002:adf:8506:: with SMTP id 6mr6895416wrh.128.1547070905623;
        Wed, 09 Jan 2019 13:55:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc? (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de. [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
        by smtp.googlemail.com with ESMTPSA id o15sm50679728wrp.12.2019.01.09.13.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:55:05 -0800 (PST)
Subject: Re: Regression in v4.20 with net phy soft reset changes
To:     Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rex Chang <rchang@ti.com>, Tero Kristo <t-kristo@ti.com>,
        WingMan Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <dcbf0bcb-7014-f7ee-3f24-c801babff086@gmail.com>
Date:   Wed, 9 Jan 2019 22:54:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109213611.GU5544@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.2019 22:36, Tony Lindgren wrote:
> Hi,
> 
> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>> least cpsw on am437x-sk-evm.
>>>
>> What kind of PHY and which PHY driver is used with this board?
>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>> Is it the same on your board?
> 
> Yes that's the phy.
> 
>> As described in the commit message of this commit you would have
>> the option to implement the soft_reset callback in the PHY driver.
>> Can you try to add .soft_reset = genphy_soft_reset to the
>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>> it fixes the issue?
> 
> Yes that seems to work based on a quick test of five suspend
> resume cycles.
> 
> I wonder what all hardware this issue affects though?
> 
As one of few vendors Microchip publishes errata documentation
like this one for KSZ9031RNX:
http://ww1.microchip.com/downloads/en/DeviceDoc/80000692D.pdf
I wonder whether this is applicable for the PHY in our case and
whether the need for an extra soft reset is caused by one of
the mentioned issues.

> It's probably best that the network folks check what all
> hardare needs patching.
> 
> For TI hardware, Sekhar and TI network folks, can you guys
> please check the various TI SoCs for multiple suspend resume
> cycles with v5.0-rc1 and patch accordingly? See also below
> for something else to check, 10 seconds to resume a phy
> seems very long to me :)
> 
>>> Keerthy noticed this may not happen on the first resume, but usually
>>> happens after few suspend resume cycles. The most working suspend resume
>>> cycles I've seen with the commit above is three.
> ...
>>> Note that unrelated to the commit above, there may be other issues too
>>> as the cpsw phy LED seems to come on only after about five seconds with
>>> about total of 10 seconds before the Ethernet is up again.
> 
> Regards,
> 
> Tony
> 
Heiner
