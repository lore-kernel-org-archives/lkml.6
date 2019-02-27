Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FB12063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5DlPHoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfB0Jjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:39:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36636 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0Jja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:39:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so7749575pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1YcwB19SZERWAVswN3oGQNHnhJtC4SkqMVJ2HiFCQlQ=;
        b=n5DlPHoHbkNqPJiUFk0n9G0rQD8vYTulurRKVvehWRwbiNjxG54ZdnsrwpL/1WUYOO
         sfLxhgPsTP4oV7hG8xtWW2KgX5xwSPc6MDVnldWtJn+BQUvoWyp3Lmc547vt9eSZaPOj
         J+9QXOUIRtDaB5BpDQHTg4CFyWJrxfrTnwxNABnMFtx/Ck9k6Qfl2XzRIKRoaGkyF92G
         RcWAW1I3sFOIvDooweaDFMuSqkVuFGELN3s4fpCYyaiJtnaBEFpiRDnSOvvPV01txQbp
         66oDAlNdzjEjAMQ2NnYKbBecjHKywzI3ZWurkDlicgwohelAnNFPekV6oHfpdgeIuBdi
         MC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1YcwB19SZERWAVswN3oGQNHnhJtC4SkqMVJ2HiFCQlQ=;
        b=sT5nfWfz1tXboCKuazEV/OirbLcsvAIKsrUvg3EJR5NB37gt600O34JjkOvLOvKh2X
         jcDZbfGNPp/wTiIge/lPWCEUM2YUQlsKBsKzMFb4EyMm3O2IPGl10UGdpnlfl6evsTcb
         qfzvttmfyOCqE0r2IGcxUIsh5m9ksiQynVZdOtJIMdV1kDNJc6SaV07T2+T6fFhwh5H1
         cGmJZXYyI44RP+39CqzV6g4yrxEU4juHr1RDY+bIRojsEZ3TOcdT3pW2LLSrsn/43YaE
         sQAhjokMgEXp2zZbG9khYtjHj8/geDHI13fWyiFBaongdsspMa9IMkQsC3oGIbEAGUuh
         ELqA==
X-Gm-Message-State: AHQUAuYEGrvaFJdqkeQJcPvAICi90CGF7YgS9ZaI12F/mW+dqVxoKuBf
        hKIs/JX3gZdni0a262PyWd8=
X-Google-Smtp-Source: AHgI3IZlR346D+iYN/GVSC/NGgaew+N9J18AX0R3rybythzrvHyzcGuWCRwTFWYfy1qHruubl0Vy9Q==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr2073424pgk.195.1551260369530;
        Wed, 27 Feb 2019 01:39:29 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-235-188.dynamic-ip.hinet.net. [114.36.235.188])
        by smtp.gmail.com with ESMTPSA id d16sm19371286pfo.112.2019.02.27.01.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 01:39:28 -0800 (PST)
From:   Morris Ku <saumah@gmail.com>
To:     sudipm.mukherjee@gmail.com
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        linux-parport@lists.infradead.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] parallel: fix driver conflict issue.
Date:   Wed, 27 Feb 2019 17:39:13 +0800
Message-Id: <20190227093913.2928-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am an engineer in the software team at SUNIX Inc.,maintain SUNIX
Multi-I/O Board Device driver,we plan to submit our drivers to the 
kernel,therefore,i want to modify 8250's files for resolve 
driver conflict issue.
---
 parport/parport_pc.c     |  17 +---
 parport/parport_serial.c | 179 ---------------------------------------
 2 files changed, 1 insertion(+), 195 deletions(-)

diff --git a/parport/parport_pc.c b/parport/parport_pc.c
index 9c8249f7..78129f09 100644
--- a/parport/parport_pc.c
+++ b/parport/parport_pc.c
@@ -2622,11 +2622,6 @@ enum parport_pc_pci_cards {
 	lava_parallel_dual_b,
 	boca_ioppar,
 	plx_9050,
-	timedia_4006a,
-	timedia_4014,
-	timedia_4008a,
-	timedia_4018,
-	timedia_9018a,
 	syba_2p_epp,
 	syba_1p_ecp,
 	titan_010l,
@@ -2679,11 +2674,6 @@ static struct parport_pc_pci {
 	/* lava_parallel_dual_b */	{ 1, { { 0, -1 }, } },
 	/* boca_ioppar */		{ 1, { { 0, -1 }, } },
 	/* plx_9050 */			{ 2, { { 4, -1 }, { 5, -1 }, } },
-	/* timedia_4006a */             { 1, { { 0, -1 }, } },
-	/* timedia_4014  */             { 2, { { 0, -1 }, { 2, -1 }, } },
-	/* timedia_4008a */             { 1, { { 0, 1 }, } },
-	/* timedia_4018  */             { 2, { { 0, 1 }, { 2, 3 }, } },
-	/* timedia_9018a */             { 2, { { 0, 1 }, { 2, 3 }, } },
 					/* SYBA uses fixed offsets in
 					   a 1K io window */
 	/* syba_2p_epp AP138B */	{ 2, { { 0, 0x078 }, { 0, 0x178 }, } },
@@ -2738,12 +2728,7 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, boca_ioppar },
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 	  PCI_SUBVENDOR_ID_EXSYS, PCI_SUBDEVICE_ID_EXSYS_4014, 0, 0, plx_9050 },
-	/* PCI_VENDOR_ID_TIMEDIA/SUNIX has many differing cards ...*/
-	{ 0x1409, 0x7268, 0x1409, 0x0101, 0, 0, timedia_4006a },
-	{ 0x1409, 0x7268, 0x1409, 0x0102, 0, 0, timedia_4014 },
-	{ 0x1409, 0x7268, 0x1409, 0x0103, 0, 0, timedia_4008a },
-	{ 0x1409, 0x7268, 0x1409, 0x0104, 0, 0, timedia_4018 },
-	{ 0x1409, 0x7268, 0x1409, 0x9018, 0, 0, timedia_9018a },
+
 	{ PCI_VENDOR_ID_SYBA, PCI_DEVICE_ID_SYBA_2P_EPP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, syba_2p_epp },
 	{ PCI_VENDOR_ID_SYBA, PCI_DEVICE_ID_SYBA_1P_ECP,
diff --git a/parport/parport_serial.c b/parport/parport_serial.c
index 461fd8a2..4a7e4807 100644
--- a/parport/parport_serial.c
+++ b/parport/parport_serial.c
@@ -38,30 +38,11 @@ enum parport_pc_pci_cards {
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
 	wch_ch382_0s1p,
 	wch_ch382_2s1p,
 	brainboxes_5s1p,
-	sunix_2s1p,
 };
 
 /* each element directly indexed from enum list, above */
@@ -128,30 +109,11 @@ static struct parport_pc_pci cards[] = {
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
 	/* wch_ch382_0s1p*/		{ 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
 	/* brainboxes_5s1p */           { 1, { { 3, -1 }, } },
-	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -231,25 +193,6 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
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
@@ -261,14 +204,6 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
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
@@ -377,114 +312,6 @@ static struct pciserial_board pci_parport_serial_boards[] = {
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
 	[wch_ch353_1s1p] = {
 		.flags          = FL_BASE0|FL_BASE_BARS,
 		.num_ports      = 1,
@@ -516,12 +343,6 @@ static struct pciserial_board pci_parport_serial_boards[] = {
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

