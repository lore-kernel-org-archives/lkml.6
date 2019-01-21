Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40534C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073EB20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HwkEIyaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfAUQIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:08:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36728 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbfAUQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:08:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LG7oxI110789;
        Mon, 21 Jan 2019 10:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548086870;
        bh=hTmZ+nvPQsoBq3Sseg38xKH5XD++JfQ0yG6JJda2FF4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HwkEIyaLPsYpz9KoPhz3s/TZDNSiuOCRTJzxmgxKPOgnctcEB0KenCQQjco8SF93e
         6Ih0gf//ZcCZak0XmocfWmUsf/gtoyfwJnIyn7l2vlzoQJKs1PK9zwIMnPfwl56AlO
         0KfsLbyTgQEjZBGZEiXunDNEDCPeZvnnNF6IYEqQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LG7ord023278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 10:07:50 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 10:07:50 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 10:07:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LG7nlY019577;
        Mon, 21 Jan 2019 10:07:49 -0600
Date:   Mon, 21 Jan 2019 10:07:49 -0600
From:   Bin Liu <b-liu@ti.com>
To:     <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v4 6/6] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20190121160749.GD30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com, Yonglong Wu <yonglong.wu@mediatek.com>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-7-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1548073351-13739-7-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Mon, Jan 21, 2019 at 08:22:31PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> There are some quirk of MediaTek musb controller, such as:
>  -W1C interrupt status registers
>  -Private data toggle registers
>  -No dedicated DMA interrupt line
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> ---
> changes in v4:
> 1. no changes
> 
> changes in v3:
> suggested by Bin:
> 1. Remove 'u8/u16 data' parameter in clearb/w() hooks
> 2. Replace musb_readb/w() with musb_clearb/w() to clear interrupts status
> 
> changes in v2:
> suggested by Bin:
> 1. Add summarize of MediaTek musb controller differences in the commit log
> 2. Add "|| COMPILE_TEST" in Kconfig
> 3. Move MediaTek's private toggle registers from musb_regs.h to mediatek.c
> 4. Replace musb_readl() with musb_readw() to read 16bit toggle register
> ---
>  drivers/usb/musb/Kconfig    |   8 +-
>  drivers/usb/musb/Makefile   |   1 +
>  drivers/usb/musb/mediatek.c | 624 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 632 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/musb/mediatek.c
> 

[snip]

> +static irqreturn_t generic_interrupt(int irq, void *__hci)
> +{
> +	unsigned long flags;
> +	irqreturn_t retval = IRQ_NONE;
> +	struct musb *musb = __hci;
> +
> +	spin_lock_irqsave(&musb->lock, flags);
> +	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB) &
> +	    musb_readb(musb->mregs, MUSB_INTRUSBE);
> +	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX)
> +	    & musb_readw(musb->mregs, MUSB_INTRTXE);
> +	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX)
> +	    & musb_readw(musb->mregs, MUSB_INTRRXE);

Based on my comment in 5/6, the above 3 musb_readb/w() can be changed to

> +	/* MediaTek controller interrupt status is W1C */
> +	musb_clearw(musb->mregs, MUSB_INTRRX);
> +	musb_clearw(musb->mregs, MUSB_INTRTX);
> +	musb_clearb(musb->mregs, MUSB_INTRUSB);

	musb->int_usb = musb_clearb(musb->mregs, MUSB_INTRUSB)
	musb->int_tx = musb_clearw(musb->mregs, MUSB_INTRTX);
	musb->int_rx = musb_clearw(musb->mregs, MUSB_INTRRX);

> +
> +	if (musb->int_usb || musb->int_tx || musb->int_rx)
> +		retval = musb_interrupt(musb);
> +
> +	spin_unlock_irqrestore(&musb->lock, flags);
> +
> +	return retval;
> +}
> +

[snip]

> +
> +static u8 mtk_musb_clearb(void __iomem *addr, unsigned int offset)
> +{
> +	u8 data;
> +
> +	/* W1C */
> +	data = musb_readb(addr, offset);
> +	musb_writeb(addr, offset, data);
> +	return musb_readb(addr, offset);

	return data;

> +}
> +
> +static u16 mtk_musb_clearw(void __iomem *addr, unsigned int offset)
> +{
> +	u16 data;
> +
> +	/* W1C */
> +	data = musb_readw(addr, offset);
> +	musb_writew(addr, offset, data);
> +	return musb_readw(addr, offset);

	return data;


Regards,
-Bin.
