Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042750-2-5703582495598741783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042749; b=pHDDJHQLVQX3p+S1xgfSK5XAcUehNto71giCCUabJy4wCrm
    ORgn+0UuqPjzwry7t/dqKoKSpNvWzxms8vHamhmk00JWD7AytysMCGvn/Q1ErIop
    mKtz1h1fgVi/UbwyZGrurAScyW2kevg9NT+UY0Nswjedk2wm7U4t7rNGTzx0AqMM
    Ug9mBXoknTXv7BSKkG4YgXl+snk80uURf0vJhsKB7txnlgFMGmYJ5E/5M1+5jcwW
    zI9CO4DPcItyG2pp+dR6miQg/dZ56jzHrJw91JZ1isWl8S/hayWm9R0eN2oAWNwp
    AwtopaaWGwDnkcq2uCGhsZQmDwgLBb3bXwAsNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042749;
    bh=/ND0jPcY+ko/0qxpCzTucSA1pOMmmP9KdmKiJwxsX0o=; b=rgVsjtUkbRPn
    XfPHtRD6CWhLbPl3AuVv7Ci+x8y5WZMQt9l+B27hB1fcP06wj9pY9FJt7WoiKXue
    GuKoZSJmKnoduoHB5NzMS9sKBDR0jevF1TiBa3NqNAkGDMMkz8eQ9/n4mmiLJDcU
    k527PuNOy3CEkluCUYdM2NsY3wOJsubxb6ZDLGkatmRA1WalzzQsO+kM4Wi6I1p4
    8CBzuDQ9t/qw2UI2XUTVkEmiT/Nd/iWqU49Ps6JTJIgPC+mYqqNBfaGFwOSqV6jr
    Ki7Vety2uAi99+WHnJE5WwE0QMASW5BNu4uG557wFrTSd0tv8n0WRSsBE1OhmN+D
    ywJXXVcWXw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeCNPwQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:52:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeCNPwO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 11:52:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 38/47] usb: musb: remove blackfin port
Date: Wed, 14 Mar 2018 16:35:51 +0100
Message-Id: <20180314153603.3127932-39-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:EKo1M9FA9v4uyUR5tTHNd7lgO5we7q1Fx9alv9aK6zsN66HFsWX
 4Vxl7QcKIzSMICzlqdGFzYxVb58YdJV53RjnFa2C7Ll/dYK50eAGaRx7U/Yr4ruuqTNyrgn
 b5VCYKRUjuysge7/rhH0h16hGla2QPFI6A0olsa9dnYzuYFGeUEXmhLOQcpQwd/T5eF+oie
 MfAb/J97CE9V+oBY42SLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TUvYnlmYCXU=:egKEqe6dUVON9RdQvh4upa
 2OkzxpSwdVqpileqvUh/NbDtEAmsFTSGbYS0A4zafjp8JNIDSu8Tb4Mg8eOa+shSkivhFy3jw
 6VPvntZ89hxO/VzL/f+1ahBJ7qdcILFiNNm7h3Oehp94YjEPxs1GQ6Qu8iGG8ex/9t68SCYTN
 25eM0d6Nq7AFaN4gb426UH7IQJ6F8JasPbYlhIYZ6uRdkLLuH6zWvuPOQ0oAv1u+Sbq1HAm3U
 2AWB2XcIe5e1mZxNUs4JzqAZrwqWqCseSmVq+7UegGHub4Ghmf8DxOIvmtsUL2DW06Sys5RmU
 UzQ+4ZITNriL5+gRXK7DTupC8zEh9QnH6k/OH1PkwbVh82wO/B6c6OBD1zPbAwojL3NdKINvx
 D/WbZLYTvgT0a2NmIp+U4zq98toLQTiS1NfNi768Q1dtxdUQGgS+ndGb7IxHtzshjn+oDQbhs
 7dmChGhkXTcdMPEvpW1rqo6578YBXhdvX/UHP6E3IlBmHcDu8woR52KCnoc2x0ve3ogyrrT0X
 1s4VN6oTMQx/vCN/rKLEUQuLvGuyDxvYhgG9CcP1pypll0Mbz4iefjgS4Cv9EBiQNmjgEkRBp
 LBM8lJvWMBYOH/surGepBBjetH+tZh78E4GpysBy7+epfqdYqRltX98oLiWxnYMWkEVJftE6z
 5OibW7fkKN2u8wFYXtR89tqsRb4mLwOx/U7fN8nz9Z+50cDFYyeLpdDwnGnN/CY0FajQLGQbm
 AicYIXq4RiLjZiapeVr/+kIEIowE9vcHGYMoCw==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so we can clean up
all the special cases in the musb driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/musb/Kconfig        |  10 +-
 drivers/usb/musb/Makefile       |   1 -
 drivers/usb/musb/blackfin.c     | 623 ----------------------------------------
 drivers/usb/musb/blackfin.h     |  81 ------
 drivers/usb/musb/musb_core.c    |   5 -
 drivers/usb/musb/musb_core.h    |  30 --
 drivers/usb/musb/musb_debugfs.c |   2 -
 drivers/usb/musb/musb_dma.h     |  11 -
 drivers/usb/musb/musb_gadget.c  |  35 ---
 drivers/usb/musb/musb_regs.h    | 182 ------------
 drivers/usb/musb/musbhsdma.c    |   5 -
 drivers/usb/musb/musbhsdma.h    |  64 -----
 include/linux/usb/musb.h        |   7 -
 13 files changed, 1 insertion(+), 1055 deletions(-)
 delete mode 100644 drivers/usb/musb/blackfin.c
 delete mode 100644 drivers/usb/musb/blackfin.h

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 5506a9c03c1f..490990e8b015 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -18,9 +18,6 @@ config USB_MUSB_HDRC
 	  Texas Instruments families using this IP include DaVinci
 	  (35x, 644x ...), OMAP 243x, OMAP 3, and TUSB 6010.
 
-	  Analog Devices parts using this IP include Blackfin BF54x,
-	  BF525 and BF527.
-
 	  Allwinner SoCs using this IP include A10, A13, A20, ...
 
 	  If you do not know what this is, please say N.
@@ -107,11 +104,6 @@ config USB_MUSB_DSPS
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on OF_IRQ
 
-config USB_MUSB_BLACKFIN
-	tristate "Blackfin"
-	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
-	depends on NOP_USB_XCEIV
-
 config USB_MUSB_UX500
 	tristate "Ux500 platforms"
 	depends on ARCH_U8500 || COMPILE_TEST
@@ -149,7 +141,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
+	depends on USB_MUSB_OMAP2PLUS
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 79d4d5439164..3a88c79e650c 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_USB_MUSB_DSPS)			+= musb_dsps.o
 obj-$(CONFIG_USB_MUSB_TUSB6010)			+= tusb6010.o
 obj-$(CONFIG_USB_MUSB_DAVINCI)			+= davinci.o
 obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
-obj-$(CONFIG_USB_MUSB_BLACKFIN)			+= blackfin.o
 obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
 obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
deleted file mode 100644
index 0a98dcd66d19..000000000000
diff --git a/drivers/usb/musb/blackfin.h b/drivers/usb/musb/blackfin.h
deleted file mode 100644
index 5b149915b0f8..000000000000
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c344ef4e5355..72bb03e7b751 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -126,7 +126,6 @@ EXPORT_SYMBOL_GPL(musb_get_mode);
 
 /*-------------------------------------------------------------------------*/
 
-#ifndef CONFIG_BLACKFIN
 static int musb_ulpi_read(struct usb_phy *phy, u32 reg)
 {
 	void __iomem *addr = phy->io_priv;
@@ -208,10 +207,6 @@ static int musb_ulpi_write(struct usb_phy *phy, u32 val, u32 reg)
 
 	return ret;
 }
-#else
-#define musb_ulpi_read		NULL
-#define musb_ulpi_write		NULL
-#endif
 
 static struct usb_phy_io_ops musb_ulpi_access = {
 	.read = musb_ulpi_read,
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 385841ee6f46..ac675b1a34c4 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -467,34 +467,6 @@ static inline char *musb_ep_xfertype_string(u8 type)
 	return s;
 }
 
-#ifdef CONFIG_BLACKFIN
-static inline int musb_read_fifosize(struct musb *musb,
-		struct musb_hw_ep *hw_ep, u8 epnum)
-{
-	musb->nr_endpoints++;
-	musb->epmask |= (1 << epnum);
-
-	if (epnum < 5) {
-		hw_ep->max_packet_sz_tx = 128;
-		hw_ep->max_packet_sz_rx = 128;
-	} else {
-		hw_ep->max_packet_sz_tx = 1024;
-		hw_ep->max_packet_sz_rx = 1024;
-	}
-	hw_ep->is_shared_fifo = false;
-
-	return 0;
-}
-
-static inline void musb_configure_ep0(struct musb *musb)
-{
-	musb->endpoints[0].max_packet_sz_tx = MUSB_EP0_FIFOSIZE;
-	musb->endpoints[0].max_packet_sz_rx = MUSB_EP0_FIFOSIZE;
-	musb->endpoints[0].is_shared_fifo = true;
-}
-
-#else
-
 static inline int musb_read_fifosize(struct musb *musb,
 		struct musb_hw_ep *hw_ep, u8 epnum)
 {
@@ -531,8 +503,6 @@ static inline void musb_configure_ep0(struct musb *musb)
 	musb->endpoints[0].max_packet_sz_rx = MUSB_EP0_FIFOSIZE;
 	musb->endpoints[0].is_shared_fifo = true;
 }
-#endif /* CONFIG_BLACKFIN */
-
 
 /***************************** Glue it together *****************************/
 
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 7cf5a1bbdaff..7dac456f7ebc 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -70,7 +70,6 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "DMA_CNTLch7",	0x274,	16 },
 	{ "DMA_ADDRch7",	0x278,	32 },
 	{ "DMA_COUNTch7",	0x27C,	32 },
-#ifndef CONFIG_BLACKFIN
 	{ "ConfigData",	MUSB_CONFIGDATA,8 },
 	{ "BabbleCtl",	MUSB_BABBLE_CTL,8 },
 	{ "TxFIFOsz",	MUSB_TXFIFOSZ,	8 },
@@ -79,7 +78,6 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "RxFIFOadd",	MUSB_RXFIFOADD,	16 },
 	{ "EPInfo",	MUSB_EPINFO,	8 },
 	{ "RAMInfo",	MUSB_RAMINFO,	8 },
-#endif
 	{  }	/* Terminating Entry */
 };
 
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index a4241f4d430e..0fc8cd0c2a5c 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -80,17 +80,6 @@ struct musb_hw_ep;
 #define	is_cppi_enabled(musb)	0
 #endif
 
-/* Anomaly 05000456 - USB Receive Interrupt Is Not Generated in DMA Mode 1
- *	Only allow DMA mode 1 to be used when the USB will actually generate the
- *	interrupts we expect.
- */
-#ifdef CONFIG_BLACKFIN
-# undef USE_MODE1
-# if !ANOMALY_05000456
-#  define USE_MODE1
-# endif
-#endif
-
 /*
  * DMA channel status ... updated by the dma controller driver whenever that
  * status changes, and protected by the overall controller spinlock.
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 293e5b8da565..58a41b54763b 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1680,40 +1680,6 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-#ifdef CONFIG_BLACKFIN
-static struct usb_ep *musb_match_ep(struct usb_gadget *g,
-		struct usb_endpoint_descriptor *desc,
-		struct usb_ss_ep_comp_descriptor *ep_comp)
-{
-	struct usb_ep *ep = NULL;
-
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_ISOC:
-	case USB_ENDPOINT_XFER_BULK:
-		if (usb_endpoint_dir_in(desc))
-			ep = gadget_find_ep_by_name(g, "ep5in");
-		else
-			ep = gadget_find_ep_by_name(g, "ep6out");
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		if (usb_endpoint_dir_in(desc))
-			ep = gadget_find_ep_by_name(g, "ep1in");
-		else
-			ep = gadget_find_ep_by_name(g, "ep2out");
-		break;
-	default:
-		break;
-	}
-
-	if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
-		return ep;
-
-	return NULL;
-}
-#else
-#define musb_match_ep NULL
-#endif
-
 static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int musb_gadget_stop(struct usb_gadget *g);
@@ -1727,7 +1693,6 @@ static const struct usb_gadget_ops musb_gadget_operations = {
 	.pullup			= musb_gadget_pullup,
 	.udc_start		= musb_gadget_start,
 	.udc_stop		= musb_gadget_stop,
-	.match_ep		= musb_match_ep,
 };
 
 /* ----------------------------------------------------------------------- */
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index a4beba184798..88466622c89f 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -195,8 +195,6 @@
 #define MUSB_HUBADDR_MULTI_TT		0x80
 
 
-#ifndef CONFIG_BLACKFIN
-
 /*
  * Common USB registers
  */
@@ -416,184 +414,4 @@ static inline u8 musb_read_txhubport(struct musb *musb, u8 epnum)
 			  musb->io.busctl_offset(epnum, MUSB_TXHUBPORT));
 }
 
-#else /* CONFIG_BLACKFIN */
-
-#define USB_BASE		USB_FADDR
-#define USB_OFFSET(reg)		(reg - USB_BASE)
-
-/*
- * Common USB registers
- */
-#define MUSB_FADDR		USB_OFFSET(USB_FADDR)	/* 8-bit */
-#define MUSB_POWER		USB_OFFSET(USB_POWER)	/* 8-bit */
-#define MUSB_INTRTX		USB_OFFSET(USB_INTRTX)	/* 16-bit */
-#define MUSB_INTRRX		USB_OFFSET(USB_INTRRX)
-#define MUSB_INTRTXE		USB_OFFSET(USB_INTRTXE)
-#define MUSB_INTRRXE		USB_OFFSET(USB_INTRRXE)
-#define MUSB_INTRUSB		USB_OFFSET(USB_INTRUSB)	/* 8 bit */
-#define MUSB_INTRUSBE		USB_OFFSET(USB_INTRUSBE)/* 8 bit */
-#define MUSB_FRAME		USB_OFFSET(USB_FRAME)
-#define MUSB_INDEX		USB_OFFSET(USB_INDEX)	/* 8 bit */
-#define MUSB_TESTMODE		USB_OFFSET(USB_TESTMODE)/* 8 bit */
-
-/*
- * Additional Control Registers
- */
-
-#define MUSB_DEVCTL		USB_OFFSET(USB_OTG_DEV_CTL)	/* 8 bit */
-
-#define MUSB_LINKINFO		USB_OFFSET(USB_LINKINFO)/* 8 bit */
-#define MUSB_VPLEN		USB_OFFSET(USB_VPLEN)	/* 8 bit */
-#define MUSB_HS_EOF1		USB_OFFSET(USB_HS_EOF1)	/* 8 bit */
-#define MUSB_FS_EOF1		USB_OFFSET(USB_FS_EOF1)	/* 8 bit */
-#define MUSB_LS_EOF1		USB_OFFSET(USB_LS_EOF1)	/* 8 bit */
-
-/* Offsets to endpoint registers */
-#define MUSB_TXMAXP		0x00
-#define MUSB_TXCSR		0x04
-#define MUSB_CSR0		MUSB_TXCSR	/* Re-used for EP0 */
-#define MUSB_RXMAXP		0x08
-#define MUSB_RXCSR		0x0C
-#define MUSB_RXCOUNT		0x10
-#define MUSB_COUNT0		MUSB_RXCOUNT	/* Re-used for EP0 */
-#define MUSB_TXTYPE		0x14
-#define MUSB_TYPE0		MUSB_TXTYPE	/* Re-used for EP0 */
-#define MUSB_TXINTERVAL		0x18
-#define MUSB_NAKLIMIT0		MUSB_TXINTERVAL	/* Re-used for EP0 */
-#define MUSB_RXTYPE		0x1C
-#define MUSB_RXINTERVAL		0x20
-#define MUSB_TXCOUNT		0x28
-
-/* Offsets to endpoint registers in indexed model (using INDEX register) */
-#define MUSB_INDEXED_OFFSET(_epnum, _offset)	\
-	(0x40 + (_offset))
-
-/* Offsets to endpoint registers in flat models */
-#define MUSB_FLAT_OFFSET(_epnum, _offset)	\
-	(USB_OFFSET(USB_EP_NI0_TXMAXP) + (0x40 * (_epnum)) + (_offset))
-
-/* Not implemented - HW has separate Tx/Rx FIFO */
-#define MUSB_TXCSR_MODE			0x0000
-
-static inline void musb_write_txfifosz(void __iomem *mbase, u8 c_size)
-{
-}
-
-static inline void musb_write_txfifoadd(void __iomem *mbase, u16 c_off)
-{
-}
-
-static inline void musb_write_rxfifosz(void __iomem *mbase, u8 c_size)
-{
-}
-
-static inline void  musb_write_rxfifoadd(void __iomem *mbase, u16 c_off)
-{
-}
-
-static inline void musb_write_ulpi_buscontrol(void __iomem *mbase, u8 val)
-{
-}
-
-static inline u8 musb_read_txfifosz(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16 musb_read_txfifoadd(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxfifosz(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16  musb_read_rxfifoadd(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_ulpi_buscontrol(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_configdata(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16 musb_read_hwvers(void __iomem *mbase)
-{
-	/*
-	 * This register is invisible on Blackfin, actually the MUSB
-	 * RTL version of Blackfin is 1.9, so just hardcode its value.
-	 */
-	return MUSB_HWVERS_1900;
-}
-
-static inline void musb_write_rxfunaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_req)
-{
-}
-
-static inline void musb_write_rxhubaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_h_addr_reg)
-{
-}
-
-static inline void musb_write_rxhubport(void __iomem *mbase, u8 epnum,
-		u8 qh_h_port_reg)
-{
-}
-
-static inline void  musb_write_txfunaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_reg)
-{
-}
-
-static inline void  musb_write_txhubaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_reg)
-{
-}
-
-static inline void  musb_write_txhubport(void __iomem *mbase, u8 epnum,
-		u8 qh_h_port_reg)
-{
-}
-
-static inline u8 musb_read_rxfunaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxhubaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxhubport(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8  musb_read_txfunaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8  musb_read_txhubaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_txhubport(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-#endif /* CONFIG_BLACKFIN */
-
 #endif	/* __MUSB_REGS_H__ */
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 21fb9e6622f3..4389fc3422bd 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -235,11 +235,6 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 
-#ifdef CONFIG_BLACKFIN
-	/* Clear DMA interrupt flags */
-	musb_writeb(mbase, MUSB_HSDMA_INTR, int_hsdma);
-#endif
-
 	if (!int_hsdma) {
 		musb_dbg(musb, "spurious DMA irq");
 
diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
index 44f7983df0a1..93665135aff1 100644
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -6,8 +6,6 @@
  * Copyright (C) 2005-2007 by Texas Instruments
  */
 
-#ifndef CONFIG_BLACKFIN
-
 #define MUSB_HSDMA_BASE		0x200
 #define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
 #define MUSB_HSDMA_CONTROL		0x4
@@ -34,68 +32,6 @@
 	musb_writel(mbase, \
 		    MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT), \
 		    len)
-#else
-
-#define MUSB_HSDMA_BASE		0x400
-#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
-#define MUSB_HSDMA_CONTROL		0x04
-#define MUSB_HSDMA_ADDR_LOW		0x08
-#define MUSB_HSDMA_ADDR_HIGH		0x0C
-#define MUSB_HSDMA_COUNT_LOW		0x10
-#define MUSB_HSDMA_COUNT_HIGH		0x14
-
-#define MUSB_HSDMA_CHANNEL_OFFSET(_bchannel, _offset)		\
-		(MUSB_HSDMA_BASE + (_bchannel * 0x20) + _offset)
-
-static inline u32 musb_read_hsdma_addr(void __iomem *mbase, u8 bchannel)
-{
-	u32 addr = musb_readw(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_HIGH));
-
-	addr = addr << 16;
-
-	addr |= musb_readw(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_LOW));
-
-	return addr;
-}
-
-static inline void musb_write_hsdma_addr(void __iomem *mbase,
-				u8 bchannel, dma_addr_t dma_addr)
-{
-	musb_writew(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_LOW),
-		dma_addr);
-	musb_writew(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_HIGH),
-		(dma_addr >> 16));
-}
-
-static inline u32 musb_read_hsdma_count(void __iomem *mbase, u8 bchannel)
-{
-	u32 count = musb_readw(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_HIGH));
-
-	count = count << 16;
-
-	count |= musb_readw(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_LOW));
-
-	return count;
-}
-
-static inline void musb_write_hsdma_count(void __iomem *mbase,
-				u8 bchannel, u32 len)
-{
-	musb_writew(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_LOW),len);
-	musb_writew(mbase,
-		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_HIGH),
-		(len >> 16));
-}
-
-#endif /* CONFIG_BLACKFIN */
-
 /* control register (16-bit): */
 #define MUSB_HSDMA_ENABLE_SHIFT		0
 #define MUSB_HSDMA_TRANSMIT_SHIFT	1
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 5d19e6730475..9eb908a98033 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -89,13 +89,6 @@ struct musb_hdrc_config {
 	u8		ram_bits;	/* ram address size */
 
 	struct musb_hdrc_eps_bits *eps_bits __deprecated;
-#ifdef CONFIG_BLACKFIN
-	/* A GPIO controlling VRSEL in Blackfin */
-	unsigned int	gpio_vrsel;
-	unsigned int	gpio_vrsel_active;
-	/* musb CLKIN in Blackfin in MHZ */
-	unsigned char   clkin;
-#endif
 	u32		maximum_speed;
 };
 
-- 
2.9.0

