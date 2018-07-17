Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C483ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA56B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX5DD1eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA56B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGQVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:20:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34238 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeGQVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:20:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so955362pgv.1;
        Tue, 17 Jul 2018 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=dX5DD1eLri0jVUcRlx0Qk6ra62hvO0WcA70uvE6SomPtK2B8DHkV1Pi3xWJpdJbMfu
         NIy0hpSnrRl5JAFK3zzmk5BBnwa+/jjWUwuzPPzN4JMHEepzaxim9+BYYacg9E/OneM4
         Fb8OF6b3m3qnS+n4v+gE9njeZYVe6QdA6iTFTC6bhacxZMNl+acxvWmktv21oiL1sX51
         tlAsz9FOoIkM2V2eVzd37dIFvgWuCJxFDLGf80/3E+r2wJeBI696TbnP9oz2OAMpAMuY
         l/2MbICJmWg7DVlYQh4H9Egh0kNS/RnVkkd/X4aA4gcb6V+DpCH8KBcr3L2BfEYPbcXl
         s+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=UO7D5qBmB5WQsMwCU4hezUcPDJPN20ZsNQHL8PjgtVbGvce1lhwRECGaLCfpjlC1Sb
         dcRrbE1mOIGYPVuyMZpiqeM6FO7qHiGGDfR3GyBAfYjwSc9tKmGJ4raAWc8GiKFh4D3Q
         b4alZKeW6TohBB0P2cJVzUDF/NdJCa13hjh4B+fEVOH2n5QXFopwg2lHYBWn3L1kDCn0
         vmcFHlfGh1uAIeDl4s2ltXps9Jcg0knIpac+pvpzYM6asag67hV+wPqx5eBLYaDIZF3X
         yRzFrUXlOZ+EgDo92hyyCxk+n5zO1UPiv+3x3CsFzCFhAFbOLb30P3NP1xTwggB3bKmp
         KeDw==
X-Gm-Message-State: AOUpUlF9RESBG+c8UqBhnMGVD+TcT64BLVmJCBRcZisYfqXlQkaQdkEC
        sBtQsNlaC+NbxEPtrVlEFq0=
X-Google-Smtp-Source: AAOMgpfXsttKT09W/wo9XQ7ggHb337b+9z3940vAL/1PR9NgGTccWRyQIvXbbfIXq1HzqHkAq/sQ0A==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr2222450pfi.43.1531860382599;
        Tue, 17 Jul 2018 13:46:22 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id h6-v6sm2544453pfn.80.2018.07.17.13.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:46:21 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Date:   Tue, 17 Jul 2018 23:31:53 +0530
Message-Id: <20180717180153.19386-1-raghuhack78@gmail.com>
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

