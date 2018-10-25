Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D7ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD1C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD1C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJYU5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:57:02 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:40802 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYU5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:57:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id E90C3201D9;
        Thu, 25 Oct 2018 14:24:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q8ByWkGsa2LX; Thu, 25 Oct 2018 14:24:24 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 523C3201CF;
        Thu, 25 Oct 2018 14:24:24 +0200 (CEST)
Received: from [10.182.7.41] (10.182.7.41) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 14:24:23 +0200
From:   Dennis Wassenberg <dennis.wassenberg@secunet.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dennis.wassenberg@secunet.com; keydata=
 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
 YPsSSSBN/R6Xmw==
Organization: secunet Security Networks AG
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        "Maxim Moseychuk" <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: USB-C device hotplug issue
Message-ID: <7d444d00-5144-452d-4229-e77d38a991f5@secunet.com>
Date:   Thu, 25 Oct 2018 14:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 523B41F7-128C-40BA-BC11-617919484B70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a question regarding the usb hub driver (drivers/usb/core/hub.c).

There is the following scenario. I am using the Lenovo T580 device with the Lenovo UltraDock CS18 docking station. If I plug an usb-c device to the docking station there is one device which will not be recognized (SanDisk Ultra USB-C Flash Drive, https://www.sandisk.com/home/mobile-device-storage/ultra-usb-type-c). An other usb-c devices (SanDisk Extreme 900 SSD, https://www.sandisk.com/home/ssd/extreme-900-ssd) works fine. I don’t have that much USB-C devices available, so there is one device working and the other one not.

I made some analysis of the situation where I attached the SanDisk Ultra USB-C Flash Drive.
I added some debug logs in drivers/usb/core/hub.c in port_event and hub_port_reset and activated all dynamic debug prints in hub.c. The output is the following:

[  724.110784] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
[  724.110789] usb 4-1-port1: link state change
[  724.114953] usb 4-1-port1: do warm reset
[  724.168109] usb 4-1-port1: not warm reset yet, waiting 50ms
[  724.220768] usb 4-1-port1: not warm reset yet, waiting 200ms
[  724.425188] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
[  724.425906] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
[  724.477429] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
[  724.477980] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x0!

The same situation with SanDisk Extreme 900 SSD:

[  863.647484] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
[  863.647965] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
[  863.648305] usb 4-1-port1: status 0203, change 0001, 10.0 Gb/s
[  863.758573] usb 4-1-port1: debounce total 100ms stable 100ms status 0x203
[  863.773495] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
[  863.773699] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
[  863.826311] usb 4-1.1: new SuperSpeedPlus USB device number 6 using xhci_hcd
[  863.840002] usb 4-1.1: udev 6, busnum 4, minor = 389
[  863.840010] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5593
[  863.840014] usb 4-1.1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[  863.840018] usb 4-1.1: Product: EXTREME900
[  863.840022] usb 4-1.1: Manufacturer: SanDisk
[  863.840026] usb 4-1.1: SerialNumber: 10000019DF56

So, at first I am wondering if the usb hub port was in USB_SS_PORT_LS_U3 if I attach the SanDisk Ultra USB-C Flash Drive. In case of the SanDisk Extreme 900 the usb hub port is in USB_SS_PORT_LS_U0. What’ the reason for that?

I read https://www.kernel.org/doc/html/v4.14/driver-api/usb/power-management.html. In this test usb core was bootet wird autosuspend=-1.Additionally the <hubdev-portX>/power/pm_qos_no_power_off sysfs variable is always set to 1. Nevertheless the hub port is in LS U3, but only using SanDisk Ultra USB-C Flash Drive.

I looked through the code and wondered why the USB_PORT_FEAT_C_CONNECTION bit is cleared at successful warm usb 3 reset in hub_port_reset.
In case of the Ultra USB-C Flash Drive at first the link state change is detected. Directly after executing the actual hub_port_reset the USB_PORT_FEAT_C_CONNECTION bit will change to 1. But the hub_port_reset code will set this bit to 0. At the next run the bit remains 0 and the connect_change flag in port_event will not be set. That  means the USB_PORT_FEAT_C_CONNECTION flag will be cleared without taking it into account. That’s why this device will not be detected correctly.

If I modify the code in this way that I did’t clear the USB_PORT_FEAT_C_CONNECTION bit in hub_port_reset on warm usb3 reset this flag is still set during the next run. This makes sure that the connect_change flag in port_event is set and the usb device is detected correctly.
Is this code change correct or will it break other use cases? Are there any other ways to make the kernel detect that usb device at the docking station?

Please refer to the output of the modified usb_hub_reset code:

[  121.566344] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
[  121.566805] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
[  121.566810] usb 4-1-port1: link state change
[  121.573481] usb 4-1-port1: do warm reset
[  121.625297] usb 4-1-port1: not warm reset yet, waiting 50ms
[  121.677854] usb 4-1-port1: not warm reset yet, waiting 200ms
[  121.881091] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
[  121.881454] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
[  121.933109] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
[  121.933407] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
[  121.933861] usb 4-1-port1: status 0203, change 0001, 10.0 Gb/s
[  122.042540] usb 4-1-port1: debounce total 100ms stable 100ms status 0x203
[  122.056865] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
[  122.057230] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
[  122.109166] usb 4-1.1: new SuperSpeed USB device number 5 using xhci_hcd
[  122.122392] usb 4-1.1: udev 5, busnum 4, minor = 388
[  122.122399] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5596
[  122.122404] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  122.122408] usb 4-1.1: Product: Ultra T C
[  122.122412] usb 4-1.1: Manufacturer: SanDisk
[  122.122415] usb 4-1.1: SerialNumber: 4C531001400624115002
[  122.124151] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
[  122.125042] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x0!


The code change for Kernel 4.14 look as follows:

Subject: [PATCH] usb: core: do not clear USB_PORT_FEAT_C_CONNECTION on warm
 hub port reset

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 drivers/usb/core/hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a9db0887edca..9b4dfe6c8829 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 					USB_PORT_FEAT_C_BH_PORT_RESET);
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_PORT_LINK_STATE);
-			usb_clear_port_feature(hub->hdev, port1,
+
+			if (!warm)
+				usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
 
 			/*
-- 
2.17.1


Thank you for your help!

Best regards,

Dennis
