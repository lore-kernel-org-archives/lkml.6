Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233DAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF65A2073F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEkSmhoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBIRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:18:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44010 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfBIRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:18:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so7550964qtc.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HR9a4FNV3eINeMVs3yFZ7OXxcTPEt2JHVTANyvSmDjc=;
        b=kEkSmhoWgGPf5DlMgB+T7ovcfAzN+czoVimD3AqsSSji9fUhbjHWwLdLruv5FK3Vha
         tiMGkqpVQ3RDskz0+rwUVty78xdmMTBH1SM1H/5OPxgtYP357WV0mErhS/XA+/dUxYsS
         90/QxcyJWy4O3dCtd3MexueAtYPo4Gqc+XsMU/+R6pKCyyLenh5xF90WnsIBaVpXALdX
         qb/RW5QByDpIMTn9Rv4SmafV6MXq6sfOGynHscM2TjOoB/0wi1DD9jkGyiyab0ebfHJ8
         2n+QyUTA0gP8+WuKc6yA/8VEGJ/hx02bwzWLeMZHnrBYKD4+hf62rQU6z7RHOupDcRbS
         piOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HR9a4FNV3eINeMVs3yFZ7OXxcTPEt2JHVTANyvSmDjc=;
        b=TCcCIdJtIhwrC50dRznroLqfGjlWXTR5AmlACH56Ientox+m8IpeJk1reRN3ij7CRW
         4C6ZLiiuxIB7JNA7dRvrAnISFHC3G8jaGuCAjXYHFaFKyNomaB1DuzSe/yWbvPh1E4YY
         V0BsEcD3uOLYF46K6QPMe8DB3ilwucYP29bhxmpNzU9hPqI3sr9av9nXA2u27UJuiF4/
         xjTtyZl/nBBS8RY8vv6Q4hoyfTD9+S2hbcLIw7k1fyI7noBrd3sBggMYqQVzBG9h8K6A
         SRBhODfHDkO4bpO+nIvqURAKOj+bfBgdT7WQzsEj/Ht7YDM/Juj8QAt53LNXVYnjyFJW
         3IJQ==
X-Gm-Message-State: AHQUAub6hwJk6US7lAmoOExMpfEEDO6Nz2K5d5zvD891CXba+MVFd9cG
        D3O5vbdr4vsKDISfTlYscYg=
X-Google-Smtp-Source: AHgI3Ia/T668ILx2bU1N1agETRYbdCPjFt8jGYz+GpBA0jeFSYY8ODUjH0rh1BYp18CQSabzHOeIgg==
X-Received: by 2002:ac8:296a:: with SMTP id z39mr21412369qtz.264.1549732728891;
        Sat, 09 Feb 2019 09:18:48 -0800 (PST)
Received: from localhost.localdomain ([191.8.89.57])
        by smtp.gmail.com with ESMTPSA id l53sm6856010qtc.33.2019.02.09.09.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 09:18:48 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gui.maeoka@gmail.com
Subject: [PATCH] Staging: mt7621-pci: Fix space required coding style
Date:   Sat,  9 Feb 2019 15:17:18 -0200
Message-Id: <20190209171718.25010-1-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some space required coding style.

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 31310b6fb7db..fd8990e61120 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -90,7 +90,7 @@
 
 #define PCIE_CLK_GEN_EN			BIT(31)
 #define PCIE_CLK_GEN_DIS		0
-#define PCIE_CLK_GEN1_DIS		GENMASK(30,24)
+#define PCIE_CLK_GEN1_DIS		GENMASK(30, 24)
 #define PCIE_CLK_GEN1_EN		(BIT(27) | BIT(25))
 #define RALINK_PCI_IO_MAP_BASE		0x1e160000
 #define MEMORY_BASE			0x0
@@ -714,7 +714,7 @@ static void mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
 static int mt7621_pcie_init_virtual_bridges(struct mt7621_pcie *pcie)
 {
 	u32 pcie_link_status = 0;
-	u32 val= 0;
+	u32 val = 0;
 	struct mt7621_pcie_port *port;
 
 	list_for_each_entry(port, &pcie->ports, list) {
-- 
2.17.1

