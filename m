Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59217C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F399820685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tZOFAEH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F399820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437607AbeKWB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:59:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45713 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731279AbeKWB7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=t4lJXZS95oUH104pGtmd//yuZEh99+M7Tq15NPLR90c=;
        b=tZOFAEH7vac0PvgCod69bwYwvyIZo6yWcL3ndZpPjkSdVXP94gAlPsEtQJxgeqE60PBMpir6lXB2Roe0CA/qmni4UCys+NT4+B5IyfHAAlpRJlBqhLXoGRgLKwnx/FD7U74cjybm8cSgMIwJ6PNgOVv43EmXqTWaRKFspnpqJUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPqlQ-0000Xp-Vp; Thu, 22 Nov 2018 16:19:33 +0100
Date:   Thu, 22 Nov 2018 16:19:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181122151932.GD15403@lunn.ch>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:28:41PM +0800, Biao Huang wrote:
> The commit adds the device tree binding documentation for the MediaTek DWMAC
> found on MediaTek MT2712.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

> +Optional properties:
> +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-rxid/mii interface.
> +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.

You have received the same feedback at least twice now, from two
different maintainers, that the delay should be specified in pS, and
the driver should figure out what values to place into registers.

You should not ignore feedback like that. If you don't understand the
feedback, please ask us to explain it. If you don't agree with the
feedback, you need to argue why you think it is wrong, or why what you
are doing is better, etc.

We are here to help, but just ignoring us won't get you anywhere.

For the moment:

NACK

	Andrew
