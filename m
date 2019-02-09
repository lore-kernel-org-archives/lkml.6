Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8349BC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47645217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2e6eE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBIQ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:28:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfBIQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:28:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so8785771wmc.5;
        Sat, 09 Feb 2019 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wzAULqxTUgG4qL90xHFg+19/6BAj8+tW1ulyeHM8CbQ=;
        b=gN2e6eE9EuwmeHix6zBrY9qO3dYkrUF5R4UZhaoOclIfo1P4tZDxgvY2toGrikFOD2
         kdg7g41Aum27Dm+Uu/+wts4op0/3hTrCJCLZHbQIHUo+UAV6Fjadb7OQAvDUeY6AB6ZS
         XEKT3Zl1i1daJoCpRtW90nbR7O7Dryw6jkEFR0u2eS2Eq8xi7VWrkWvg7ZYoy/f1qV8D
         1L8WHHJkpjhOkJ6fW6HVugLU+8zvzlVZajyE65D2VtemFiBXV1b1uKcDB96wjVqhzqYr
         lhRBK650iCvq3+ng0+UHJ8atVl+VCTLfW1NvkE8juuUevdgbazzoB2n1C9dnWA4cgR4F
         kfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzAULqxTUgG4qL90xHFg+19/6BAj8+tW1ulyeHM8CbQ=;
        b=YPt+Jxlk2zMP12xV05iu09UwYvztLS8IewAp0YOJPdRL8Gnl3dFesGe8OtHRDx/DNd
         8+JH/1LzeqHxZQtUuDaZkaFe2p3aU9ON/mY6JLhBBhOySo+TOU9pbZa+NhdLiPrN+O7B
         gqwWq+RMSHng5JXmEYf7zZc0AI/+DUBk4zraCfF/8a0qRL7zkQ5pedcrFFRG79EXpl6e
         si/ajTuV9e9hPyIRkZnoRoUk3SGlkXZcJfZ+o99RlbWiGA4UErM98vF443Xq+6vp2kJ9
         pc0p59OvQSxqzExRqI/LMdkHX5WxwCfmVdsH7ebr5jHoX6sz9zLZG54P/DieMyprSuEh
         FEog==
X-Gm-Message-State: AHQUAuYFBxDZkIc8I4nWaTXcwYB/FwzoafzL1B0JZcIGmghZq7SK5bjC
        dtdrWxuCjPLUZO6b8sRiBJk=
X-Google-Smtp-Source: AHgI3IbQZ8v1SXkwp2jDOztYVESy3DotGn90D23DS1i3iJfTwroUpLd55pP3NXC4pD73iYDllNSpSA==
X-Received: by 2002:a1c:384:: with SMTP id 126mr3341649wmd.26.1549729709742;
        Sat, 09 Feb 2019 08:28:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97? (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
        by smtp.googlemail.com with ESMTPSA id c1sm2884656wrf.20.2019.02.09.08.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 08:28:29 -0800 (PST)
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET
 PHYs
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
 <20190209162545.GA30856@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <6081929b-4d32-d0e9-9357-563df4b58290@gmail.com>
Date:   Sat, 9 Feb 2019 17:28:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190209162545.GA30856@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2019 17:25, Andrew Lunn wrote:
>> I'd propose that you extract generic patches being submission-ready
>> and split the patch series into two. I think the following patches
>> would be candidates for the first series: 2, 3, 5, 6
>> (provided they have no dependency on the other patches)
>> Based on that both of us can go on with our work.
>>
>> Andrew, what do you think?
> 
> Yes, that would help.
> 
> Heiner, can you also submit the .get_features patches soon. That is
> another important piece of the puzzle for both drivers.
> 
Just submitted it few hours ago.
https://patchwork.ozlabs.org/patch/1039237/

> 	Thanks
> 		Andrew
> 
Heiner
