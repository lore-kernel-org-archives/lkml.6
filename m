Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B8C2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+E6o4tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeHBKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:09:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44297 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHBKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:09:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so1338216qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iSHmmsrP2UzF9IriGZ+wHxpwzZjGFujQLxtf7uuAt8Y=;
        b=q+E6o4tp6TEA8kghz4/Ry4GwC+DH+9+xvbP94P9xJM0PSzePCLRMqcvUDrwkgqMros
         1xU9mWt2x8sc6tXz+xIU0hxUcjwhcJi6tjOApSu0zsHKYmC6JZi7xQaBGGNv9QyOiMrq
         fICJoqcQXrICaNrfIGOtbyZCoaOIL5O7o82Iuhns83TIH+5vwpLCo9nG5t3kcs3vNG4E
         x85NkM3Yh2SyPoCICX8Z8Q6RHiRkGi4KXVgqIhmYxVPMnNMkqPVebMMhHqvQrA0LA6g5
         JkUxXGgovb4UjtKhIN31JZ/en1oDpTocCv5eOxtJGz9eyM1dl2Tzh43qqIA2E6v8pERy
         howw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iSHmmsrP2UzF9IriGZ+wHxpwzZjGFujQLxtf7uuAt8Y=;
        b=dp+M/ETSp1gbjxpzeT2K/bJuQX72v94p2n2gHlcZIq234Ueznxg6fb6N1KJZ9968xn
         blgzbGUbKAVKXNcedTDdHNvszToJBhzlEpNy4fQWyDhI9ECRwcNpee8lrW0+kjYy+1Jp
         w3y+hE2dTS/rrt7MGNuP3hTQZHMyQvOfqjZjFjhxCmdHGT8VyBN8+WbtDnaG9qu3szc2
         IF5UuozYIEEnFGF+2DZHt59nG0IKvYl0Jd04J/N1p9ifmzlHuwM5o8WOE1iQPpDe5cmM
         9qYQkOriX2q2TQkidrlE+dOeDE7sUN3U3Tc4mugtva5gPPDXCS2YlY3+5nD3BaU3d5y5
         oKvQ==
X-Gm-Message-State: AOUpUlEpnq9F1VQJ8Y4jLm93At/zXz4Z+wE1GognPglUmdet6gHnrC7G
        YOFHlrEHg6byq+hCm5CCebY=
X-Google-Smtp-Source: AAOMgpdWm9YSeewMck1zipN7SJQ7ibfm+W+GSSwfbnvvUlyE6YqKYvJuF+6qUrWKcXNnbV+08/mBig==
X-Received: by 2002:ac8:1a46:: with SMTP id q6-v6mr1637498qtk.5.1533197984770;
        Thu, 02 Aug 2018 01:19:44 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.58])
        by smtp.gmail.com with ESMTPSA id c93-v6sm1441078qkh.90.2018.08.02.01.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:19:44 -0700 (PDT)
From:   oceanhehy@gmail.com
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH v2] libnvdimm, bus: check if type of nd_device_driver within valid scope
Date:   Thu,  2 Aug 2018 04:19:36 -0400
Message-Id: <1533197976-27391-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

According to enum nd_driver_flags, the valid type of nd_device_driver
start from 0x02 and end up with 0x80. Both 0x00 and 0x01 are invalid, and
the value larger than 0x80 is invalid.

To filter valid type, ND_DRIVER_FLAGS_MASK is defined as
(((ND_DRIVER_FLAGS_MAX) << 1) - 2). For example, when ND_DRIVER_FLAGS_MAX
equals to ND_DRIVER_DAX_PMEM(0x80), then ND_DRIVER_FLAGS_MASK equals
to 0xFE.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
v1: https://www.spinics.net/lists/kernel/msg2869760.html
v2: Sorry for noise. I got an email problem, so I have to resend to loop 
linux-nvdimm@lists.01.org.

 drivers/nvdimm/bus.c       | 2 +-
 include/uapi/linux/ndctl.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 27902a8..ec8cf4b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -546,7 +546,7 @@ int __nd_driver_register(struct nd_device_driver *nd_drv, struct module *owner,
 {
 	struct device_driver *drv = &nd_drv->drv;
 
-	if (!nd_drv->type) {
+	if (!(nd_drv->type & ND_DRIVER_FLAGS_MASK)) {
 		pr_debug("driver type bitmask not set (%pf)\n",
 				__builtin_return_address(0));
 		return -EINVAL;
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 7e27070..2a1ce06 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -207,6 +207,8 @@ enum nd_driver_flags {
 	ND_DRIVER_NAMESPACE_BLK   = 1 << ND_DEVICE_NAMESPACE_BLK,
 	ND_DRIVER_DAX_PMEM	  = 1 << ND_DEVICE_DAX_PMEM,
 };
+#define ND_DRIVER_FLAGS_MAX	ND_DRIVER_DAX_PMEM
+#define ND_DRIVER_FLAGS_MASK	(((ND_DRIVER_FLAGS_MAX) << 1) - 2)
 
 enum {
 	ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
-- 
1.8.3.1

