Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A09ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648C9206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zr2W66co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648C9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeIQUwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:52:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36632 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbeIQUwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bWbfYheuTaUYMxjV6zEe/SywgMtqoDFxgycatvQpwFw=;
        b=Zr2W66coQ1IcspKNMJn3vlQ2iKZlmuLjYiFrylJgeUZI/B8/Gg7aPL/BuIxyfTK2ibgd7c0c3F2G4RbadZI6h2C27fqHmyPp1/Cxv9UXKp9aQXN+54b3q7zLV8iv54sjjsQ2mWtG6A+9bue4QmhXh137NY+NcUd/ky3PR4e7y9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g1vOD-0002KC-S2; Mon, 17 Sep 2018 17:24:41 +0200
Date:   Mon, 17 Sep 2018 17:24:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        sean.wang@mediatek.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] add Ethernet driver support for mt2712
Message-ID: <20180917152441.GD5458@lunn.ch>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:29:21PM +0800, Biao Huang wrote:

Adding in the STMMAC driver maintainers.

> Ethernet in mt2712 is totally different from that in
> drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.
> 
> The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
> reference driver in drivers/net/ethernet/synopsys/*. But
> 1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
> mt2712 Ethernet design is differnet from that in synopsys folder in many
> aspects, and some key features are not included in mt2712, such as rss
> and split header. At the same time, some features we need have not been
> implenmented in synopsys folder.

In general, we don't have two very similar drivers. We try to have one
driver. If the problem was just missing features in the stmmac driver,
you can add them. I doubt not supporting 2.5/4/5Gbps in your silicon
is an issue, since very few STMMAC devices have this. By split header,
do you mean support for TSO? That seems to be a gmac4 or newer
feature, but the driver supports not having tso support in hardware.

Giuseppe, Alexandre, Jose: Please can you look at the proposed driver
and see how much it really differs from the STMMAC driver. How easy
would it be to extend stmmac it to support the mt2712?

Thanks
	Andrew
