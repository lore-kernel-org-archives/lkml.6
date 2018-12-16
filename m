Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A9217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrryzIZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeLPPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:52:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51127 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:52:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so10022447wmd.0;
        Sun, 16 Dec 2018 07:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N3knESCERZVZBEU7JMa5VqucN+zQIpgQS+62pp4ic6A=;
        b=CrryzIZUipjuv6OURQ2iA5g7t7rKFd7cw0rYyNSGK0GJZZ+HEewBpl30hG86O3/sP5
         fKP9vHqyhbCzP3PO47byvZIY3SZSk48GFoA2cWb521IbRjEzIgNlBVl/5U5B7zoqjpQJ
         Vp7CWngSsJEyMN6GW2B77BZNXBqtCjkmPk4LnlHV+MZBF9Zj/SA8Qu9hHGeJ1+0nu4td
         G0iV/ynNGp8EUmtoIjvVgTfIVxhG81ii2/0qjPtKkGizxSBay5lVFLpmOR0Pr4LvGDEv
         35Zr2A0408FM+4L0AwlAStjRj7vWDkjIg49baHX+bPlvEzLqMuyW1NGrkWDmGO5w/Ujr
         X+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N3knESCERZVZBEU7JMa5VqucN+zQIpgQS+62pp4ic6A=;
        b=PfW6viGKzmaNBMEED7QcMPaDzrgNUnXJID3KGmFbeDtftYTSwhZ6z+KTx5FJ0EpqHs
         4Qp29RQxGvnVqfQYLdyWWU4wKGop6qDKPVVej/xYWsZrHWrC7qzGU2F6wopu5ABd0rej
         AQ87ID3o8WjUh0NP5GjmIORg+p4I4gFmDlTgqEbpSY8AVi1xcvUnfAciX1htjxv0we3U
         zR8I5MSfLzvgpZBs8SJWQfVKP65RJRxX+fokB/2H6M/04RbgR1X7Z4LXFWF7eyXFVIho
         CHstna9XtnzJYl/RNrNogXXenuE8AUDtnGKgLy7mKMAFZyZ9xzAmEKvhREJWBLAR8E7Y
         xIcg==
X-Gm-Message-State: AA+aEWaLRBvHcdZneWtlsIcDsQlu8bzka4hGL4syeiLIRIp2cJVxOEAq
        PzvgYkPlxeay0HzZ78c8zp0=
X-Google-Smtp-Source: AFSGD/Wx5PzWNaRnwI36hM0Huap1746p7M4zeIc1ZPfAR8mI48NUo5XTWg4BqzKQtA+CvLThw6eHCw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr8723741wma.19.1544975529287;
        Sun, 16 Dec 2018 07:52:09 -0800 (PST)
Received: from arks.localdomain (36.red-88-18-46.staticip.rima-tde.net. [88.18.46.36])
        by smtp.gmail.com with ESMTPSA id p5sm7001652wmh.16.2018.12.16.07.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 07:52:08 -0800 (PST)
Date:   Sun, 16 Dec 2018 16:53:19 +0100
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mbrugger@suse.com, kernelrocks@gmail.com
Subject: [PATCH v2] HID: asus: Add support for the ASUS T101HA keyboard dock
Message-ID: <20181216155319.GA17189@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
specific UsagePage 0xff31. In consequence, some multimedia keys such as
brightness up and down are not working with hid-generic.

This commit adds the T101HA dock into the supported device list of the
hid-asus driver. It also prevents the dock's integrated touchpad to be
bound with hid-asus given that it is already working fine with
hid-multitouch.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---

Changes in v2:
- use the report descriptor's application usage to identify the dock's
  touchpad instead of the usb interface id

drivers/hid/hid-asus.c | 8 ++++++++
drivers/hid/hid-ids.h  | 1 +
2 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ab8bd40a77ed..951bb17ae8b2 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -70,6 +70,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_T100_KEYBOARD		BIT(6)
 #define QUIRK_T100CHI			BIT(7)
 #define QUIRK_G752_KEYBOARD		BIT(8)
+#define QUIRK_T101HA_DOCK		BIT(9)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -699,6 +700,11 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	/* use hid-multitouch for T101HA touchpad */
+	if (id->driver_data & QUIRK_T101HA_DOCK &&
+	    hdev->collection->usage == HID_GD_MOUSE)
+		return -ENODEV;
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "Asus hw start failed: %d\n", ret);
@@ -830,6 +836,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4206428c0ba2..f1eee2778b70 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -184,6 +184,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
 #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
+#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
-- 
2.20.0

