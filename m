Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA1C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0607C20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1QS2vli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfBBPS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33798 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfBBPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so7275231lfc.1;
        Sat, 02 Feb 2019 07:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FqsdWNrwVpIkpI1KCzw2aeX63P4x3d77h9m6SbC+28=;
        b=e1QS2vlijvL7+oERYjEdug6nmZItdcdlmk5TAOUSGq3e/m3FGg+oneu0y0PVR8y2h6
         hgRRxdvil5LrwWgsrSiU5sM1WbSLRKwGBsCuJHUrpv68mY9GvUFReoX/KEf/MonI0MPo
         JUe1Ac9sjsqmIyZpaa7mD6CeIzPrSatQSrADav2CTOh7SSrqVUGqWM8E2E/5TC0B6iry
         LrPlNKOJ5FxWS3nvXVYrmqUFRzCY91hWqZT7C85RmVpoQmtGEROhgKkaXb3NLmwd1QNE
         FqSU6KBgUiQu7DtMHP3Le20xbhrhg6QQyeJdvoQ/GC7htL2P7J1a0h03th3VqZbnSUNF
         /fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FqsdWNrwVpIkpI1KCzw2aeX63P4x3d77h9m6SbC+28=;
        b=rAQPTgEMCX/VGR/xnxckxzYkyv7szm9LLGBOM22Zz+c6Ep26v4xbhwIs7SAOdvL31n
         0wcQlSiJSReLZEBMM8WuXCGgr7rNi062lvXsgALQELrj/zgRkwUduUnJxXxnxBaAWvCR
         /V/yV4yx6Lsw/5PYV0pP+7Uz66GFEqeJkeuruNyc/PMRQ9lU0oqO/FisU/jADpgdJD6k
         t1+y2+gCq1VvBxwiggKXxaWen6XQolyXa/ldeYdbyHTfsZbZgd0iWTn6t8rJiFSz9Vyq
         9Y7f36VsIPTPFUxNpXoj+ZmFmo7bFJXSwwlAy8/LeD/cDRyKhjgFDl7VUP6DTkt6EbCC
         oDzw==
X-Gm-Message-State: AHQUAuZL9KsiB1GpsrH3hoeOe9isVenP6TcgTWPRTJuY1GHuOLTlvee8
        iU1lhE1M/E1RgBbAu/8jrjk=
X-Google-Smtp-Source: AHgI3IYVxQtjfiYmkS7RhtpDNUBsaw5coqDJ5XHqR+KfVkQeQn3taZv8KfEnmWXMUoFxGgsTxMw3HA==
X-Received: by 2002:a19:214c:: with SMTP id h73mr3496496lfh.149.1549120697426;
        Sat, 02 Feb 2019 07:18:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:16 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] input: misc: bma150: Register input device after setting private data
Date:   Sat,  2 Feb 2019 16:18:06 +0100
Message-Id: <20190202151806.9064-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Otherwise we introduce a race condition where userspace can request input
before we're ready leading to null pointer dereference such as

input: bma150 as /devices/platform/i2c-gpio-2/i2c-5/5-0038/input/input3
Unable to handle kernel NULL pointer dereference at virtual address 00000018
pgd = (ptrval)
[00000018] *pgd=55dac831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in: bma150 input_polldev [last unloaded: bma150]
CPU: 0 PID: 2870 Comm: accelerometer Not tainted 5.0.0-rc3-dirty #46
Hardware name: Samsung S5PC110/S5PV210-based board
PC is at input_event+0x8/0x60
LR is at bma150_report_xyz+0x9c/0xe0 [bma150]
pc : [<80450f70>]    lr : [<7f0a614c>]    psr: 800d0013
sp : a4c1fd78  ip : 00000081  fp : 00020000
r10: 00000000  r9 : a5e2944c  r8 : a7455000
r7 : 00000016  r6 : 00000101  r5 : a7617940  r4 : 80909048
r3 : fffffff2  r2 : 00000000  r1 : 00000003  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 54e34019  DAC: 00000051
Process accelerometer (pid: 2870, stack limit = 0x(ptrval))
Stackck: (0xa4c1fd78 to 0xa4c20000)
fd60:                                                       fffffff3 fc813f6c
fd80: 40410581 d7530ce3 a5e2817c a7617f00 a5e29404 a5e2817c 00000000 7f008324
fda0: a5e28000 8044f59c a5fdd9d0 a5e2945c a46a4a00 a5e29668 a7455000 80454f10
fdc0: 80909048 a5e29668 a5fdd9d0 a46a4a00 806316d0 00000000 a46a4a00 801df5f0
fde0: 00000000 d7530ce3 a4c1fec0 a46a4a00 00000000 a5fdd9d0 a46a4a08 801df53c
fe00: 00000000 801d74bc a4c1fec0 00000000 a4c1ff70 00000000 a7038da8 00000000
fe20: a46a4a00 801e91fc a411bbe0 801f2e88 00000004 00000000 80909048 00000041
fe40: 00000000 00020000 00000000 dead4ead a6a88da0 00000000 ffffe000 806fcae8
fe60: a4c1fec8 00000000 80909048 00000002 a5fdd9d0 a7660110 a411bab0 00000001
fe80: dead4ead ffffffff ffffffff a4c1fe8c a4c1fe8c d7530ce3 20000013 80909048
fea0: 80909048 a4c1ff70 00000001 fffff000 a4c1e000 00000005 00026038 801eabd8
fec0: a7660110 a411bab0 b9394901 00000006 a696201b 76fb3000 00000000 a7039720
fee0: a5fdd9d0 00000101 00000002 00000096 00000000 00000000 00000000 a4c1ff00
ff00: a6b310f4 805cb174 a6b310f4 00000010 00000fe0 00000010 a4c1e000 d7530ce3
ff20: 00000003 a5f41400 a5f41424 00000000 a6962000 00000000 00000003 00000002
ff40: ffffff9c 000a0000 80909048 d7530ce3 a6962000 00000003 80909048 ffffff9c
ff60: a6962000 801d890c 00000000 00000000 00020000 a7590000 00000004 00000100
ff80: 00000001 d7530ce3 000288b8 00026320 000288b8 00000005 80101204 a4c1e000
ffa0: 00000005 80101000 000288b8 00026320 000288b8 000a0000 00000000 00000000
ffc0: 000288b8 00026320 000288b8 00000005 7eef3bac 000264e8 00028ad8 00026038
ffe0: 00000005 7eef3300 76f76e91 76f78546 800d0030 000288b8 00000000 00000000
[<80450f70>] (input_event) from [<a5e2817c>] (0xa5e2817c)
Code: e1a08148 eaffffa8 e351001f 812fff1e (e590c018)
---[ end trace 1c691ee85f2ff243 ]---

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1cdc8ce97968..64caf43e5bca 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -470,7 +470,6 @@ static void bma150_init_input_device(struct bma150_data *bma150,
 static int bma150_register_input_device(struct bma150_data *bma150)
 {
 	struct input_dev *idev;
-	int error;
 
 	idev = devm_input_allocate_device(&bma150->client->dev);
 	if (!idev)
@@ -482,18 +481,14 @@ static int bma150_register_input_device(struct bma150_data *bma150)
 	idev->close = bma150_irq_close;
 	input_set_drvdata(idev, bma150);
 
-	error = input_register_device(idev);
-	if (error)
-		return error;
-
 	bma150->input = idev;
-	return 0;
+
+	return input_register_device(idev);
 }
 
 static int bma150_register_polled_device(struct bma150_data *bma150)
 {
 	struct input_polled_dev *ipoll_dev;
-	int error;
 
 	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
 	if (!ipoll_dev)
@@ -509,14 +504,10 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 
 	bma150_init_input_device(bma150, ipoll_dev->input);
 
-	error = input_register_polled_device(ipoll_dev);
-	if (error)
-		return error;
-
 	bma150->input_polled = ipoll_dev;
 	bma150->input = ipoll_dev->input;
 
-	return 0;
+	return input_register_polled_device(ipoll_dev);
 }
 
 int bma150_cfg_from_of(struct device_node *np)
-- 
2.17.1

