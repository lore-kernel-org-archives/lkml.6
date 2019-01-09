Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5589C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72DB20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547074050;
	bh=l7tzuTsg78rO7wjkdQgRKZOQ2uEo9fP1/NLImyZXw8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tntXz6iCH5vQY6/4jQ+FB/HfnlHyiFrNZy41qwVMfMMILsiyp0yaZgGqdlTXHhLrk
	 VTHaemvTT9k7AVK+cOeL7tWg3xkhtMZgi1tusc12GLvCAS4KjIh2BeZyQrkLyV0gjn
	 MjwoPGumpb9Y7vJguR0oPRjjA7DyDFWsTw/dojms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfAIWr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbfAIWr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:47:29 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FB72177B;
        Wed,  9 Jan 2019 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547074048;
        bh=l7tzuTsg78rO7wjkdQgRKZOQ2uEo9fP1/NLImyZXw8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yv4k0vDwKgEu11nEmhamEMPt9NquImzUvIzVa9PaNEfufn0A363o46s110sIqr90K
         Sufh/mkG3yAqKGyC6v8uSy+pABlyfqvaupQXRLDndxX7LAj9rhfdfSh67eLjqK27AC
         lRlZ47SnfqW6+ovvH/4GrnIWUvkaNkCB8HAV1R7U=
Received: by mail-wr1-f45.google.com with SMTP id t6so9271713wrr.12;
        Wed, 09 Jan 2019 14:47:27 -0800 (PST)
X-Gm-Message-State: AJcUukcWrhDlnsq3gqO7ZqJ6/uaaRl1QohYRaNVXDdnudi8dVAGuPB2G
        kGltaJ/qHGqAxWX28HMbt2bR3C95IaITN4a4+r8=
X-Google-Smtp-Source: ALg8bN4JPg86LH2GZDK2bY71qQWd26+yY5GC6vYObYXaNMrtN4QfrUbcJVu1JYj7Na+UP2ulwAb2lnJxl/dYdxKE3iQ=
X-Received: by 2002:adf:b243:: with SMTP id y3mr6917561wra.184.1547074046284;
 Wed, 09 Jan 2019 14:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20190109072028.30513-1-frank-w@public-files.de> <2d3d2d19-b149-76e7-8013-ffb124b62f2b@gmail.com>
In-Reply-To: <2d3d2d19-b149-76e7-8013-ffb124b62f2b@gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 9 Jan 2019 14:48:43 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpzX4bFF9mMk_teZrTtkf9NSoSfGqVSgPKYY5HjUPbqnw@mail.gmail.com>
Message-ID: <CAGp9LzpzX4bFF9mMk_teZrTtkf9NSoSfGqVSgPKYY5HjUPbqnw@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: mediatek: fix warning in phy_start_aneg
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
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

On Wed, Jan 9, 2019 at 10:31 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 09.01.2019 08:20, Frank Wunderlich wrote:
> > From: Heiner Kallweit <hkallweit1@gmail.com>
> >
> > linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:
> >
> > [ 5.170597] WARNING: CPU: 3 PID: 1 at drivers/net/phy/phy.c:548 phy_start_aneg+0x110/0x144
> > [ 5.178826] called from state READY
> > ....
> > [ 5.264111] [<c0629fd4>] (phy_start_aneg) from [<c0e3e720>] (mtk_init+0x414/0x47c)
> > [ 5.271630] r7:df5f5eec r6:c0f08c48 r5:00000000 r4:dea67800
> > [ 5.277256] [<c0e3e30c>] (mtk_init) from [<c07dabbc>] (register_netdevice+0x98/0x51c)
> > [ 5.285035] r8:00000000 r7:00000000 r6:c0f97080 r5:c0f08c48 r4:dea67800
> > [ 5.291693] [<c07dab24>] (register_netdevice) from [<c07db06c>] (register_netdev+0x2c/0x44)
> > [ 5.299989] r8:00000000 r7:dea2e608 r6:deacea00 r5:dea2e604 r4:dea67800
> > [ 5.306646] [<c07db040>] (register_netdev) from [<c06326d8>] (mtk_probe+0x668/0x7ac)
> > [ 5.314336] r5:dea2e604 r4:dea2e040
> > [ 5.317890] [<c0632070>] (mtk_probe) from [<c05a78fc>] (platform_drv_probe+0x58/0xa8)
> > [ 5.325670] r10:c0f86bac r9:00000000 r8:c0fbe578 r7:00000000 r6:c0f86bac r5:00000000
> > [ 5.333445] r4:deacea10
> > [ 5.335963] [<c05a78a4>] (platform_drv_probe) from [<c05a5248>] (really_probe+0x2d8/0x424)
> >
> > maybe other boards using this generic driver are affected
> >
> > v2:
> > optimization:
> >
> > - phy_set_max_speed() is only needed if you want to reduce the
> >   max speed, typically if the PHY supports 1Gbps but the MAC
> >   supports 100Mbps only.
> >
> > - The pause parameters are autonegotiated. Except you have a specific
> >   need you normally don't need to manually fiddle with this.
> >
> > - phy_start_aneg() is called implicitly by the phylib state machine,
> >   you shouldn't call it manually except you have a good excuse.
> >
> > - netif_carrier_on/netif_carrier_off in mtk_phy_link_adjust() isn't
> >   needed. It's done by phy_link_change() in phylib.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for your help to have the driver more fit in phylib.

Acked-by: Sean Wang <sean.wang@kernel.org>
