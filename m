Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330738-1519730990-2-7573432189931076857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UPPERCASE_50_75 0.008, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519730989; b=QaEj0Ip3mr9lM/G0jWRaxPPrwNCeh50Emia/kbpazsLYyBM
    vB8ncVP2zWgFLNKikvY4VOI9iCf7+UJUkLmgu/6lPBbNxUg4zRAOKF/OSHM/eVPm
    OYmFcLggaMp/gixMjxAA8zHdx6txucxqqmX4EWCZTWDjbnkPAjadhPD6j3cZVnc2
    8QfuFrm8a25U8+FVl59zmNDyyxO3gLkl9mWm48/Z3a10p67BKcAbKf5MEbdhqPen
    g/lmdbCt4Dhys6vwIQrJtI931T73QgxoygQDisVA/+q+mwgcFkbAdPyrF9LYEDsH
    XyOMyFf9I2csg28ADZrVzMLqV3OkAEG61wawiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519730989; bh=7XbsFPTn5S3Xk41eKGdVK68Y9P
    BRyAiquuNCq7rJ4zQ=; b=lKgxzAyrOPpteq4smkp8L4hja13KssQLdcH0fnZHHq
    wcvnj25EaO9Wi60LPaPsSGLT2LxnycfCwA7yoG0fLtHlFGQOdm6Y01LE0Dc+5Umf
    sYPOWDqXuOwGZv269G9qCQVq3kSA5PPcQkglkdHsj7VcoAt0xRz+NyciUQTtcc8t
    gWNBvYiY5iOXU8BANah1SfFGDCYDo6JxEE0aCBtKeGAG/QUYum2lstXp6Yq/alTv
    NOZLWPxLpgN/ML/tcc1cfOaGig1PoX4NSCALX+cJfD5cQsOJT8cBpJ3KjfEh4BkP
    KqNDi60HsJsz/YsPapcuLHZl9kWBZTehMt2jhmsXZO8w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pAqd43hW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pAqd43hW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeB0L3c (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:29:32 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10559 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeB0L3S (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:29:18 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/2] usb: dwc3: core.h: add some register definitions
Date: Tue, 27 Feb 2018 13:29:11 +0200
Message-ID: <1519730952-2102-2-git-send-email-rogerq@ti.com>
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

Add OTG and GHWPARAMS6 register definitions

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.h | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc..0d4c698 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -201,6 +201,15 @@
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
+/* Global Status Register */
+#define DWC3_GSTS_OTG_IP	BIT(10)
+#define DWC3_GSTS_BC_IP		BIT(9)
+#define DWC3_GSTS_ADP_IP	BIT(8)
+#define DWC3_GSTS_HOST_IP	BIT(7)
+#define DWC3_GSTS_DEVICE_IP	BIT(6)
+#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
+#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
+
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
@@ -286,6 +295,11 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
+#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
+#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
+#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
+#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
+#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
 #define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
@@ -467,6 +481,74 @@
 #define DWC3_DEV_IMOD_INTERVAL_SHIFT	0
 #define DWC3_DEV_IMOD_INTERVAL_MASK	(0xffff << 0)
 
+/* OTG Configuration Register */
+#define DWC3_OCFG_DISPWRCUTTOFF		BIT(5)
+#define DWC3_OCFG_HIBDISMASK		BIT(4)
+#define DWC3_OCFG_SFTRSTMASK		BIT(3)
+#define DWC3_OCFG_OTGVERSION		BIT(2)
+#define DWC3_OCFG_HNPCAP		BIT(1)
+#define DWC3_OCFG_SRPCAP		BIT(0)
+
+/* OTG CTL Register */
+#define DWC3_OCTL_OTG3GOERR		BIT(7)
+#define DWC3_OCTL_PERIMODE		BIT(6)
+#define DWC3_OCTL_PRTPWRCTL		BIT(5)
+#define DWC3_OCTL_HNPREQ		BIT(4)
+#define DWC3_OCTL_SESREQ		BIT(3)
+#define DWC3_OCTL_TERMSELIDPULSE	BIT(2)
+#define DWC3_OCTL_DEVSETHNPEN		BIT(1)
+#define DWC3_OCTL_HSTSETHNPEN		BIT(0)
+
+/* OTG Event Register */
+#define DWC3_OEVT_DEVICEMODE		BIT(31)
+#define DWC3_OEVT_XHCIRUNSTPSET		BIT(27)
+#define DWC3_OEVT_DEVRUNSTPSET		BIT(26)
+#define DWC3_OEVT_HIBENTRY		BIT(25)
+#define DWC3_OEVT_CONIDSTSCHNG		BIT(24)
+#define DWC3_OEVT_HRRCONFNOTIF		BIT(23)
+#define DWC3_OEVT_HRRINITNOTIF		BIT(22)
+#define DWC3_OEVT_ADEVIDLE		BIT(21)
+#define DWC3_OEVT_ADEVBHOSTEND		BIT(20)
+#define DWC3_OEVT_ADEVHOST		BIT(19)
+#define DWC3_OEVT_ADEVHNPCHNG		BIT(18)
+#define DWC3_OEVT_ADEVSRPDET		BIT(17)
+#define DWC3_OEVT_ADEVSESSENDDET	BIT(16)
+#define DWC3_OEVT_BDEVBHOSTEND		BIT(11)
+#define DWC3_OEVT_BDEVHNPCHNG		BIT(10)
+#define DWC3_OEVT_BDEVSESSVLDDET	BIT(9)
+#define DWC3_OEVT_BDEVVBUSCHNG		BIT(8)
+#define DWC3_OEVT_BSESSVLD		BIT(3)
+#define DWC3_OEVT_HSTNEGSTS		BIT(2)
+#define DWC3_OEVT_SESREQSTS		BIT(1)
+#define DWC3_OEVT_ERROR			BIT(0)
+
+/* OTG Event Enable Register */
+#define DWC3_OEVTEN_XHCIRUNSTPSETEN	BIT(27)
+#define DWC3_OEVTEN_DEVRUNSTPSETEN	BIT(26)
+#define DWC3_OEVTEN_HIBENTRYEN		BIT(25)
+#define DWC3_OEVTEN_CONIDSTSCHNGEN	BIT(24)
+#define DWC3_OEVTEN_HRRCONFNOTIFEN	BIT(23)
+#define DWC3_OEVTEN_HRRINITNOTIFEN	BIT(22)
+#define DWC3_OEVTEN_ADEVIDLEEN		BIT(21)
+#define DWC3_OEVTEN_ADEVBHOSTENDEN	BIT(20)
+#define DWC3_OEVTEN_ADEVHOSTEN		BIT(19)
+#define DWC3_OEVTEN_ADEVHNPCHNGEN	BIT(18)
+#define DWC3_OEVTEN_ADEVSRPDETEN	BIT(17)
+#define DWC3_OEVTEN_ADEVSESSENDDETEN	BIT(16)
+#define DWC3_OEVTEN_BDEVBHOSTENDEN	BIT(11)
+#define DWC3_OEVTEN_BDEVHNPCHNGEN	BIT(10)
+#define DWC3_OEVTEN_BDEVSESSVLDDETEN	BIT(9)
+#define DWC3_OEVTEN_BDEVVBUSCHNGEN	BIT(8)
+
+/* OTG Status Register */
+#define DWC3_OSTS_DEVRUNSTP		BIT(13)
+#define DWC3_OSTS_XHCIRUNSTP		BIT(12)
+#define DWC3_OSTS_PERIPHERALSTATE	BIT(4)
+#define DWC3_OSTS_XHCIPRTPOWER		BIT(3)
+#define DWC3_OSTS_BSESVLD		BIT(2)
+#define DWC3_OSTS_VBUSVLD		BIT(1)
+#define DWC3_OSTS_CONIDSTS		BIT(0)
+
 /* Structures */
 
 struct dwc3_trb;
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

