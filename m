Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2982C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC0C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeI1X65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:58:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55888 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbeI1X65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:58:57 -0400
X-UUID: ecae2fd7fcdb4564a63d43912880be73-20180929
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1101918247; Sat, 29 Sep 2018 01:34:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Sep 2018 01:34:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Sep 2018 01:34:00 +0800
Message-ID: <1538156040.30348.89.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] mmc: dt-bindings: add "bus-clk" for MT2712
From:   Sean Wang <sean.wang@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Sat, 29 Sep 2018 01:34:00 +0800
In-Reply-To: <1538134855-11198-2-git-send-email-chaotian.jing@mediatek.com>
References: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
         <1538134855-11198-2-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: BF19B54871203A5D54846AEF06A582874388539EF489BF8797DAAB632A65D5E92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-28 at 19:40 +0800, Chaotian Jing wrote:
> On MT2712 MSDC0/3, HCLK/bus-clk need gate/ungate together,
> or will hang when access MSDC register.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index f33467a..182299b 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -22,6 +22,7 @@ Required properties:
>  	"source" - source clock (required)
>  	"hclk" - HCLK which used for host (required)
>  	"source_cg" - independent source clock gate (required for MT2712)
> +	"bus_clk" - bus clk used for internal register access(required for MT2712 MSDC0/3)

use a full name in the description such as changing "clk" to "clock" and

add an extra blank char prior to left parenthesis

>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl


