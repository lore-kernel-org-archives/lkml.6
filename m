Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136EE13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F6208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfAWseYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F6208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeG3K7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeG3K7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so4265660pfo.12;
        Mon, 30 Jul 2018 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IzmHTBeBSiVIrmI0rYCsSUBQMd5jnyXOKOPzzJavHxc=;
        b=BfAWseYaKEvgzC0aHgGnKNJft7AHpn7jESHCTMlZsHJHnDwabh49b4uelgEAQmE1oF
         vu4QM8gofRSP+un0GuQ4l2VYZ0poix/HMGIdcCu/hZPOklewk24GKRkPGdqSaK5emMhV
         IvU1MWKOhmjYiLhpMBcjQVSs9A7aohb53cj5fJzuB0057y2W/XkhXijfGdS0WC3NxFlN
         Mh3ctW/ZjqfA2eBkfsFkviDwmG/XUj+QnMcVJxep3xsI8dtDo/DzYHuljCLjCh+fT1AC
         PvDcVumJaSmTmMYM9jV+y5l9n+K2ylz/Tni0eXrBNfNVhWcVgYe/QmLBwFrSdsV2i6aw
         wXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IzmHTBeBSiVIrmI0rYCsSUBQMd5jnyXOKOPzzJavHxc=;
        b=FN5UVkIm6i6ATkV8QfSbFzffEgh8yg2VZEvXHZquHPZqMmxFm/myF5J/om0gF6A40o
         mXIJcLzpNx8K8Cw6CIacN5IYb9M5TguvTk/AWlddXR7KJNCr04Si/A7+573y83sOYxkO
         BBw9Cnm8soZA6GWK6dJI8CJAl66WAFbx9G/9L2Pt80aDGOyp59bpRS1wct7qyhzT06Ef
         05TnODwJKy2T4M77E0QLOCSYjpVEr8In0/uRgeyCmJPaDczF1QGEPBH+ZNJ42+26OYTq
         d9c0IKgbMIYyGPF9uJ5P2tr9++Pf8nIMLJfdDmnRYWhAL2eBNpr+t0GRIlS4Lr4L8E28
         tIpw==
X-Gm-Message-State: AOUpUlFDqzDL7MhYvIs+I5Rr5GTvJlinl0Giep3/goFuqLI6oKmwxXBj
        hfmSjt5fKOGwiMYGjlmVy0A=
X-Google-Smtp-Source: AAOMgpd260cQ6HEvevaFmkALXGv6xbf5is7SwBTecNuAcwJKnydd2dBSVZQBEoDZOVoEoH20bJQjQw==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr15298865pgp.200.1532942713454;
        Mon, 30 Jul 2018 02:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id d9-v6sm20096500pfb.86.2018.07.30.02.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:25:13 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] media: usb: em28xx: Replace GFP_ATOMIC with GFP_KERNEL in em28xx_init_usb_xfer()
Date:   Mon, 30 Jul 2018 17:25:07 +0800
Message-Id: <20180730092507.7902-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

em28xx_init_usb_xfer() is never called in atomic context.
It calls usb_submit_urb() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index 36d341fb65dd..4a2ba6132a90 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1053,7 +1053,7 @@ int em28xx_init_usb_xfer(struct em28xx *dev, enum em28xx_mode mode,
 
 	/* submit urbs and enables IRQ */
 	for (i = 0; i < usb_bufs->num_bufs; i++) {
-		rc = usb_submit_urb(usb_bufs->urb[i], GFP_ATOMIC);
+		rc = usb_submit_urb(usb_bufs->urb[i], GFP_KERNEL);
 		if (rc) {
 			dev_err(&dev->intf->dev,
 				"submit of urb %i failed (error=%i)\n", i, rc);
-- 
2.17.0

