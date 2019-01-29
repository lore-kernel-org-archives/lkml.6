Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE9BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7790A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek4SAPpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfA2FQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:16:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2FQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:16:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so9104833pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jzmZGdThprPvWBd9rPPWpnODIbiUAg2dB5lcjbKVNTg=;
        b=Ek4SAPpYxmrdAk8oSy7CDj4WiM+49wRgZNo7M7PR/r59RBoySwQmnL4sGmIVxTqV2J
         A4NBpdIMj+AkkAUDlp4jYAbvd7gitZM13RrgdTB6uIbD17rSuMIuXa3jLegqks6dm2Dc
         NvXkYSa+DzmwyBPQleUqCijGvEUaCzCVKMP8q4683H0T8ltEpn76kx+h41vIft8BVC+x
         XyHqp57OODoQJU/sc1dH/rxhvKsTaKlCZBLZbjSeuyeTtamfn+aDsCMEsI7b8hX6+cn/
         Jqjl3anZCmx1qlSto2XvUZlJi9vGa49Ru73Q16GFj93LC7sqz1ZRuNB2O6vTnZ6qjLtj
         2OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jzmZGdThprPvWBd9rPPWpnODIbiUAg2dB5lcjbKVNTg=;
        b=W7JDsyXnXgRNm6X5E8/1zih0+3wYG8g00BDwkxlTHKGgZzZgMqi8tgr0UhbI0DrF5y
         zeYqqe2zPNEx8AL7iHBNxFtuYKnxk0JnVffT/a4Tacp8EyejZ1HaoL/C7IlgVXH3gqAG
         ZcVMQATeBBRUfv27n9QmCgErjr+50Emnwzb3oclt85SqEitxDx3EpWMOAijdDi3I5Jsy
         OrNxM1xb2J+wbx7qgO8R0xHk5R4tCm4rsj/DRgcaaiE7r5NXyTz9ls6lFxY4yST979L6
         RCQTO3ohxaE6G/2jGvH4kVZBVwTnZhpILvwBivn2uN0YFuKXqk6ALyOJcx1ST6Ysa3cA
         ZAXA==
X-Gm-Message-State: AJcUuke2SW85BVABRQdoEruxEvwUSvmOiMxDiv2pPXQSclUVitMGwZTT
        i7DPY2C/UOHIjKVuqIETUc8=
X-Google-Smtp-Source: ALg8bN48y+ktCVq5x1K/plzhuH4aeYGKqlt3V60TtfRMBozkSJyyIlQgoguwZTwcXQnkLBMFLvJmjQ==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr22782210pgh.129.1548739011054;
        Mon, 28 Jan 2019 21:16:51 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-229-251.dynamic-ip.hinet.net. [114.36.229.251])
        by smtp.gmail.com with ESMTPSA id u126sm83182740pgb.2.2019.01.28.21.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:16:50 -0800 (PST)
From:   saumah <saumah@gmail.com>
To:     sudipm.mukherjee@gmail.com
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        saumah <saumah@gmail.com>
Subject: [PATCH] 8250_pci.c change for fix hanging problem while suspend machine. pci_ids.h has the same vendor id and device id definition as sunix multi-I/O card driver, when the sunix multi-io borad driver is installed,there are two drivers to support the same sunix multi-io card,it will cause operation error
Date:   Tue, 29 Jan 2019 13:16:30 +0800
Message-Id: <20190129051630.2630-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: saumah <saumah@gmail.com>
---
 8250_pci.c | 162 +----------------------------------------------------
 1 file changed, 2 insertions(+), 160 deletions(-)

diff --git a/8250_pci.c b/8250_pci.c
index f80a300..310b1eb 100644
--- a/8250_pci.c
+++ b/8250_pci.c
@@ -519,115 +519,6 @@ static int pci_siig_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }

-/*
- * Timedia has an explosion of boards, and to avoid the PCI table from
- * growing *huge*, we use this function to collapse some 70 entries
- * in the PCI table into one, for sanity's and compactness's sake.
- */
-static const unsigned short timedia_single_port[] = {
-	0x4025, 0x4027, 0x4028, 0x5025, 0x5027, 0
-};
-
-static const unsigned short timedia_dual_port[] = {
-	0x0002, 0x4036, 0x4037, 0x4038, 0x4078, 0x4079, 0x4085,
-	0x4088, 0x4089, 0x5037, 0x5078, 0x5079, 0x5085, 0x6079,
-	0x7079, 0x8079, 0x8137, 0x8138, 0x8237, 0x8238, 0x9079,
-	0x9137, 0x9138, 0x9237, 0x9238, 0xA079, 0xB079, 0xC079,
-	0xD079, 0
-};
-
-static const unsigned short timedia_quad_port[] = {
-	0x4055, 0x4056, 0x4095, 0x4096, 0x5056, 0x8156, 0x8157,
-	0x8256, 0x8257, 0x9056, 0x9156, 0x9157, 0x9158, 0x9159,
-	0x9256, 0x9257, 0xA056, 0xA157, 0xA158, 0xA159, 0xB056,
-	0xB157, 0
-};
-
-static const unsigned short timedia_eight_port[] = {
-	0x4065, 0x4066, 0x5065, 0x5066, 0x8166, 0x9066, 0x9166,
-	0x9167, 0x9168, 0xA066, 0xA167, 0xA168, 0
-};
-
-static const struct timedia_struct {
-	int num;
-	const unsigned short *ids;
-} timedia_data[] = {
-	{ 1, timedia_single_port },
-	{ 2, timedia_dual_port },
-	{ 4, timedia_quad_port },
-	{ 8, timedia_eight_port }
-};
-
-/*
- * There are nearly 70 different Timedia/SUNIX PCI serial devices.  Instead of
- * listing them individually, this driver merely grabs them all with
- * PCI_ANY_ID.  Some of these devices, however, also feature a parallel port,
- * and should be left free to be claimed by parport_serial instead.
- */
-static int pci_timedia_probe(struct pci_dev *dev)
-{
-	/*
-	 * Check the third digit of the subdevice ID
-	 * (0,2,3,5,6: serial only -- 7,8,9: serial + parallel)
-	 */
-	if ((dev->subsystem_device & 0x00f0) >= 0x70) {
-		dev_info(&dev->dev,
-			"ignoring Timedia subdevice %04x for parport_serial\n",
-			dev->subsystem_device);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int pci_timedia_init(struct pci_dev *dev)
-{
-	const unsigned short *ids;
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(timedia_data); i++) {
-		ids = timedia_data[i].ids;
-		for (j = 0; ids[j]; j++)
-			if (dev->subsystem_device == ids[j])
-				return timedia_data[i].num;
-	}
-	return 0;
-}
-
-/*
- * Timedia/SUNIX uses a mixture of BARs and offsets
- * Ugh, this is ugly as all hell --- TYT
- */
-static int
-pci_timedia_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	unsigned int bar = 0, offset = board->first_offset;
-
-	switch (idx) {
-	case 0:
-		bar = 0;
-		break;
-	case 1:
-		offset = board->uart_offset;
-		bar = 0;
-		break;
-	case 2:
-		bar = 1;
-		break;
-	case 3:
-		offset = board->uart_offset;
-		/* FALLTHROUGH */
-	case 4: /* BAR 2 */
-	case 5: /* BAR 3 */
-	case 6: /* BAR 4 */
-	case 7: /* BAR 5 */
-		bar = idx - 2;
-	}
-
-	return setup_port(priv, port, bar, offset, board->reg_shift);
-}

 /*
  * Some Titan cards are also a little weird
@@ -2103,42 +1994,8 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= titan_400l_800l_setup,
 	},
-	/*
-	 * Timedia cards
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_TIMEDIA,
-		.device		= PCI_DEVICE_ID_TIMEDIA_1889,
-		.subvendor	= PCI_VENDOR_ID_TIMEDIA,
-		.subdevice	= PCI_ANY_ID,
-		.probe		= pci_timedia_probe,
-		.init		= pci_timedia_init,
-		.setup		= pci_timedia_setup,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_TIMEDIA,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_timedia_setup,
-	},
-	/*
-	 * SUNIX (Timedia) cards
-	 * Do not "probe" for these cards as there is at least one combination
-	 * card that should be handled by parport_pc that doesn't match the
-	 * rule in pci_timedia_probe.
-	 * It is part number is MIO5079A but its subdevice ID is 0x0102.
-	 * There are some boards with part number SER5037AL that report
-	 * subdevice ID 0x0002.
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_SUNIX,
-		.device		= PCI_DEVICE_ID_SUNIX_1999,
-		.subvendor	= PCI_VENDOR_ID_SUNIX,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_timedia_init,
-		.setup		= pci_timedia_setup,
-	},
+
+
 	/*
 	 * Xircom cards
 	 */
@@ -4375,22 +4232,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi },
-	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_921600 },

-	/*
-	 * SUNIX (TIMEDIA)
-	 */
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00,
-		pbn_b0_bt_1_921600 },
-
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
-		pbn_b0_bt_1_921600 },

 	/*
 	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
--
2.17.1

