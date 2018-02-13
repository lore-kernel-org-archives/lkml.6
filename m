Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518510532-2-4070974465737653759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518510532; b=dc2F23KjKyGXJ09VgN0wgg6wbRbGBsxkGg+3nCbBNMN1W36
    lyVLgnTDJr0Ws+i7YJKjeyFDVOu8KkrNeiL5KLOZ0mg7jWp/TsyWNRyAsgT7PWhs
    Rfa6KxvF7SeeygEjIXfOMNKmqVKUaeVMbYnx+tr3QcbII1rQ6aPbtKs2xt33sk09
    uCkCHzpnTr+APpweUaPpfgkzLK6ng9d4b4BDtqhOOc4wQAmOYsg0mBhyIgY4bU7v
    /FFB44zLCVm0tK7nLfIXysk64h1afZGGA3iab88uccZ+7EZEN2t/6B/avmEsXf91
    2HVtg37ISSegyuSSxd7ubdC0lYHhz/mh4owj86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518510532; bh=A2qGbYaNiYDyTN1nQQ35l44XVh9F4s/k53PPmJZmUps=; b=L
    tnFyLFi0SPzkG2fZaSBXw2/oQcYtv7FbefQ1YpgLID39p7dqX53Bs0rbK4zTSUB7
    3p3g9QyHrwXCK46wqysqebn4NkBoPrq5OLo3DtWPrCzmtfDbL9FhVp8ts5W6MoBO
    i28sslTC0tIWekIJ3OOs7y70ND26dyN+uAQcaSfevBHT3FE0rmmmVX2X0uV3VwaT
    zpHmWTFZbBl86eoNi5OpOOdof4NXEgd/hV2m7Er+BkYWxf7puag2f0DIBSRGU5JN
    B9jkKrG6XyC+x7JnpGF78Tq2mFXOikDUadOMMrANSDiZtTOv+pWS9GFScrsnVOH+
    6cgkLtgpNz7nrDBU7rpeg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeBMI2g (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 03:28:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48720 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933584AbeBMI2V (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Feb 2018 03:28:21 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Gevorg Sahakyan <gevorg.sahakyan@synopsys.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] usb: dwc2: add support for host mode external vbus supply
Date: Tue, 13 Feb 2018 09:28:12 +0100
Message-ID: <1518510492-10159-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_04:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds a way to enable an external vbus supply in host mode,
when dwc2 drvvbus signal is not used.

This patch is very similar to the one done in U-Boot dwc2 driver [1]. It
also adds dynamic vbus supply management depending on the role and state
of the core.

[1] https://lists.denx.de/pipermail/u-boot/2017-March/283434.html

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/core.h |  2 ++
 drivers/usb/dwc2/hcd.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index cd77af3..8ebc85c 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -786,6 +786,7 @@ struct dwc2_hregs_backup {
  * @plat:               The platform specific configuration data. This can be
  *                      removed once all SoCs support usb transceiver.
  * @supplies:           Definition of USB power supplies
+ * @vbus_supply:        Regulator supplying vbus.
  * @phyif:              PHY interface width
  * @lock:		Spinlock that protects all the driver data structures
  * @priv:		Stores a pointer to the struct usb_hcd
@@ -922,6 +923,7 @@ struct dwc2_hsotg {
 	struct usb_phy *uphy;
 	struct dwc2_hsotg_plat *plat;
 	struct regulator_bulk_data supplies[DWC2_NUM_SUPPLIES];
+	struct regulator *vbus_supply;
 	u32 phyif;
 
 	spinlock_t lock;
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index a5d72fc..2cf2fd0 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -365,6 +365,23 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
 }
 
+static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
+{
+	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
+	if (IS_ERR(hsotg->vbus_supply))
+		return 0;
+
+	return regulator_enable(hsotg->vbus_supply);
+}
+
+static int dwc2_vbus_supply_exit(struct dwc2_hsotg *hsotg)
+{
+	if (hsotg->vbus_supply)
+		return regulator_disable(hsotg->vbus_supply);
+
+	return 0;
+}
+
 /**
  * dwc2_enable_host_interrupts() - Enables the Host mode interrupts
  *
@@ -3257,6 +3274,7 @@ static void dwc2_conn_id_status_change(struct work_struct *work)
 
 	/* B-Device connector (Device Mode) */
 	if (gotgctl & GOTGCTL_CONID_B) {
+		dwc2_vbus_supply_exit(hsotg);
 		/* Wait for switch to device mode */
 		dev_dbg(hsotg->dev, "connId B\n");
 		if (hsotg->bus_suspended) {
@@ -4363,6 +4381,9 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	}
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	dwc2_vbus_supply_init(hsotg);
+
 	return 0;
 }
 
@@ -4390,6 +4411,8 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
+	dwc2_vbus_supply_exit(hsotg);
+
 	usleep_range(1000, 3000);
 }
 
@@ -4426,6 +4449,7 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		hprt0 |= HPRT0_SUSP;
 		hprt0 &= ~HPRT0_PWR;
 		dwc2_writel(hprt0, hsotg->regs + HPRT0);
+		dwc2_vbus_supply_exit(hsotg);
 	}
 
 	/* Enter hibernation */
@@ -4506,6 +4530,8 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_port_resume(hsotg);
 	} else {
+		dwc2_vbus_supply_init(hsotg);
+
 		/* Wait for controller to correctly update D+/D- level */
 		usleep_range(3000, 5000);
 
-- 
2.7.4

