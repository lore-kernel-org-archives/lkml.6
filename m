Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032629AbeE0NMW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 09:12:22 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44309 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0NMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 09:12:21 -0400
X-Google-Smtp-Source: AB8JxZqmcO9Q0oTWQTW/YZQ416cE+JRP1r3vwTcm0G/SGKEowJqj4GLOceCE7044Sb/bzjXFjMO18A==
Date: Sun, 27 May 2018 18:42:15 +0530
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: mt7621-pci: Fix line size exceeding 80 columns.
Message-ID: <20180527131215.ruevc7lmxchxwayt@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: line over 80 characters

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index edd95013faf3..17f2105ec698 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -194,7 +194,8 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 	address_reg = RALINK_PCI_CONFIG_ADDR;
 	data_reg = RALINK_PCI_CONFIG_DATA_VIRTUAL_REG;
 
-	address = (((where&0xF00)>>8)<<24) |(bus->number << 16) | (slot << 11) | (func << 8) | (where & 0xfc) | 0x80000000;
+	address = (((where&0xF00)>>8)<<24) |(bus->number << 16) | (slot << 11) |
+				(func << 8) | (where & 0xfc) | 0x80000000;
 	MV_WRITE(address_reg, address);
 
 	switch(access_type) {
-- 
2.11.0
