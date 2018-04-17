Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523973215-2-5021656001284013995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523973214; b=DFX8z2+TCCIO4NsKjf8JMj/27Rgn7ilWcdH6xo8X57+eZygfOA
    3PKJIx0vsp3J3UYgNq6RcLyc25kgm3LBI8KebqXvFuSLuvZOR4COGuTv30cOSIlp
    j/Z9UxLVE8jkMGDCvqyuJfjwvLDYQ6HXHS+UcyUgHyP+QSpBvLGJAIfO20Ic1qAD
    Hzp5G1rJcea4DCt+vxdDGy3H/SvjAjEdIIDHSGtVqTfR90pWVgwzoRa7BhITUqyd
    P0EsrdYbaQLjh12R0scr//G28IBWGLFQYCWZzT08keIpIi2nxVWNGlXHLU2VToox
    5qZXixnxMuZrgmcdrkfFwRdXR51ZbgDUK4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523973214; bh=1xDCh2F5rhk/lM07tqkDovKf2+1N2C
    xUDF0H6wFkjLQ=; b=TM0lHtzwPHEyf3lX2bfcWctIo5a/SW0FlrZ7Uomj+W2Hvt
    Ifb2cYi/R0AtuWCdSnqCNykJqNgyBMy+GXlxT0M96AnCKNbZds1W/hpN2NjdyEv6
    zRIkzfWMnrgM2xz1u48i6rFbphMRzTyRV5JaLHnAxNiU6pEW/s6lVi1Ov+KjecJd
    E+VOQQETh1NYqC1PUppgGVhvCrtcI4eyeO9DDYo4KamtVrHo/5ygRuqjbB8MdfG5
    O+cjvlLioqPfzxJZxIch8qnkWsSn6rVoKQZXaoCvC9aLBRPSss1ye2HC2Bd3eYs4
    0AuFbt0Ue17KjSrPD+MrkH2maVUbevZcCMwhc/fQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Jm0uhRQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=dzWh5f36 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Jm0uhRQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=dzWh5f36 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQoFLSSpLKB+oYR2taiAd+BvmxqdmFYkJxuj4vzMRGEVzhb6CLhaNfy8JDRmhQv5pomR+hBL2OdODdoMeiSihpixCeEndNUG8UVNCzBv/AWvubfXEH9
    MdCTwye81+ykAl0gE+LRgAMv9+miut32kJZFqpShZXqnOWAUYBktyhwsxRfUNADYXVAa0Q31F/IFrcFJHgUK0sEkE5UDWeuh8YHJtbTTcFYiVqmn94iQLOHj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8
    a=8AirrxEcAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=LpQP-O61AAAA:8 a=kg-UbGovrIhLtwywPbwA:9 a=kiR4oCbkcUSWJ7Qr:21
    a=76ZrOVe15nerNXEu:21 a=x8gzFH9gYPwA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeDQNxU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:53:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbeDQNxT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 09:53:19 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5A646071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yossim@codeaurora.org
From: Yossi Mansharoff <yossim@codeaurora.org>
To: Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CHIPIDEA USB HIGH SPEED DUAL ROLE
        CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc: robh@kernel.org, swboyd@chromium.org,
        Yossi Mansharoff <yossim@codeaurora.org>,
        Peter Rosin <peda@axentia.se>, Peter Chen <peter.chen@nxp.com>,
        <devicetree@vger.kernel.org>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb switch
Date: Tue, 17 Apr 2018 16:52:28 +0300
Message-Id: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On the db410c 96boards platform we have a TC7USB40MU on the board
to mux the D+/D- lines coming from the controller between a micro
usb "device" port and a USB hub for "host" roles[1]. During a
role switch, we need to toggle this mux to forward the D+/D-
lines to either the port or the hub. Add the necessary code to do
the role switch in chipidea core via the generic mux framework.
Board configurations like on db410c are expected to change roles
via the sysfs API described in
Documentation/ABI/testing/sysfs-platform-chipidea-usb2.

[1] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf

Cc: Peter Rosin <peda@axentia.se>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Signed-off-by: Yossi Mansharoff <yossim@codeaurora.org>
---
 drivers/usb/chipidea/Kconfig |  2 ++
 drivers/usb/chipidea/core.c  |  5 +++++
 drivers/usb/chipidea/host.c  |  7 +++++++
 drivers/usb/chipidea/udc.c   | 13 ++++++++++++-
 include/linux/usb/chipidea.h |  2 ++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 785f0ed..6a8e635 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -3,6 +3,8 @@ config USB_CHIPIDEA
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
 	select EXTCON
 	select RESET_CONTROLLER
+	select MULTIPLEXER
+	select MUX_GPIO
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on ChipIdea silicon IP. It supports:
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 33ae87f..8fa0991 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -61,6 +61,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/ehci_def.h>
+#include <linux/mux/consumer.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -687,6 +688,10 @@ static int ci_get_platdata(struct device *dev,
 	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
 		platdata->flags |= CI_HDRC_SET_NON_ZERO_TTHA;
 
+	platdata->usb_switch = devm_mux_control_get_optional(dev, "usb_switch");
+	if (IS_ERR(platdata->usb_switch))
+		return PTR_ERR(platdata->usb_switch);
+
 	ext_id = ERR_PTR(-ENODEV);
 	ext_vbus = ERR_PTR(-ENODEV);
 	if (of_property_read_bool(dev->of_node, "extcon")) {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index af45aa32..d9d2d00 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -13,6 +13,7 @@
 #include <linux/usb/hcd.h>
 #include <linux/usb/chipidea.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mux/consumer.h>
 
 #include "../host/ehci.h"
 
@@ -161,6 +162,10 @@ static int host_start(struct ci_hdrc *ci)
 		if (ci_otg_is_fsm_mode(ci)) {
 			otg->host = &hcd->self;
 			hcd->self.otg_port = 1;
+		} else {
+			ret = mux_control_select(ci->platdata->usb_switch, 1);
+			if (ret)
+				goto disable_reg;
 		}
 	}
 
@@ -181,6 +186,8 @@ static void host_stop(struct ci_hdrc *ci)
 	struct usb_hcd *hcd = ci->hcd;
 
 	if (hcd) {
+		if (!ci_otg_is_fsm_mode(ci))
+			mux_control_deselect(ci->platdata->usb_switch);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
 				CI_HDRC_CONTROLLER_STOPPED_EVENT);
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 9852ec5..209d3f6 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -19,6 +19,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg-fsm.h>
 #include <linux/usb/chipidea.h>
+#include <linux/mux/consumer.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -1965,16 +1966,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
 
 static int udc_id_switch_for_device(struct ci_hdrc *ci)
 {
+	int ret = 0;
+
 	if (ci->is_otg)
 		/* Clear and enable BSV irq */
 		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
 					OTGSC_BSVIS | OTGSC_BSVIE);
 
-	return 0;
+	if (!ci_otg_is_fsm_mode(ci))
+		ret = mux_control_select(ci->platdata->usb_switch, 0);
+
+	if (ci->is_otg && ret)
+		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
+
+	return ret;
 }
 
 static void udc_id_switch_for_host(struct ci_hdrc *ci)
 {
+	mux_control_deselect(ci->platdata->usb_switch);
+
 	/*
 	 * host doesn't care B_SESSION_VALID event
 	 * so clear and disbale BSV irq
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 07f9936..9ea55a1 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -10,6 +10,7 @@
 #include <linux/usb/otg.h>
 
 struct ci_hdrc;
+struct mux_control;
 
 /**
  * struct ci_hdrc_cable - structure for external connector cable state tracking
@@ -76,6 +77,7 @@ struct ci_hdrc_platform_data {
 	/* VBUS and ID signal state tracking, using extcon framework */
 	struct ci_hdrc_cable		vbus_extcon;
 	struct ci_hdrc_cable		id_extcon;
+	struct mux_control		*usb_switch;
 	u32			phy_clkgate_delay_us;
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

