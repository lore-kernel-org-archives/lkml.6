Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB07C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F50206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976984;
	bh=d3ERtPeQBuYf05umVBU/ZzTe4eKjbdLsdfPJgnKuOEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dm9TQ3D5P4WpZ3mjibHhx8snZ7bObVhlKt7TcuUmh84/yJcLQTMG9g6pkVbfdhZaV
	 levvGj99uVbKFSAHxzH5xbZBh0CpMuvFnwWKF9B6RalOJGM7aCQ+6RqVTsYDQSSYGi
	 BzDutU+b/mBmJpMbDnCXachDAecP3kB/eOllwuKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfAHTtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbfAHTb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF8B217D9;
        Tue,  8 Jan 2019 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975918;
        bh=d3ERtPeQBuYf05umVBU/ZzTe4eKjbdLsdfPJgnKuOEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ww3VAx/70WeeuMLJ6rePWCxO6HIXWOpTtZwLg8X/VAyYeV5d90MAcWK0kAB43jZ/o
         5Bv91dq78bQXWuw+BHWewE8VH+tY8uFvl/ttjH/1qgO7us1V9czumBUWH+rigNkgLd
         JvLF6ayzQSwNc7571zb2toH8clNucxFnDbbT+oKg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 83/97] Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029
Date:   Tue,  8 Jan 2019 14:29:32 -0500
Message-Id: <20190108192949.122407-83-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

[ Upstream commit 2da711bcebe81209a9f2f90e145600eb1bae2b71 ]

Include the new USB product ID for Intel Bluetooth device 22260
family(CcPeak)

The /sys/kernel/debug/usb/devices portion for this device is:

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0029 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 72 ++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd2e5cf14ea5..77b67a5f21ee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -343,6 +343,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
@@ -2054,6 +2055,35 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
+static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
+					     struct intel_boot_params *params,
+					     char *fw_name, size_t len,
+					     const char *suffix)
+{
+	switch (ver->hw_variant) {
+	case 0x0b:	/* SfP */
+	case 0x0c:	/* WsP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(params->dev_revid),
+			suffix);
+		break;
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(ver->hw_revision),
+			le16_to_cpu(ver->fw_revision),
+			suffix);
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2105,7 +2135,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
+	case 0x14:	/* CcP */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
@@ -2189,23 +2219,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
 	 *
 	 */
-	switch (ver.hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(params.dev_revid));
-		break;
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(ver.hw_revision),
-			 le16_to_cpu(ver.fw_revision));
-		break;
-	default:
+	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
+						sizeof(fwname), "sfi");
+	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
@@ -2221,23 +2237,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Save the DDC file name for later use to apply once the firmware
 	 * downloading is done.
 	 */
-	switch (ver.hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(params.dev_revid));
-		break;
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(ver.hw_revision),
-			 le16_to_cpu(ver.fw_revision));
-		break;
-	default:
+	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
+						sizeof(fwname), "ddc");
+	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
-- 
2.19.1

