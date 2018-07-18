Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0EBECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3OlRbfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5247B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbeGRRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:43:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39548 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbeGRRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:43:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id p23-v6so2317138plo.6;
        Wed, 18 Jul 2018 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=M3OlRbfiKb7d5Zk4XzQLEttvWk1wNIYxvSXi3zdE5xxgHL2kBTNhr0nHQNI5WMNSfX
         Of/dOnuzDJNrOOSWpBqAVSmHlGSWQqYOUd7AljErWqXcEv5kVbrEvQUyBSoAWOLmzXoH
         IhUmE64+c9G/q0ijmFEUI+BJ2wrfTagCXMxH3KPtx78srl9S6oQ1lLjBh9uWMlnU/fsg
         uL17jkUgL7bI7vbkoDsDUmmxc/4oGP8J/98YQpLEnFEhESICcGQsJiSDp6YCC158cG1V
         UfCacQ3Xcr6m4YNrAcWi0FaZfcbL23rxy2Ka57zrCnEh+GhX63uaQNK6pNY9f14JUdgk
         6clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=ac71iWt5gYtUzc123Fyjr6XnIt/PaGquNS7yLimnG0q5fwlo6NmSjWsKDqibHqx45B
         hpS4PRK4xxVfWUfZZpImLANiWacNlZb8WeltmLGUjQ9phZHMCCrZ26z/ZdJUvRabdeCU
         n21GfPBVNe1srOl6015SYwjH79RB7gokcvUS0QDO+cQ3Tb4WKbWqVTWrbm7CNn2uAqpz
         /9GgsP6vbIHzwzSnRzxryngGipjMgI77yDJAS1g7X8Hjy6uVS2rc0jwvApkwj4IcsvOj
         S3D/NoClZd0zbi8U+0acFS5ujsBougOX/tqHDx6SPHwRUsk/jnSxQ3RLFC65CZwJfziO
         pg1A==
X-Gm-Message-State: AOUpUlEIlHkFN1BqyElucDlfWTB8+tQBKcAc5ZH0lAqNz1yzvotgR657
        Ob9Wlkfo+OGVlrw7Sv5bHOw=
X-Google-Smtp-Source: AAOMgpfKdVU6GhK+7JCGWW0pilkwAxhKAZCJSR94mP0iKIY6lEmh8HiVWg8KPR0DYI5X2vgJaWaqiw==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr6624355plr.217.1531933459768;
        Wed, 18 Jul 2018 10:04:19 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id l85-v6sm11265190pfk.34.2018.07.18.10.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:04:19 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, RAGHU Halharvi <raghuhack78@gmail.com>
Subject: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Date:   Wed, 18 Jul 2018 21:28:55 +0530
Message-Id: <20180718155855.4949-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix all pointer declaration which causes
   "ERROR: "foo* bar" should be "foo *bar""

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 59fb66c0e064..50a574049144 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -104,7 +104,7 @@ static struct class	*class_pktcdvd;    /* /sys/class/pktcdvd */
 static struct dentry	*pkt_debugfs_root; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
-static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
+static int pkt_setup_dev(dev_t dev, dev_t *pkt_dev);
 static int pkt_remove_dev(dev_t pkt_dev);
 static int pkt_seq_show(struct seq_file *m, void *p);
 
@@ -116,10 +116,10 @@ static sector_t get_zone(sector_t sector, struct pktcdvd_device *pd)
 /*
  * create and register a pktcdvd kernel object.
  */
-static struct pktcdvd_kobj* pkt_kobj_create(struct pktcdvd_device *pd,
-					const char* name,
-					struct kobject* parent,
-					struct kobj_type* ktype)
+static struct pktcdvd_kobj *pkt_kobj_create(struct pktcdvd_device *pd,
+					const char *name,
+					struct kobject *parent,
+					struct kobj_type *ktype)
 {
 	struct pktcdvd_kobj *p;
 	int error;
@@ -246,7 +246,7 @@ static ssize_t kobj_pkt_show(struct kobject *kobj,
 	return n;
 }
 
-static void init_write_congestion_marks(int* lo, int* hi)
+static void init_write_congestion_marks(int *lo, int *hi)
 {
 	if (*hi > 0) {
 		*hi = max(*hi, 500);
@@ -2708,7 +2708,7 @@ static char *pktcdvd_devnode(struct gendisk *gd, umode_t *mode)
 /*
  * Set up mapping from pktcdvd device to CD-ROM device.
  */
-static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
+static int pkt_setup_dev(dev_t dev, dev_t *pkt_dev)
 {
 	int idx;
 	int ret = -ENOMEM;
-- 
2.17.1

