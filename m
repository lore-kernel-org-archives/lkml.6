Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD0CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfAQMl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:41:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47626 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727506AbfAQMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:41:26 -0500
X-UUID: 73f7eb08865e4460ab5e11fa1cf686d1-20190117
X-UUID: 73f7eb08865e4460ab5e11fa1cf686d1-20190117
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1494410280; Thu, 17 Jan 2019 20:41:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 20:41:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 20:41:17 +0800
Message-ID: <1547728876.4433.237.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Date:   Thu, 17 Jan 2019 20:41:16 +0800
In-Reply-To: <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
         <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
         <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 2019-01-17 at 14:06 +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/17/2019 10:15 AM, min.guo@mediatek.com wrote:
> 
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..3e3f671
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,43 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +   the registers
> 
>    I'd indent it more to align with "specifies", else it looks weird.

Okay.

> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +   refer to usb/generic.txt
> 
>   Same here...

Okay.

> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +   each entry in clock-names
> 
>    Here...

Okay.

> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +   for clocks of controller
> 
>   And here.

Okay.

> > +
> > +Optional properties:
> > + - extcon : external connector for VBUS and IDPIN changes detection,
> 
>    ID pin, maybe?

Okay.

> > +   needed when supports dual-role mode.
> > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > +   dual-role mode.
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +   MTCMOS
> [...]
> 
> MBR, Sergei


