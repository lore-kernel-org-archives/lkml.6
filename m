Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934067AbeE2NQQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:16:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52610 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934203AbeE2NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:41 -0400
X-Google-Smtp-Source: AB8JxZq6nVvOFq97Z5cXExN+Lnt0nbJxfw43uwfzey1SKMqk7/fUXSbdYBntobIAvoxTV4a/qFBa2w==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 05/19] serdev: Introduce modalias field
Date: Tue, 29 May 2018 15:10:00 +0200
Message-Id: <20180529131014.18641-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name of the driver to use with this device, or an alias for that name,
or an alias for the part.
Required for hardware that is neither an of_node nor part of the ACPI
table.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/serdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 62f1b085a794..bb3b9599c652 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -54,6 +54,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	char modalias[SERDEV_NAME_SIZE];
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
-- 
2.17.0
