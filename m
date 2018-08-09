Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B922238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXNGfIDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B922238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHIUhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHIUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so3211303pff.7;
        Thu, 09 Aug 2018 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJlZGWei2gsWFEDFHY/yR33U2XNBivlD3ZxVWnBZt0A=;
        b=bXNGfIDb7rbruBoDL+SS0iWYo1VQNfjYsLBGm+sqxM4pXMBQjlvYIdMSEyzx/WYq1P
         B0N+/pXNtR1hgthJcOzydh8eoMWLW+VdYUFIW/QrrhXBw6umYbwQKpYfbTcUp8H1zaK0
         JN9cukC4aZvJSk8a2K3e7oKmbq0WjfmdX3e0Kvcb8L7Tw5zD+2vUKYprDNxSNUNSC0M6
         i4JCcCjjaCeN8C/jyoDSIDt3LdE6wPLow3md6ARyu5mRFxUBK8YjG5Lm5UW3/iewVf6r
         FLsEX9O4PSKjNUAcfgdzVDhzNu5OfW9KjsmVtiBpuDdcnNsqjFN1OpeTqnsGu2I1F9Pq
         0e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pJlZGWei2gsWFEDFHY/yR33U2XNBivlD3ZxVWnBZt0A=;
        b=llvlkVofb9VEWyFwlDYvX/26CJNpWheUnJikUzyfwxbtoaPj+1kIcD9L41+mx8i81K
         4Qa9mnW6FXF+lDqb0taa7JNMXr2h1RDGuuFuGdyQEvqZXetJYWyJVK9yytwinDoj9gJg
         vXWIoYr8jsGDcPg0B/mQW2ztgeA5YwCKrxg6z18oT8yz8mcKrVysknJwjlK6kgw8ek1q
         8ftHIsZoqjiMCnWnk9p1zKmlkj0EuqcysBgPCuEgF38KYiZilbKlozKg7H4KNtQmMQkt
         gCMFglGV04lWIitfLqMr/o99VhFl3ZiyUQ8Ztbv38twKmiGDnDS7oA14xjtOcsRxEFo0
         XICg==
X-Gm-Message-State: AOUpUlGyl8MwOuQ0NemO0mFtgJRQ60jwUTpuTfIgoYfhVLVxUluvVM+R
        o2Z09WWDg5nuIebHZ9NvYag=
X-Google-Smtp-Source: AA+uWPwa9VIUNkyJsN1XCji9UOY6SsnlEpk+B9+LlzED8kMPEpKvME7BsaRqBgEtzJdlpm/TJ5DMbg==
X-Received: by 2002:a63:c20:: with SMTP id b32-v6mr3050616pgl.400.1533838293034;
        Thu, 09 Aug 2018 11:11:33 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id t19-v6sm19889786pfk.182.2018.08.09.11.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:32 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 09/12] btrfs-progs: mkfs: Zoned block device support
Date:   Fri, 10 Aug 2018 03:11:02 +0900
Message-Id: <20180809181105.12856-9-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the size of the temporary system group chunk equal to the
device zone size. It also enables PREP_DEVICE_HMZONED if the user enables
the HMZONED feature.

Enabling HMZONED feature is done using option "-O hmzoned". This feature is
incompatible for now with source directory setup.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 mkfs/common.c | 12 +++++++-----
 mkfs/common.h |  1 +
 mkfs/main.c   | 45 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 0ace262b..d01402c8 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -152,6 +152,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
+	u64 system_group_size;
 
 	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
 	if (!buf)
@@ -312,12 +313,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
+	system_group_size = (cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED) ?
+		cfg->zone_size : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
 	dev_item = btrfs_item_ptr(buf, nritems, struct btrfs_dev_item);
 	btrfs_set_device_id(buf, dev_item, 1);
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
-	btrfs_set_device_bytes_used(buf, dev_item,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
@@ -345,7 +348,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
-	btrfs_set_chunk_length(buf, chunk, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_chunk_length(buf, chunk, system_group_size);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
@@ -411,8 +414,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		    (unsigned long)btrfs_dev_extent_chunk_tree_uuid(dev_extent),
 		    BTRFS_UUID_SIZE);
 
-	btrfs_set_dev_extent_length(buf, dev_extent,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_dev_extent_length(buf, dev_extent, system_group_size);
 	nritems++;
 
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
diff --git a/mkfs/common.h b/mkfs/common.h
index 28912906..d0e4c7b2 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -53,6 +53,7 @@ struct btrfs_mkfs_config {
 	u64 features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
+	u64 zone_size;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 83969b4b..f940eba1 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -60,8 +60,12 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
+	u64 system_group_size = 0;
 	int ret;
 
+	system_group_size = fs_info->fs_devices->hmzoned ?
+		fs_info->fs_devices->zone_size : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
 	trans = btrfs_start_transaction(root, 1);
 	BUG_ON(IS_ERR(trans));
 	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
@@ -74,8 +78,8 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
 				     BTRFS_BLOCK_GROUP_SYSTEM,
 				     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER,
-				     BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	allocation->system += BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+				     system_group_size);
+	allocation->system += system_group_size;
 	if (ret)
 		return ret;
 
@@ -700,6 +704,7 @@ int main(int argc, char **argv)
 	int metadata_profile_opt = 0;
 	int discard = 1;
 	int ssd = 0;
+	int hmzoned = 0;
 	int force_overwrite = 0;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
@@ -713,6 +718,7 @@ int main(int argc, char **argv)
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
+	u64 system_group_size;
 
 	while(1) {
 		int c;
@@ -835,6 +841,8 @@ int main(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
+	hmzoned = features & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
 		goto error;
@@ -844,6 +852,11 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
+	if (source_dir_set && hmzoned) {
+		error("The -r and hmzoned feature are incompatible\n");
+		exit(1);
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -875,6 +888,16 @@ int main(int argc, char **argv)
 
 	file = argv[optind++];
 	ssd = is_ssd(file);
+	if (hmzoned) {
+		if (zoned_model(file) == ZONED_NONE) {
+			error("%s: not a zoned block device\n", file);
+			exit(1);
+		}
+		if (!zone_size(file)) {
+			error("%s: zone size undefined\n", file);
+			exit(1);
+		}
+	}
 
 	/*
 	* Set default profiles according to number of added devices.
@@ -1026,7 +1049,8 @@ int main(int argc, char **argv)
 	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
 			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(verbose ? PREP_DEVICE_VERBOSE : 0));
+			(verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
@@ -1037,9 +1061,11 @@ int main(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	if (dev_block_count < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+	system_group_size = hmzoned ?
+		zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
-				(unsigned long long)BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+				(unsigned long long)system_group_size);
 		goto error;
 	}
 
@@ -1055,6 +1081,7 @@ int main(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.zone_size = zone_size(file);
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1064,6 +1091,7 @@ int main(int argc, char **argv)
 
 	fs_info = open_ctree_fs_info(file, 0, 0, 0,
 			OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
+
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
@@ -1137,7 +1165,8 @@ int main(int argc, char **argv)
 				block_count,
 				(verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		if (ret) {
 			goto error;
 		}
@@ -1234,6 +1263,10 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
+		printf("Zoned device:       %s\n", hmzoned ? "yes" : "no");
+		if (hmzoned)
+			printf("Zone size:          %s\n",
+			       pretty_size(fs_info->fs_devices->zone_size));
 		btrfs_parse_features_to_string(features_buf, features);
 		printf("Incompat features:  %s", features_buf);
 		printf("\n");
-- 
2.18.0

