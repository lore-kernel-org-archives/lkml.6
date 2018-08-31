Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3354C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D6220835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdSfHVpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D6220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIADjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:39:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46995 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIADjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:39:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so6150742pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XVxUJjJRuUL5forqmG7x086nVxqj/jr4sQMt84QM6pA=;
        b=OdSfHVplU/W55AyhBHcDfC1YHarFXLTH8h6s2B3vTtFvsugUtOExYMlnO4+bSpL5cl
         NMM2QcobAUNKKIrTREWmgnzu1zG2ZxkUVjtIEW3rYP7NQAn3W+07KSFWOS1bI6qKynfw
         Q4L+IJ+SrUOAXsq1MVgf7oHig7kzxPLKT6iZYs3n+Hqh2HhzperQaJiUha20ibi6c+eB
         jK7OTnIsfcmsIvKJ4bD4dFSKxHS2aopj1aWay9Os1M/8Lqqa+FOuI69KLof12b8Odqma
         Z1P8KC+LyqxiwGVyMh8K7mmGD1cVLt97IyFoily31DYiRoLqKc1iOJon7EPrzDVvTrUn
         iWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XVxUJjJRuUL5forqmG7x086nVxqj/jr4sQMt84QM6pA=;
        b=pWLXV/xbKuDWuRVYy5ZBuFVchunrIyKPTY73Q3H8HiaBAoQQier9spTWiQdrHCgAnr
         ZJctCg666sEyYrzLBxiXR1aTwUuoSjUHZEZml5TIEdFKFYRo8yke75PzlktQrvSP4fD8
         DDRa+OJB4WEWNUKeToCIeT1UquNc8/te6KGyMlTCeqm68/dtxtoLtpcw6HO1/EBnlJ7U
         Qz9flciyvMkFfrLC7aAZF080tmSIq4p0SCp1q0P41FZ6vy5HJBPPC9DDdWAdlnFEfPF0
         y8lnyrxBd7ySgHePROvLmXtV0gaXQoKDpiuzYLKv5+LY3+sKghQh/lCybzwLaBQmDEUH
         9aWA==
X-Gm-Message-State: APzg51C6Skq2XqcGuo8u4ljiPalp/ywjmiuh5Dg6d7PQL8HOssL6kMuG
        Ty0eqplwRbsmUFXHbmcDE2vZlv5W
X-Google-Smtp-Source: ANB0VdYeFHi52UwoT8UASWvtkGZhYVwO8Rhg5rNI/ZlQtRPgu7YWgkUW/DQk2OWL1xZTChSQCJWAMg==
X-Received: by 2002:a63:c245:: with SMTP id l5-v6mr16588617pgg.255.1535758204122;
        Fri, 31 Aug 2018 16:30:04 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id o21-v6sm19462637pfa.54.2018.08.31.16.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:30:03 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: [PATCH 2/3] regmap: split up regmap_config.use_single_rw
Date:   Fri, 31 Aug 2018 16:33:32 -0700
Message-Id: <20180831233333.17223-3-dpfrey@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180831233333.17223-1-dpfrey@gmail.com>
References: <20180831233333.17223-1-dpfrey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split regmap_config.use_single_rw into use_single_read and
use_single_write. This change enables drivers of devices which only
support bulk operations in one direction to use the regmap_bulk_*()
functions for both directions and have their bulk operation split into
single operations only when necessary.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/base/regmap/regmap.c |  4 ++--
 include/linux/regmap.h       | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..78a778c08f92 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -762,8 +762,8 @@ struct regmap *__regmap_init(struct device *dev,
 		map->reg_stride_order = ilog2(map->reg_stride);
 	else
 		map->reg_stride_order = -1;
-	map->use_single_read = config->use_single_rw || !bus || !bus->read;
-	map->use_single_write = config->use_single_rw || !bus || !bus->write;
+	map->use_single_read = config->use_single_read || !bus || !bus->read;
+	map->use_single_write = config->use_single_write || !bus || !bus->write;
 	map->can_multi_write = config->can_multi_write && bus && bus->write;
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 379505a53722..6ea9bf9377cb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -315,9 +315,12 @@ typedef void (*regmap_unlock)(void *);
  *                   masks are used.
  * @zero_flag_mask: If set, read_flag_mask and write_flag_mask are used even
  *                   if they are both empty.
- * @use_single_rw: If set, converts the bulk read and write operations into
- *		    a series of single read and write operations. This is useful
- *		    for device that does not support bulk read and write.
+ * @use_single_read: If set, converts the bulk read operation into a series of
+ *                   single read operations. This is useful for a device that
+ *                   does not support  bulk read.
+ * @use_single_write: If set, converts the bulk write operation into a series of
+ *                    single write operations. This is useful for a device that
+ *                    does not support bulk write.
  * @can_multi_write: If set, the device supports the multi write mode of bulk
  *                   write operations, if clear multi write requests will be
  *                   split into individual write operations
@@ -380,7 +383,8 @@ struct regmap_config {
 	unsigned long write_flag_mask;
 	bool zero_flag_mask;
 
-	bool use_single_rw;
+	bool use_single_read;
+	bool use_single_write;
 	bool can_multi_write;
 
 	enum regmap_endian reg_format_endian;
-- 
2.11.0

