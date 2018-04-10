Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeDJRKp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:10:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36366 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDJRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:10:43 -0400
X-Google-Smtp-Source: AIpwx4+7ZQ2wVlS75vI6hALPSfug67qBLDjUtfsIZzNjYLlFc1sQ0xVJu+W9sJLtcw8jev5nX4/+9Q==
Date: Tue, 10 Apr 2018 19:10:38 +0200
From: Laszlo Toth <laszlth@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: add missing newline to printk
Message-ID: <20180410171038.GA4189@laszlth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...and restore reverse xmas tree while at it.

Signed-off-by: Laszlo Toth <laszlth@gmail.com>
---
 drivers/acpi/reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 71769fd..6fa9c2a 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -8,8 +8,8 @@ void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
 	struct pci_bus *bus0;
-	u8 reset_value;
 	unsigned int devfn;
+	u8 reset_value;
 
 	if (acpi_disabled)
 		return;
@@ -40,7 +40,7 @@ void acpi_reboot(void)
 		/* Form PCI device/function pair. */
 		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
 				  (rr->address >> 16) & 0xffff);
-		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.");
+		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.\n");
 		/* Write the value that resets us. */
 		pci_bus_write_config_byte(bus0, devfn,
 				(rr->address & 0xffff), reset_value);
-- 
2.7.4
