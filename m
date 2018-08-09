Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DDC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038B2238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZJL5vB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B038B2238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHIUh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33691 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeHIUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so3125789pgv.0;
        Thu, 09 Aug 2018 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOCMaRWDGBx2P16zaSrQG44JuqG6jiFD4BQxMhQSjxw=;
        b=iZJL5vB6KST4yVzlHcHE97tAkN+RPilFSnhA2GWM8teM3KW3d4055Il42rq3yNP4dr
         WvIRunldBSaikTFjBHA/bu198kYf/NBkdop8U0qZHek6LVo/6a6TOhE/v+o1+sH3Bt2p
         TmT9vwi/vRrhEEwji/7o4OJnK/l6HwF1bNz9K915Z2rL0b53oZpOshYSWGl+SqtqmmWe
         NFqHLWpq69n5avfUM5sU62kSgiJ59rSHgHKstm5Ko+nGwFXMKQNazo1fsItpZvfrQLdp
         oipNVSNrxgJWH/Fe6KwOgMUo4ORzIMn3lLOyl5NF6AdTzcZ065wEv+NuaK5GOu+K2/L4
         wClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=oOCMaRWDGBx2P16zaSrQG44JuqG6jiFD4BQxMhQSjxw=;
        b=Q6Skb5gDfz0KHpCFCdEbAMYKpk+h60LUAxSEtPXGfyuPJUI01vxN9ceQp1RB1LF4Zq
         nmdIq/PVQJBgYhSIww1trIHI/KmFrBK3TU5Y9O8VX0u97Mwchu12JZsV1Dpx41JGpdyD
         7WlVmTV2cufeinDvSzHWhGySG4W/H17J9NSoYvk/7DYAOdqYMGjGtnMRplb2kPGUQ182
         DHN6o1IJ2nsERNZQHfMajvL5XiISyc27aKZzLeokY8gn4DXBbXCYBVVu2NmlETlJfVSx
         6Y90cPAW7ZLkoIMMpiF7OKft7aY5D00DxsLEq6hlmVEsxKwXk7gRoRy3cnn6Uz/kbNY+
         MvbQ==
X-Gm-Message-State: AOUpUlEyNlvQjbxeftnidG++lV2uweGlYU+yOk/bLqVwR/4Y5kT9lO5i
        TvBSc+owMPZP+xnpEo2Y6Mc=
X-Google-Smtp-Source: AA+uWPwhel7H6qKI+Qy1ZTiSaPVGP0PYYdO9ijDjjxUOTZnx8ogPNV/2HtcHFW1sNZCz9MkDwS3E2g==
X-Received: by 2002:a62:67c2:: with SMTP id t63-v6mr3455435pfj.204.1533838287195;
        Thu, 09 Aug 2018 11:11:27 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id v30-v6sm12506966pgn.80.2018.08.09.11.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:26 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 07/12] btrfs-progs: support discarding zoned device
Date:   Fri, 10 Aug 2018 03:11:00 +0900
Message-Id: <20180809181105.12856-7-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All zones of zoned block devices should be reset before writing. Support
this by considering zone reset as a special case of block discard and block
zeroing. Of note is that only zones accepting random writes can be zeroed.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 utils.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/utils.c b/utils.c
index a2172a82..79a45d92 100644
--- a/utils.c
+++ b/utils.c
@@ -123,6 +123,37 @@ static int discard_range(int fd, u64 start, u64 len)
 	return 0;
 }
 
+/*
+ * Discard blocks in the zones of a zoned block device.
+ * Process this with zone size granularity so that blocks in
+ * conventional zones are discarded using discard_range and
+ * blocks in sequential zones are discarded though a zone reset.
+ */
+static int discard_zones(int fd, struct btrfs_zone_info *zinfo)
+{
+#ifdef BTRFS_ZONED
+	unsigned int i;
+
+	/* Zone size granularity */
+	for (i = 0; i < zinfo->nr_zones; i++) {
+		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			discard_range(fd, zinfo->zones[i].start << 9,
+				      zinfo->zone_size);
+		} else if (zinfo->zones[i].cond != BLK_ZONE_COND_EMPTY) {
+			struct blk_zone_range range = {
+				zinfo->zones[i].start,
+				zinfo->zone_size >> 9 };
+			if (ioctl(fd, BLKRESETZONE, &range) < 0)
+				return errno;
+		}
+	}
+
+	return 0;
+#else
+	return -EIO;
+#endif
+}
+
 /*
  * Discard blocks in the given range in 1G chunks, the process is interruptible
  */
@@ -205,8 +236,38 @@ static int zero_blocks(int fd, off_t start, size_t len)
 
 #define ZERO_DEV_BYTES SZ_2M
 
+static int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo,
+			    off_t start, size_t len)
+{
+	size_t zone_len = zinfo->zone_size;
+	off_t ofst = start;
+	size_t count;
+	int ret;
+
+	/* Make sure that zero_blocks does not write sequential zones */
+	while (len > 0) {
+
+		/* Limit zero_blocks to a single zone */
+		count = min_t(size_t, len, zone_len);
+		if (count > zone_len - (ofst & (zone_len - 1)))
+			count = zone_len - (ofst & (zone_len - 1));
+
+		if (zone_is_random_write(zinfo, ofst)) {
+			ret = zero_blocks(fd, ofst, count);
+			if (ret != 0)
+				return ret;
+		}
+
+		len -= count;
+		ofst += count;
+	}
+
+	return 0;
+}
+
 /* don't write outside the device by clamping the region to the device size */
-static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
+static int zero_dev_clamped(int fd, struct btrfs_zone_info *zinfo,
+			    off_t start, ssize_t len, u64 dev_size)
 {
 	off_t end = max(start, start + len);
 
@@ -219,6 +280,9 @@ static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
 	start = min_t(u64, start, dev_size);
 	end = min_t(u64, end, dev_size);
 
+	if (zinfo->model != ZONED_NONE)
+		return zero_zone_blocks(fd, zinfo, start, end - start);
+
 	return zero_blocks(fd, start, end - start);
 }
 
@@ -566,6 +630,7 @@ int btrfs_get_zone_info(int fd, const char *file, int hmzoned,
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags)
 {
+	struct btrfs_zone_info zinfo;
 	u64 block_count;
 	struct stat st;
 	int i, ret;
@@ -584,13 +649,30 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (max_block_count)
 		block_count = min(block_count, max_block_count);
 
+	ret = btrfs_get_zone_info(fd, file, opflags & PREP_DEVICE_HMZONED,
+				  &zinfo);
+	if (ret < 0)
+		return 1;
+
 	if (opflags & PREP_DEVICE_DISCARD) {
 		/*
 		 * We intentionally ignore errors from the discard ioctl.  It
 		 * is not necessary for the mkfs functionality but just an
-		 * optimization.
+		 * optimization. However, we cannot ignore zone discard (reset)
+		 * errors for a zoned block device as this could result in the
+		 * inability to write to non-empty sequential zones of the
+		 * device.
 		 */
-		if (discard_range(fd, 0, 0) == 0) {
+		if (zinfo.model != ZONED_NONE) {
+			printf("Resetting device zones %s (%u zones) ...\n",
+				file, zinfo.nr_zones);
+			if (discard_zones(fd, &zinfo)) {
+				fprintf(stderr,
+					"ERROR: failed to reset device '%s' zones\n",
+					file);
+				return 1;
+			}
+		} else if (discard_range(fd, 0, 0) == 0) {
 			if (opflags & PREP_DEVICE_VERBOSE)
 				printf("Performing full device TRIM %s (%s) ...\n",
 						file, pretty_size(block_count));
@@ -598,12 +680,12 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		}
 	}
 
-	ret = zero_dev_clamped(fd, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, &zinfo, 0, ZERO_DEV_BYTES, block_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
-		ret = zero_dev_clamped(fd, btrfs_sb_offset(i),
+		ret = zero_dev_clamped(fd, &zinfo, btrfs_sb_offset(i),
 				       BTRFS_SUPER_INFO_SIZE, block_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, block_count - ZERO_DEV_BYTES,
+		ret = zero_dev_clamped(fd, &zinfo, block_count - ZERO_DEV_BYTES,
 				       ZERO_DEV_BYTES, block_count);
 
 	if (ret < 0) {
-- 
2.18.0

