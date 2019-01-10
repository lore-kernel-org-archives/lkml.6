Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF575C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0D42177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vxlHSybG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfAJOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:18:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53230 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:18:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0AEIekd041451;
        Thu, 10 Jan 2019 08:18:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547129920;
        bh=sw50tcgNgr1jaX/gPIw/5Ma8kA6L6qkYhNC/N0csP+4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vxlHSybGhcEZY3I2CZWey/z8a5EebITUJAKAS62UBQuqdEE7PXhj4xWmMl+gwo3yF
         ql7fQvg2y7JQHfEj7KFWLjZbn0qfcYY3E5kWagiPxnuNOdVKp4QVFYJbFFeAhrXuXY
         tObLczOCe58y1ssmcIbcx6ZrB5rS9Z9IXPfbMWxM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0AEIeTH099515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 08:18:40 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 08:18:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 08:18:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0AEIeuk024405;
        Thu, 10 Jan 2019 08:18:40 -0600
Date:   Thu, 10 Jan 2019 08:18:40 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Min Guo <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH 4/4] usb: musb: Add support for MediaTek musb controller
Message-ID: <20190110141840.GA18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yonglong Wu <yonglong.wu@mediatek.com>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-5-git-send-email-min.guo@mediatek.com>
 <20190108154441.GG25910@uda0271908>
 <1547037068.4433.122.camel@mhfsdcap03>
 <20190109140144.GI25910@uda0271908>
 <1547105062.4433.144.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547105062.4433.144.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

Please briefly summarize the controller differences in the commit log,
such as

- WIC interrupt registers;
- data toggle bit;
- no dedicated DMA interrupt line;

so that we can quickly understand the core driver is modified
accordingly to handle the differences.

On Thu, Jan 10, 2019 at 03:24:22PM +0800, Min Guo wrote:
> Hi Bin,

[snip]

> > > > > +		musb_writeb(mbase, MUSB_INTRUSB,
> > > > > +			musb_readb(mbase, MUSB_INTRUSB));
> > > > 
> > > > For this clearing register bit operation, please create platform hooks
> > > > musb_clearb() and musb_clearw() in struct musb_platform_ops instead,
> > > > then follow how musb_readb() pointer is assigned in
> > > > musb_init_controller() to use the W1C version for mtk platform.
> > > 
> > > I have tried implementing musb_readb(), musb_readw() interface with
> > > interrupt status W1C function in struct musb_platform_ops. But this
> > > interface will require a global variable to hold MAC basic address for
> > > judgment, and then special handling of the interrupt state. A global
> > > variable will make the driver work with only a single instance, so it
> > > can't work on some MTK platforms which have two instances.
> > 
> > I didn't mean to modify musb_read*(), but
> > 
> > > How about creating musb_clearb/w() as following:
> > > void (*clearb)(void __iomem *addr, unsigned offset, u8 data);
> > > void (*clearw)(void __iomem *addr, unsigned offset, u16 data);
> > 
> > this is what I was asking for, similar to what musb_readb/w() is
> > implemented.
> 
> I will prepare a patch for musb_clearb/w().

This doesn't have to be a separate patch.

> > > > > +		musb_writew(mbase, MUSB_INTRRX,
> > > > > +			musb_readw(mbase, MUSB_INTRRX));
> > > > > +		musb_writew(mbase, MUSB_INTRTX,
> > > > > +			musb_readw(mbase, MUSB_INTRTX));
> > > > > +	}

[snip]

> > > > > +	/* MediaTek controller has private toggle register */
> > > > 
> > > > only one toggle register for all endpoints? how does it handle
> > > > difference toggle values for different endpoints?
> > > 
> > > MediaTek controller has separate registers to describe TX/RX toggle.
> > 
> > Is it one register per endpoint?
> 
> MUSB_RXTOG/MUSB_TXTOG is common register, each bit reflects the toggle
> state of an endpoint. bit[0] not used,bit[1~8] corresponds to ep[1~8]
> 
> > > 
> > > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > > > +		u16 toggle;
> > > > > +		u8 epnum = qh->hw_ep->epnum;
> > > > > +
> > > > > +		if (is_in)
> > > > > +			toggle = musb_readl(musb->mregs, MUSB_RXTOG);
> > 
> > this line seems telling there is just *one* register for all endpoints.
> 
> Yes, all endpoint share this register, endpoint and bit are one-to-one
> correspondence.

Okay, thanks. Sorry I missed the bit operation in the code below.

> 
> > > > 
> > > > should use musb_readw() instead? MUSB_RXTOG seems to be 16bit.
> > > 
> > > Ok
> > > 
> > > > > +		else
> > > > > +			toggle = musb_readl(musb->mregs, MUSB_TXTOG);
> > > > > +
> > > > > +		csr = toggle & (1 << epnum);

Regards,
-Bin.
