Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13877206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAHTHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:07:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:58907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfAHTHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:07:13 -0500
Received: from [91.14.64.214] ([91.14.64.214]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Tue, 8 Jan 2019
 20:06:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Heiner Kallweit" <hkallweit1@gmail.com>
Cc:     "Felix Fietkau" <nbd@openwrt.org>,
        "John Crispin" <john@phrozen.org>,
        "Sean Wang" <sean.wang@kernel.org>,
        "Nelson Chang" <nelson.chang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH] net: ethernet: mediatek: fix warning in
 phy_start_aneg
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 8 Jan 2019 20:06:53 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZJLH7Z5j6IMWKTHNDAq6EUnJKNx6pZWJhT+UxWNmhz4F977/b+WwiyKDgL3ti+DXmfHD9
 Wgmm718q0bGENdKngNx39qqL/Jp3zPJlxWjjAg3TMgcJyZxbMVwa42KqxvhopBSGaDfKFzEtVdbq
 94mzoVKfARAGMNQkTUiHctnr15Oku8WMu3ujAp34NEngjMyGn5IJS3FS7wb8EfN5n0dhA6il5IBb
 UWfdOKhMzUQVRga8dvv9xkMtwMNxjzh6m2ykbKU7Ad1M9HoU+knS2yCeGzIUQB6QY6QSdmDctroH
 No=
X-UI-Out-Filterresults: notjunk:1;V03:K0:gFXAB7BfwYo=:59sDYjgMRQNN0lLW5e66j5
 65hHbsys7LlrQ2dMTQjdy61Q7gYADs13JmEUcXQzg18QT963AePmLlQ2FxzuX6HA4dm0NXbBp
 PUAz7pAsq6nvlpoI/Q/ULuV7nO/uARLeX9cLZfWKXsEGX0UrzNXSM9AMrWOXWKx+24zFaw/Bi
 llQRkgl2clHzcC/mQ70SBRV8EfxUHo4MJXDLYBYQmQz1Sk/DSUR9Oq1xPMC+X8QZ90bVcS2xZ
 EWBHVz4+5kJdJnUNiQWh1LQJ1wjodl7O/GIKN6j4RaYzcpmBOu1fF792y+zz+Ez8puA1qnaeT
 gT3HI31hsbFIYVFEl8y0fyjyR+F7QPyucsx9iur5hScUFE2DkvehIq4ANXYhCbVGsXZpEmW+D
 Ii5xQMvTKedrgALOPQx5Xw7+FkD0WRGtQDquG+RG8ApRYejqeIgDxn4ndlDrSlNRMh2nKWdx6
 5h2qWvwT9KNF4lZH1CKsBj5lbXuGwecsGXvHujcWQLZkO4smvp5ltDFzCOvyySvz57H9o40rw
 Isvcjk3GMUM8i6pBiGiWo1AdfDD4V4BBWacLeCkCdwQLMjlTJc5GIUavebfE6DL9knfUfIQ8T
 vVLl3NvIEboqQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> In mtk_phy_connect() I would say this complete block can be removed.
> All this is handled internally by phylib.
> 
> 	dev->phydev->autoneg = AUTONEG_ENABLE;
> 	dev->phydev->speed = 0;
> 	dev->phydev->duplex = 0;
> 
> 	phy_set_max_speed(dev->phydev, SPEED_1000);
> 	phy_support_asym_pause(dev->phydev);
> 	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
> 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> 			 dev->phydev->advertising);
> 	phy_start_aneg(dev->phydev);
> 
> Could you please test this?

seems to work well, no warning in dmesg

traffic 940Mbit sending, 900 receive

> And a further proposal:
> Instead of the open-coded dev_info() in mtk_phy_connect_node()
> you could use phy_attached_info().

have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it 

> Calling phy_start() in the ndo_open callback is fine, you can leave
> it there.

have it re-added

pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc

regards Frank
