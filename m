Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DDDC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E712238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpkozzay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E712238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHIUhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32955 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHIUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3233190pfn.0;
        Thu, 09 Aug 2018 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSiVVi3rqDaN9cOwbVZla/jtHoG6CbWIGbpqxT3FMYw=;
        b=JpkozzayIBkTZoq7nEMnOnb+AqMkjCfJTNzra59vHZtsFBReoyU6ZOKpEvzez8ttwq
         DlzZ+Zxsn2Z3EUSRZLV5BFZRGa0zwHcoESo4lvNeDgMj7C7U1PJanAdrQN2tYvszhAV9
         Pde0DpaU7pYgxAvaPow/IzmIrbUeYZf9sRycvOEy2xS9/KlM5MkGZdx3BS7UtFqMooDQ
         GxUJc7/BC6Js6U5hFn022HWSDgSxCCGi7M3y095iwfSrXTh+3hmzQjMGCwtcoafP44qj
         4254PSSGJ0/sv0g1IbTP7FCcKdZm2S0qYdrQdsZkITSd0MuxZbqiUG/ygdxGXhDiJNZ+
         NvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sSiVVi3rqDaN9cOwbVZla/jtHoG6CbWIGbpqxT3FMYw=;
        b=jlSUv2p7yy8dLtgVr1Qw7xMG+ZzTc3Zq1DzqewLE3EQoybaSX4376p1+bYt/TbTP/q
         YJ2JxN80J72VJ5PwGxfZfJKPdXOXU8K1vQ4cGHuzgC2LsjVY8E6jD3r7TogSJOKY3HMe
         xpoe80bW9NeGjzgC+8tCUlyOfICYc6TGTAiBkgVZMUJVriRL/abnsJ6QSAs2eIpinYEL
         spfFO5yOOewQo0Vs5jcny65unkW8cJGwdm7oHwCVjlLIkly0qMORr1GaKxrvlJO9/l4G
         5KiWhGGY5r+oQHfTOsJLSY0NxWFOvRdZjeIOj32jgOpK03YUfeIgo593PiMVeyj2Sk2b
         /I/w==
X-Gm-Message-State: AOUpUlFu0L6zSfwvGAFWUQdaYwZY8uquMgID9TAkL2raeH+iMQw8Jz6Q
        gsvuJgSEOLtTID6jseTq7VE=
X-Google-Smtp-Source: AA+uWPzndkqIa8Of0ZBquZi6yK+iLdlTGgRwCvgpmBifMjQzp7+eswSn6xSVmXNWd5q75r+2KfJLuA==
X-Received: by 2002:a63:2647:: with SMTP id m68-v6mr3173234pgm.60.1533838278334;
        Thu, 09 Aug 2018 11:11:18 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id k64-v6sm16081815pfc.160.2018.08.09.11.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:17 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 04/12] btrfs-progs: Introduce zone block device helper functions
Date:   Fri, 10 Aug 2018 03:10:57 +0900
Message-Id: <20180809181105.12856-4-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce several zone related functions: btrfs_get_zones() to
get zone information from the specified device and put the information in
zinfo, and zone_is_random_write() to check if a zone accept random writes.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 utils.c   | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 utils.h   |  16 +++++
 volumes.h |  28 ++++++++
 3 files changed, 238 insertions(+)

diff --git a/utils.c b/utils.c
index 2212692c..71fc044a 100644
--- a/utils.c
+++ b/utils.c
@@ -359,6 +359,200 @@ out:
 	return ret;
 }
 
+enum btrfs_zoned_model zoned_model(const char *file)
+{
+	char model[32];
+	int ret;
+
+	ret = queue_param(file, "zoned", model, sizeof(model));
+	if (ret <= 0)
+		return ZONED_NONE;
+
+	if (strncmp(model, "host-aware", 10) == 0)
+		return ZONED_HOST_AWARE;
+	if (strncmp(model, "host-managed", 12) == 0)
+		return ZONED_HOST_MANAGED;
+
+	return ZONED_NONE;
+}
+
+size_t zone_size(const char *file)
+{
+	char chunk[32];
+	int ret;
+
+	ret = queue_param(file, "chunk_sectors", chunk, sizeof(chunk));
+	if (ret <= 0)
+		return 0;
+
+	return strtoul((const char *)chunk, NULL, 10) << 9;
+}
+
+#ifdef BTRFS_ZONED
+int zone_is_random_write(struct btrfs_zone_info *zinfo, u64 bytenr)
+{
+	unsigned int zno;
+
+	if (zinfo->model == ZONED_NONE)
+		return 1;
+
+	zno = bytenr / zinfo->zone_size;
+
+	/*
+	 * Only sequential write required zones on host-managed
+	 * devices cannot be written randomly.
+	 */
+	return zinfo->zones[zno].type != BLK_ZONE_TYPE_SEQWRITE_REQ;
+}
+
+#define BTRFS_REPORT_NR_ZONES	8192
+
+static int btrfs_get_zones(int fd, const char *file, u64 block_count,
+			   struct btrfs_zone_info *zinfo)
+{
+	size_t zone_bytes = zone_size(file);
+	size_t rep_size;
+	u64 sector = 0;
+	struct blk_zone_report *rep;
+	struct blk_zone *zone;
+	unsigned int i, n = 0;
+	int ret;
+
+	/*
+	 * Zones are guaranteed (by the kernel) to be a power of 2 number of
+	 * sectors. Check this here and make sure that zones are not too
+	 * small.
+	 */
+	if (!zone_bytes || (zone_bytes & (zone_bytes - 1))) {
+		error("ERROR: Illegal zone size %zu (not a power of 2)\n",
+		      zone_bytes);
+		exit(1);
+	}
+	if (zone_bytes < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+		error("ERROR: Illegal zone size %zu (smaller than %d)\n",
+		      zone_bytes,
+		      BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+		exit(1);
+	}
+
+	/* Allocate the zone information array */
+	zinfo->zone_size = zone_bytes;
+	zinfo->nr_zones = block_count / zone_bytes;
+	if (block_count & (zone_bytes - 1))
+		zinfo->nr_zones++;
+	zinfo->zones = calloc(zinfo->nr_zones, sizeof(struct blk_zone));
+	if (!zinfo->zones) {
+		error("No memory for zone information\n");
+		exit(1);
+	}
+
+	/* Allocate a zone report */
+	rep_size = sizeof(struct blk_zone_report) +
+		sizeof(struct blk_zone) * BTRFS_REPORT_NR_ZONES;
+	rep = malloc(rep_size);
+	if (!rep) {
+		error("No memory for zones report\n");
+		exit(1);
+	}
+
+	/* Get zone information */
+	zone = (struct blk_zone *)(rep + 1);
+	while (n < zinfo->nr_zones) {
+
+		memset(rep, 0, rep_size);
+		rep->sector = sector;
+		rep->nr_zones = BTRFS_REPORT_NR_ZONES;
+
+		ret = ioctl(fd, BLKREPORTZONE, rep);
+		if (ret != 0) {
+			error("ioctl BLKREPORTZONE failed (%s)\n",
+			      strerror(errno));
+			exit(1);
+		}
+
+		if (!rep->nr_zones)
+			break;
+
+		for (i = 0; i < rep->nr_zones; i++) {
+			if (n >= zinfo->nr_zones)
+				break;
+			memcpy(&zinfo->zones[n], &zone[i],
+			       sizeof(struct blk_zone));
+			sector = zone[i].start + zone[i].len;
+			n++;
+		}
+
+	}
+
+	/*
+	 * We need at least one random write zone (a conventional zone or
+	 * a sequential write preferred zone on a host-aware device).
+	 */
+	if (!zone_is_random_write(zinfo, 0)) {
+		error("ERROR: No conventional zone at block 0\n");
+		exit(1);
+	}
+
+	zinfo->nr_zones = n;
+
+	free(rep);
+
+	return 0;
+}
+
+#endif
+
+int btrfs_get_zone_info(int fd, const char *file, int hmzoned,
+			struct btrfs_zone_info *zinfo)
+{
+	struct stat st;
+	int ret;
+
+	memset(zinfo, 0, sizeof(struct btrfs_zone_info));
+
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		error("unable to stat %s\n", file);
+		return 1;
+	}
+
+	if (!S_ISBLK(st.st_mode))
+		return 0;
+
+	/* Check zone model */
+	zinfo->model = zoned_model(file);
+	if (zinfo->model == ZONED_NONE)
+		return 0;
+
+	if (zinfo->model == ZONED_HOST_MANAGED && !hmzoned) {
+		error("%s: host-managed zoned block device (enable zone block device support with -O hmzoned)\n",
+		      file);
+		return -1;
+	}
+
+	if (!hmzoned) {
+		/* Treat host-aware devices as regular devices */
+		zinfo->model = ZONED_NONE;
+		return 0;
+	}
+
+#ifdef BTRFS_ZONED
+	/* Get zone information */
+	ret = btrfs_get_zones(fd, file, btrfs_device_size(fd, &st), zinfo);
+	if (ret != 0)
+		return ret;
+#else
+	error("%s: Unsupported host-%s zoned block device\n",
+	      file, zinfo->model == ZONED_HOST_MANAGED ? "managed" : "aware");
+	if (zinfo->model == ZONED_HOST_MANAGED)
+		return -1;
+
+	printf("%s: heandling host-aware block device as a regular disk\n",
+	       file);
+#endif
+	return 0;
+}
+
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags)
 {
diff --git a/utils.h b/utils.h
index ac333095..47f6b101 100644
--- a/utils.h
+++ b/utils.h
@@ -68,6 +68,7 @@ void units_set_base(unsigned *units, unsigned base);
 #define	PREP_DEVICE_ZERO_END	(1U << 0)
 #define	PREP_DEVICE_DISCARD	(1U << 1)
 #define	PREP_DEVICE_VERBOSE	(1U << 2)
+#define	PREP_DEVICE_HMZONED	(1U << 3)
 
 #define SEEN_FSID_HASH_SIZE 256
 struct seen_fsid {
@@ -77,10 +78,25 @@ struct seen_fsid {
 	int fd;
 };
 
+struct btrfs_zone_info;
+
+enum btrfs_zoned_model zoned_model(const char *file);
+size_t zone_size(const char *file);
 int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, u64 objectid);
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
+int btrfs_get_zone_info(int fd, const char *file, int hmzoned,
+			struct btrfs_zone_info *zinfo);
+#ifdef BTRFS_ZONED
+int zone_is_random_write(struct btrfs_zone_info *zinfo, u64 bytenr);
+#else
+static inline int zone_is_random_write(struct btrfs_zone_info *zinfo,
+				       u64 bytenr)
+{
+	return 1;
+}
+#endif
 int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root, int fd, const char *path,
 		      u64 block_count, u32 io_width, u32 io_align,
diff --git a/volumes.h b/volumes.h
index b4ea93f0..bad688e5 100644
--- a/volumes.h
+++ b/volumes.h
@@ -22,12 +22,40 @@
 #include "kerncompat.h"
 #include "ctree.h"
 
+#ifdef BTRFS_ZONED
+#include <linux/blkzoned.h>
+#else
+struct blk_zone {
+	int dummy;
+};
+#endif
+
+/*
+ * Zoned block device models.
+ */
+enum btrfs_zoned_model {
+	ZONED_NONE = 0,
+	ZONED_HOST_AWARE,
+	ZONED_HOST_MANAGED,
+};
+
+/*
+ * Zone information for a zoned block device.
+ */
+struct btrfs_zone_info {
+	enum btrfs_zoned_model	model;
+	size_t			zone_size;
+	struct blk_zone		*zones;
+	unsigned int		nr_zones;
+};
+
 #define BTRFS_STRIPE_LEN	SZ_64K
 
 struct btrfs_device {
 	struct list_head dev_list;
 	struct btrfs_root *dev_root;
 	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_zone_info zinfo;
 
 	u64 total_ios;
 
-- 
2.18.0

