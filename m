Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BAEC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCE20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUFsRucj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfAUP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:59:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfAUP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:59:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LFxT0r107484;
        Mon, 21 Jan 2019 09:59:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548086369;
        bh=ZHPYsL2xkgsk70zv70n70ayT4Gz6Ev9RUwViMeg/gGo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yUFsRucjWrwpgVJzsPIsThNEoPsOzkv1qN9wfkyx/DGd0/e1B17HSyWiQE7cJLSAC
         BzBpLY79TYpW8IXDT8l7KzukDCH5lxCB9PmqL45sFI9TbWTdAQVUOrE09e/qQfFI7G
         /gIgdMxb9eaZqSKZfUX7Zp0kScmz6ji5q935vEfs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LFxTLh067437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 09:59:29 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 09:59:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 09:59:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LFxT47030421;
        Mon, 21 Jan 2019 09:59:29 -0600
Date:   Mon, 21 Jan 2019 09:59:29 -0600
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
        <hdegoede@redhat.com>
Subject: Re: [PATCH v4 5/6] usb: musb: Add musb_clearb/w() interface
Message-ID: <20190121155929.GC30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Mon, Jan 21, 2019 at 08:22:30PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> Delete the const attribute of addr parameter in readb/w/l hooks, these
> changes are for implementing clearing W1C registers.
> Replace musb_readb/w with musb_clearb/w to clear the interrupt status.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> new patch based on v3:
> ---
>  drivers/usb/musb/musb_core.c | 32 +++++++++++++++++++++++---------
>  drivers/usb/musb/musb_core.h |  8 ++++++--
>  drivers/usb/musb/musb_io.h   |  8 +++++---
>  drivers/usb/musb/musbhsdma.c |  3 +++
>  drivers/usb/musb/sunxi.c     |  4 ++--
>  drivers/usb/musb/tusb6010.c  |  2 +-
>  6 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2fe5225..5ef8848 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c

[snip]

> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index b2394a7..7bf91cb 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -286,6 +286,9 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>  
>  	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
>  
> +	/* clear pending interrupts by manual */
> +	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
> +

Make musb_clearb/w() return the value of the _read() instead of
_write(), so that we don't have to read twice here. The value of
_write() is not used anyway.

The change above can be:

	int_hsdma = musb_clearb(mbase, MUSB_HSDMA_INTR);

Please see my comments in 6/6 for details.

Regards,
-Bin.
