Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B8BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A24420883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3CSxWZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A24420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeG0ESc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:18:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeG0ESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:18:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so1229473pfi.1;
        Thu, 26 Jul 2018 19:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HGNmA1HswNv9X/n1diJlSamezB6YadgeU8ab6hh7e24=;
        b=E3CSxWZIEqKL6GVYgpAzNOfYAsXXzseuzwSzNcsOERk1SsbkhleoFuBTj8hnVA4Qq1
         wCBT9bhZ5bJnR7rmRRE0noCsptqls7Oz1CbfGYDdOY5iJQ0Yl1YbCrQ3RHqWWanyvOsy
         BA5d7IWWrRvSa4YNmYSB3F5vrGiDnFEaYYKi7jiQMSCcPHj8dsTsDlbTaO9zx6Wtbt5R
         F2fMdBhio8R4gtvZ7QmYioXPzaWHS28I9UJoFW0PZlXHhyhezrZQPxUKUk1InyviGyvB
         0OOmZo9WX46D9uKqyfgWNbO/FiVihwoHky3uzNroPF1MyS3UYj+q90HQ+WKg+mtcqeys
         9ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HGNmA1HswNv9X/n1diJlSamezB6YadgeU8ab6hh7e24=;
        b=PiOuavMBmfA3WWVQBKhXrv/2DsR3l2/5L2Jv+cK6RjRL5sRSWelJsWqBmWQu9u1vtN
         nOy6N0Omx1Xc6vPIsj6A+kSRyI3gwQbaXwCqPeL28O+05tuDTF4xGqkd+mmy9W89BH5d
         zLEZ9Vfdx688VGKuJhcF/0WcdQ8CmP4VtOp9XvM60p9doyRRBAozoRR2SfbFSAsoNsGK
         U92KhPLaPjuHi1XfHv4bSCWrQytfkTKzzBTiwwmgZYbQjWarOLAcw2pNrpEpGWIguDqQ
         VvdTBVouHnm3LBE/AMgIDTbcMKv5+SCJv65h34vOfrnns6QVuHiv+wUjuhrK9WOuHXOZ
         vhIA==
X-Gm-Message-State: AOUpUlFmfJejzebltJL3y5U0RDNqV93KHQXa7Z55uiA9+tQF8iM88y5A
        Xh33XnlxZgcv4Tu2j97Rc+8=
X-Google-Smtp-Source: AAOMgpd33+WSgZl5WC7Q7iu5hm7r3hH4mUy5+on5vNNk5JBnkJTm5uvCXWWewtGmD3aLgerIuz6VFA==
X-Received: by 2002:a62:ed5:: with SMTP id 82-v6mr4733581pfo.198.1532660330608;
        Thu, 26 Jul 2018 19:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id d12-v6sm3626973pfn.118.2018.07.26.19.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:58:50 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     hans.verkuil@cisco.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: i2c: adv7842: Replace mdelay() with msleep() and usleep_range() in adv7842_ddr_ram_test()
Date:   Fri, 27 Jul 2018 10:58:43 +0800
Message-Id: <20180727025843.2378-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adv7842_ddr_ram_test() is never called in atomic context.
It only calls from:
adv7842_ddr_ram_test() <- adv7842_command_ram_test() <- adv7842_ioctl()

adv7842_ddr_ram_test() calls mdelay() to busily wait, 
which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/i2c/adv7842.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index fddac32e5051..74ed32f77d5f 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -3102,7 +3102,7 @@ static int adv7842_ddr_ram_test(struct v4l2_subdev *sd)
 	sdp_write(sd, 0x12, 0x00); /* Disable 3D comb, Frame TBC & 3DNR */
 	io_write(sd, 0xFF, 0x04);  /* Reset memory controller */
 
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	sdp_write(sd, 0x12, 0x00);    /* Disable 3D Comb, Frame TBC & 3DNR */
 	sdp_io_write(sd, 0x2A, 0x01); /* Memory BIST Initialisation */
@@ -3116,12 +3116,12 @@ static int adv7842_ddr_ram_test(struct v4l2_subdev *sd)
 	sdp_io_write(sd, 0x7d, 0x00); /* Memory BIST Initialisation */
 	sdp_io_write(sd, 0x7e, 0x1a); /* Memory BIST Initialisation */
 
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	sdp_io_write(sd, 0xd9, 0xd5); /* Enable BIST Test */
 	sdp_write(sd, 0x12, 0x05); /* Enable FRAME TBC & 3D COMB */
 
-	mdelay(20);
+	msleep(20);
 
 	for (i = 0; i < 10; i++) {
 		u8 result = sdp_io_read(sd, 0xdb);
@@ -3132,7 +3132,7 @@ static int adv7842_ddr_ram_test(struct v4l2_subdev *sd)
 			else
 				pass++;
 		}
-		mdelay(20);
+		msleep(20);
 	}
 
 	v4l2_dbg(1, debug, sd,
-- 
2.17.0

