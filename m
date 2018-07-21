Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0703ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A24820858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGbtCDxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A24820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeGUNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47003 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeGUNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so9016327pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+2IJEtfJULp18D+0nd4wW9BdT1d7nKZ3Wde8OwFth+8=;
        b=DGbtCDxwv859J0mCFKvaJERC5KCS19BJf1BJ17CEb1LrPi9JMmqhIVw99uuc1T95IO
         eyBTJnN5eKyGhqi7CnT30HQrIDfsovHpAmDbjMKW57lNmeaCx3uORS8Qi/W6S+xDzyAs
         /qMnvRtJduic3TjxieMNCJWxKHzL/Fw7FN3MuD2y1nndY7IOtOkTx0x7E5yE9ZlkYCyP
         CTwC4cnPQVTUrk57NnsypCiYmjB3WmSjBQ0smN/8THrpcwN0BUpZsVJRocF2Uv7UJAmY
         LK3UZr40uQBvDWdnrWljWEV/xAEcwxUy6/2pTRxP4FU/a1cXGzGfz6zlM8rFKB9vlaQw
         TvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+2IJEtfJULp18D+0nd4wW9BdT1d7nKZ3Wde8OwFth+8=;
        b=ui9ZohmbAI9cszVdP6/xH3OgJkBGrDknJQEhXghhJzv//hhI50ng+31s+mcKPiqW13
         OdxcWq+88YGV6UXE0xqfewY5HTb+FDbZIq+WzjyPQYzZnnbAUTHsikof/0Il4pryDT7f
         5nDtBMrhCTnXRVXNQ2oZXWFaxO+YwlD6mIZHqHqguk4XY3OQdZyrwV93MF/wo+R7ka7X
         K4fV2UN8mAOgqcWfBB9R/dtA5q2xfsodGtrjSO21zD72sd84APB828jZ5WlC3c0Zgctr
         IPcNxjpAhV156KxaN+bYAgAg8yZESkrJkD2Gled2wyeZwc9VVR1jTVpQh6fkLZLrROZ+
         di/w==
X-Gm-Message-State: AOUpUlGaJ5H5Ta0ZjhsLcqkj5BZIqL/ChWIoXTTuS4/hUWyWtbOcC3x9
        6SuX7xfrk+xGiZF87WmfysVsHIVHl9c=
X-Google-Smtp-Source: AAOMgpeu3bPQqJthYygQLHZNZdkf3Ifw3FN2LuDlNt3AWNQU9mhmDPv9paoojaDdSv4PTiplz0l0dw==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr5911289pff.211.1532177870441;
        Sat, 21 Jul 2018 05:57:50 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:49 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/14] staging: gasket: interrupts: convert various logs to debug level
Date:   Sat, 21 Jul 2018 05:56:58 -0700
Message-Id: <20180721125713.88501-20-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index d096ce73cc8b3..2b8c26d065336 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -287,7 +287,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 	int ret;
 
 	if (!gasket_dev->interrupt_data) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev,
 			"Attempted to reinit uninitialized interrupt data.");
 		return -EINVAL;
@@ -305,7 +305,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 	case PCI_MSI:
 	case PLATFORM_WIRE:
 	default:
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"Cannot handle unsupported interrupt type %d.",
 			gasket_dev->interrupt_data->type);
 		ret = -EINVAL;
@@ -351,7 +351,7 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 		gasket_dev->interrupt_data;
 
 	if (!interrupt_data) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Interrupt data is not initialized.");
 		return;
 	}
@@ -365,7 +365,7 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 	}
 
 	if (interrupt_data->type != PCI_MSIX) {
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"Cannot handle unsupported interrupt type %d.",
 			interrupt_data->type);
 		return;
@@ -403,7 +403,7 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 				pack_shift = 3 * interrupt_data->pack_width;
 				break;
 			default:
-				gasket_nodev_error(
+				gasket_nodev_debug(
 					"Found interrupt description with "
 					"unknown enum %d.",
 					interrupt_data->interrupts[i].packing);
@@ -445,7 +445,7 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 	case PCI_MSI:
 	case PLATFORM_WIRE:
 	default:
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"Cannot handle unsupported interrupt type %d.",
 			interrupt_data->type);
 	};
@@ -460,18 +460,18 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 int gasket_interrupt_system_status(struct gasket_dev *gasket_dev)
 {
 	if (!gasket_dev->interrupt_data) {
-		gasket_nodev_info("Interrupt data is null.");
+		gasket_nodev_debug("Interrupt data is null.");
 		return GASKET_STATUS_DEAD;
 	}
 
 	if (!gasket_dev->interrupt_data->msix_configured) {
-		gasket_nodev_info("Interrupt not initialized.");
+		gasket_nodev_debug("Interrupt not initialized.");
 		return GASKET_STATUS_LAMED;
 	}
 
 	if (gasket_dev->interrupt_data->num_configured !=
 		gasket_dev->interrupt_data->num_interrupts) {
-		gasket_nodev_info("Not all interrupts were configured.");
+		gasket_nodev_debug("Not all interrupts were configured.");
 		return GASKET_STATUS_LAMED;
 	}
 
@@ -516,14 +516,14 @@ static ssize_t interrupt_sysfs_show(
 
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"No sysfs mapping found for device 0x%p", device);
 		return 0;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"No sysfs attr data found for device 0x%p", device);
 		gasket_sysfs_put_device_data(device, gasket_dev);
 		return 0;
@@ -545,7 +545,7 @@ static ssize_t interrupt_sysfs_show(
 		ret = total_written;
 		break;
 	default:
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Unknown attribute: %s", attr->attr.name);
 		ret = 0;
 		break;
-- 
2.18.0.233.g985f88cf7e-goog

