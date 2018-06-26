Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A94326554
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A94326554
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFZGga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:36:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38794 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751869AbeFZGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:36:28 -0400
X-UUID: 6acbb1c84d01431c8d4c040bf61bcb3e-20180626
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 443016716; Tue, 26 Jun 2018 14:36:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 26 Jun 2018 14:36:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 26 Jun 2018 14:36:24 +0800
Message-ID: <1529994984.17448.27.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] dt-bindings: Add mtk-systimer bindings
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 26 Jun 2018 14:36:24 +0800
In-Reply-To: <ad38a952-4400-984a-a7fd-aa4e6af13c13@linaro.org>
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
         <1529910601-15005-2-git-send-email-stanley.chu@mediatek.com>
         <ad38a952-4400-984a-a7fd-aa4e6af13c13@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 23:53 +0200, Daniel Lezcano wrote:
> On 25/06/2018 09:10, Stanley Chu wrote:
> > Add binding documentation for the System Timer driver of
> > the Mediatek SoCs.
> > 
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > ---
> >  .../bindings/timer/mediatek,mtk-systimer.txt       |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> > new file mode 100644
> > index 0000000..735a6fd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> > @@ -0,0 +1,18 @@
> > +Mediatek System Timers
> > +----------------------
> > +
> > +Required properties:
> > +- compatible: should contain
> > +	"mediatek,sys_timer" for those platforms which support system timer.
> > +- reg: Mandatory. The location and length for system timer registers.
> > +- clock-frequency: Optional. If not assigned specifically, default
> > +	value 13000000 (means 13 MHz) would be applied.
> 
> The driver tells there is an error if it is not defined, so it can't be
> optional.
> 
> > +Examples:
> > +
> > +	sys_timer@10017000 {
> > +		compatible = "mediatek,sys_timer";
> > +		reg = <0 0x10017000 0 0x1000>;
> > +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> > +		clock-frequency = <13000000>;
> 
> Replace it by a phandle to a 'fixed-clock'.
> 
> eg.
> 
> clocks = <&myclk>;
> 
> 
> > +	};
> 
> myclk: myclk {
> 	#clock-cells = <0>;
> 	compatible = "fixed-clock";
>         clock-frequency = <13000000>;
> };
> 
> Thanks
> 
>   -- DAniel
> 
> 
> 
> 
Hi Daniel,

13 MHz clock is necessary. We will fix it in v2 by using system's
fixed-clock.

Thanks.
Stanley Chu


