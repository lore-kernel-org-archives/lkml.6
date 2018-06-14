Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD75CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA6208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA6208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755487AbeFNUoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:44:12 -0400
Received: from mailrelay112.isp.belgacom.be ([195.238.20.139]:38648 "EHLO
        mailrelay112.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755272AbeFNUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:44:10 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3A68pqLB3Uysg5ZmIxsmDT+DRfVm0co7zxezQtwd8Z?=
 =?us-ascii?q?seMUKPad9pjvdHbS+e9qxAeQG9mDtrQc06L/iOPJYSQ4+5GPsXQPItRndiQuro?=
 =?us-ascii?q?EopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZv?=
 =?us-ascii?q?JuTyB4Xek9m72/q99pHPYwhEniaxba9vJxiqsAvdsdUbj5F/Iagr0BvJpXVIe+?=
 =?us-ascii?q?VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PGAv5c3krgfM?=
 =?us-ascii?q?QA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7S60/Vza/4KdxUBLmhi?=
 =?us-ascii?q?cJOSAk/m/UhMN/g75UrQm9pxBj2YPYfJ2ZOeBgcq7bYNgURXBBXsFUVyFZHIOz?=
 =?us-ascii?q?cZEPAPQfMulErInyuUECrRmkCgmqH+7v0TxIh3/w3aIkz+QtCxrJ0xImEtkTs3?=
 =?us-ascii?q?rUtM34OaQPXeyv0qXFwijPY+lI1Tr58oTEbBAsrP6KULlta8Te01MvGBnAjliI?=
 =?us-ascii?q?rIzlOC6a2foVvmiA6upgSfqvi2k6qwFtujSvxtkjio3Oho8N0VDE8Dl5wJ4vKd?=
 =?us-ascii?q?2mVkF7e8CrH4VMuCGZKYR6WMYiQ2ZvuCY90LEJpZm7fC0SxJQmwR7QdeCHfpCL?=
 =?us-ascii?q?7x7+TuqdPzh1iG9/dL6hgxu+61asx+3zW8Ws1VZFtCtFkt3CtnAX0BzT79CKSu?=
 =?us-ascii?q?Vj8Ue7xzmAyRzc6uJaLkwul6rUMZghz6UrlpoQsUXDGDH5mFnsgKCNaEoo4vKo?=
 =?us-ascii?q?5Pj/YrX6up+cMJd5igP/MqQtncy/Gv81MgsQUGiB/+Szyrnj8Vf+QLVQgf08ir?=
 =?us-ascii?q?PZv4zCJcQHuq65BBdY3Z095Ba5DTepytEYnXgBLF5fZBKHjpPpO0rJIPD5F/ew?=
 =?us-ascii?q?nU+snSxxx//YI7LhAo/CLmTZnLj9erZ97lZWyBAvwtBH+5JUFrYBLer3Wk/wst?=
 =?us-ascii?q?zYExA4PxW1w+bhENV9y58eVHmRAq+WLqzSq0WE5uExLOmWYo8apjL9J+Ii5/70?=
 =?us-ascii?q?gn8zgUUdcrWx3ZsLdHC4GexrI0GYYXrqn9cAHn4GvgkgQ+zwjl2NTzpTam2sX6?=
 =?us-ascii?q?Iz+D47EpiqDYTdSYC3hryOwiO7EodRZmBcBVDfWUvvIoGFXeocLSGfOMlslhQa?=
 =?us-ascii?q?WrW7DYwszxejsEn90bUjZu7V/DAI8JPlzMVpz/PcmAt09jFuCcmZlWaXQDJahG?=
 =?us-ascii?q?QNEiE7xq1yqk9wjFWK14BjgO1eGMAV7f4aAU8BKZfAwrkiWJjJUQXbc4LRRQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BfBgA30iJb//4d8VFdHQEBBQELAYNIQ?=
 =?us-ascii?q?oEfjQSLcwGBXVIBljMLhGyCSiI3FQECAQEBAQEBAgFsKII1IoMQAhwjLW0QFYU?=
 =?us-ascii?q?5rDGIBESBaIYbhESBP4InB4p5AodQkT4HAo8Bh3WFQgGRQYFXIoFSbYMXgiAXj?=
 =?us-ascii?q?hk9kHMBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BfBgA30iJb//4d8VFdHQEBBQELAYNIQoEfjQSLcwGBXVI?=
 =?us-ascii?q?BljMLhGyCSiI3FQECAQEBAQEBAgFsKII1IoMQAhwjLW0QFYU5rDGIBESBaIYbh?=
 =?us-ascii?q?ESBP4InB4p5AodQkT4HAo8Bh3WFQgGRQYFXIoFSbYMXgiAXjhk9kHMBAQ?=
Received: from 254.29-241-81.adsl-dyn.isp.belgacom.be (HELO smtp.vereecke.mooo.com) ([81.241.29.254])
  by relay.skynet.be with ESMTP; 14 Jun 2018 22:44:07 +0200
Received: from Hermes.vereecke.mooo.com (Hermes.vereecke.mooo.com [192.168.4.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.vereecke.mooo.com (Postfix) with ESMTPSA id C558DDFE9B;
        Thu, 14 Jun 2018 22:44:07 +0200 (CEST)
Date:   Thu, 14 Jun 2018 22:44:07 +0200 (CEST)
From:   vereecke.jan@skynet.be
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
cc:     benjamin.tissoires@redhat.com, jikos@kernel.org
Subject: [PATCH] Patch enabling Fn function keys for Laptop Asus G730 (keyboard
 0x1869)
Message-ID: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
User-Agent: Alpine 2.21 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch enabling (most of) the Fn function keys for the Asus 
ROG Strix GL730 Laptop. The keyboard identifies as a USB device 0x1869.

This patch enables:
     volume/mute keys, ROG key, rew/play/ff,
     monitor and keyboard brightness keys,
     Touchpad toggle key,
     Calculator key

'Touchpad on/off' Key returns keycode 33, which is mapped to the 'p' key.
'Display on/off' returns keycode 253, which is mapped in X11 to NoSymbol
'Airplane Key' returns keycode 255, which is mapped in X11 to NoSymbol

The following keys are not activated yet:
        Microphone Mute key, Fan key, Display Switch key

This patch is against the 4.17-rc7 kernel, for the x86 architecture

diffstat for this patch is:
  hid-asus.c   |    2 ++
  hid-ids.h    |    1 +
  hid-quirks.c |    1 +
  3 files changed, 4 insertions(+)

To apply the patch, in the root of the kernel tree use:
patch -p1 < AsusGL703-Keyboard-Fn-keys.patch

----------------------------------------------------------------------------------------------
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 88a5672..8f4f3c1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -781,6 +781,8 @@ static const struct hid_device_id asus_devices[] = {
                 USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
                 USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+               USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4), QUIRK_USE_KBD_BACKLIGHT },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
                 USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
           QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 46f5ecd..93b958f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -187,6 +187,7 @@
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
+#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4 0x1869

  #define USB_VENDOR_ID_ATEN             0x0557
  #define USB_DEVICE_ID_ATEN_UC100KM     0x2004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 587e268..ebb1353 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -286,6 +286,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD4) },
         { HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
         { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },

