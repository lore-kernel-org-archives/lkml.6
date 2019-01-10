Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464B8206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfAJHZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:25:02 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28652 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfAJHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:25:01 -0500
X-UUID: 84658294262c466a88eab89fc24255e3-20190110
X-UUID: 84658294262c466a88eab89fc24255e3-20190110
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1357864204; Thu, 10 Jan 2019 15:24:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 15:24:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 15:24:22 +0800
Message-ID: <1547105062.4433.144.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] usb: musb: Add support for MediaTek musb controller
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
Date:   Thu, 10 Jan 2019 15:24:22 +0800
In-Reply-To: <20190109140144.GI25910@uda0271908>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
         <1545896066-897-5-git-send-email-min.guo@mediatek.com>
         <20190108154441.GG25910@uda0271908> <1547037068.4433.122.camel@mhfsdcap03>
         <20190109140144.GI25910@uda0271908>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Wed, 2019-01-09 at 08:01 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Wed, Jan 09, 2019 at 08:31:08PM +0800, Min Guo wrote:
> > Hi Bin,
> > On Tue, 2019-01-08 at 09:44 -0600, Bin Liu wrote:
> > > Hi,
> > > 
> > > On Thu, Dec 27, 2018 at 03:34:26PM +0800, min.guo@mediatek.com wrote:
> > > > From: Min Guo <min.guo@mediatek.com>
> > > > 
> > > > This adds support for MediaTek musb controller in
> > > > host, peripheral and otg mode
> > > > 
> > > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > > Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> > > > ---
> > > >  drivers/usb/musb/Kconfig     |   8 +-
> > > >  drivers/usb/musb/Makefile    |   1 +
> > > >  drivers/usb/musb/mediatek.c  | 562 +++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/usb/musb/musb_core.c |  10 +
> > > >  drivers/usb/musb/musb_core.h |   1 +
> > > >  drivers/usb/musb/musb_dma.h  |   1 +
> > > >  drivers/usb/musb/musb_host.c |  79 ++++--
> > > >  drivers/usb/musb/musb_regs.h |   6 +
> > > >  drivers/usb/musb/musbhsdma.c |  34 ++-
> > > >  9 files changed, 671 insertions(+), 31 deletions(-)
> > > >  create mode 100644 drivers/usb/musb/mediatek.c
> > > > 
> > > > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > > > index ad08895..540fc9f 100644
> > > > --- a/drivers/usb/musb/Kconfig
> > > > +++ b/drivers/usb/musb/Kconfig
> > > > @@ -115,6 +115,12 @@ config USB_MUSB_JZ4740
> > > >  	depends on USB_MUSB_GADGET
> > > >  	depends on USB_OTG_BLACKLIST_HUB
> > > >  
> > > > +config USB_MUSB_MEDIATEK
> > > > +	tristate "MediaTek platforms"
> > > > +	depends on ARCH_MEDIATEK
> > > 
> > > Please also add '|| COMPILE_TEST' to make testing easier.
> > 
> > Ok
> > 
> > > > +	depends on NOP_USB_XCEIV
> > > > +	depends on GENERIC_PHY
> > > > +
> > > >  config USB_MUSB_AM335X_CHILD
> > > >  	tristate
> > > >  
> > > > @@ -141,7 +147,7 @@ config USB_UX500_DMA
> > > >  
> > > >  config USB_INVENTRA_DMA
> > > >  	bool 'Inventra'
> > > > -	depends on USB_MUSB_OMAP2PLUS
> > > > +	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_MEDIATEK
> > > >  	help
> > > >  	  Enable DMA transfers using Mentor's engine.
> > > >  
> > > > diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
> > > > index 3a88c79..63d82d0 100644
> > > > --- a/drivers/usb/musb/Makefile
> > > > +++ b/drivers/usb/musb/Makefile
> > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
> > > >  obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
> > > >  obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
> > > >  obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
> > > > +obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= mediatek.o
> > > >  
> > > >  
> > > >  obj-$(CONFIG_USB_MUSB_AM335X_CHILD)		+= musb_am335x.o
> > > > diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> > > > new file mode 100644
> > > > index 0000000..15a6460
> > > > --- /dev/null
> > > > +++ b/drivers/usb/musb/mediatek.c
> > > 
> > > [snip]
> > > I will review this section later after we sorted out other things.
> > > 
> > > > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > > > index b7d5627..d60f76f 100644
> > > > --- a/drivers/usb/musb/musb_core.c
> > > > +++ b/drivers/usb/musb/musb_core.c
> > > > @@ -1028,6 +1028,16 @@ static void musb_disable_interrupts(struct musb *musb)
> > > >  	temp = musb_readb(mbase, MUSB_INTRUSB);
> > > >  	temp = musb_readw(mbase, MUSB_INTRTX);
> > > >  	temp = musb_readw(mbase, MUSB_INTRRX);
> > > > +
> > > > +	/*  MediaTek controller interrupt status is W1C */
> > > 
> > > This W1C doesn't match to the MUSB Programming Guide that I have. Those
> > > registers are read-only.
> > > Is the difference due to the IP intergration in the mtk platforms? or is
> > > it a new version of the MUSB controller? If latter, what is the version?
> > 
> > This is difference due to the IP intergration in mtk platforms. W1C is
> > easy for CpdeViser debug.
> > 
> > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > 
> > > Basically we don't want to use this type of platform specific quirks if
> > > possible, so let's try to not use it.
> > 
> > I will try my best to avoid using it.
> 
> Thanks.
> 
> > 
> > > > +		musb_writeb(mbase, MUSB_INTRUSB,
> > > > +			musb_readb(mbase, MUSB_INTRUSB));
> > > 
> > > For this clearing register bit operation, please create platform hooks
> > > musb_clearb() and musb_clearw() in struct musb_platform_ops instead,
> > > then follow how musb_readb() pointer is assigned in
> > > musb_init_controller() to use the W1C version for mtk platform.
> > 
> > I have tried implementing musb_readb(), musb_readw() interface with
> > interrupt status W1C function in struct musb_platform_ops. But this
> > interface will require a global variable to hold MAC basic address for
> > judgment, and then special handling of the interrupt state. A global
> > variable will make the driver work with only a single instance, so it
> > can't work on some MTK platforms which have two instances.
> 
> I didn't mean to modify musb_read*(), but
> 
> > How about creating musb_clearb/w() as following:
> > void (*clearb)(void __iomem *addr, unsigned offset, u8 data);
> > void (*clearw)(void __iomem *addr, unsigned offset, u16 data);
> 
> this is what I was asking for, similar to what musb_readb/w() is
> implemented.

I will prepare a patch for musb_clearb/w().

> > 
> > 
> > > > +		musb_writew(mbase, MUSB_INTRRX,
> > > > +			musb_readw(mbase, MUSB_INTRRX));
> > > > +		musb_writew(mbase, MUSB_INTRTX,
> > > > +			musb_readw(mbase, MUSB_INTRTX));
> > > > +	}
> > > >  }
> > > >  
> > > >  static void musb_enable_interrupts(struct musb *musb)
> > > > diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> > > > index 04203b7..1bf4e9a 100644
> > > > --- a/drivers/usb/musb/musb_core.h
> > > > +++ b/drivers/usb/musb/musb_core.h
> > > > @@ -138,6 +138,7 @@ enum musb_g_ep0_state {
> > > >   */
> > > >  struct musb_platform_ops {
> > > >  
> > > > +#define MUSB_MTK_QUIRKS	BIT(10)
> > > >  #define MUSB_G_NO_SKB_RESERVE	BIT(9)
> > > >  #define MUSB_DA8XX		BIT(8)
> > > >  #define MUSB_PRESERVE_SESSION	BIT(7)
> > > > diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> > > > index 281e75d3..b218210 100644
> > > > --- a/drivers/usb/musb/musb_dma.h
> > > > +++ b/drivers/usb/musb/musb_dma.h
> > > > @@ -197,6 +197,7 @@ static inline void musb_dma_controller_destroy(struct dma_controller *d) { }
> > > >  extern struct dma_controller *
> > > >  musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
> > > >  extern void musbhs_dma_controller_destroy(struct dma_controller *c);
> > > > +extern irqreturn_t dma_controller_irq(int irq, void *private_data);
> > > >  
> > > >  extern struct dma_controller *
> > > >  tusb_dma_controller_create(struct musb *musb, void __iomem *base);
> > > > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > > > index b59ce9a..b1b0216 100644
> > > > --- a/drivers/usb/musb/musb_host.c
> > > > +++ b/drivers/usb/musb/musb_host.c
> > > > @@ -292,20 +292,73 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
> > > >  {
> > > >  	void __iomem		*epio = qh->hw_ep->regs;
> > > >  	u16			csr;
> > > > +	struct musb *musb = qh->hw_ep->musb;
> > > >  
> > > >  	/*
> > > >  	 * FIXME: the current Mentor DMA code seems to have
> > > >  	 * problems getting toggle correct.
> > > >  	 */
> > > >  
> > > > -	if (is_in)
> > > > -		csr = musb_readw(epio, MUSB_RXCSR) & MUSB_RXCSR_H_DATATOGGLE;
> > > > -	else
> > > > -		csr = musb_readw(epio, MUSB_TXCSR) & MUSB_TXCSR_H_DATATOGGLE;
> > > > +	/* MediaTek controller has private toggle register */
> > > 
> > > only one toggle register for all endpoints? how does it handle
> > > difference toggle values for different endpoints?
> > 
> > MediaTek controller has separate registers to describe TX/RX toggle.
> 
> Is it one register per endpoint?

MUSB_RXTOG/MUSB_TXTOG is common register, each bit reflects the toggle
state of an endpoint. bit[0] not used,bit[1~8] corresponds to ep[1~8]

> > 
> > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > > +		u16 toggle;
> > > > +		u8 epnum = qh->hw_ep->epnum;
> > > > +
> > > > +		if (is_in)
> > > > +			toggle = musb_readl(musb->mregs, MUSB_RXTOG);
> 
> this line seems telling there is just *one* register for all endpoints.

Yes, all endpoint share this register, endpoint and bit are one-to-one
correspondence.

> > > 
> > > should use musb_readw() instead? MUSB_RXTOG seems to be 16bit.
> > 
> > Ok
> > 
> > > > +		else
> > > > +			toggle = musb_readl(musb->mregs, MUSB_TXTOG);
> > > > +
> > > > +		csr = toggle & (1 << epnum);
> > > > +	} else {
> > > > +		if (is_in)
> > > > +			csr = musb_readw(epio, MUSB_RXCSR)
> > > > +				& MUSB_RXCSR_H_DATATOGGLE;
> > > > +		else
> > > > +			csr = musb_readw(epio, MUSB_TXCSR)
> > > > +				& MUSB_TXCSR_H_DATATOGGLE;
> > > 
> > > Does this logic still work for the mtk platform even if it has its own
> > > private toggle register? If so, we don't need to change here.
> > 
> > Sorry, this logic can not work on mtk platform, bit
> > MUSB_RXCSR_H_DATATOGGLE and MUSB_TXCSR_H_DATATOGGLE are used for other
> > function.
> 
> Is there a different controller RTL version we can use to
> differentiate?

Sorry, there is no controller RTL version can be used to indicate the
differences.

> > 
> > > If not, let's try to not use this quirk flag. Please create a hook
> > > musb_platform_get_toggle() in struct musb_platform_ops.
> > 
> > Does the method of implement musb_platform_get_toggle() is prepare
> > musb_default_get_toggle with common function, then follow how
> > musb_readb() pointer is assigned in musb_init_controller()?
> 
> Yes, similar to musb_readb() implementation.

OK.

> > How about creating musb_platform_get_toggle() as following:
> > u16 (*get_toggle)(struct musb* musb, struct musb_qh *qh, int is_in);
> 
> yes, it is part of the implementation, then add it in struct musb_io.

I will prepare a patch for (*get_toggle).

> > 
> > > > +	}
> > > >  
> > > >  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
> > > >  }
> > > >  
> > > > +static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
> > > > +					struct urb *urb)
> > > > +{
> > > > +	u16 csr = 0;
> > > > +	u16 toggle = 0;
> > > > +	struct musb *musb = qh->hw_ep->musb;
> > > > +	u8 epnum = qh->hw_ep->epnum;
> > > > +
> > > > +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> > > > +
> > > > +	/* MediaTek controller has private toggle register */
> > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > > +		if (is_in) {
> > > > +			musb_writel(musb->mregs, MUSB_RXTOGEN, (1 << epnum));
> > > > +			musb_writel(musb->mregs, MUSB_RXTOG, (toggle << epnum));
> > > > +		} else {
> > > > +			musb_writel(musb->mregs, MUSB_TXTOGEN, (1 << epnum));
> > > > +			musb_writel(musb->mregs, MUSB_TXTOG, (toggle << epnum));
> > > > +		}
> > > > +	} else {
> > > > +		if (is_in) {
> > > > +			if (toggle)
> > > > +				csr = MUSB_RXCSR_H_WR_DATATOGGLE
> > > > +						| MUSB_RXCSR_H_DATATOGGLE;
> > > > +			else
> > > > +				csr = 0;
> > > > +		} else {
> > > > +			if (toggle)
> > > > +				csr |= MUSB_TXCSR_H_WR_DATATOGGLE
> > > > +						| MUSB_TXCSR_H_DATATOGGLE;
> > > > +			else
> > > > +				csr |= MUSB_TXCSR_CLRDATATOG;
> 
> '? :' operation probably is better than 'if else' here.

OK.

> > > > +		}
> > > > +	}
> > > > +	return csr;
> > > 
> > > Please create a seperate patch for this musb_set_toggle() without adding
> > > the mtk logic. It is a nice cleanup.
> > 
> > Does this like get toggle implementation, create a hook
> > musb_platform_set_toggle() in struct musb_platform_ops?
> 
> You did the code cleanup by creating musb_set_toggle(), please make it
> in a separate patch, like
> 
> static u16 musb_set_toggle(struct musb_qh *qh, int is_in, struct urb *urb)
> {
> 	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> 	if (is_in)
> 		csr = toggle ? 
> 			(MUSB_RXCSR_H_WR_DATATOGGLE | MUSB_RXCSR_H_DATATOGGLE) :
> 			0;
> 	else
> 		csr = toggle ?
> 			MUSB_TXCSR_H_WR_DATATOGGLE | MUSB_TXCSR_H_DATATOGGLE :
> 			MUSB_TXCSR_CLRDATATOG;
> 	return csr;
> }
> 
> /* use musb_set_toggle() in the two instances */
> 
> then in this patch you add the mtk implementation similar as
> *get_toggle() discussed above.

OK.

> > 
> > > > +}
> > > > +
> > > >  /*
> > > >   * Advance this hardware endpoint's queue, completing the specified URB and
> > > >   * advancing to either the next URB queued to that qh, or else invalidating
> > > > @@ -772,13 +825,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> > > >  					);
> > > >  			csr |= MUSB_TXCSR_MODE;
> > > >  
> > > > -			if (!hw_ep->tx_double_buffered) {
> > > > -				if (usb_gettoggle(urb->dev, qh->epnum, 1))
> > > > -					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
> > > > -						| MUSB_TXCSR_H_DATATOGGLE;
> > > > -				else
> > > > -					csr |= MUSB_TXCSR_CLRDATATOG;
> > > > -			}
> > > > +			if (!hw_ep->tx_double_buffered)
> > > > +				csr |= musb_set_toggle(qh, !is_out, urb);
> > > >  
> > > >  			musb_writew(epio, MUSB_TXCSR, csr);
> > > >  			/* REVISIT may need to clear FLUSHFIFO ... */
> > > > @@ -860,17 +908,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> > > >  
> > > >  	/* IN/receive */
> > > >  	} else {
> > > > -		u16	csr;
> > > > +		u16	csr = 0;
> > > >  
> > > >  		if (hw_ep->rx_reinit) {
> > > >  			musb_rx_reinit(musb, qh, epnum);
> > > > +			csr |= musb_set_toggle(qh, !is_out, urb);
> > > >  
> > > > -			/* init new state: toggle and NYET, maybe DMA later */
> > > > -			if (usb_gettoggle(urb->dev, qh->epnum, 0))
> > > > -				csr = MUSB_RXCSR_H_WR_DATATOGGLE
> > > > -					| MUSB_RXCSR_H_DATATOGGLE;
> > > > -			else
> > > > -				csr = 0;
> > > >  			if (qh->type == USB_ENDPOINT_XFER_INT)
> > > >  				csr |= MUSB_RXCSR_DISNYET;
> > > >  
> > > > diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
> > > > index 5cd7264..ffbe267 100644
> > > > --- a/drivers/usb/musb/musb_regs.h
> > > > +++ b/drivers/usb/musb/musb_regs.h
> > > > @@ -273,6 +273,12 @@
> > > >  #define MUSB_RXHUBADDR		0x06
> > > >  #define MUSB_RXHUBPORT		0x07
> > > >  
> > > > +/* MediaTek controller toggle enable and status reg */
> > > > +#define MUSB_RXTOG		0x80
> > > > +#define MUSB_RXTOGEN		0x82
> > > > +#define MUSB_TXTOG		0x84
> > > > +#define MUSB_TXTOGEN		0x86
> > > 
> > > Again, these offsets are for different registers in the MUSB version I
> > > have, please let me know if you have different version of the MUSB IP.
> > 
> > Sorry, these are MediaTek controller private registers used for control
> > toggle.
> 
> Okay. Once the platform get/set_toggle() are implemented, those
> registers can be defined in the mtk glue driver instead of here.

OK.

> Regards,
> -Bin.


