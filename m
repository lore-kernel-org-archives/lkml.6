Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C26C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F8521848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVk4w82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfAIT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:28:37 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55389 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfAIT2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:28:35 -0500
Received: by mail-wm1-f41.google.com with SMTP id y139so8829414wmc.5;
        Wed, 09 Jan 2019 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxS56qBpl3OhFSSMkg01eCan4LQUjzw+yOC5UR1STEw=;
        b=fzVk4w82G48Iq8ct6VXxs0+tRfl7VlN6iKPKaFQt+UvhFLJ8rkPm/SrdmLIceyrhg7
         niFaX8Vcubrag3T59zbZXbPqW4YDU9YZz/h0NL3ID4m/6FCNUDeC6mPKN1FOZ2wmvXtT
         nmZReYBANQh6FoD6IqiAz6xsO0vkbLEm5WYRNN2hRc1RkBxG63tPmJVMmiGrvaV3Y56y
         cqr4pX7jab5GSo7rxwUpAYow+MGECbEHrxhO40DV0C5z/0eiea8/KfIeXH0YWdxfMkPz
         tb85m8zkbdkbC1z6Sv/pBV6JjU8vi5AzYpE7eXMAxqxr6h2xZ8HPXyEjCjFBfXiqjciF
         Eakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxS56qBpl3OhFSSMkg01eCan4LQUjzw+yOC5UR1STEw=;
        b=qLchJkiYaNPNLuXO7BatQ2RquYXHUHnHBXubzQ9uIitwXSLCBGoFEY1KeKJo8MdRLv
         Gjs1uTLk9KSJhtEZ1Kf0mDjDl2eqWmo0i8XSHmJSpFNoRt3s2Du526u0rku07L7SAOLr
         zILTKtThTJZgIHlKzLAvnjTJAE33wldS61Yxe8GGs0/ASEbzRD5eu7HBG4Ysqft9D5km
         mW31IrCPsdp6pepzImS17BmXqzwwZdYT0Ip7sCzDTKpTfnbT56tIQruuo+y8mzuIdW//
         cHN2ns3qFuYFkPbQWdAjC7OXpRwqHZOQhE9ybi/lo3Fn2BDnyItY+b9fjevrGLq+0P2r
         bidg==
X-Gm-Message-State: AJcUukcAIB/4I4ME+TzS/Uh0MqSjrLeov5tFoM8oFma1vZglVj/xWnit
        VE8kwsHkpkjbfLxQVxxFJRXepGpm
X-Google-Smtp-Source: ALg8bN50/p/qBPBQ5wdOAPrjW3br2IW3kwaD9cWlnH4sFXl+Q8Q5FGG1MrGTanQTVb+Feet/ig52cg==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr6769921wmf.85.1547062113287;
        Wed, 09 Jan 2019 11:28:33 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc? (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de. [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
        by smtp.googlemail.com with ESMTPSA id n82sm14791353wma.42.2019.01.09.11.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 11:28:32 -0800 (PST)
Subject: Re: Regression in v4.20 with net phy soft reset changes
To:     Tony Lindgren <tony@atomide.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rex Chang <rchang@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20190109190650.GT5544@atomide.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
Date:   Wed, 9 Jan 2019 20:28:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109190650.GT5544@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.2019 20:06, Tony Lindgren wrote:
> Hi all,
> 
> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
> a regression where suspend resume cycle fails to bring up Ethernet on at
> least cpsw on am437x-sk-evm.
> 
What kind of PHY and which PHY driver is used with this board?
I found one schematics of am437x where a KSZ9031RN PHY is used.
Is it the same on your board?

As described in the commit message of this commit you would have
the option to implement the soft_reset callback in the PHY driver.
Can you try to add .soft_reset = genphy_soft_reset to the
KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
it fixes the issue?

> Keerthy noticed this may not happen on the first resume, but usually
> happens after few suspend resume cycles. The most working suspend resume
> cycles I've seen with the commit above is three.
> 
> Any ideas what might be going wrong?
> 
> Note that unrelated to the commit above, there may be other issues too
> as the cpsw phy LED seems to come on only after about five seconds with
> about total of 10 seconds before the Ethernet is up again.
> 
> Regards,
> 
> Tony
> 
Heiner
