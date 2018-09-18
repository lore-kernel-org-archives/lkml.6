Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F4BECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E9021473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E9021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeIRIzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:55:39 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbeIRIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:55:39 -0400
X-UUID: 9d955216efc44d148644e3a370b66a3a-20180918
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1714470159; Tue, 18 Sep 2018 11:24:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 18 Sep
 2018 11:24:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 18 Sep 2018 11:24:47 +0800
Message-ID: <1537241087.7058.6.camel@mhfsdcap03>
Subject: Re: [PATCH 0/2] add Ethernet driver support for mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 18 Sep 2018 11:24:47 +0800
In-Reply-To: <a8c0a091-6bee-6504-04cd-36e214e805aa@synopsys.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
         <20180917152441.GD5458@lunn.ch>
         <a8c0a091-6bee-6504-04cd-36e214e805aa@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose, Andrew,
	Thanks for your comments.
	Synopsys ip version in mt2712 is 4.21a, and followed ic will use 5.10a.
it seems GMAC4+ is a good choice. I'll try to  extend STMMAC to support
mt2712.
	Any tips about extend STMMAC? or anythings I should pay attention to?
	
On Mon, 2018-09-17 at 17:18 +0100, Jose Abreu wrote:
> Hi Andrew, Biao,
> 
> On 17-09-2018 16:24, Andrew Lunn wrote:
> > On Mon, Sep 17, 2018 at 02:29:21PM +0800, Biao Huang wrote:
> >
> > Adding in the STMMAC driver maintainers.
> >
> >> Ethernet in mt2712 is totally different from that in
> >> drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.
> >>
> >> The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
> >> reference driver in drivers/net/ethernet/synopsys/*. But
> >> 1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
> >> mt2712 Ethernet design is differnet from that in synopsys folder in many
> >> aspects, and some key features are not included in mt2712, such as rss
> >> and split header. At the same time, some features we need have not been
> >> implenmented in synopsys folder.
> > In general, we don't have two very similar drivers. We try to have one
> > driver. If the problem was just missing features in the stmmac driver,
> > you can add them. I doubt not supporting 2.5/4/5Gbps in your silicon
> > is an issue, since very few STMMAC devices have this. By split header,
> > do you mean support for TSO? That seems to be a gmac4 or newer
> > feature, but the driver supports not having tso support in hardware.
> >
> > Giuseppe, Alexandre, Jose: Please can you look at the proposed driver
> > and see how much it really differs from the STMMAC driver. 
> 
> Thanks for the cc Andrew, indeed this looks very similar and the
> register bank matches, by what I've seen, GMAC 4+.
> 
> > How easy
> > would it be to extend stmmac it to support the mt2712?
> 
> Very easy, as I've just done with XGMAC2. If Biao wants to expand
> stmmac functionality I'm all in favor!
> 
> Thanks and Best Regards,
> Jose Miguel Abreu
> 
> >
> > Thanks
> > 	Andrew
> 
Best Regards!
Biao

