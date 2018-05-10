Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1523401-1525931254-2-1681587130322927115
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
    1525931253; b=eEKWtGHT50H94AtVMCXWD+Jm75xeiJxgy+tlUgI04OmM/wXDwA
    paA7/iOK0IW7zMvXnoTjoHaoTG4EFMNLSP0VmuTbU6vkzgb9ZFqJTA5aHIAA36WL
    u2Yl1dcnQqKcU1BuACpVzJoKa6BnADjK8oBFb+NpFq1eZzqQ0al25ZgtS3/o1EPi
    zxhEGLGHjNcLGMRbkEAh3kxNVXRZyB+ke0qdr5AGvhfwdAXKUONZxmh27naelzr0
    kDdk4o15HWYc1t1OqAVGi8mKIecprbOW2/ICbe+JX0eEWwKQ4nC9OGaguADThZet
    jU8I9xAJEGHUUxt7Ed76r6FCNtZZ1gVmDrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931253; bh=H8tPpoYkE877A9k3zAqZORQTvbUTVS
    edIFVEQGdpSJo=; b=BdKpvuUZVBK8pe38qMM3YxVHrVsrhU0yxVUT58ObfSNapU
    LTezgFpRqeHhsULLdHp4CRWn+1D8bcVH1IQNzuEFX0soyagiuKjCQfjD7AUC7lc4
    8PMJa6EcTUQFTjvVUF94g1u87NdtzpLSrm3EGwU2XWSkufDEng9H4F+xP7aZqF0s
    Q6OiQ8e/OuMj5/Iz+U5zZFzIQbTGhuWoZEUxxqXYq3O0AlcIdWCY0jJsQoIGBENn
    a7NUFf1ZJOyl3NHslolhc/Mrj47PLPKbjqAfZvRs9puGlRRSKzxxlbfWO3Jx/LWK
    MO7Xzit1fWPPNKM9Kt4AH20X8ow5Nse7/rsREZyg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAi2xl9yWwtQvEX4iyn8AiHUBGLalrVgep7pUIs0U/xi/8ohNRKYsAxjbAiVkzzqWHUhTgQkLV/uSXZUCmKNNK/GEivYX0Dfs5R5Kn+s4VTzVaEeemb3
    OYTsabGjKOsgNdj6GAaTWSoqG8ONRSjuE+imFL+pZwFvwU9iC/xOYT2OMiT7jKMCslLCLrXcnVgzb+o+ZVYdlfNYZr5aKLFsykn2Z69cWRS3z+Auw0/UKoiF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=P3edHxyqTk94n7NrUAEA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756646AbeEJFr3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:47:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756501AbeEJFrZ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:25 -0400
X-UUID: fbf901d026ed4a689fc2c94af2cced2a-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/7] usb: mtu3: fix an unrecognized issue when connected with PC
Date: Thu, 10 May 2018 13:47:08 +0800
Message-ID: <ee3a8ac3622be752e42580acf2558ebd0213cca1.1525930818.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
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

