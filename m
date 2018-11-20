Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB917C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD6420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5yBjFVwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD6420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeKUBSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:18:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41972 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeKUBSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XGDPgJMuMrxMxxrx/USinv7RSSIwmfvDeYI7idd3/P0=;
        b=5yBjFVwKW8nG+9fhhv3cXW6T4PeI1p4aKneJx9mrKWo0/K0FhxYOUHVY6JfJQxQafAwoD7tS6NvYgidoIjCnI5pHIUHEqKrASGOxTo6uQHmoLB0emhBxJlyLYFnda/bImTxbhYM4hNndQjL9tuzPEKQN2UkBbmC0LTWFh3XiWGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gP7Kr-00072n-4C; Tue, 20 Nov 2018 15:49:05 +0100
Date:   Tue, 20 Nov 2018 15:49:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [v4, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181120144905.GD18335@lunn.ch>
References: <1542705696-18507-1-git-send-email-biao.huang@mediatek.com>
 <1542705696-18507-3-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542705696-18507-3-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Optional properties:
> +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-rxid/mii interface.
> +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +- mediatek,fine-tune: boolean property, if present indicates that fine delay
> +	is selected for rgmii interface.
> +	If present, tx-delay/rx-delay is 170+/-50ps per stage.
> +	Else tx-delay/rx-delay of coarse delay macro is 0.55+/-0.2ns per stage.
> +	This property do not apply to non-rgmii PHYs.
> +	Only coarse-tune delay is supported for mii/rmii PHYs.

Didn't Rob say to express the delay in pS, and have the driver convert
that to values to put into registers. That is what i would prefer.

     Andrew
