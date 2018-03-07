Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451874-2-6540303536412307427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451874; b=ON0bimWYmRZ4x2ye+FUrDEP4FJQjQOcnVpGAi25w/Q669l3
    gr8UgEwc7ICvgpJDtxZILWzqAX4+RBHd9OoTBmfNUR5Ea0F0p4G98qQPuSXJkRRT
    I3T0tlw9KWYrbHDkLeyU/c3K6jcM4tHjq+J0mBWN+hjcd/DoOfsd+TkYobUc4CWn
    kIMID2ApCeuAYx4CwaG0tH9+p4V1Se2IA68Qp4crXy3WFYBAyZu++HRES5oaV7rL
    XOqCf9AkkyxUUGwjfzvfPMnZ1gnsu2QhySs4JKQ5NIq5EnrmZbZjsYjFMzGMLnll
    8lgWaUyG6tTkqsKQfsGnOiRbW9DGfxCEInJbt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451874; bh=xETRkZnhkE14L5erp75ZWSGTL/
    q9+M49Pa8ma2J27dY=; b=oLwcCPVcehB4GAjyp1Z6GzWok8FcL0IALbtid0g04y
    nYMy1W3USC+OkLVu6hlep90CKblZaCdZydbZXiLf6A/uQAPiSV2hAX2qMzDWDyuF
    iK7umxRt14yWnoRw0LHOK1m+SpAY4f2TRgoyizuGChdPFoG6Q0Tt7Z6Y5xgNRuCd
    QgIszdOaxDa9wD5Rmm0P8Q7Hrb0Urd1qSiaFme1cutIDEcNNKGKmKIKm22dIA/oU
    t8Uzysmho12mJVsTCpsQ87LcbBag7y+5d13CrPWJDdlnmguP86//+iH1GUfL8QpO
    ZL1YlUyQ4Xlvi9kGXTNBd17h4ql0xfCptzjFOBYk6GlQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965081AbeCGTob (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:44:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbeCGToa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:44:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 001/110] Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking
Date: Wed,  7 Mar 2018 11:37:44 -0800
Message-Id: <20180307191039.963407943@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1fdb926974695d3dbc05a429bafa266fdd16510e upstream.

Commit 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume fix
with a "rewritten" version") applied the USB_QUIRK_RESET_RESUME to all QCA
USB Bluetooth modules. But it turns out that the resume problems are not
caused by the QCA Rome chipset, on most platforms it resumes fine. The
resume problems are actually a platform problem (likely the platform
cutting all power when suspended).

The USB_QUIRK_RESET_RESUME quirk also disables runtime suspend, so by
matching on usb-ids, we're causing all boards with these chips to use extra
power, to fix resume problems which only happen on some boards.

This commit fixes this by applying the quirk based on DMI matching instead
of on usb-ids, so that we match the platform and not the chipset.

Here is the /sys/kernel/debug/usb/devices for the Bluetooth module:

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Fixes: 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume..")
Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-and-tested-by: Kevin Fenzi <kevin@scrye.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
@@ -381,6 +382,21 @@ static const struct usb_device_id blackl
 	{ }	/* Terminating entry */
 };
 
+/* The Bluetooth USB module build into some devices needs to be reset on resume,
+ * this is a problem with the platform (likely shutting off all power) not with
+ * the module itself. So we use a DMI list to match known broken platforms.
+ */
+static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
+	{
+		/* Lenovo Yoga 920 (QCA Rome device 0cf3:e300) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920"),
+		},
+	},
+	{}
+};
+
 #define BTUSB_MAX_ISOC_FRAMES	10
 
 #define BTUSB_INTR_RUNNING	0
@@ -3013,6 +3029,9 @@ static int btusb_probe(struct usb_interf
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
+	if (dmi_check_system(btusb_needs_reset_resume_table))
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3099,12 +3118,6 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-
-		/* QCA Rome devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * explicitly request a device reset on resume.
-		 */
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
