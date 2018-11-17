Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CBD20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="TMmuAnUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CBD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telfort.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKQXcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:32:55 -0500
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:52093 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbeKQXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:32:55 -0500
X-Greylist: delayed 783 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Nov 2018 18:32:51 EST
Received: from cpsps-ews11.kpnxchange.com ([10.94.84.178]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 17 Nov 2018 14:03:09 +0100
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=11;e1=10;e2=11;e3=10);EVW:Whi
        te;BM:Clean;FinalVerdict:Clean
X-Brightmail-Tracker: H4sIAAAAAAAAC+NgFprFJsWRWlGSWpSXmKPExsVyuJKZVbdX
        8EO0wZw5T3dwWVzeNYfNgdHj8ya5AMYo1sy8pPyKBNaMnt0X2Apma1f83fSEtYHxhkoXIy
        eHhIC2xKH+56xdjFxA9kdGiX/LJ7BBJNQllnw5yQiSEBJYyijx++5MRpAEs4CZxLzND5kh
        bHmJ5q2zoWxxiVtP5jOBNLAIdDJLXDzYBdW9nVHi0/dusCo2AWWJnW/egK0QFgiRmPBgKR
        tEt7rE5s9b2SFWm0r8/tgDZosIKEhs7n3GCmLzCthK3H//ECzOIqAqsWjyVbCLRAUiJM6+
        XMcIUSMocXLmExYQW0hAVuLruotQM4Ml/t/4yzqBUWQWkidmIXliFpInZiEZtYCRZRWjRH
        JBcUGxbmp5saGhXnZBHpChl5OfnJiziREY/le9NWx3MH7tiz3EaMrBpCTKa9z3PlqILyk/
        pTIjsTgjvqg0J7VYSYp3zwaHKCFhuHBxaVJuZnFxZn7eIUZrDg4lCd5cgQ/RQoJFqempFW
        mZOcAIhmqV5RXu0YsUEkOWQdZtzMGjJMJbCtLNW1yQmFucmQ7VKQnRKQQTReg6xRjI8W7B
        /+nMHA2NDTOYhVjy8vNSpcR5K0CmCIDUZ5TmwZ0gJcPrfA3oKVEkCYRZoEQ4scXg2C1GMY
        6HTByPmaCmAYUZgMCA8RWjIQejkjCvAchwnsy8EoQLJXjNFhoAfQ0VRBj6CugtJqC3nl99
        D/JWSWIJFm9BRRG6pBoYn0xMTL6zbtHUy6F7J5Rv3nH60Me040Kev17UX558UEBBYVf8WZ
        Zn3OckmRY3X+e7xdFju6wyO7PYb56m9YRXcjOfCJ63nFr0ptnHqq8ieP6p5O6ph2WVVSLU
        p28JyDh2aOoKwaSD6QEOMYu82W5XuEvudzkc57Y/Y1PIvpQfp4s1UtRkryXFKrEUZyQaaj
        EXFScCAPdF1OetAwAA
X-VPER-ID: 371D4FD463D92D24577D573A8A08E266
X-CMAE-Analysis: v=2.3 cv=MZq9RK3f c=1 sm=1 tr=0
         a=YL3AR/2x8YElkrFdNIJrSQ==:117 a=WlLoZYvoDPkrvwfrrc3pQQ==:17
         a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=yvFk4-U7QBjicrOkR6sA:9
         a=DZbPjfIs5ozEPSMa:21 a=wFqw2eA9BNEZ2AtQ:21 a=QEXdDO2ut3YA:10
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews11.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Sat, 17 Nov 2018 14:03:09 +0100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; d=telfort.nl; s=telfort01;
        c=relaxed/relaxed; t=1542459789;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2ubaeisAKtJBS6UR35zBWszNci05lJu+1qN1ZWSj37s=;
        b=TMmuAnUu1AQBhBy6LBFU06YI/9H4NyXtwEIRAkIkUtbYduH1X61giPqpnb6XIOp8NdvUL2GToKG
        w622nwuEBS3LF1n2aOyhOsmR+AMG5G+Tbz7turO4AOPHEPf62OJ0lhU0JZR0I8ZvIkGtwqHNXlQxg
        Q0t9mQvAGC9QKPIOFA0=
Received: from [192.168.188.20] ([145.132.48.198]) by CPSMTPM-TLF102.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 17 Nov 2018 14:03:09 +0100
From:   Ferry Toth <ftoth@telfort.nl>
Subject: Unloading acpi table through configfs causes NULL pointer dereference
 bug
Cc:     Jan Kiszka <jan.kiszka@siemens.com>
X-Mozilla-News-Host: news://news://news.gmane.org:119
To:     linux-kernel@vger.kernel.org
Message-ID: <33fa0c51-1de6-9300-cd5e-1a8b17363675@telfort.nl>
Date:   Sat, 17 Nov 2018 14:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
X-OriginalArrivalTime: 17 Nov 2018 13:03:09.0836 (UTC) FILETIME=[E3C774C0:01D47E75]
X-RcptDomain: vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4.13 we have patch 'ACPI: configfs: Unload SSDT on configfs entry
removal' in the kernel.

However when I try to actually unload a table I get a bug check. I have
tested this on Intel Edison Arduino with 4.18 x86_64 using 2 different
tables, 1 called arduino, providing I2C/SPI/HSU and a 2nd one called 
leds, providing a simple LED connected to a gpio. Result is similar. 
Logs below.

FYI Intel Edison has no BIOS and receives ACPI tables in part from 
U-Boot and in my case Arduino support through configfs. Loading tables 
in this fashion appears to work just as fine as through a cpio, with the 
potential bonus of being able to unload them.

The use case for unloading tables on a platform like Edison Arduino 
would of course be that certain gpio lines are muxed, like a led with a 
spi line. During platform configuration one would like to provide the 
user feedback through flashing a LED, while operating normally the LED 
is less important and the line is used for SPI_CLK. Unloading the LED 
table is needed to be able to load the SPI table without reboot.

I'm hoping that if this patch has worked in the past it will be easy 
enough to make it work again. Any pointers in the right direction are 
appreciated.

ARDUINO
-------
rmdir /sys/kernel/config/acpi/table/arduino/
ACPI: Host-directed Dynamic ACPI Table Unload
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 7181 Comm: kworker/u4:0 Not tainted 4.18.0-edison-acpi-standard
#1
Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542
2015.01.21:18.19.48
Workqueue: kacpi_hotplug acpi_device_del_work_fn
RIP: 0010:create_of_modalias.isra.1+0x4d/0x150
Code: 44 24 10 00 00 00 00 48 c7 44 24 08 ff ff ff ff 65 48 8b 04 25 28 00
00 00 48 89 44 24 18 31 c0 e8 4a a2 03 00 48 8b 4c 24 10 <0f> b6 01 84 c0 74
27 48 c7 c7 40 13 f4 a2 0f b6 f0 8d 50 20 f6 04
RSP: 0018:ffff9c51c0c6bc10 EFLAGS: 00010246
RAX: 0000000000001001 RBX: ffff8fa4bb3d4196 RCX: 0000000000000000
RDX: 0000000000001001 RSI: 0000000000000286 RDI: ffff8fa4bd804260
RBP: ffff8fa48ca08210 R08: 0000000000001001 R09: 0000000000000000
R10: ffff8fa48ca08000 R11: ffffffffa305fe3d R12: 0000000000000785
R13: 0000000000000000 R14: ffff8fa4bc698010 R15: ffff8fa4bdad1060
FS:  0000000000000000(0000) GS:ffff8fa4bf300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000c8de000 CR4: 00000000001006e0
Call Trace:
  ? vsnprintf+0x2b6/0x4b0
  __acpi_device_uevent_modalias+0xde/0x100
  spi_uevent+0xd/0x40
  dev_uevent+0x96/0x2c0
  kobject_uevent_env+0x2e7/0x7f0
  device_release_driver_internal+0x227/0x240
  bus_remove_device+0xe0/0x150
  device_del+0x133/0x350
  ? klist_iter_exit+0x17/0x30
  device_unregister+0x11/0x60
  acpi_spi_notify+0x89/0xa0
  notifier_call_chain+0x42/0x60
  blocking_notifier_call_chain+0x39/0x60
  acpi_device_del_work_fn+0x62/0xb0
  process_one_work+0x1e3/0x3c0
  worker_thread+0x28/0x3c0
  ? set_worker_desc+0xb0/0xb0
  kthread+0x10e/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x35/0x40
Modules linked in: iptable_nat nf_nat_ipv4 nf_nat spi_pxa2xx_platform
smsc95xx pwm_lpss_pci pwm_lpss brcmfmac brcmutil spi_pxa2xx_pci hci_uart
btbcm ti_ads7950 industrialio_triggered_buffer kfifo_buf spidev mmc_block
sdhci_pci cqhci sdhci led_class mmc_core
CR2: 0000000000000000
---[ end trace 77bdc8463ac6088b ]---

LEDS
----
root@edison:~# rmdir /sys/kernel/config/acpi/table/leds/
ACPI: Host-directed Dynamic ACPI Table Unload
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 4316 Comm: kworker/u4:2 Not tainted 4.18.0-edison-acpi-standard
#1
Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542
2015.01.21:18.19.48
Workqueue: kacpi_hotplug acpi_device_del_work_fn
RIP: 0010:create_of_modalias.isra.1+0x4d/0x150
Code: 44 24 10 00 00 00 00 48 c7 44 24 08 ff ff ff ff 65 48 8b 04 25 28 00
00 00 48 89 44 24 18 31 c0 e8 4a a2 03 00 48 8b 4c 24 10 <0f> b6 01 84 c0 74
27 48 c7 c7 40 13 74 bd 0f b6 f0 8d 50 20 f6 04
RSP: 0018:ffffaf4800257cf8 EFLAGS: 00010246
RAX: 0000000000001001 RBX: ffff8c403a877176 RCX: 0000000000000000
RDX: 0000000000001001 RSI: 0000000000000296 RDI: ffff8c403d804260
RBP: ffff8c403ae98a10 R08: 0000000000001001 R09: 0000000000000000
R10: ffff8c403ae98800 R11: ffffffffbd85ff0d R12: 00000000000007a5
R13: 0000000000000000 R14: ffff8c403ae98a60 R15: ffff8c403dad1060
FS:  0000000000000000(0000) GS:ffff8c403f300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003b89c000 CR4: 00000000001006e0
Call Trace:
  __acpi_device_uevent_modalias+0xde/0x100
  dev_uevent+0x96/0x2c0
  kobject_uevent_env+0x2e7/0x7f0
  ? __pm_runtime_disable+0x13/0xc0
  device_del+0x235/0x350
  acpi_device_del_work_fn+0x6a/0xb0
  process_one_work+0x1e3/0x3c0
  worker_thread+0x28/0x3c0
  ? set_worker_desc+0xb0/0xb0
  kthread+0x10e/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x35/0x40
Modules linked in: i2c_dev ledtrig_netdev ledtrig_oneshot ledtrig_timer
leds_gpio ledtrig_heartbeat iptable_nat nf_nat_ipv4 nf_nat
spi_pxa2xx_platform smsc95xx pwm_lpss_pci pwm_lpss brcmfmac brcmutil
spi_pxa2xx_pci hci_uart btbcm ti_ads795>
CR2: 0000000000000000
---[ end trace 09430e0923010718 ]---

