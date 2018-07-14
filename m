Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C89ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00FD208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQU4wLvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00FD208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeGNGRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:17:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40814 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeGNGQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so10380037pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bzV7JNi1B0YB6I8xMD9DgtX/J5F56rHwvBuY6Ka1GOA=;
        b=cQU4wLvYINtyVOz4eyoaQhix28Phg5CQMqUR12PK5MpMmmJOwFKbZuZ3DDKpSWRfKH
         gWHAmiffHDhjffTllrFVnViqVhXem14GYYWxrTlOFbsmVBJqnuYWvukfgSfbmTu9i8cs
         h0/ZpX0uDHILzLcXAzK0wt3E2WYHhoakc4PWGYREKDf6iGpJdzcychOLN4W896Y2sM1D
         YMNNt5m+5O2R9IO9WpzhV1TT4MdNy1+7wqqBp+OEJ74sYUpDzTHHzoPN06rv1S0cBG3Q
         249JlmbhsCDwY/9VYN/le3NMnbI54UpEqoqaMyANnxq8cuWgX/kLXBoXiHeJwpcvI+k/
         xwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bzV7JNi1B0YB6I8xMD9DgtX/J5F56rHwvBuY6Ka1GOA=;
        b=DP64hZ/QhESSWslTZAWKahe5usi5TN+flZlo99Sf4LHHk9vDDRwNILbUKqXsm9yuFE
         cLyjIdMRAO5gyoYJNz5dYJmMTjayMnC2AATPgVF4xeM8c0/7k0irVFBiyNu7k+k7BYCx
         aUXerIbx1vpkg8/UBwko8j/sA4DX1JZmQDeWW8Yj9HXrJkG2mqhiqtHYj1ZmC6FbrPFu
         cyfMjc2toPaqATkxfCbbffZ22bbjn5q+G924U24AaXfoQ7EAegKLIOpTjfRt1H4zXGO4
         EMqKTXYcR8Czbc/ROEdELcqKr96oMQqJHiKQIcUNMQWvQjHMAAV90rk5JKajK2n/zPyj
         qQpg==
X-Gm-Message-State: AOUpUlFVRa2dA8nH42GOxGFuLAoiMGoUfAuaONdAeVV9P5WS73VNMhAq
        b26bExUwOmRThJ7TtGKpi/I=
X-Google-Smtp-Source: AAOMgpcV99Cdnhjglzh8UtVglfptMElthn9GtHJP2Otiru7vrfw6BLTZLlIL9SITNwHrMgCpwWqn6g==
X-Received: by 2002:a62:6d42:: with SMTP id i63-v6mr9920884pfc.41.1531547939999;
        Fri, 13 Jul 2018 22:58:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 16/18] staging: gasket: gasket core error handling fixups
Date:   Fri, 13 Jul 2018 22:58:14 -0700
Message-Id: <20180714055816.223754-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Minor fixups to error codes and error handling in gasket core.

No device reset callback registered is not an error condition.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0ef37667e0f1..65780d4dffbf 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -814,7 +814,7 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 			gasket_dev,
 			"Cannot get BAR %d memory region %p",
 			bar_num, &gasket_dev->pci_dev->resource[bar_num]);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	gasket_dev->bar_data[bar_num].virt_base =
@@ -1655,7 +1655,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 			"0x%lx",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
-		return bar_index;
+		return -EINVAL;
 	}
 
 	vma->vm_private_data = gasket_dev;
@@ -1865,11 +1865,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb) {
-		gasket_log_error(
-			gasket_dev, "No device reset callback was registered.");
-		return -EINVAL;
-	}
+	if (!driver_desc->device_reset_cb)
+		return 0;
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
@@ -1894,7 +1891,7 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
 	if (gasket_dev->status == GASKET_STATUS_DEAD) {
 		gasket_log_error(gasket_dev, "Device reported as dead.");
-		return -EINVAL;
+		return -EIO;
 	}
 
 	return 0;
-- 
2.18.0.203.gfac676dfb9-goog

