Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1442817-1518442222-2-10183461425732620180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518442221; b=gnsBODVKztqmfX2YX//lj/zM5xK7MV/xUxBRF/chSjSid/U
    56u/05czRAFD+fIbVIc0V69H90IHm+hn++RMx3oStKvhyrJUypn7jsLOwzRwjN3g
    y1QMknfZKTr7QYmsQcHRxPsfPPwIHeU+tuTJUbCxkox2nlIltWZY5BRmIrHfDGTP
    //v4AlbMaFRILjCkIBxhnVknjvzcjeVPHcygxUEBwGE/0zNMM64LLXVQlnX8fKJ6
    ifo5fQi8X8GUMrNtueRCR6tYubhb5iFM1DA9mesxOm8Rv0Ak1YIq1GafAZIRVDpu
    bPBCRPNZfp0ZwuKbVDYAG3yDg4F/CHSzuFeUMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518442221; bh=F55TNhW1+en19zFgERSZwRKbdH2EqDSrJE12wlT3pCM=; b=F
    BPNCb6ihifuKsI/pvRvENZFOeLiKr0wsGMJ6j6nDAVQ7sGFVltgrkAnD00/2oYXD
    tAlcIzcl+NGX7ZDSvigZGH4xC/oGFSixgday/X2B611H1pQxJShnpo3wGbw/dG4e
    FC6WuEG3BqefPi+DAZbKnb9t1oQeYLV13udmVcbF5RQJFz8nLY1hM3pcWxyyjAZD
    8P7gmzwusEzpeYPImvlzwjIQ/sbh5mSaD3IbePtesSS5pwZxYE49FJMpoyZnRPI4
    LCnj5h9yErG1/sN7y0TnXN4+VZomEH1nezzO5LMAvzT5PAiZXSgdPI+MWz0+t+Ew
    LmNZ8PiAPm9YDWWpnE7ow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=KM9uk9CR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=KM9uk9CR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935504AbeBLNaP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 08:30:15 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:44293 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbeBLNaN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Feb 2018 08:30:13 -0500
Subject: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent
 phy_get/ulpi_init during suspend/resume
To: <balbi@kernel.org>
CC: <vigneshr@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "linux-stable # = v4 . 13" <stable@vger.kernel.org>,
        <rogerq@ti.com>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com>
Date: Mon, 12 Feb 2018 15:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515667087-4110-1-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order for ULPI PHYs to work, dwc3_phy_setup() and dwc3_ulpi_init()
must be doene before dwc3_core_get_phy().

commit 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
broke this.

The other issue is that dwc3_core_get_phy() and dwc3_ulpi_init() should
be called only once during the life cycle of the driver. However,
as dwc3_core_init() is called during system suspend/resume it will
result in multiple calls to dwc3_core_get_phy() and dwc3_ulpi_init()
which is wrong.

Fix this by moving dwc3_ulpi_init() out of dwc3_phy_setup()
into dwc3_core_ulpi_init(). Use a flag 'ulpi_ready' to ensure that
dwc3_core_ulpi_init() is called only once from dwc3_core_init().

Use another flag 'phys_ready' to call dwc3_core_get_phy() only once from
dwc3_core_init().

Fixes: 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
Fixes: f54edb539c11 ("usb: dwc3: core: initialize ULPI before trying to get the PHY")
Cc: linux-stable <stable@vger.kernel.org> # >= v4.13
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Rebased on Felipe's testing/fixes branch.

 drivers/usb/dwc3/core.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 59511f2..f1d838a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -486,6 +486,22 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
 }
 
+static int dwc3_core_ulpi_init(struct dwc3 *dwc)
+{
+	int intf;
+	int ret = 0;
+
+	intf = DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3);
+
+	if (intf == DWC3_GHWPARAMS3_HSPHY_IFC_ULPI ||
+	    (intf == DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI &&
+	     dwc->hsphy_interface &&
+	     !strncmp(dwc->hsphy_interface, "ulpi", 4)))
+		ret = dwc3_ulpi_init(dwc);
+
+	return ret;
+}
+
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -497,7 +513,6 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
-	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -568,9 +583,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		}
 		/* FALLTHROUGH */
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		ret = dwc3_ulpi_init(dwc);
-		if (ret)
-			return ret;
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -727,6 +739,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 }
 
 static int dwc3_core_get_phy(struct dwc3 *dwc);
+static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
@@ -758,17 +771,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
 			dwc->maximum_speed = USB_SPEED_HIGH;
 	}
 
-	ret = dwc3_core_get_phy(dwc);
+	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
 
-	ret = dwc3_core_soft_reset(dwc);
-	if (ret)
-		goto err0;
+	if (!dwc->ulpi_ready) {
+		ret = dwc3_core_ulpi_init(dwc);
+		if (ret)
+			goto err0;
+		dwc->ulpi_ready = true;
+	}
 
-	ret = dwc3_phy_setup(dwc);
+	if (!dwc->phys_ready) {
+		ret = dwc3_core_get_phy(dwc);
+		if (ret)
+			goto err0a;
+		dwc->phys_ready = true;
+	}
+
+	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0;
+		goto err0a;
 
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
@@ -841,6 +864,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+err0a:
+	dwc3_ulpi_exit(dwc);
+
 err0:
 	return ret;
 }
@@ -1235,7 +1261,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err3:
 	dwc3_free_event_buffers(dwc);
-	dwc3_ulpi_exit(dwc);
 
 err2:
 	pm_runtime_allow(&pdev->dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 185b960..860d2bc 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -797,7 +797,9 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
+ * @ulpi_ready: flag to indicate that ULPI is initialized
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
  * @u1sel: parameter from Set SEL request.
@@ -895,7 +897,10 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	bool			phys_ready;
+
 	struct ulpi		*ulpi;
+	bool			ulpi_ready;
 
 	void __iomem		*regs;
 	size_t			regs_size;
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


