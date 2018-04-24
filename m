Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2202739-1524538472-2-11140040091038229623
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524538471; b=C/vjwk5g9GlBG5ZR9JaCVbjTwQDSBzzkr5V21Em3nLvAmxWr1i
    LPbLckmy5O3lhEh6baQearZ/evf/KI5jHBumfFIISPY+xMcghhrwGPZF431t3zmB
    UyvYPle0EaPP3WHlDuW2uhWxxIzjQR7ebfHnGEmRhuByp1f5e2IIX+CuoWWQWqih
    grKxAxcUA2FbjMTNI4lJ4LdjMpVYBPnrHyljRin8a6TwaMO61YKe/qD07upMixlN
    xr14eU+kzYuSbtpxWq52d6pjyClXVN/lRDqGd7cRzFAPQfFo3E45tQJ75LzTxd8+
    j5sIE7+Xv7KnZn9ayHXnobg654Iz5GaE6CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524538471; bh=H8tPpoYkE877A9k3zAqZORQTvbUTVS
    edIFVEQGdpSJo=; b=YlmtlCJj0NXPb405LTTYbYflGdGQzD2W107qFeqr1gcpUF
    XovLhJWvuX7qjQ3zSSkOge3XURiNHW068/djGYisOYfTFz0KGZe2mdTSGy62Onev
    w0EbAUC4AXEfnRo2Ge0ALw2juxceOFV4iahxlEBo+ALALpBWE7OcvL/pkafcXgtI
    hc/GX8ZztWNpoYNLsXEd0p9Jcd3npciuw8SherZ3noG1NaaZqO9QoaQHttK8Q6bo
    YGi2ryw63H6wLw5BO7BGoQ3MVZmjg7GrHbE878CiZGhpvjf1UaVqbvcnQbmh0soN
    2BPzc2GOf1swubmYXMVBwidFrbafac4aqf9UnEmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTk78O3vQ/Hd+V9YoCH52bgQdnt/EPptikHUOgLGrlMmGs/gGd9eg/AIe5VC0vGuN44LqAlbfJT8XpWILv6vr6u/s1A3VufObKPYsyVjacTphzaqBYX
    +qb4QFSNn06UhDqAC5YTKbljUCJiVIvcHUBWAH/MRil7IIpSQrPq2EyVUN5OtR1p7VHZPJHK9i0BrOE//cHJYDPvfUWgG4ytiBYFtq7eRwctpv3Z8Bqa/ISW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=P3edHxyqTk94n7NrUAEA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeDXCyR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:54:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63440 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932757AbeDXCxf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:53:35 -0400
X-UUID: 33c848e1f7c044c6859013946edcaf60-20180424
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/5] usb: mtu3: fix an unrecognized issue when connected with PC
Date: Tue, 24 Apr 2018 10:52:48 +0800
Message-ID: <87c13b177c67bb614b761c594231a39e3fa25924.1524537854.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When boot on the platform with the USB cable connected to Win7,
the Win7 will pop up an error dialog: "USB Device not recognized",
but finally the Win7 can enumerate it successfully.
The root cause is as the following:
When the xHCI driver set PORT_POWER of the OTG port, and if both
IDPIN and VBUS_VALID are high at the same time, the MTU3 controller
will set SESSION and pull up DP, so the Win7 can detect existence
of USB device, but if the mtu3 driver can't switch to device mode
during the debounce time, the Win7 can not enumerate it.
Here to fix it by removing the 1s delayed EXTCON register to speed up
mode switch.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    |  4 ----
 drivers/usb/mtu3/mtu3_dr.c | 25 +++----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 2cd00a2..a56fee0 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -197,9 +197,6 @@ struct mtu3_gpd_ring {
 * @edev: external connector used to detect vbus and iddig changes
 * @vbus_nb: notifier for vbus detection
 * @vbus_nb: notifier for iddig(idpin) detection
-* @extcon_reg_dwork: delay work for extcon notifier register, waiting for
-*		xHCI driver initialization, it's necessary for system bootup
-*		as device.
 * @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
 * @manual_drd_enabled: it's true when supports dual-role device by debugfs
 *		to switch host/device modes depending on user input.
@@ -209,7 +206,6 @@ struct otg_switch_mtk {
 	struct extcon_dev *edev;
 	struct notifier_block vbus_nb;
 	struct notifier_block id_nb;
-	struct delayed_work extcon_reg_dwork;
 	bool is_u3_drd;
 	bool manual_drd_enabled;
 };
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index db7562d..80083e0 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -238,15 +238,6 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 	return 0;
 }
 
-static void extcon_register_dwork(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct otg_switch_mtk *otg_sx =
-	    container_of(dwork, struct otg_switch_mtk, extcon_reg_dwork);
-
-	ssusb_extcon_register(otg_sx);
-}
-
 /*
  * We provide an interface via debugfs to switch between host and device modes
  * depending on user input.
@@ -407,18 +398,10 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	if (otg_sx->manual_drd_enabled) {
+	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_init(ssusb);
-	} else {
-		INIT_DELAYED_WORK(&otg_sx->extcon_reg_dwork,
-				  extcon_register_dwork);
-
-		/*
-		 * It is enough to delay 1s for waiting for
-		 * host initialization
-		 */
-		schedule_delayed_work(&otg_sx->extcon_reg_dwork, HZ);
-	}
+	else
+		ssusb_extcon_register(otg_sx);
 
 	return 0;
 }
@@ -429,6 +412,4 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_exit(ssusb);
-	else
-		cancel_delayed_work(&otg_sx->extcon_reg_dwork);
 }
-- 
1.9.1

