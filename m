Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8DAC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9262070D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBKGfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:35:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12923 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725931AbfBKGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:35:39 -0500
X-UUID: 5a48a9fdda8b4c8aa21af3800d68c9a8-20190211
X-UUID: 5a48a9fdda8b4c8aa21af3800d68c9a8-20190211
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1290777801; Mon, 11 Feb 2019 14:35:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 14:35:29 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 14:35:29 +0800
Message-ID: <1549866929.22817.20.camel@mtksdccf07>
Subject: Re: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt
 parameters for sysirq
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <mars.cheng@mediatek.com>,
        <eddie.huang@mediatek.com>, <linux-clk@vger.kernel.org>
Date:   Mon, 11 Feb 2019 14:35:29 +0800
In-Reply-To: <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
         <898ca3d9-002b-e28e-fc97-86bc2538e9de@gmail.com>
         <626b5b46-aac7-1532-386e-2fed85bf4ad9@arm.com>
         <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0EC95753EDE9BB9F38910B43EEEF03341118F2C1563FCCA041DC54C948DD96C92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 15:52 +0000, Marc Zyngier wrote:
> On 07/02/2019 15:47, Marc Zyngier wrote:
> > On 07/02/2019 15:20, Matthias Brugger wrote:
> >>
> >>
> >> On 24/01/2019 09:07, Erin Lo wrote:
> >>> From: Seiya Wang <seiya.wang@mediatek.com>
> >>>
> >>> To support partitioned PPIs, 4 interrupt parameters should be valid
> >>> for sysirq.
> >>>
> >>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> >>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >>> ---
> >>>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> >>> index 90aaf19..282736a 100644
> >>> --- a/drivers/irqchip/irq-mtk-sysirq.c
> >>> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> >>> @@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
> >>>  				       unsigned int *type)
> >>>  {
> >>>  	if (is_of_node(fwspec->fwnode)) {
> >>> -		if (fwspec->param_count != 3)
> >>> +		if (fwspec->param_count != 3 && fwspec->param_count != 4)
> >>
> >> Where is this 4th parameter used?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt#n14
> Sorry, I fired Send way too early.
> 
> What I wanted to add is that it is not clear to me why this change would
> be required here, as this driver only supports SPIs. It could be fixed
> by just relaxing the binding itself.
> 
> Thanks,
> 
> 	M.

Do you mean that we should change #interrupt-cells back to 3 for sysirq
and remove the 4th parameters of every spi interrupts in mt8183.dtsi
(i.e. 3 parameters for spi, 4 for ppi) such that we can discard this
patch?

If yes, we may need some time to verify the change before resending the
patch.

Thanks.

