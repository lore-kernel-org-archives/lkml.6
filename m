Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E95C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE34A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVKC8qm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE34A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeG0E1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41595 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeG0E1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so1679586ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DaqMVL0jLNf4KHD93nUlZVD1OiE7sTNJXVIDcgiMHw=;
        b=WVKC8qm7i1A7QaMZZ/C+b3VHVUHRLkPS2+6oMPQh+gjQY3zf7IBjkmWWKR/f7Megwu
         hEFVZPz80CWEiGNTQzmUhjOKiTNN+ago7gRYe5KsueV+dbbJdpAVQhu78Q5ZztHEXNxA
         mYj5qjmyFMJH0TSkjbEr549W/Mb+XbfM/DapfkXuYBdeWTvJZ5OKjG/uqfxLlnn+BIg+
         GEfk2gicThRnIuK7pXbnBZmdbI5t6Nk0B3RKHFL7573wIridZhLs++H1SI3un4cVr+WO
         HfZrEpvsDzWq7aYztRjrKhjdBti/GX6FHFSgKboSD3YuOirvIykzT/qaGTi77H21cwtf
         MTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DaqMVL0jLNf4KHD93nUlZVD1OiE7sTNJXVIDcgiMHw=;
        b=rRfWNTXJKT4z2RCuJkDo0SSuCiCAi7opoLrg9VLXohuXoqM6cOBPf+gj/W9D2pR0Ib
         DdaAbSlDnrjNcdwk+RDIpgrJvWcJGy7BLvDWnwjvrnsYCqdAcOnS8u7e/zfRwf9Sk9rP
         eHuVOmOq52LBYrikirSDQXHOv4E5Icent9k313uYnQZZzEzMC/CwO77sSe/iSucrNnPx
         MFqEAPr83IjNQqkr02rocAuNseNgG/pT9VBTwT0G4pzg0Dm3F53lMGMmy2KPcY2pBlA5
         tuZFLQi+NOKW2jOFF+SFgGLroXGQwXWtCNME9kimq42A6IkpYb3obTDw/9qGfJWa7FvS
         voGg==
X-Gm-Message-State: AOUpUlG0hI73nBzVwpFoCGpmw8vzmb2K08S/KB9ZG69pAPWO8z5dKESV
        /uxFRpGE6CLwckzAJB6B3OM=
X-Google-Smtp-Source: AAOMgpfZZQXBCXe5SOB5BOPTX9C0ihsxFbkIuRic4JnNYXang6zsgQnqdlpo5eUkdcunElk06fSrQg==
X-Received: by 2002:a17:902:a60b:: with SMTP id u11-v6mr4301078plq.158.1532660885608;
        Thu, 26 Jul 2018 20:08:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:05 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/10] staging: gasket: interrupt: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:30 -0700
Message-Id: <20180727030737.231268-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Convert gasket logging calls to standard functions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 67 +++++++++++------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 2b8c26d065336..3be8e24c126d0 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -5,9 +5,10 @@
 
 #include "gasket_constants.h"
 #include "gasket_core.h"
-#include "gasket_logging.h"
 #include "gasket_sysfs.h"
+#include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/printk.h>
 #include <linux/version.h>
 #ifdef GASKET_KERNEL_TRACE_SUPPORT
 #define CREATE_TRACE_POINTS
@@ -165,8 +166,8 @@ int gasket_interrupt_init(
 	case PCI_MSI:
 	case PLATFORM_WIRE:
 	default:
-		gasket_nodev_error(
-			"Cannot handle unsupported interrupt type %d.",
+		dev_err(gasket_dev->dev,
+			"Cannot handle unsupported interrupt type %d\n",
 			interrupt_data->type);
 		ret = -EINVAL;
 	};
@@ -175,8 +176,8 @@ int gasket_interrupt_init(
 		/* Failing to setup interrupts will cause the device to report
 		 * GASKET_STATUS_LAMED. But it is not fatal.
 		 */
-		gasket_log_warn(
-			gasket_dev, "Couldn't initialize interrupts: %d", ret);
+		dev_warn(gasket_dev->dev,
+			 "Couldn't initialize interrupts: %d\n", ret);
 		return 0;
 	}
 
@@ -216,7 +217,7 @@ static int gasket_interrupt_msix_init(
 			interrupt_data);
 
 		if (ret) {
-			gasket_nodev_error(
+			dev_err(&interrupt_data->pci_dev->dev,
 				"Cannot get IRQ for interrupt %d, vector %d; "
 				"%d\n",
 				i, interrupt_data->msix_entries[i].vector, ret);
@@ -287,9 +288,8 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 	int ret;
 
 	if (!gasket_dev->interrupt_data) {
-		gasket_log_debug(
-			gasket_dev,
-			"Attempted to reinit uninitialized interrupt data.");
+		dev_dbg(gasket_dev->dev,
+			"Attempted to reinit uninitialized interrupt data\n");
 		return -EINVAL;
 	}
 
@@ -305,8 +305,8 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 	case PCI_MSI:
 	case PLATFORM_WIRE:
 	default:
-		gasket_nodev_debug(
-			"Cannot handle unsupported interrupt type %d.",
+		dev_dbg(gasket_dev->dev,
+			"Cannot handle unsupported interrupt type %d\n",
 			gasket_dev->interrupt_data->type);
 		ret = -EINVAL;
 	};
@@ -315,7 +315,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 		/* Failing to setup MSIx will cause the device
 		 * to report GASKET_STATUS_LAMED, but is not fatal.
 		 */
-		gasket_log_warn(gasket_dev, "Couldn't init msix: %d", ret);
+		dev_warn(gasket_dev->dev, "Couldn't init msix: %d\n", ret);
 		return 0;
 	}
 
@@ -327,7 +327,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 /* See gasket_interrupt.h for description. */
 int gasket_interrupt_reset_counts(struct gasket_dev *gasket_dev)
 {
-	gasket_log_debug(gasket_dev, "Clearing interrupt counts.");
+	dev_dbg(gasket_dev->dev, "Clearing interrupt counts\n");
 	memset(gasket_dev->interrupt_data->interrupt_counts, 0,
 	       gasket_dev->interrupt_data->num_interrupts *
 			sizeof(*gasket_dev->interrupt_data->interrupt_counts));
@@ -351,12 +351,11 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 		gasket_dev->interrupt_data;
 
 	if (!interrupt_data) {
-		gasket_log_debug(
-			gasket_dev, "Interrupt data is not initialized.");
+		dev_dbg(gasket_dev->dev, "Interrupt data is not initialized\n");
 		return;
 	}
 
-	gasket_log_debug(gasket_dev, "Running interrupt setup.");
+	dev_dbg(gasket_dev->dev, "Running interrupt setup\n");
 
 	if (interrupt_data->type == PLATFORM_WIRE ||
 	    interrupt_data->type == PCI_MSI) {
@@ -365,8 +364,8 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 	}
 
 	if (interrupt_data->type != PCI_MSIX) {
-		gasket_nodev_debug(
-			"Cannot handle unsupported interrupt type %d.",
+		dev_dbg(gasket_dev->dev,
+			"Cannot handle unsupported interrupt type %d\n",
 			interrupt_data->type);
 		return;
 	}
@@ -379,10 +378,9 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 		 * the register directly. If not, we need to deal with a read-
 		 * modify-write and shift based on the packing index.
 		 */
-		gasket_log_debug(
-			gasket_dev,
+		dev_dbg(gasket_dev->dev,
 			"Setting up interrupt index %d with index 0x%llx and "
-			"packing %d",
+			"packing %d\n",
 			interrupt_data->interrupts[i].index,
 			interrupt_data->interrupts[i].reg,
 			interrupt_data->interrupts[i].packing);
@@ -403,9 +401,9 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 				pack_shift = 3 * interrupt_data->pack_width;
 				break;
 			default:
-				gasket_nodev_debug(
+				dev_dbg(gasket_dev->dev,
 					"Found interrupt description with "
-					"unknown enum %d.",
+					"unknown enum %d\n",
 					interrupt_data->interrupts[i].packing);
 				return;
 			}
@@ -445,8 +443,8 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 	case PCI_MSI:
 	case PLATFORM_WIRE:
 	default:
-		gasket_nodev_debug(
-			"Cannot handle unsupported interrupt type %d.",
+		dev_dbg(gasket_dev->dev,
+			"Cannot handle unsupported interrupt type %d\n",
 			interrupt_data->type);
 	};
 
@@ -460,18 +458,19 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 int gasket_interrupt_system_status(struct gasket_dev *gasket_dev)
 {
 	if (!gasket_dev->interrupt_data) {
-		gasket_nodev_debug("Interrupt data is null.");
+		dev_dbg(gasket_dev->dev, "Interrupt data is null\n");
 		return GASKET_STATUS_DEAD;
 	}
 
 	if (!gasket_dev->interrupt_data->msix_configured) {
-		gasket_nodev_debug("Interrupt not initialized.");
+		dev_dbg(gasket_dev->dev, "Interrupt not initialized\n");
 		return GASKET_STATUS_LAMED;
 	}
 
 	if (gasket_dev->interrupt_data->num_configured !=
 		gasket_dev->interrupt_data->num_interrupts) {
-		gasket_nodev_debug("Not all interrupts were configured.");
+		dev_dbg(gasket_dev->dev,
+			"Not all interrupts were configured\n");
 		return GASKET_STATUS_LAMED;
 	}
 
@@ -516,15 +515,13 @@ static ssize_t interrupt_sysfs_show(
 
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
-		gasket_nodev_debug(
-			"No sysfs mapping found for device 0x%p", device);
+		dev_dbg(device, "No sysfs mapping found for device\n");
 		return 0;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
-		gasket_nodev_debug(
-			"No sysfs attr data found for device 0x%p", device);
+		dev_dbg(device, "No sysfs attr data found for device\n");
 		gasket_sysfs_put_device_data(device, gasket_dev);
 		return 0;
 	}
@@ -545,8 +542,8 @@ static ssize_t interrupt_sysfs_show(
 		ret = total_written;
 		break;
 	default:
-		gasket_log_debug(
-			gasket_dev, "Unknown attribute: %s", attr->attr.name);
+		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
+			attr->attr.name);
 		ret = 0;
 		break;
 	}
@@ -574,7 +571,7 @@ static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
 		}
 	}
 	if (interrupt == -1) {
-		gasket_nodev_error("Received unknown irq %d", irq);
+		pr_err("Received unknown irq %d\n", irq);
 		return IRQ_HANDLED;
 	}
 	trace_gasket_interrupt_event(interrupt_data->name, interrupt);
-- 
2.18.0.345.g5c9ce644c3-goog

