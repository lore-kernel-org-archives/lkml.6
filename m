Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A974C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE021470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTHmYYo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeJLX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:59:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34881 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeJLX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:59:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so13556288wmf.0;
        Fri, 12 Oct 2018 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23da0w/qgoNPD0fMvWjJIhP0dLanI2/jb3uK9EmShR0=;
        b=GTHmYYo76zzVmg0IFdzJuCHVTlJnlsMx2i6nbPcBzxMUJZyy9OlwdxvaUfKifFWKh6
         ZrqkbDfz4QQ0+Qbe5vme6LtJv05as9e5wr6rHVOR5uxjlFo7PXDnm6kf5SdHZBT3Sh7K
         1krDTktJdoPNQjopQVZvuC4D6PKOrL1RygWT/wSj/rFv0n5h9GR1/NJx4YWLd8MU9U0Z
         i1oxAhozu4Ek9T+j+RhXd6vacYI5RUM9u1IXqE5QFnt/8jfrlvhtKpMNsXX0Ugix5QZK
         9uqPoSY12RkLkPyP2O5gSjARE6kxUq93KYb7UxaH+Q/Bv+YSw9PgQNrNVo1+SsdoRQLt
         Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=23da0w/qgoNPD0fMvWjJIhP0dLanI2/jb3uK9EmShR0=;
        b=lvvVkWeZf6hgAuHVNo7b2SPOkQL93HKqRIPmZNO5Eul350KcgJnGZulGUMAXqMYEIR
         45Ib2EhPto3TLfawTK4t2Uqo6j2qR/HsURJPr7G6p1FObWU5qukEKMAy4ZOnSzfIcKdt
         oJ8Vo39xVTFSmBCqvkVtakmJrfbGVsVpEpSoKsm8xiHWvlWBD18Pb00jwCJtU8tUBorU
         JNqX4ZgamFeWVp5G3gnEoQlm2T2l3fj5jYgnwUD4i25s8otUQFhYhoTrFf0vFHllQDXW
         2t94+FmAC0xXM0wrsRaDtpj3B04ii7qjuKec15EkAlKf/tqfYQrOTf6UpbR3oAPadAOL
         OC5Q==
X-Gm-Message-State: ABuFfoh+ucSndhQE557aHtjCwbSxLTyVcAHXxJVnBS+Vh9xzfC3/9yQS
        4+X9COs7IJ+X9j6bexm/x3Q=
X-Google-Smtp-Source: ACcGV63mviExopDVadMYJuZqJC3WsWiIoTw6FNcHjWi1sKeSKbINQi/v8D1ug6OEbE+uOm2o72kwBw==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr5440240wmd.63.1539361599071;
        Fri, 12 Oct 2018 09:26:39 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1736842wmd.9.2018.10.12.09.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 09:26:38 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 lora-next 1/5] regmap: Add regmap_noinc_write API
Date:   Fri, 12 Oct 2018 17:26:02 +0100
Message-Id: <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API had a noinc_read function added for instances where devices
supported returning data from an internal FIFO in a single read.

This commit adds the noinc_write variant to allow writing to a non
incrementing register, this is used in devices such as the sx1301 for
loading firmware.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h         | 19 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a6bf34d63..404f123 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -94,11 +94,13 @@ struct regmap {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *wr_noinc_table;
 	const struct regmap_access_table *rd_noinc_table;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
@@ -183,6 +185,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
+bool regmap_writeable_noinc(struct regmap *map, unsigned int reg);
 bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90..d4f1fc6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 	return false;
 }
 
+bool regmap_writeable_noinc(struct regmap *map, unsigned int reg)
+{
+	if (map->writeable_noinc_reg)
+		return map->writeable_noinc_reg(map->dev, reg);
+
+	if (map->wr_noinc_table)
+		return regmap_check_range_table(map, reg, map->wr_noinc_table);
+
+	return true;
+}
+
 bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
 {
 	if (map->readable_noinc_reg)
@@ -777,11 +788,13 @@ struct regmap *__regmap_init(struct device *dev,
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
 	map->precious_table = config->precious_table;
+	map->wr_noinc_table = config->wr_noinc_table;
 	map->rd_noinc_table = config->rd_noinc_table;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->writeable_noinc_reg = config->writeable_noinc_reg;
 	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
@@ -1298,6 +1311,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->writeable_noinc_reg = config->writeable_noinc_reg;
 	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
@@ -1898,6 +1912,69 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 EXPORT_SYMBOL_GPL(regmap_raw_write);
 
 /**
+ * regmap_noinc_write(): Write data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to write to
+ * @reg: Register to write to
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus write operations will write a
+ * range of registers. Some devices have certain registers for which a write
+ * operation can write to an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple writes as required to write val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_write(struct regmap *map, unsigned int reg,
+		      const void *val, size_t val_len)
+{
+	size_t write_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->write)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_writeable_noinc(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_write && map->max_raw_write < val_len)
+			write_len = map->max_raw_write;
+		else
+			write_len = val_len;
+		ret = _regmap_raw_write(map, reg, val, write_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + write_len;
+		val_len -= write_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_write);
+
+/**
  * regmap_field_update_bits_base() - Perform a read/modify/write cycle a
  *                                   register field.
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 379505a..de04dc4 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
  *                field is NULL but precious_table (see below) is not, the
  *                check is performed on such table (a register is precious if
  *                it belongs to one of the ranges specified by precious_table).
+ * @writeable_noinc_reg: Optional callback returning true if the register
+ *			supports multiple write operations without incrementing
+ *			the register number. If this field is NULL but
+ *			wr_noinc_table (see below) is not, the check is
+ *			performed on such table (a register is no increment
+ *			writeable if it belongs to one of the ranges specified
+ *			by wr_noinc_table).
  * @readable_noinc_reg: Optional callback returning true if the register
  *			supports multiple read operations without incrementing
  *			the register number. If this field is NULL but
@@ -302,6 +309,7 @@ typedef void (*regmap_unlock)(void *);
  * @rd_table:     As above, for read access.
  * @volatile_table: As above, for volatile registers.
  * @precious_table: As above, for precious registers.
+ * @wr_noinc_table: As above, for no increment writeable registers.
  * @rd_noinc_table: As above, for no increment readable registers.
  * @reg_defaults: Power on reset values for registers (for use with
  *                register cache support).
@@ -352,6 +360,7 @@ struct regmap_config {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
@@ -369,6 +378,7 @@ struct regmap_config {
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *wr_noinc_table;
 	const struct regmap_access_table *rd_noinc_table;
 	const struct reg_default *reg_defaults;
 	unsigned int num_reg_defaults;
@@ -979,6 +989,8 @@ int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
 int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val);
 int regmap_raw_write(struct regmap *map, unsigned int reg,
 		     const void *val, size_t val_len);
+int regmap_noinc_write(struct regmap *map, unsigned int reg,
+		     const void *val, size_t val_len);
 int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			size_t val_count);
 int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
@@ -1222,6 +1234,13 @@ static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_write(struct regmap *map, unsigned int reg,
+				    const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_write(struct regmap *map, unsigned int reg,
 				    const void *val, size_t val_count)
 {
-- 
2.7.4

