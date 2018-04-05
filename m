Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3962421-1522967549-2-11815153679562985595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522967548; b=qLSjRb0FoactuWGRFtVba9jpMkTu76jfeC6GQsYcEyK4UawPpY
    DNpCrZkdJ1+dZyKst0G37gRKpzyY9KtBm2oYeqJDQh2Ab6cD4+jZYSypqj+Gag06
    c0f/QUi6ScicQbRm1X6dMJnZDxXUW3izx1erl/FOeOnjyHzK1B5rYGL/E9l27f8g
    6l7zV5t47El4TIYTbe7e5nHsUQSFx/x4v/xtckwHw3tI0zOHo5yD1fxzR5R/AF/p
    T103qDWr/h8l7aTBV2HvV6Pi/czTB0Ig8PTRK0oyS8KZoCOzBWFQY5MC5CVimoKZ
    mW9+GF8qoP4+zjQNkx77omIuFUxTAa+J0YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522967548; bh=uOmCFA2zim4IhEkq+Po0Txuf/Vw1vl
    TP/fVDdbPGSd4=; b=oR5wcguB7G4oG+Edzd12tvqJwEWU3ipwdJF6h8YAj68MOW
    uyxd5Cu4v/SxuSFTZ7FLIT0pwjtjqliqJt5bn6ki6iUc9bVn1wACkVhEViBIBCiH
    dCBCbiG8bFAVELRYcpwqbZtctKxPWyonm5V2y4O+SZztSN2Z3zfOnZM9nWijnarQ
    2jC0EIDa+BAdRGVdT1QWnJJkynUUHZTQ0yoc3V1PEgCWJvcwbG8Vqd/CZZGQGQ+h
    6FqbFIRHlzfbdXKdzisfxK1YHmncLh1AcT6s63+LEMD6L5w28P0j5aLgs+eh0RFv
    gBVl/hhm0ND38YGIYMEP9YqAQt1exiC0etZecLcg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBbh+DqLzTB+FW3IG8YvgG0NaNFCMXHBmh7yeKnmra5XzPUIAbsfRKMNhVwLayfpz21Lf6Lx5yadjfB481k5m57G9gV06oybyczDwsaQfEgNmnmnglaE
    7bhtSknO6Hn+FHS3QwHPrO9jAyarCUnFHAv9+znuwkx65dtDk57GTQYW7UluP2hIBWrviQbZPAZtMnC4JKjw8waDBEEDlyvEwCVQAYUmugLgBTCudBWRTwJH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=RuwYIv2K_eApPuJof-sA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDEWcO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 18:32:14 -0400
Received: from osg.samsung.com ([64.30.133.232]:44870 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeDEWcM (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 5 Apr 2018 18:32:12 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vhci_hcd: check rhport before using in vhci_hub_control()
Date: Thu,  5 Apr 2018 16:31:49 -0600
Message-Id: <20180405223149.24643-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Validate !rhport < 0 before using it to access port_status array.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/usbip/vhci_hcd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 20e3d4609583..d11f3f8dad40 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -354,6 +354,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
+		if (rhport < 0)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -511,11 +513,16 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				goto error;
 			}
 
+			if (rhport < 0)
+				goto error;
+
 			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_SUSPEND;
 			break;
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_POWER\n");
+			if (rhport < 0)
+				goto error;
 			if (hcd->speed == HCD_USB3)
 				vhci_hcd->port_status[rhport] |= USB_SS_PORT_STAT_POWER;
 			else
@@ -524,6 +531,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed != HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -534,6 +543,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* if it's already enabled, disable */
 			if (hcd->speed == HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -554,6 +565,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
+			if (rhport < 0)
+				goto error;
 			if (hcd->speed == HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
-- 
2.14.1

