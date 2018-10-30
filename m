Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453F420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dVkvjuPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453F420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJ3Ut6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:49:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46033 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbeJ3Ut6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=fGAXxkMpjEQScWxcavJWXrtG5M3JJ/Cg71rddAg+URg=;
        b=dVkvjuPHiiSGA404TpAyYNH26Hm8ZDWYMzQPx+NeYPBePlqKnyyo1Q8Ir9RER1mSNeDsbwv4eUbmLH1yitU+ERyViUkINZiw+UkSfkwo98zO5xD4RYC0cG0wah1YyXP3F+0IGOFG/Tybm2kxds55LOhIg+8+bd4lctii/9I+IRE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHSdS-0007Jn-JW; Tue, 30 Oct 2018 12:56:38 +0100
Date:   Tue, 30 Oct 2018 12:56:38 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     biao huang <biao.huang@mediatek.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, nelson.chang@mediatek.com,
        netdev@vger.kernel.org, sean.wang@mediatek.com,
        liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, joabreu@synopsys.com,
        linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
Message-ID: <20181030115638.GB27873@lunn.ch>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
 <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
 <20181029100828.GA19103@Red>
 <1540883812.26982.15.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540883812.26982.15.camel@mhfsdcap03>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	plat_dat->interface = priv_plat->phy_mode;
> > > +	/* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> > > +	plat_dat->clk_csr = 5;
> > > +	plat_dat->has_gmac4 = 1;
> > > +	plat_dat->has_gmac = 0;
> > > +	plat_dat->pmt = 0;
> > > +	plat_dat->maxmtu = 1500;
> > 
> > ETH_DATA_LEN ?
> how about getting maxmtu from device tree rather than assignment here?

Does it vary between devices? I expect it is a constant, determined by
the DMA hardware design. So no need to make it configurabale.

    Andrew
