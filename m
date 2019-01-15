Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D931C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7614E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAOHpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:45:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:46673 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726594AbfAOHpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:45:13 -0500
X-UUID: b73da8501bab474b848fbd595f955e47-20190115
X-UUID: b73da8501bab474b848fbd595f955e47-20190115
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1216061093; Tue, 15 Jan 2019 15:44:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 15:44:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 15:44:57 +0800
Message-ID: <1547538297.10234.4.camel@mhfsdcap03>
Subject: Re: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
From:   Guochun Mao <guochun.mao@mediatek.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <robh+dt@kernel.org>, <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 15 Jan 2019 15:44:57 +0800
In-Reply-To: <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
         <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
         <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 06:59 +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Ryder,
> 
> On 01/14/2019 07:12 AM, Ryder Lee wrote:
> > From: Guochun Mao <guochun.mao@mediatek.com>
> > 
> > SNOR_HWCAPS_READ is a basic read mode for both flash and controller,
> > it should be supported, so add the capcity for mtk-quadspi.
> 
> Since I couldn't find a datasheet for mt8173, I tend to share your assumption -
> SNOR_HWCAPS_READ should be supported by this controller. However, it's always
> better to test it and not rely on assumptions. You can test it by forcing the
> mask to have just SNOR_HWCAPS_READ | SNOR_HWCAPS_PP set. Or you already tested it?

Our IPs all support SNOR_HWCAPS_READ, Ryedr and I have test it.

> 
> You have a typo in capcity. Maybe substitute it with capability or "add this
> flag to spi_nor_hwcaps mask"

Ok, we'll correct it next version.

Thanks.
Guochun
> 
> > 
> > Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> 
> You should add your SoB tag, because you are sending a patch that is not yours.
> 
> Cheers,
> ta
> 
> > ---
> > Changes since v1: none. 
> > ---
> >  drivers/mtd/spi-nor/mtk-quadspi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> > index 5442993..d9eed68 100644
> > --- a/drivers/mtd/spi-nor/mtk-quadspi.c
> > +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> > @@ -431,7 +431,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
> >  			struct device_node *flash_node)
> >  {
> >  	const struct spi_nor_hwcaps hwcaps = {
> > -		.mask = SNOR_HWCAPS_READ_FAST |
> > +		.mask = SNOR_HWCAPS_READ |
> > +			SNOR_HWCAPS_READ_FAST |
> >  			SNOR_HWCAPS_READ_1_1_2 |
> >  			SNOR_HWCAPS_PP,
> >  	};
> > 


