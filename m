Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013362085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfAGHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:31:44 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51702 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726257AbfAGHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:31:44 -0500
X-UUID: 0c9b5a191b804c8eb35bd1ce88c5a16f-20190107
X-UUID: 0c9b5a191b804c8eb35bd1ce88c5a16f-20190107
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1289226290; Mon, 07 Jan 2019 15:31:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 15:31:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 15:31:32 +0800
Message-ID: <1546846292.4433.24.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 7 Jan 2019 15:31:32 +0800
In-Reply-To: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
         <1545896066-897-2-git-send-email-min.guo@mediatek.com>
         <20190103221414.GA14639@bogus> <1546570807.585.31.camel@mhfsdcap03>
         <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-04 at 10:10 -0600, Rob Herring wrote:
> On Thu, Jan 3, 2019 at 9:00 PM Min Guo <min.guo@mediatek.com> wrote:
> >
> > On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> > > On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > > > From: Min Guo <min.guo@mediatek.com>
> > > >
> > > > This adds support for MediaTek musb controller in
> > > > host, peripheral and otg mode
> 
> [...]
> 
> > > > + - interrupts      : interrupt used by musb controller
> > > > + - interrupt-names : must be "mc"
> > >
> > > -names is pointless when there is only one.
> > The MUSB core driver has two interrupts, one is for MAC, another for DMA,
> > but on MTK platform, there is only a MAC interrupt, here following the binding
> > of MUSB core driver.
> 
> You should probably be listing the same interrupt number twice if 2
> interrupts are combined.

If only one interrupt is regisetred in driver, dose still need list the
same interrupt number twice in dtsi?

> > > > +Optional properties:
> > > > + - extcon : external connector for VBUS and IDPIN changes detection,
> > > > +   needed when supports dual-role mode.
> > >
> > > Don't use extcon for new bindings. The usb-connector binding should be
> > > used instead.
> > This is used to detect the changes of the IDPIN and VBUS, the change
> > events are provided by other drivers, such as extcon-usb-gpio.c, and
> > then switch MUSB controller to host or device mode, but the
> > usb-connector can't detect these changes.
> 
> To repeat, do not use extcon binding for new bindings. It is poorly
> designed as it reflects extcon driver needs, not a description of the
> hardware. If you have ID on GPIO, then that belongs in a usb-connector
> node because that GPIO goes to the connector. For Vbus, you should
> have a vbus-supply in the connector and use a gpio-regulator if it is
> GPIO controlled.

Sorry, I didn't find a common driver describing the usb-connector. Is
there any driver that I can refer to, specially the way to switch MUSB
controller between host and device mode?

> > > > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > > > +   dual-role mode.
> > >
> > > The controller is powered from Vbus? Probably not. This belongs in the
> > > connector or maybe the phy (if the phy is powered from Vbus).
> > The Vbus is used to provide 5V voltage to the connected device when the
> > controller works as host mode.
> 
> I know what Vbus is. Unless Vbus is providing power to the host
> controller, putting the Vbus supply in the controller node is not a
> accurate representation of the hardware.

I will put vbus-supply in usb-connector after implement it.

> Rob


