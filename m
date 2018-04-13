Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163989-1523638351-2-6112387639871366380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523638350; b=YYt7BlbhBwmMSvnLmToUd5sf9whthPlP0ajCIMKwV5BsS/snJ2
    sNvdfrq7dUgMeC4Qsp5gb4+nJrrqbnRTpmf9c1sYdLcuzJkF9IC9YtO0w2PmDE+0
    mi7hQ8dA/h3/K9dLu8fCcMExbZJZWoMd50gZoOlQrvgYBYdAuv2T00uUeFmI1daX
    qh3NObzG45sPZfLjpniTolY07ORgllIwkHL4X1iVrd45eLAruZ/huyaHSVN/8Exd
    cwxsT4V6NzUpua1cAkVkhVFEt/AmOlg9QNspPfxx16fGYCofNFeS9rJAffCGuAiq
    W2XSBdoeUEShOSSexfQcWjXP5Ja3/+zhVO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523638350; bh=
    hCzhAd/uIBPTMLINKBPWHPn4SHyIRny3ZgTzcytu9X8=; b=msStmtajluDw7Daa
    j0mACjp/Znq9Vqv5fnVCKrAp9EfwIW3Fdbgf7k9C+7mWM9OFCOayCW2aXFV9nunl
    axzWu0LZjcRUJYSDFfKWRXxxo9TrFetp0iWZBStPLDsuqCbnmPFxIi3z4wWxvkIx
    YzsW/qh8I7+v2yyl4HVSdpz81H5fWQKbk7nozCS1272yZeepGXl2/OhQtubEsoHL
    htDrQ/dDZuH2jyQ1g24dL6AXbuTiu0/xWKYHDZ9Ya1nouL+NgBxAjFbLZTb3u0hg
    XWvB/hWvwSGvUliHZe/OindjXr36Gi4gKXU0/ux1yfRRJw+Cpg7qif1swUyruHl1
    n+5TdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=LmaeTFc+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=WoT1KQ1G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=LmaeTFc+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=WoT1KQ1G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEeJVnee+Y4K4E6Y5BoMTQPCCp/fg8jvIyFWs910n8JOqI/bBLTYDhGVDOg0+E3+71Z90J2z1pnfkQyY3k25RWCipmz20xgLNtIaUw6Cr/sAfZ3R9BTI
    zlTPZ4rAPgwRBSRgH8Ab/Hym2WywjwP0v5OZXKX6E8YsmNRcpW1R1oXKPbWlOFV9oVeVAKeEUqE+6N5IsLTgsZHPL2v3HPXKjiRxIuf3KZCEylwzlRH+e9t8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=YBa6zzCqqxeBDIK0CJYA:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDMQwO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:52:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeDMQwK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 12:52:10 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3DCA605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/3] usb: dwc3: core: Suspend PHYs on runtime suspend in host mode
Date: Fri, 13 Apr 2018 22:21:24 +0530
Message-Id: <1523638285-5742-4-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some PHY drivers (e.g. for Qualcomm QUSB2 and QMP PHYs) support
runtime PM to reduce PHY power consumption during bus_suspend.
Add changes to let core auto-suspend PHYs on host bus-suspend
using GUSB2PHYCFG register if needed for a platform. Also perform
PHYs runtime suspend/resume and let platform glue drivers e.g.
dwc3-qcom handle remote wakeup during bus suspend by waking up
devices on receiving wakeup event from PHY.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/usb/dwc3/core.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a15648d..449a098 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1394,6 +1394,7 @@ static int dwc3_remove(struct platform_device *pdev)
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
+	u32 reg;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1403,9 +1404,25 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		/* do nothing during host runtime_suspend */
-		if (!PMSG_IS_AUTO(msg))
+		if (!PMSG_IS_AUTO(msg)) {
 			dwc3_core_exit(dwc);
+			break;
+		}
+
+		/* Let controller to suspend HSPHY before PHY driver suspends */
+		if (dwc->dis_u2_susphy_quirk ||
+		    dwc->dis_enblslpm_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+				DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+			/* Give some time for USB2 PHY to suspend */
+			usleep_range(5000, 6000);
+		}
+
+		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
+		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -1433,6 +1450,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
+	u32		reg;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1446,13 +1464,25 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		/* nothing to do on host runtime_resume */
 		if (!PMSG_IS_AUTO(msg)) {
 			ret = dwc3_core_init(dwc);
 			if (ret)
 				return ret;
 			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			break;
 		}
+		/* Restore GUSB2PHYCFG bits that were modified in suspend */
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		if (dwc->dis_u2_susphy_quirk)
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+		if (dwc->dis_enblslpm_quirk)
+			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
+		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

