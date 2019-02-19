Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D234C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE552147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8aqpFST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfBSIvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:51:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33618 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBSIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:51:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so10128863plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FWWyZ1qxbZTxhJIN2rAyrUoOMrYjx7Hozy1aUmJfayk=;
        b=l8aqpFSTxV7BTe6tXH/f/7hZ7VG6J0KFBclJJcMl+Xpuanyr99Z7QbbgH79xEX7jno
         lpFQ/TR8Rtv7mmD6w9C3Nj1T8pJ1huR3RJ8vv8Hwlr7XvuSAGhR2rzmt/Pjf60FEBpcw
         xG8h14QXToOC5S/4bBfn/4hu4m81Zq69hMqPmnRaAcyYgdzCjKs3O8i15zrypIAiJTOb
         drn2q4ED8RAphPxjKMVu0AoAh1IjfMFbNxQSuyon3gh7KyJHtTaeTe1TIrdUy8kZ+9Zy
         2aSGOw+2NG1KEwJLS6q53N8aBH2amKdasqEmDw4KWuyJFFR0GckLftx7Ljh03zqMhelY
         oaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FWWyZ1qxbZTxhJIN2rAyrUoOMrYjx7Hozy1aUmJfayk=;
        b=lBVQYOdmJX2fGgICfKQMf8Gwi1E1zjAhtqyqcH1f0Gq7HPNy0hj/HWUKpAfJuSPIz2
         XDFjn1wNVePhrRsoQwIMO0sZhL/bNhobhQTLg9OLeclM6WbmXVh+RBdPKbsJv+xzDhav
         +RMDA0vN+vFN2qfxaZgFpLinEYEQaUCmDl2k/oPthXsDkZjhCmB+BpTuk8oX4cK8X7bZ
         dgHAjzu/4/VaGu/sK4fViAmrLUvvwLqFrqJ2KGrmTM+9HPrOVkwGh5sbhtRAhqP9Su+a
         SZ2Bx5w7Otd7Soy3cyA9YyY3V9723QFjkShW3hTFpSqwrq9UpqCBD9dIULpjk1iz++Su
         AQyA==
X-Gm-Message-State: AHQUAuZggihvG1ADbQaMhyr7bb0+/HIcftHXnycTE2RaHBP0mqCczT+C
        /hY6sz1+j3nxRPFPrae8W8qd1J+u
X-Google-Smtp-Source: AHgI3IZdHZJjc02bknRN3GSTwg1JPtAqSLQX/pCJDGVyj5mKmjq+hKS6k8dwuAAWae31qzH5ml19fQ==
X-Received: by 2002:a17:902:9304:: with SMTP id bc4mr6297397plb.81.1550566269585;
        Tue, 19 Feb 2019 00:51:09 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-242-146.dynamic-ip.hinet.net. [114.36.242.146])
        by smtp.gmail.com with ESMTPSA id q86sm14727498pfi.171.2019.02.19.00.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 00:51:09 -0800 (PST)
From:   saumah <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        saumah <saumah@gmail.com>
Subject: [PATCH V2] 8250_pci.c change for fix hanging problem.
Date:   Tue, 19 Feb 2019 16:50:31 +0800
Message-Id: <20190219085031.3776-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_pci.c change for fix hanging problem while suspend machine. 8250_pci.c support the same vendor id and device id definition as sunix multi-I/O card driver, when the sunix multi-io borad driver is installed,there are two drivers to support the same sunix multi-io card,it will cause operation error.

Signed-off-by: saumah <saumah@gmail.com>
---
 8250_pci.c | 163 +----------------------------------------------------
 1 file changed, 1 insertion(+), 162 deletions(-)

diff --git a/8250_pci.c b/8250_pci.c
index f80a300..c5b1799 100644
--- a/8250_pci.c
+++ b/8250_pci.c
@@ -519,116 +519,6 @@ static int pci_siig_setup(struct serial_private *priv,
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
-
 /*
  * Some Titan cards are also a little weird
  */
@@ -2103,42 +1993,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
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
 	/*
 	 * Xircom cards
 	 */
@@ -4375,22 +4230,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi },
-	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_921600 },
-
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

