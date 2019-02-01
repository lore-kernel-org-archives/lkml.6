Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E420863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfBAIWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15442 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbfBAIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:22:28 -0500
X-UUID: 098c044d9f8c4aad920757316504b906-20190201
X-UUID: 098c044d9f8c4aad920757316504b906-20190201
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1981925851; Fri, 01 Feb 2019 16:22:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:22:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:22:23 +0800
Message-ID: <1549009343.22634.4.camel@mtksdaap41>
Subject: Re: [PATCH v3 08/12] clk: mediatek: Add MT8183 clock support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 1 Feb 2019 16:22:23 +0800
In-Reply-To: <154482479243.19322.7465842539016312943@swboyd.mtv.corp.google.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
         <20181210073240.32278-10-weiyi.lu@mediatek.com>
         <154482479243.19322.7465842539016312943@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2018-12-14 at 13:59 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-12-09 23:32:36)
> > +       "apll2_ck"
> > +};
> > +
> > +static const struct mtk_mux top_muxes[] = {
> > +       /* CLK_CFG_0 */
> > +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_AXI, "axi_sel",
> > +               axi_parents, 0x40,
> > +               0x44, 0x48, 0, 2, 7, 0x004, 0, CLK_IS_CRITICAL),
> 
> Please document why CLK_IS_CRITICAL is being used everywhere it's used.
> 

OK, I'll add some more comment at where critical clock data is declared.

> > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MM, "mm_sel",
> > +               mm_parents, 0x40,
> > +               0x44, 0x48, 8, 3, 15, 0x004, 1),
> > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_IMG, "img_sel",
> > +               img_parents, 0x40,
> > +               0x44, 0x48, 16, 3, 23, 0x004, 2),
> > +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_CAM, "cam_sel",
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



