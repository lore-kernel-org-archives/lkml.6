Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA795ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839B620652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXeDiK93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839B620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGRQmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:42:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37701 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeGRQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:42:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so2249153plc.4;
        Wed, 18 Jul 2018 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=FXeDiK934lPGED/Az9IslSjj98nY0ly4OVNNkPjZPtU+E5tsKmaxo9PuBwsoqQrByh
         dQQmMOu2uRO/3Una3f7b1HYZ1eXc03lQRbCBxWK7w25+J3tHlFnaJOWYAdqg+npszh0g
         HI48bNvc3k7DYEQPuL4klvQPwDK1qt7g7erksc8Axnq6QCJeDY1gYKkLYzgWtjYukQmb
         tma1yC+Qt3aG6Q7z3rQoUjVycP3w+3cKlqkoKOw91CZVglN06dmeQZk/l4MciDptVDzF
         ERUU60ZuB6lLs3XV327vwuW9OcX3aqKmbvysnkiiQ1hqEKsB6HpYYUkwiBr9mLWIt2VJ
         4bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0JQ3i/A6dCHftViqRb24/jwNh9q4x0+VqllIARCODCQ=;
        b=QzmX4Ay7YDCAZw1Yo0Av6fcb5WQaFcYXqE49ykaNGGD8bMjl6tENu0qolg1/JDtdN0
         jL/yCQUwfTYpYZX/Z/q73ccGr3W4ats0a+4/StkOW1swSLUES9FNCBBlCe8aDCwTGnnl
         DIA1x8IvIWLG4FuHkDMql1Nah7RSO//Mifb5tSF1PECOYg4q8GMCQgwmHr0i3F/mTVG2
         AhwfAREWGfPo8p3P7foL81q8UONtW/DRlJSHF5hdp+ZdUrAV1KdbXrv3szDAXxjd2v3s
         C3g9SvaIGVEXxo1vY2UUovtLgwPnsbwjog6t/D/JIjxVUNhNw7qu2JlLV5Vt9NAm9c+f
         //9Q==
X-Gm-Message-State: AOUpUlEQT2r9dOsLZBxnb5iV8Tr0SDMcX5Q3vo2lyYVh6YA64832W+9I
        vFDax5Dx4EDWxwH+YxWZBZw=
X-Google-Smtp-Source: AAOMgpfdA56Mz8T/sRh38ImjYEMi9Yfa15KioXMVwbDw4GIPHOX1Z//rlQGjsEbTas6rn0bU3UrzIg==
X-Received: by 2002:a17:902:8645:: with SMTP id y5-v6mr6491440plt.334.1531929850009;
        Wed, 18 Jul 2018 09:04:10 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id o27-v6sm13227732pfj.35.2018.07.18.09.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:04:09 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Date:   Wed, 18 Jul 2018 20:29:00 +0530
Message-Id: <20180718145900.4048-1-raghuhack78@gmail.com>
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

