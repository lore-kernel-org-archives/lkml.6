Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330738-1519731048-2-4896230167125134515
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519731047; b=lh+ANLrhoMWRGo5CBxvtAIzUQmu2efEhf6dhOwysEHJuUZu
    aByvjBu/axPrwFn+E4Aj41d+83oy0fUli1anhk9s+tnPK/KbWP1dAN142YObE/E3
    1/D3KLuq4tsJmZ5PLMJYSnyPClAmZJnJC47L6hO3Z8YHOnLDkDE+zjlBpoY4Bhek
    MlbZlmxC1ylPgR5yn86tutjv22yzg8iFaL/qdhffhb5crKEZMXAmgEjVqOM2mUXM
    jX7Dvax5DZ4y+hXEjYBCQBA/o4acY9+EXRMmT2dZmVTOdX0uGe+M5M3bxSlNvy9l
    1n2ceYybXLjR7hsyzVVmTVIF+pskRSg+7idUIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519731047; bh=MqmSAE0FOwJZ2wHFgv5JO9/50W
    IR70QglOS3qZy+0Gc=; b=SUzQQoADaijWJa38xbQ8oYEo2tLGl0W8uAnLIDuS8w
    iYT3EKAvpvoEvEHinhUH7aFUMEdh+No0wkR/Nb/8LsBhKVO/23Lyn/zpIukxfEJS
    DSKfLVjEDzkPIKzW9SCuUVlOOUDGhAucWM0dDTavyjGy5jv+PKhK5V0chNhJemfW
    1wPZQ8Y8HvylbXJWfuosgAI5DN6WpKLWAd7Ewe3hxfERboFPEm9gaqFmxAdiIovn
    zw6ww3UhtzgZKtvVu0N1DeWtTu7XCfA/hRN3tcpdAj+U7fI0lbT9C9GYcv6FbRnD
    RshW0Gc5gYM6OA7SP7Iy3Kccy4+48ge3k79yxUDUeyOw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=i4JptBnz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=i4JptBnz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeB0La1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:30:27 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:13419 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeB0La0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:30:26 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/2] usb: dwc3: add dual role support using OTG block
Date: Tue, 27 Feb 2018 13:30:19 +0200
Message-ID: <1519731019-2220-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519730952-2102-1-git-send-email-rogerq@ti.com>
References: <1519730952-2102-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is useful on platforms (e.g. TI AM437x) that don't
have ID available on a GPIO but do have the OTG block.

We can obtain the ID state via the OTG block and use it
for dual-role switching.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c |  67 ++++++-
 drivers/usb/dwc3/core.h |  29 +++
 drivers/usb/dwc3/drd.c  | 489 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 557 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index df4569d..397a4d4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -89,10 +89,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
-static void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
-static int dwc3_event_buffers_setup(struct dwc3 *dwc);
-
-static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -110,16 +107,19 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->desired_dr_role)
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		dwc3_otg_update(dwc, 0);
+
+	if (!dwc->desired_dr_role)
 		return;
 
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
+	if (dwc->desired_dr_role == dwc->current_dr_role)
 		return;
 
-	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG)
+	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
 		return;
 
 	switch (dwc->current_dr_role) {
@@ -130,6 +130,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		dwc3_gadget_exit(dwc);
 		dwc3_event_buffers_cleanup(dwc);
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_otg_update(dwc, 1);
+		break;
 	default:
 		break;
 	}
@@ -165,9 +172,14 @@ static void __dwc3_set_mode(struct work_struct *work)
 		if (ret)
 			dev_err(dwc->dev, "failed to initialize peripheral\n");
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_init(dwc);
+		dwc3_otg_update(dwc, 0);
+		break;
 	default:
 		break;
 	}
+
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -351,7 +363,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
  *
  * Returns 0 on success otherwise negative errno.
  */
-static int dwc3_event_buffers_setup(struct dwc3 *dwc)
+int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -368,7 +380,7 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 	return 0;
 }
 
-static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -1329,6 +1341,20 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		if (!PMSG_IS_AUTO(msg))
 			dwc3_core_exit(dwc);
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* do nothing during runtime_suspend */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_gadget_suspend(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+
+		dwc3_otg_exit(dwc);
+		dwc3_core_exit(dwc);
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1360,6 +1386,27 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 				return ret;
 		}
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* nothing to do on runtime_resume */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		ret = dwc3_core_init(dwc);
+		if (ret)
+			return ret;
+
+		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+
+		dwc3_otg_init(dwc);
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
+			dwc3_otg_host_init(dwc);
+		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_gadget_resume(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+
+		break;
 	default:
 		/* do nothing */
 		break;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 0d4c698..09243a6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -58,6 +58,11 @@
 #define DWC3_DEVICE_EVENT_CMD_CMPL		10
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
+/* Controller's role while using the OTG block */
+#define DWC3_OTG_ROLE_IDLE	0
+#define DWC3_OTG_ROLE_HOST	1
+#define DWC3_OTG_ROLE_DEVICE	2
+
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
 #define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
@@ -863,6 +868,10 @@ struct dwc3_scratchpad_array {
  * @regs_size: address space size
  * @fladj: frame length adjustment
  * @irq_gadget: peripheral controller's IRQ number
+ * @otg_irq: IRQ number for OTG IRQs
+ * @current_otg_role: current role of operation while using the OTG block
+ * @desired_otg_role: desired role of operation while using the OTG block
+ * @otg_restart_host: flag that OTG controller needs to restart host
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
@@ -996,6 +1005,10 @@ struct dwc3 {
 
 	u32			fladj;
 	u32			irq_gadget;
+	u32			otg_irq;
+	u32			current_otg_role;
+	u32			desired_otg_role;
+	bool			otg_restart_host;
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
@@ -1257,6 +1270,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
@@ -1274,6 +1288,9 @@ static inline bool dwc3_is_usb31(struct dwc3 *dwc)
 
 bool dwc3_has_imod(struct dwc3 *dwc);
 
+int dwc3_event_buffers_setup(struct dwc3 *dwc);
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
@@ -1317,11 +1334,23 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_drd_init(struct dwc3 *dwc);
 void dwc3_drd_exit(struct dwc3 *dwc);
+void dwc3_otg_init(struct dwc3 *dwc);
+void dwc3_otg_exit(struct dwc3 *dwc);
+void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus);
+void dwc3_otg_host_init(struct dwc3 *dwc);
 #else
 static inline int dwc3_drd_init(struct dwc3 *dwc)
 { return 0; }
 static inline void dwc3_drd_exit(struct dwc3 *dwc)
 { }
+static inline void dwc3_otg_init(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_exit(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
+{ }
+static inline void dwc3_otg_host_init(struct dwc3 *dwc)
+{ }
 #endif
 
 /* power management interface */
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index cc8ab9a..1d8c557 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,22 +8,423 @@
  */
 
 #include <linux/extcon.h>
+#include <linux/platform_device.h>
 
 #include "debug.h"
 #include "core.h"
 #include "gadget.h"
 
-static void dwc3_drd_update(struct dwc3 *dwc)
+static void dwc3_otg_disable_events(struct dwc3 *dwc, u32 disable_mask)
+{
+	u32 reg = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+
+	reg &= ~(disable_mask);
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, reg);
+}
+
+static void dwc3_otg_enable_events(struct dwc3 *dwc, u32 enable_mask)
+{
+	u32 reg = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+
+	reg |= (enable_mask);
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, reg);
+}
+
+static void dwc3_otg_clear_events(struct dwc3 *dwc)
+{
+	u32 reg = dwc3_readl(dwc->regs, DWC3_OEVT);
+
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, reg);
+}
+
+#define DWC3_OTG_ALL_EVENTS	(DWC3_OEVTEN_XHCIRUNSTPSETEN | \
+		DWC3_OEVTEN_DEVRUNSTPSETEN | DWC3_OEVTEN_HIBENTRYEN | \
+		DWC3_OEVTEN_CONIDSTSCHNGEN | DWC3_OEVTEN_HRRCONFNOTIFEN | \
+		DWC3_OEVTEN_HRRINITNOTIFEN | DWC3_OEVTEN_ADEVIDLEEN | \
+		DWC3_OEVTEN_ADEVBHOSTENDEN | DWC3_OEVTEN_ADEVHOSTEN | \
+		DWC3_OEVTEN_ADEVHNPCHNGEN | DWC3_OEVTEN_ADEVSRPDETEN | \
+		DWC3_OEVTEN_ADEVSESSENDDETEN | DWC3_OEVTEN_BDEVBHOSTENDEN | \
+		DWC3_OEVTEN_BDEVHNPCHNGEN | DWC3_OEVTEN_BDEVSESSVLDDETEN | \
+		DWC3_OEVTEN_BDEVVBUSCHNGEN)
+
+static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
 {
+	struct dwc3 *dwc = _dwc;
+
+	spin_lock(&dwc->lock);
+	if (dwc->otg_restart_host) {
+		dwc3_otg_host_init(dwc);
+		dwc->otg_restart_host = 0;
+	}
+
+	spin_unlock(&dwc->lock);
+
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
+{
+	u32 reg;
+	struct dwc3 *dwc = _dwc;
+	irqreturn_t ret = IRQ_NONE;
+
+	reg = dwc3_readl(dwc->regs, DWC3_OEVT);
+	if (reg) {
+		/* ignore non OTG events, we can't disable them in OEVTEN */
+		if (!(reg & DWC3_OTG_ALL_EVENTS)) {
+			dwc3_writel(dwc->regs, DWC3_OEVT, reg);
+			return IRQ_NONE;
+		}
+
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST &&
+		    !(reg & DWC3_OEVT_DEVICEMODE))
+			dwc->otg_restart_host = 1;
+		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	return ret;
+}
+
+static void dwc3_otgregs_init(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/*
+	 * Prevent host/device reset from resetting OTG core.
+	 * If we don't do this then xhci_reset (USBCMD.HCRST) will reset
+	 * the signal outputs sent to the PHY, the OTG FSM logic of the
+	 * core and also the resets to the VBUS filters inside the core.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	reg |= DWC3_OCFG_SFTRSTMASK;
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+
+	/* Disable hibernation for simplicity */
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~DWC3_GCTL_GBLHIBERNATIONEN;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	/*
+	 * Initialize OTG registers as per
+	 * Figure 11-4 OTG Driver Overall Programming Flow
+	 */
+	/* OCFG.SRPCap = 0, OCFG.HNPCap = 0 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	reg &= ~(DWC3_OCFG_SRPCAP | DWC3_OCFG_HNPCAP);
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+	/* OEVT = FFFF */
+	dwc3_otg_clear_events(dwc);
+	/* OEVTEN = 0 */
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/* OEVTEN.ConIDStsChngEn = 1. Instead we enable all events */
+	dwc3_otg_enable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/*
+	 * OCTL.PeriMode = 1, OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0,
+	 * OCTL.HNPReq = 0
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg |= DWC3_OCTL_PERIMODE;
+	reg &= ~(DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN |
+		 DWC3_OCTL_HNPREQ);
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+}
+
+static int dwc3_otg_get_irq(struct dwc3 *dwc)
+{
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+	int irq;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "otg");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq(dwc3_pdev, 0);
+	if (irq > 0)
+		goto out;
+
+	if (irq != -EPROBE_DEFER)
+		dev_err(dwc->dev, "missing OTG IRQ\n");
+
+	if (!irq)
+		irq = -EINVAL;
+
+out:
+	return irq;
+}
+
+void dwc3_otg_init(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/*
+	 * As per Figure 11-4 OTG Driver Overall Programming Flow,
+	 * block "Initialize GCTL for OTG operation".
+	 */
+	/* GCTL.PrtCapDir=2'b11 */
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	/* GUSB2PHYCFG0.SusPHY=0 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+	/* Initialize OTG registers */
+	dwc3_otgregs_init(dwc);
+}
+
+void dwc3_otg_exit(struct dwc3 *dwc)
+{
+	/* disable all OTG IRQs */
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/* clear all events */
+	dwc3_otg_clear_events(dwc);
+}
+
+/* should be called before Host controller driver is started */
+void dwc3_otg_host_init(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/* As per Figure 11-10 A-Device Flow Diagram */
+	/* OCFG.HNPCap = 0, OCFG.SRPCap = 0. Already 0 */
+
+	/*
+	 * OCTL.PeriMode=0, OCTL.TermSelDLPulse = 0,
+	 * OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg &= ~(DWC3_OCTL_PERIMODE | DWC3_OCTL_TERMSELIDPULSE |
+			DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN);
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+
+	/*
+	 * OCFG.DisPrtPwrCutoff = 0/1
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	reg &= ~DWC3_OCFG_DISPWRCUTTOFF;
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+
+	/*
+	 * OCFG.SRPCap = 1, OCFG.HNPCap = GHWPARAMS6.HNP_CAP
+	 * We don't want SRP/HNP for simple dual-role so leave
+	 * these disabled.
+	 */
+
+	/*
+	 * OEVTEN.OTGADevHostEvntEn = 1
+	 * OEVTEN.OTGADevSessEndDetEvntEn = 1
+	 * We don't want HNP/role-swap so leave these disabled.
+	 */
+
+	/* GUSB2PHYCFG.ULPIAutoRes = 1/0, GUSB2PHYCFG.SusPHY = 1 */
+	if (!dwc->dis_u2_susphy_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
+	/* Set Port Power to enable VBUS: OCTL.PrtPwrCtl = 1 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg |= DWC3_OCTL_PRTPWRCTL;
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+}
+
+/* should be called after Host controller driver is stopped */
+static void dwc3_otg_host_exit(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/*
+	 * Exit from A-device flow as per
+	 * Figure 11-4 OTG Driver Overall Programming Flow
+	 */
+
+	/*
+	 * OEVTEN.OTGADevBHostEndEvntEn=0, OEVTEN.OTGADevHNPChngEvntEn=0
+	 * OEVTEN.OTGADevSessEndDetEvntEn=0,
+	 * OEVTEN.OTGADevHostEvntEn = 0
+	 * But we don't disable any OTG events
+	 */
+
+	/* OCTL.HstSetHNPEn = 0, OCTL.PrtPwrCtl=0 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg &= ~(DWC3_OCTL_HSTSETHNPEN | DWC3_OCTL_PRTPWRCTL);
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+}
+
+/* should be called before the gadget controller driver is started */
+static void dwc3_otg_device_init(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/* As per Figure 11-20 B-Device Flow Diagram */
+
+	/*
+	 * OCFG.HNPCap = GHWPARAMS6.HNP_CAP, OCFG.SRPCap = 1
+	 * but we keep them 0 for simple dual-role operation.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	/* OCFG.OTGSftRstMsk = 0/1 */
+	reg |= DWC3_OCFG_SFTRSTMASK;
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+	/*
+	 * OCTL.PeriMode = 1
+	 * OCTL.TermSelDLPulse = 0/1, OCTL.HNPReq = 0
+	 * OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg |= DWC3_OCTL_PERIMODE;
+	reg &= ~(DWC3_OCTL_TERMSELIDPULSE | DWC3_OCTL_HNPREQ |
+			DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN);
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+	/* OEVTEN.OTGBDevSesVldDetEvntEn = 1 */
+	dwc3_otg_enable_events(dwc, DWC3_OEVTEN_BDEVSESSVLDDETEN);
+	/* GUSB2PHYCFG.ULPIAutoRes = 0, GUSB2PHYCFG0.SusPHY = 1 */
+	if (!dwc->dis_u2_susphy_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+	/* GCTL.GblHibernationEn = 0. Already 0. */
+}
+
+/* should be called after the gadget controller driver is stopped */
+static void dwc3_otg_device_exit(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/*
+	 * Exit from B-device flow as per
+	 * Figure 11-4 OTG Driver Overall Programming Flow
+	 */
+
+	/*
+	 * OEVTEN.OTGBDevHNPChngEvntEn = 0
+	 * OEVTEN.OTGBDevVBusChngEvntEn = 0
+	 * OEVTEN.OTGBDevBHostEndEvntEn = 0
+	 */
+	dwc3_otg_disable_events(dwc, DWC3_OEVTEN_BDEVHNPCHNGEN |
+				DWC3_OEVTEN_BDEVVBUSCHNGEN |
+				DWC3_OEVTEN_BDEVBHOSTENDEN);
+
+	/* OCTL.DevSetHNPEn = 0, OCTL.HNPReq = 0, OCTL.PeriMode=1 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg &= ~(DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HNPREQ);
+	reg |= DWC3_OCTL_PERIMODE;
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+}
+
+void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
+{
+	int ret;
+	u32 reg;
 	int id;
+	unsigned long flags;
 
-	id = extcon_get_state(dwc->edev, EXTCON_USB_HOST);
-	if (id < 0)
-		id = 0;
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
 
-	dwc3_set_mode(dwc, id ?
-		      DWC3_GCTL_PRTCAP_HOST :
-		      DWC3_GCTL_PRTCAP_DEVICE);
+	/* don't do anything if debug user changed role to not OTG */
+	if (dwc->current_dr_role != DWC3_GCTL_PRTCAP_OTG)
+		return;
+
+	if (!ignore_idstatus) {
+		reg = dwc3_readl(dwc->regs, DWC3_OSTS);
+		id = !!(reg & DWC3_OSTS_CONIDSTS);
+
+		dwc->desired_otg_role = id ? DWC3_OTG_ROLE_DEVICE :
+					DWC3_OTG_ROLE_HOST;
+	}
+
+	if (dwc->desired_otg_role == dwc->current_otg_role)
+		return;
+
+	switch (dwc->current_otg_role) {
+	case DWC3_OTG_ROLE_HOST:
+		dwc3_host_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc3_otg_host_exit(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		break;
+	case DWC3_OTG_ROLE_DEVICE:
+		dwc3_gadget_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc3_event_buffers_cleanup(dwc);
+		dwc3_otg_device_exit(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		break;
+	default:
+		break;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	dwc->current_otg_role = dwc->desired_otg_role;
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	switch (dwc->desired_otg_role) {
+	case DWC3_OTG_ROLE_HOST:
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc3_otgregs_init(dwc);
+		dwc3_otg_host_init(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		ret = dwc3_host_init(dwc);
+		if (ret) {
+			dev_err(dwc->dev, "failed to initialize host\n");
+		} else {
+			if (dwc->usb2_phy)
+				otg_set_vbus(dwc->usb2_phy->otg, true);
+			if (dwc->usb2_generic_phy)
+				phy_set_mode(dwc->usb2_generic_phy,
+					     PHY_MODE_USB_HOST);
+		}
+		break;
+	case DWC3_OTG_ROLE_DEVICE:
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc3_otgregs_init(dwc);
+		dwc3_otg_device_init(dwc);
+		dwc3_event_buffers_setup(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, false);
+		if (dwc->usb2_generic_phy)
+			phy_set_mode(dwc->usb2_generic_phy,
+				     PHY_MODE_USB_DEVICE);
+		ret = dwc3_gadget_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize peripheral\n");
+		break;
+	default:
+		break;
+	}
+}
+
+static void dwc3_drd_update(struct dwc3 *dwc)
+{
+	int id;
+
+	if (dwc->edev) {
+		id = extcon_get_state(dwc->edev, EXTCON_USB_HOST);
+		if (id < 0)
+			id = 0;
+		dwc3_set_mode(dwc, id ?
+			      DWC3_GCTL_PRTCAP_HOST :
+			      DWC3_GCTL_PRTCAP_DEVICE);
+	}
 }
 
 static int dwc3_drd_notifier(struct notifier_block *nb,
@@ -40,11 +441,11 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 
 int dwc3_drd_init(struct dwc3 *dwc)
 {
-	int ret;
+	int ret, irq;
 
-	if (dwc->dev->of_node) {
-		if (of_property_read_bool(dwc->dev->of_node, "extcon"))
-			dwc->edev = extcon_get_edev_by_phandle(dwc->dev, 0);
+	if (dwc->dev->of_node &&
+	    of_property_read_bool(dwc->dev->of_node, "extcon")) {
+		dwc->edev = extcon_get_edev_by_phandle(dwc->dev, 0);
 
 		if (IS_ERR(dwc->edev))
 			return PTR_ERR(dwc->edev);
@@ -56,19 +457,71 @@ int dwc3_drd_init(struct dwc3 *dwc)
 			dev_err(dwc->dev, "couldn't register cable notifier\n");
 			return ret;
 		}
-	}
 
-	dwc3_drd_update(dwc);
+		dwc3_drd_update(dwc);
+	} else {
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc->current_dr_role = DWC3_GCTL_PRTCAP_OTG;
+
+		/* use OTG block to get ID event */
+		irq = dwc3_otg_get_irq(dwc);
+		if (irq < 0)
+			return irq;
+
+		dwc->otg_irq = irq;
+
+		/* disable all OTG IRQs */
+		dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+		/* clear all events */
+		dwc3_otg_clear_events(dwc);
+
+		ret = request_threaded_irq(dwc->otg_irq, dwc3_otg_irq,
+					   dwc3_otg_thread_irq,
+					   IRQF_SHARED, "dwc3-otg", dwc);
+		if (ret) {
+			dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				dwc->otg_irq, ret);
+			ret = -ENODEV;
+			return ret;
+		}
+
+		dwc3_otg_init(dwc);
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+	}
 
 	return 0;
 }
 
 void dwc3_drd_exit(struct dwc3 *dwc)
 {
-	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
-				   &dwc->edev_nb);
+	unsigned long flags;
+
+	if (dwc->edev)
+		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
+					   &dwc->edev_nb);
+
+	cancel_work_sync(&dwc->drd_work);
+
+	/* debug user might have changed role, clean based on current role */
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		dwc3_host_exit(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_gadget_exit(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_otg_update(dwc, 1);
+		break;
+	default:
+		break;
+	}
 
-	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-	flush_work(&dwc->drd_work);
-	dwc3_gadget_exit(dwc);
+	if (!dwc->edev)
+		free_irq(dwc->otg_irq, dwc);
 }
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

