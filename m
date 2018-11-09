Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D302C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0731520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0731520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeKIM7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:59:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeKIM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:59:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A991D14B3D583;
        Thu,  8 Nov 2018 19:20:24 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:20:23 -0800 (PST)
Message-Id: <20181108.192023.2260722462634716993.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     kishon@ti.com, netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tony@atomide.com, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alexandre.belloni@bootlin.com,
        antoine.tenart@free-electrons.com, quentin.schulz@bootlin.com,
        vivek.gautam@codeaurora.org, maxime.ripard@bootlin.com,
        wens@csie.org, carlo@caione.org, chunfeng.yun@mediatek.com,
        matthias.bgg@gmail.com, mgautam@codeaurora.org
Subject: Re: [PATCH 0/5] hy: core: rework phy_set_mode to accept phy mode
 and submode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181108003617.10334-1-grygorii.strashko@ti.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 19:20:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 7 Nov 2018 18:36:12 -0600

> As was discussed in [1] I'm posting series which introduces rework of
> phy_set_mode to accept phy mode and submode. I've dropped TI specific patches as
> this change is pretty big by itself.
> 
> Patch 1 is cumulative change which refactors PHY framework code to
> support dual level PHYs mode configuration - PHY mode and PHY submode. It
> extends .set_mode() callback to support additional parameter "int submode"
> and converts all corresponding PHY drivers to support new .set_mode()
> callback declaration.
> The new extended PHY API
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
> is introduced to support dual level PHYs mode configuration and existing
> phy_set_mode() API is converted to macros, so PHY framework consumers do
> not need to be changed (~21 matches).
> 
> Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface drivers or
> multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-comphy
> PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.
> 
> [1] https://lkml.org/lkml/2018/10/25/366

I guess this will go via Kishon's tree.
