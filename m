Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F4220660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977694;
	bh=six3iyUY145Sh6nLkNfMcPSzAnUFATLQInMCjSFuxH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NPLTZfLrUwmtvK78rdicLtGESZm1Dcic97dZ5fIkfFFyN4j5Sn5aW9uBqOTpGlAxS
	 eCgGFemTkd6yjQTbS59VjXzn98BVI8vZFFI8qkK5G5/rcwS8+6ZtkSrHDb+GJhYkdm
	 QxGzqY3CuGumdTTQZVAAoM/4QV76dpmrkv5otwNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfAHUBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbfAHT3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8665D2070B;
        Tue,  8 Jan 2019 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975755;
        bh=six3iyUY145Sh6nLkNfMcPSzAnUFATLQInMCjSFuxH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGtJasnUb02eXrMHujYTlj98V7+6pE2LZXux3LhaJ8tKKO2F2hsrUzt+19DJ/BtCb
         gHPf35q4N/dqAsIxfRv5UySZsbaUR4JpgkAYnA4s2CloOQHMIC6LQ8uNUWNgNgHsE7
         SEYXbdREEN8MKA6/BJB1vKEG6531DOWUIwxLOMFE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 099/117] Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029
Date:   Tue,  8 Jan 2019 14:26:07 -0500
Message-Id: <20190108192628.121270-99-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
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
index 7439a7eb50ac..05c8a7ed859c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -344,6 +344,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
@@ -2055,6 +2056,35 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2106,7 +2136,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
+	case 0x14:	/* CcP */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
@@ -2190,23 +2220,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2222,23 +2238,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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

