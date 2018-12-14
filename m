Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE262053B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkURBzDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE262053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbeLNNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39553 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbeLNNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so4883613ljh.6;
        Fri, 14 Dec 2018 05:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1Ns2266LAlGMYIaGCqH9J7ElnO02kjV8IubeAcZvyA=;
        b=gkURBzDsf3Qm5AB9Tc2rji3vBqsxxr6sHMnQJYpYrJRgMCpnoajEqgmpOcrOYPPmYz
         uVQJ4SnXkdw/Mce8D8aqKiG9RtNY97s9ap3EiSEneE7KVqH3mz64BmXuaY5Kg/ZK3I7q
         BRCDeiPhCEdxBRiDiJEpSJLbjis+pvxi7gLfwFbLSIgoLQI8MiYbV0LnJ3ezgLKigksu
         Giicr9h4kO4B7AefCkzCUn0cziNqFuEADNgGS/DqSDmRJRyoQ8rBRDSgrclk9gRq/M46
         k8yg2tAiR6FB4WvDcgKIV+Ejr4cFAchLgOaerNq/6NXSSbRPgIjT0poRQ6nn3q9xalcj
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1Ns2266LAlGMYIaGCqH9J7ElnO02kjV8IubeAcZvyA=;
        b=lAiyNC4E02VVTHt+tSLvCUXY8JMENcq+tzsk+kMBnRaTKvOtHnRCy5PZ6dUSlyexxS
         +pP5aH/bfHSHPffHrljjKGksMrK/H2CnlqiOB6kkOKKiIO1P3M01wMmLxljGO1kWCx5f
         LwguihZUEJ3WDrtpOhsscrJ5b92Fd3H1iv1SrYPmmzRfLZMcWw0MTCVUVt5hvA50H8rZ
         DnocpoJmAvApWytevLB3U6g5RKU5ohN3eZGqjAj6t/QtUTKvXVvvtuOpvryjGuaLLdIa
         1aJP/zAjQXFnS2DiPgn26QrP93wozMDLhfllV1TKMlwpxlqqttEDMC60FjK7lGfi5R8t
         uyjw==
X-Gm-Message-State: AA+aEWYJFzx9G7910aoAYpoFlm+ZwRiGcW0/5B4wykdLU7uRoh0Q7sSp
        RP09FBQURvTgU1WkC6roNE0NCdNZG2rK8aeQ
X-Google-Smtp-Source: AFSGD/VvjGgpzsVpRAFvobn6xLZZjbG0nRlQcGNGbClQkWr+/TfAL/OZ1Q5BQTjQ3dI5wdSRe0liIg==
X-Received: by 2002:a2e:4c0a:: with SMTP id z10-v6mr1844603lja.85.1544793748951;
        Fri, 14 Dec 2018 05:22:28 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:28 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 5/6] scsi: hpsa: Name more fields in "struct bmic_identify_controller"
Date:   Fri, 14 Dec 2018 18:21:14 +0500
Message-Id: <20181214132115.21440-6-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on information from "struct identify_controller" from
cciss_vol_status.c from the cciss_vol_status tool[1].

[1] https://sourceforge.net/projects/cciss/files/cciss_vol_status/

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa_cmd.h | 109 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hpsa_cmd.h b/drivers/scsi/hpsa_cmd.h
index 21a726e2eec6..64100a33f844 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -695,11 +695,114 @@ struct hpsa_pci_info {
 
 struct bmic_identify_controller {
 	u8	configured_logical_drive_count;	/* offset 0 */
-	u8	pad1[153];
+	__le32	signature;
+	char	running_firm_rev[4];
+	char	rom_firm_rev[4];
+	u8	hardware_rev;
+	u8	reserved_1[4];
+	__le32	drive_present_bit_map;
+	__le32	external_drive_bit_map;
+	__le32	board_id;
+	u8	reserved_2;
+	__le32	non_disk_map;
+	u8	reserved_3[5];
+	u8	marketing_revision;
+	u8	controller_flags;
+	u8	host_flags;
+	u8	expand_disable_code;
+	u8	scsi_chip_count;
+	u8	reserved_4[4];
+	__le32	ctlr_clock;
+	u8	drives_per_scsi_bus;
+	__le16	big_drive_present_map[8];
+	__le16	big_ext_drive_map[8];
+	__le16	big_non_disk_map[8];
+
+	/* used for FW debugging */
+	__le16	task_flags;
+	/* Bitmap used for ICL between controllers */
+	u8	icl_bus_map;
+	/* See REDUNDANT MODE VALUES */
+	u8	redund_ctlr_modes_support;
+	/* See REDUNDANT MODE VALUES */
+	u8	curr_redund_ctlr_mode;
+	/* See REDUNDANT STATUS FLAG */
+	u8	redund_ctlr_status;
+	/* See REDUNDANT FAILURE VALUES */
+	u8	redund_op_failure_code;
+	u8	unsupported_nile_bus;
+	u8	host_i2c_autorev;
+	u8	cpld_revision;
+	u8	fibre_chip_count;
+	u8	daughterboard_type;
+	u8	reserved_5[2];
+
+	u8	access_module_status;
+	u8	features_supported[12];
+	/* Recovery ROM inactive f/w revision */
+	char	rec_rom_inactive_rev[4];
+	/* Recovery ROM flags */
+	u8	rec_rom_flags;
+	u8	pci_to_pci_bridge_status;
+	/* Reserved for future use */
+	u8	reserved_6[4];
+	/* Percent of memory allocated to write cache */
+	u8	percent_write_cache;
+	/* Total cache board size */
+	__le16	daughter_board_cache_size;
+	/* Number of cache batteries */
+	u8	cache_battery_count;
+	/* Total size (MB) of atttached memory */
+	__le16	total_memory_size;
+	/* Additional controller flags byte */
+	u8	more_controller_flags;
+	/* 2nd byte of 3 byte autorev field */
+	u8	x_board_host_i2c_autorev;
+	/* BBWC PIC revision */
+	u8	battery_pic_rev;
+	/* DDFF update engine version */
+	u8	ddff_version[4];
+	/* Maximum logical units supported */
+	__le16	max_logical_units;
+	/* Big num configured logical units */
 	__le16	extended_logical_unit_count;	/* offset 154 */
-	u8	pad2[136];
+	/* Maximum physical devices supported */
+	__le16	max_physical_devices;
+	/* Max physical drive per logical unit */
+	__le16	max_phy_drv_per_logical_unit;
+	/* Number of attached enclosures */
+	u8	enclosure_count;
+	/* Number of expanders detected */
+	u8	expander_count;
+	/* Offset to extended drive present map*/
+	__le16	offset_to_edp_bitmap;
+	/* Offset to extended external drive present map */
+	__le16	offset_to_eedp_bitmap;
+	/* Offset to extended non-disk map */
+	__le16	offset_to_end_bitmap;
+	/* Internal port status bytes */
+	u8	internal_port_status[8];
+	/* External port status bytes */
+	u8	external_port_status[8];
+	/* Yet More Controller flags  */
+	__le32	yet_more_controller_flags;
+	/* Last lockup code */
+	u8	last_lockup;
+	/* PCI slot according to option ROM*/
+	u8	pci_slot;
+	/* Build number */
+	__le16	build_num;
+	/* Maximum safe full stripe size */
+	__le32	max_safe_full_stripe_size;
+	/* Total structure length */
+	__le32	total_length;
+	/* Vendor ID */
+	char	vendor_id[8];
+	/* Product ID */
+	char	product_id[16];
+	u8	reserved_7[68];
 	u8	controller_mode;	/* offset 292 */
-	u8	pad3[32];
+	u8	reserved_8[32];
 };
 
 
-- 
2.19.2

