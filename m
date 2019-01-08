Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CCC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00D420827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975687;
	bh=VsCLYAm+CafoFhM0L1/+hpueaKDfj6J79TTWPqJHGow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sWN/j9LXPjCeQGRN4Oo4gA5lO4623cD6/UqWsJ5bQRLBT00gpzef1aH/mWA8UfqTV
	 L1aXri1aIrpAF4KCyZ1AQFTgeDoW/5jOJ97E92oKwh5RBvKSB4E8uv4JfknPmFnqz6
	 nTrnNN45BI93GeDIYq5rN42+3blmsWHVzv+AsZ1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfAHT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfAHT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:03 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059F620645;
        Tue,  8 Jan 2019 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975683;
        bh=VsCLYAm+CafoFhM0L1/+hpueaKDfj6J79TTWPqJHGow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sd6o7INQyi4T6Nn0Pd5mmqsyeeMOYQH1Pw97BKKQZOPHd3mNLNqHTrfp9WvacyISP
         iJa/D7nQH2GilnSwiwMqNPLws2rUFBdCwyt85U+x6qoII3QFPmyNr6JFl7YhP2XNHq
         x3vXjNTkQj3kd95VjyM1eOejF/j+NeamTbBGFRFA=
Received: by mail-wr1-f49.google.com with SMTP id r10so5214873wrs.10;
        Tue, 08 Jan 2019 11:28:02 -0800 (PST)
X-Gm-Message-State: AJcUukePb+iFS5aT1JoxKrS+w9btteYfU7KCLgEdmjIgS5NjoNnabJoO
        T23AVsE+tRwfMK2lhqiAKy9OldbIl+LN69g4U8M=
X-Google-Smtp-Source: ALg8bN6fvK9f9HUj4dXlagiLnTQUWuzG2yB+iTPbtaupNPjiAu5uGcvXHwEZPEHf/mCO7fPbVzMK2GZoNpBogJoi3Zk=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr2501964wro.78.1546975681453;
 Tue, 08 Jan 2019 11:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com> <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
In-Reply-To: <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 8 Jan 2019 11:29:14 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Message-ID: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Subject: Re: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 11:07 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
>
> > In mtk_phy_connect() I would say this complete block can be removed.
> > All this is handled internally by phylib.
> >
> >       dev->phydev->autoneg = AUTONEG_ENABLE;
> >       dev->phydev->speed = 0;
> >       dev->phydev->duplex = 0;
> >
> >       phy_set_max_speed(dev->phydev, SPEED_1000);
> >       phy_support_asym_pause(dev->phydev);
> >       linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
> >       linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> >                        dev->phydev->advertising);
> >       phy_start_aneg(dev->phydev);
> >
> > Could you please test this?
>
> seems to work well, no warning in dmesg
>
> traffic 940Mbit sending, 900 receive
>

The change to phy initialized valve determined by phylib looks good to
me and simplify the mac driver a lot. You could have it in v2.

> > And a further proposal:
> > Instead of the open-coded dev_info() in mtk_phy_connect_node()
> > you could use phy_attached_info().
>
> have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it

I think it can be done in a separate patch

>
> > Calling phy_start() in the ndo_open callback is fine, you can leave
> > it there.
>
> have it re-added
>
> pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc
>
> regards Frank
