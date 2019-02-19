Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D79E21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4iThV89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfBSJWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:22:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36094 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfBSJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:22:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so9964928pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RWyKeEHKnn9g3v/vRCpMjfboYr2Uf3Uk1ZfDc2b9ekk=;
        b=A4iThV89NA1ppX2NFg0ox6bppMgPozCdVYB0+DqUBT7Dt8r77UMkznUw90eoe2uEpx
         gUPzR6YYF1Ul5gyM5jtPUXHTuBP8N5GZBl8lTN7X8z1XrdwdYpxIk+ld0LKVanOOwama
         oOzmIR2pjsA2xDBofCwK1IuDQmeqU+7PX/3CYc8ojpNT5kKFoRk01LhgpzR+VXB8IYAs
         /JrWkCo6oD/2GqtwVea0hj/fckYfV8/EYnOPlRMR5rRovy6A7hG1DrSoO08uehECV4Yl
         54y1EOo2qpdP4hLKiQMVJzlSnNrnGMaPXucasol5XZRx3rN7QFD5WjDsDy0mboVaiOZe
         RoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RWyKeEHKnn9g3v/vRCpMjfboYr2Uf3Uk1ZfDc2b9ekk=;
        b=RS/KJZ8BPmVhdyIxUNaJfswjaRgaY24VS9C5NR+djsiZJANR0/gkujq/yentejTLCR
         pgIi7id70emqEwcVjwilSY/VvZYs0Z5YHm/WwqTtp8Ou3NhY4BaQKz1hOAWMu3fEVvb5
         i5egTf4B/HWmCE/Wygxxn/NhIUC4tft6mUpAcDD5yfaRTUGqfepk1cj/hNqaJsz60LAR
         41tmtf1sVd+A72wl67kdYBceep44B5PeiiAiCAEYY89nzY1++0lvnojioP1apVAiKJGA
         tGczTlVcAOoZMcsHKtQKVUwSoVOztEFhRH9V9mRFHHLZIC95vXt993SbaQzhgsCq50ij
         Z3tA==
X-Gm-Message-State: AHQUAuble2ONkSY6bLPH16XwE+ewcf1FIDzPqVnuvBu3hKDhNNv0w1hf
        9ZtGxc8444+CGQ0NwABcwM4=
X-Google-Smtp-Source: AHgI3IYCbNLZejliujwr86Xx629XKeqsPWJELr2Td0ipyuhnazAZtvfZ664KtcPK4fFbj4Houiy8ww==
X-Received: by 2002:a62:36c7:: with SMTP id d190mr17360996pfa.178.1550568120055;
        Tue, 19 Feb 2019 01:22:00 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-242-146.dynamic-ip.hinet.net. [114.36.242.146])
        by smtp.gmail.com with ESMTPSA id p12sm33244102pfj.81.2019.02.19.01.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:21:59 -0800 (PST)
From:   saumah <saumah@gmail.com>
To:     sudip.mukherjee@codethink.co.uk
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        saumah <saumah@gmail.com>
Subject: [PATCH V3] parport_serial.c change for fix hanging problem.
Date:   Tue, 19 Feb 2019 17:21:48 +0800
Message-Id: <20190219092148.4093-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parport_serial.c change for fix hanging problem while suspend machine. parport_seria.c support the same vendor id and device id definition as sunix multi-I/O card driver, when the sunix multi-io borad driver is installed,there are two drivers to support the same sunix multi-io card,it will cause operation error.

Signed-off-by: saumah <saumah@gmail.com>
---
 parport_serial.c | 180 +----------------------------------------------
 1 file changed, 1 insertion(+), 179 deletions(-)

diff --git a/parport_serial.c b/parport_serial.c
index ae9e01e..f54d1d3 100644
--- a/parport_serial.c
+++ b/parport_serial.c
@@ -38,29 +38,10 @@ enum parport_pc_pci_cards {
 	siig_2p1s_20x,
 	siig_1s1p_20x,
 	siig_2s1p_20x,
-	timedia_4078a,
-	timedia_4079h,
-	timedia_4085h,
-	timedia_4088a,
-	timedia_4089a,
-	timedia_4095a,
-	timedia_4096a,
-	timedia_4078u,
-	timedia_4079a,
-	timedia_4085u,
-	timedia_4079r,
-	timedia_4079s,
-	timedia_4079d,
-	timedia_4079e,
-	timedia_4079f,
-	timedia_9079a,
-	timedia_9079b,
-	timedia_9079c,
 	wch_ch353_1s1p,
 	wch_ch353_2s1p,
 	wch_ch382_2s1p,
 	brainboxes_5s1p,
-	sunix_2s1p,
 };

 /* each element directly indexed from enum list, above */
@@ -127,29 +108,10 @@ static struct parport_pc_pci cards[] = {
 	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
 	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
 	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
-	/* timedia_4078a */		{ 1, { { 2, -1 }, } },
-	/* timedia_4079h */             { 1, { { 2, 3 }, } },
-	/* timedia_4085h */             { 2, { { 2, -1 }, { 4, -1 }, } },
-	/* timedia_4088a */             { 2, { { 2, 3 }, { 4, 5 }, } },
-	/* timedia_4089a */             { 2, { { 2, 3 }, { 4, 5 }, } },
-	/* timedia_4095a */             { 2, { { 2, 3 }, { 4, 5 }, } },
-	/* timedia_4096a */             { 2, { { 2, 3 }, { 4, 5 }, } },
-	/* timedia_4078u */             { 1, { { 2, -1 }, } },
-	/* timedia_4079a */             { 1, { { 2, 3 }, } },
-	/* timedia_4085u */             { 2, { { 2, -1 }, { 4, -1 }, } },
-	/* timedia_4079r */             { 1, { { 2, 3 }, } },
-	/* timedia_4079s */             { 1, { { 2, 3 }, } },
-	/* timedia_4079d */             { 1, { { 2, 3 }, } },
-	/* timedia_4079e */             { 1, { { 2, 3 }, } },
-	/* timedia_4079f */             { 1, { { 2, 3 }, } },
-	/* timedia_9079a */             { 1, { { 2, 3 }, } },
-	/* timedia_9079b */             { 1, { { 2, 3 }, } },
-	/* timedia_9079c */             { 1, { { 2, 3 }, } },
 	/* wch_ch353_1s1p*/             { 1, { { 1, -1}, } },
 	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
 	/* brainboxes_5s1p */           { 1, { { 3, -1 }, } },
-	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
 };

 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -229,25 +191,6 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
-	/* PCI_VENDOR_ID_TIMEDIA/SUNIX has many differing cards ...*/
-	{ 0x1409, 0x7168, 0x1409, 0x4078, 0, 0, timedia_4078a },
-	{ 0x1409, 0x7168, 0x1409, 0x4079, 0, 0, timedia_4079h },
-	{ 0x1409, 0x7168, 0x1409, 0x4085, 0, 0, timedia_4085h },
-	{ 0x1409, 0x7168, 0x1409, 0x4088, 0, 0, timedia_4088a },
-	{ 0x1409, 0x7168, 0x1409, 0x4089, 0, 0, timedia_4089a },
-	{ 0x1409, 0x7168, 0x1409, 0x4095, 0, 0, timedia_4095a },
-	{ 0x1409, 0x7168, 0x1409, 0x4096, 0, 0, timedia_4096a },
-	{ 0x1409, 0x7168, 0x1409, 0x5078, 0, 0, timedia_4078u },
-	{ 0x1409, 0x7168, 0x1409, 0x5079, 0, 0, timedia_4079a },
-	{ 0x1409, 0x7168, 0x1409, 0x5085, 0, 0, timedia_4085u },
-	{ 0x1409, 0x7168, 0x1409, 0x6079, 0, 0, timedia_4079r },
-	{ 0x1409, 0x7168, 0x1409, 0x7079, 0, 0, timedia_4079s },
-	{ 0x1409, 0x7168, 0x1409, 0x8079, 0, 0, timedia_4079d },
-	{ 0x1409, 0x7168, 0x1409, 0x9079, 0, 0, timedia_4079e },
-	{ 0x1409, 0x7168, 0x1409, 0xa079, 0, 0, timedia_4079f },
-	{ 0x1409, 0x7168, 0x1409, 0xb079, 0, 0, timedia_9079a },
-	{ 0x1409, 0x7168, 0x1409, 0xc079, 0, 0, timedia_9079b },
-	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },

 	/* WCH CARDS */
 	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
@@ -258,14 +201,6 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_5s1p },

-	/*
-	 * More SUNIX variations. At least one of these has part number
-	 * '5079A but subdevice 0x102. That board reports 0x0708 as
-	 * its PCI Class.
-	 */
-	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
-	  0x0102, 0, 0, sunix_2s1p },
-
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -374,114 +309,7 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
-	[timedia_4078a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079h] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4085h] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4088a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4089a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4095a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4096a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4078u] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4085u] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079r] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079s] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079d] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079e] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_4079f] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_9079a] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_9079b] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
-	[timedia_9079c] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
+
 	[wch_ch353_1s1p] = {
 		.flags          = FL_BASE0|FL_BASE_BARS,
 		.num_ports      = 1,
@@ -507,12 +335,6 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
-	[sunix_2s1p] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
-		.num_ports	= 2,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
-	},
 };

 struct parport_serial_private {
--
2.17.1

