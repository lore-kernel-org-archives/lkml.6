Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADFC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eRUDIILg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADFC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJSEBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:01:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeJSEBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:01:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so1543712wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mLbC0/WN0GZ+sYzNKCRcu/aWr6nl0GR1arRrj5+n4Ls=;
        b=eRUDIILgXHB0Gham4O1yJIpBUBQ/g6raqSaoUIf8YH2//l8rSBJvVTfbp8J3etehXB
         s7dwTriiBcDaM4/Sy+73exl+yYRkqvJ+77/3e0a2P92XL5Xf6YsrQpSgnjNcwPNhkh8u
         PG7uUpcggtOFKvaA85Z08MvhQYd/S5wcp6sJab1lKRaT3ABzG2HzQ1ssH5TgF+IOUW5b
         aNBDqJc1DIfQN1Dn4iqLetndstVCLCjJVH0piNumMBBJDWoXszMb6SkVU+cjgTOnwyWB
         znZieXyE4d2ROj9Uzk1NNzRdX8HjQvdMwuaQ0arPp28UsuTH2g6v+BI24gS17j3HDTzc
         unog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLbC0/WN0GZ+sYzNKCRcu/aWr6nl0GR1arRrj5+n4Ls=;
        b=QYUClNF9hZ86C5EVw76pHhYWVuwflUuOnpwqXPi58pVy/+/Bjkf/mf6veFlgkq4fxQ
         CWPa5xYPnN6/M1kV8IOoEEoH68obf4zcwfMqlm7aYzJaP4GtlpHfy4lwg3y3Vj9g+nkC
         /D7LXS8R0jraGBfWOu19EtyQZ75rDI21RCUFLULlbfm88fB3QS8j4Oy0okCkGxGGKpCS
         rwPu+pkGr7OYfhEgyonO8O2clf4n65OKd44jK+B8npAAM8iYQJubi/3JVXhRZw3kqa/B
         Axq5AHFlnD3DobVIdn/UEtWAtaBu1cdOfWtL6TQXzIAaPqFKblMLY+et586T7hzsZsuW
         h0oA==
X-Gm-Message-State: ABuFfojll5hGBnslq7Pi4Gk4GYq3XEXea8mSvO/xYbSeFJgkza/p2r2l
        oY996EBIQ5jehvMr5vnGpUG+BQ==
X-Google-Smtp-Source: ACcGV62miaxs/sVGN9OstP6mOwSSiri7TDIkot2KxmPkeiSGwUqv5JibIWOy/8HRncBaes5Ydi/LiQ==
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr1706126wmd.17.1539892752608;
        Thu, 18 Oct 2018 12:59:12 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id m67-v6sm1515539wmb.18.2018.10.18.12.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:59:11 -0700 (PDT)
Date:   Thu, 18 Oct 2018 21:59:09 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181018195909.GA11317@Red>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:38:32PM -0700, Florian Fainelli wrote:
> On 10/18/2018 12:16 PM, LABBE Corentin wrote:
> > On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
> >> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
> >>> On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
> >>>> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> >>>>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> >>>>> This is due to missing SPEED_.
> >>>>
> >>>> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
> >>>> surely this would amount to the same code paths being taken or am I
> >>>> missing something here?
> >>>
> >>> The bisect session pointed your patch, reverting it fix the issue.
> >>> BUT since the fix seemed trivial I sent the patch without more test then compile it.
> >>> Sorry, I have just found some minutes ago that it didnt fix the issue.
> >>>
> >>> But your patch is still the cause for sure.
> >>>
> >>
> >> What you are writing is really lowering the confidence level, first
> >> Andrew is the author of that patch, and second "just compiling" and
> >> pretending this fixes a problem when it does not is not quite what I
> >> would expect.
> >>
> >> I don't have a problem helping you find the solution or the right fix
> >> though, even if it is not my patch, but please get the author and actual
> >> problem right so we can move forward in confidence, thanks!
> > 
> > Sorry again, I wanted to acknoledge my error but I did it too fast and late.
> > And sorry to have confound you with Andrew.
> 
> No worries, here to help, let us know what your bisection points to. THanks

I have added printing of phydev->supported
My working kernel (on top of 58056c1e1b0e + revert patch) got:
[    5.550838] fec_enet_mii_probe 2ff (gbit features)
[    5.555848] fec_enet_mii_probe 2ef (without 1000baseT_Half)
[    5.561620] fec_enet_mii_probe 22ef final (after pause)
[    5.566914] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
[    8.730751] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    8.788311] Sending DHCP requests ., OK
[    8.832357] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58

the non-working kernel (next-20181015)
[    7.308917] fec_enet_mii_probe 62ff after phy_set_max_speed
[    7.314545] fec_enet_mii_probe 62ef after phy_remove_link_mode
[    7.320418] fec_enet_mii_probe 62ef after pause
and then no link

So it seems that phy_set_max_speed adds bit 14 (ETHTOOL_LINK_MODE_Asym_Pause_BIT)

I have patched by adding:
phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
and got:
[    7.310559] fec_enet_mii_probe 62ff after phy_set_max_speed
[    7.316221] fec_enet_mii_probe 22ef after phy_remove_link_mode
[    7.322128] fec_enet_mii_probe 22ef after pause
[    7.326681] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
[    7.611276] Waiting up to 3 more seconds for network.
[    7.881278] Waiting up to 2 more seconds for network.
[    8.131277] Waiting up to 2 more seconds for network.
[    8.401169] Waiting up to 2 more seconds for network.
[    8.671269] Waiting up to 2 more seconds for network.
[    8.941274] Waiting up to 1 more seconds for network.
[    9.211181] Waiting up to 1 more seconds for network.
[    9.481274] Waiting up to 1 more seconds for network.
[    9.751275] Waiting up to 1 more seconds for network.
[   10.021281] Waiting up to 0 more seconds for network.
[   10.291274] Waiting up to 0 more seconds for network.
[   10.381282] Sending DHCP requests .
[   10.473000] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   12.861267] ., OK
[   12.903405] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58

So at least I got a link, but the link is still late to got

Regards
