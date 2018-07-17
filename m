Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91DCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FDD20673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt4oh9J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FDD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGQUUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:20:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38690 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:20:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so888731pgq.5;
        Tue, 17 Jul 2018 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/tpt/0uWY5c++QEOITaE78kR8KzSxsnkjws3xDlvBH4=;
        b=nt4oh9J5YWZIrWf+7gZZYNZEB8rO/Me0qXkO4PT7yH/M/T7DokIyP7rAXueCYHBszL
         2qMyvxHpTySVxbvTcZ7QOK9O/S8GF+uFh0NTg2FrCAyOSbj5NOr6e/5GrIAiTroCN+ur
         mDftE/cLsAgOAZUoU7hi2UikRo6buVOxmULnihDoNZr924ywQwZYIgK22QhI7SWJmJNn
         SK0hmWTP84iT6/bJ2eulWYhrypwTfUO3RSanu+mCPJX5RAskqjM8kcN1/ijL5G8cG99Q
         8zPrI8WTG2+o5LsXvDgO9ffzTC6XHuDitg9YSvKt2QN51ShiSOx0V5dxuOcekBhVPZaf
         RJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/tpt/0uWY5c++QEOITaE78kR8KzSxsnkjws3xDlvBH4=;
        b=sDTImMsHtwL2PVDUI4SgGpuQmtNz0DeOiBI3TwmrKbNN69nfWJ+G09O+NJDVjNKed4
         0CP7N6aoXr+rlZouFiUkIuGNBgPVAfOtVO/I+SOkP6BVmuitaHvyXEis3oZFPdEqEa6S
         /+VwzszhG940/EW3NFX3rv44HHUoR/snukP5W0Ny07/dPyGGQ9zjyZKLJDenVhoWvymu
         1em119OFNa1tzCC3y4clJ+bhs2vNM1X7uSgAiSUAjV5qDyBtloqmN+M0Gd1fxqlwAyXg
         Nr5YAmRyP4Nus5NdLu8wy4YBWFosFZPvM5nEbXt3bUwfon2bxhWonesGLI22pcsr20GI
         Fv8w==
X-Gm-Message-State: AOUpUlFIkILkpU/rM0oKt7Nbe8d2yPT77+opkj5KJ5pTF3WE9ZEe82FY
        Zzn3SgvmJEvBnIv3NeUGiVc=
X-Google-Smtp-Source: AAOMgpf9aiWqL4sut3x5lU0IQ2vKKA313QJPGBsZqvkZPdeiVpmS2Cs7OSuYoIBiOLJ2Wuri4XjFAA==
X-Received: by 2002:a63:f449:: with SMTP id p9-v6mr2915288pgk.213.1531856805264;
        Tue, 17 Jul 2018 12:46:45 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id v82-v6sm5416275pfd.64.2018.07.17.12.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 12:46:44 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:Remove assignment if condition
Date:   Tue, 17 Jul 2018 22:32:12 +0530
Message-Id: <20180717170212.17197-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove checkpatch errors caused due to assignment operation in if
condition

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 69 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c61d20c9f3f8..426e54a9d574 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -798,7 +798,8 @@ static noinline_for_stack int pkt_set_speed(struct pktcdvd_device *pd,
 	cgc.cmd[4] = (write_speed >> 8) & 0xff;
 	cgc.cmd[5] = write_speed & 0xff;
 
-	if ((ret = pkt_generic_packet(pd, &cgc)))
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret)
 		pkt_dump_sense(pd, &cgc);
 
 	return ret;
@@ -1562,7 +1563,8 @@ static int pkt_get_disc_info(struct pktcdvd_device *pd, disc_information *di)
 	cgc.cmd[8] = cgc.buflen = 2;
 	cgc.quiet = 1;
 
-	if ((ret = pkt_generic_packet(pd, &cgc)))
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret)
 		return ret;
 
 	/* not all drives have the same disc_info length, so requeue
@@ -1591,7 +1593,8 @@ static int pkt_get_track_info(struct pktcdvd_device *pd, __u16 track, __u8 type,
 	cgc.cmd[8] = 8;
 	cgc.quiet = 1;
 
-	if ((ret = pkt_generic_packet(pd, &cgc)))
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret)
 		return ret;
 
 	cgc.buflen = be16_to_cpu(ti->track_information_length) +
@@ -1612,17 +1615,20 @@ static noinline_for_stack int pkt_get_last_written(struct pktcdvd_device *pd,
 	__u32 last_track;
 	int ret = -1;
 
-	if ((ret = pkt_get_disc_info(pd, &di)))
+	ret = pkt_get_disc_info(pd, &di);
+	if (ret)
 		return ret;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
-	if ((ret = pkt_get_track_info(pd, last_track, 1, &ti)))
+	ret = pkt_get_track_info(pd, last_track, 1, &ti);
+	if (ret)
 		return ret;
 
 	/* if this track is blank, try the previous. */
 	if (ti.blank) {
 		last_track--;
-		if ((ret = pkt_get_track_info(pd, last_track, 1, &ti)))
+		ret = pkt_get_track_info(pd, last_track, 1, &ti);
+		if (ret)
 			return ret;
 	}
 
@@ -1657,7 +1663,8 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 	memset(buffer, 0, sizeof(buffer));
 	init_cdrom_command(&cgc, buffer, sizeof(*wp), CGC_DATA_READ);
 	cgc.sense = &sense;
-	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
+	ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0);
+	if (ret) {
 		pkt_dump_sense(pd, &cgc);
 		return ret;
 	}
@@ -1672,7 +1679,8 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 	 */
 	init_cdrom_command(&cgc, buffer, size, CGC_DATA_READ);
 	cgc.sense = &sense;
-	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0))) {
+	ret = pkt_mode_sense(pd, &cgc, GPMODE_WRITE_PARMS_PAGE, 0);
+	if (ret) {
 		pkt_dump_sense(pd, &cgc);
 		return ret;
 	}
@@ -1714,7 +1722,8 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 	wp->packet_size = cpu_to_be32(pd->settings.size >> 2);
 
 	cgc.buflen = cgc.cmd[8] = size;
-	if ((ret = pkt_mode_select(pd, &cgc))) {
+	ret = pkt_mode_select(pd, &cgc);
+	if (ret) {
 		pkt_dump_sense(pd, &cgc);
 		return ret;
 	}
@@ -1819,7 +1828,8 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 	memset(&di, 0, sizeof(disc_information));
 	memset(&ti, 0, sizeof(track_information));
 
-	if ((ret = pkt_get_disc_info(pd, &di))) {
+	ret = pkt_get_disc_info(pd, &di);
+	if (ret) {
 		pkt_err(pd, "failed get_disc\n");
 		return ret;
 	}
@@ -1830,7 +1840,8 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
 
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
-	if ((ret = pkt_get_track_info(pd, track, 1, &ti))) {
+	ret = pkt_get_track_info(pd, track, 1, &ti);
+	if (ret) {
 		pkt_err(pd, "failed get_track\n");
 		return ret;
 	}
@@ -1918,7 +1929,8 @@ static noinline_for_stack int pkt_write_caching(struct pktcdvd_device *pd,
 	 */
 	cgc.quiet = 1;
 
-	if ((ret = pkt_mode_sense(pd, &cgc, GPMODE_WCACHING_PAGE, 0)))
+	ret = pkt_mode_sense(pd, &cgc, GPMODE_WCACHING_PAGE, 0);
+	if (ret)
 		return ret;
 
 	buf[pd->mode_offset + 10] |= (!!set << 2);
@@ -2093,7 +2105,8 @@ static noinline_for_stack int pkt_perform_opc(struct pktcdvd_device *pd)
 	cgc.timeout = 60*HZ;
 	cgc.cmd[0] = GPCMD_SEND_OPC;
 	cgc.cmd[1] = 1;
-	if ((ret = pkt_generic_packet(pd, &cgc)))
+	ret = pkt_generic_packet(pd, &cgc);
+	if (ret)
 		pkt_dump_sense(pd, &cgc);
 	return ret;
 }
@@ -2103,19 +2116,22 @@ static int pkt_open_write(struct pktcdvd_device *pd)
 	int ret;
 	unsigned int write_speed, media_write_speed, read_speed;
 
-	if ((ret = pkt_probe_settings(pd))) {
+	ret = pkt_probe_settings(pd);
+	if (ret) {
 		pkt_dbg(2, pd, "failed probe\n");
 		return ret;
 	}
 
-	if ((ret = pkt_set_write_settings(pd))) {
+	ret = pkt_set_write_settings(pd);
+	if (ret) {
 		pkt_dbg(1, pd, "failed saving write settings\n");
 		return -EIO;
 	}
 
 	pkt_write_caching(pd, USE_WCACHING);
 
-	if ((ret = pkt_get_max_speed(pd, &write_speed)))
+	ret = pkt_get_max_speed(pd, &write_speed);
+	if (ret)
 		write_speed = 16 * 177;
 	switch (pd->mmc3_profile) {
 		case 0x13: /* DVD-RW */
@@ -2124,7 +2140,8 @@ static int pkt_open_write(struct pktcdvd_device *pd)
 			pkt_dbg(1, pd, "write speed %ukB/s\n", write_speed);
 			break;
 		default:
-			if ((ret = pkt_media_speed(pd, &media_write_speed)))
+			ret = pkt_media_speed(pd, &media_write_speed);
+			if (ret)
 				media_write_speed = 16;
 			write_speed = min(write_speed, media_write_speed * 177);
 			pkt_dbg(1, pd, "write speed %ux\n", write_speed / 176);
@@ -2132,14 +2149,16 @@ static int pkt_open_write(struct pktcdvd_device *pd)
 	}
 	read_speed = write_speed;
 
-	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
+	ret = pkt_set_speed(pd, write_speed, read_speed);
+	if (ret) {
 		pkt_dbg(1, pd, "couldn't set write speed\n");
 		return -EIO;
 	}
 	pd->write_speed = write_speed;
 	pd->read_speed = read_speed;
 
-	if ((ret = pkt_perform_opc(pd))) {
+	ret = pkt_perform_opc(pd);
+	if (ret) {
 		pkt_dbg(1, pd, "Optimum Power Calibration failed\n");
 	}
 
@@ -2161,10 +2180,12 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	 * so bdget() can't fail.
 	 */
 	bdget(pd->bdev->bd_dev);
-	if ((ret = blkdev_get(pd->bdev, FMODE_READ | FMODE_EXCL, pd)))
+	ret = blkdev_get(pd->bdev, FMODE_READ | FMODE_EXCL, pd);
+	if (ret)
 		goto out;
 
-	if ((ret = pkt_get_last_written(pd, &lba))) {
+	ret = pkt_get_last_written(pd, &lba);
+	if (ret) {
 		pkt_err(pd, "pkt_get_last_written failed\n");
 		goto out_putdev;
 	}
@@ -2175,7 +2196,8 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 
 	q = bdev_get_queue(pd->bdev);
 	if (write) {
-		if ((ret = pkt_open_write(pd)))
+		ret = pkt_open_write(pd);
+		if (ret)
 			goto out_putdev;
 		/*
 		 * Some CDRW drives can not handle writes larger than one packet,
@@ -2190,7 +2212,8 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 		clear_bit(PACKET_WRITABLE, &pd->flags);
 	}
 
-	if ((ret = pkt_set_segment_merging(pd, q)))
+	ret = pkt_set_segment_merging(pd, q);
+	if (ret)
 		goto out_putdev;
 
 	if (write) {
-- 
2.17.1

