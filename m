Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A60C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6A8205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAQDeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:34:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:25354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727815AbfAQDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:34:23 -0500
X-UUID: 67bc5a0051294c1cafd0223b4c59a006-20190117
X-UUID: 67bc5a0051294c1cafd0223b4c59a006-20190117
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1528284510; Thu, 17 Jan 2019 11:34:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 11:34:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 11:34:16 +0800
Message-ID: <1547696056.4433.233.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/4] usb: musb: Add support for MediaTek musb
 controller
From:   Min Guo <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Date:   Thu, 17 Jan 2019 11:34:16 +0800
In-Reply-To: <20190116135914.GF18026@uda0271908>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
         <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
         <20190115203815.GD18026@uda0271908> <1547631542.4433.232.camel@mhfsdcap03>
         <20190116135914.GF18026@uda0271908>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 07:59 -0600, Bin Liu wrote:
> On Wed, Jan 16, 2019 at 05:39:02PM +0800, Min Guo wrote:
> > Hi Bin,
> > 
> > On Tue, 2019-01-15 at 14:38 -0600, Bin Liu wrote:
> > > Hi Min,
> > > 
> > > very close, thanks.
> > > Below I tried to explain a further cleanup in musb_clearb/w() and
> > > musb_get/set_toggle() implementation. Please let me know if it is not
> > > clear.
> > > 
> > > Basically, we don't need musb_default_clearb/w(), just assign the
> > > musb_io function pointers to musb_readb/w().
> > > 
> > > Then the mtk platform musb_clearb/w() calls musb_readb/w() and
> > > musb_writeb/w() to handle W1C.
> > 
> > Sorry to bother you again, I encounter a problem when prepare the patch.
> 
> no problem at all.

Thanks.

> > The define of musb_clearb/w and musb_readb/w are difference as follow,
> > and cannot be directly assigned:
> > u8/u16 (*readb/w)(const void __iomem *addr, unsigned offset)
> > void (*clearb/w)(void __iomem *addr, unsigned int offset)) 
> > 
> > if modify clearb/w as:
> > u8/u16 (*clearb/w)(const void __iomem *addr, unsigned int offset)) 
> > then musb_clear needs writeb/w the const addr.
> > Can I delete const in (*readb/w)?
> 
> yes, please create a separate patch for it, and for readl() as well,
> and stating it is for implementing clearing W1C registers.

Okay.

> Regards,
> -Bin.


