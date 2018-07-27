Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B772206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUkIuxJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B772206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeG0DtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:49:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37092 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbeG0DtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:49:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so2308050pgq.4;
        Thu, 26 Jul 2018 19:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/fkGNK+QWkyH2mt9ZNA3ms785gxxvkLfa+DGEin9lUA=;
        b=uUkIuxJCcpLb2Inaanuhq2XUrYBS6Yk0bKowzFrQGnAXWvnTJonM9g9p0Fvgo//r5+
         QcKucWWJpMW+RY2hckOR0SxExCp0kpbl+ct/UlN5NBLtw0ogfdMX1EtWP0UDdsf40l2g
         RGIi8dZhP5+j2jwQk776CNJowdemzoyTj1TgUIQBE4Y7BK7e0WSAfUfU0x7XgL0ZEWYb
         CTySO0cydKIFENLKQ5tsAqS54VbMCf/YCZI4eQmETkVke2JeViH3l2Lz3lYtnlWPuaUT
         fz/MggeF1oljhRnyT+sF2YUe5kG3yBkwGqr6QV8s8DyigX/VESZvI/jUSw0vL9O7cGwX
         mrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/fkGNK+QWkyH2mt9ZNA3ms785gxxvkLfa+DGEin9lUA=;
        b=gH0/J+smKhmiiKMhMBOxu/bLNzXWIFB9/OV1avyfVpm7z1V/IZiVJmYbNFFKruXNO2
         EZ+TtbReqn637va1QxwYJ8cn4vmb1fshia93ZYkgxlL9q3EAbpRNjSCn7sVivdqrui0w
         iL+gtIw5UtYBV8dM0RvwSj/WEsOOXTpKXW6BAqCJiACW5tWgfBl47SH26bT0dvfjEh0d
         W/mPOd5c2fFxHisLcopoXpcN6ftJvM7Vb6GVsMQsH3zr4xaVfna8GwuLUaoWQ/vPrvmj
         Pof4XySWAWfHkvvrrsKVrL6AOFplprr1naYQ92gvKigOxm/Mr5TZhvWky0/ef3jQNqkY
         e3OA==
X-Gm-Message-State: AOUpUlFAwckLML1NcOYJJOOJsX0d9q38oH//iQTVruL9XOkW03eYOFzl
        VzFzFXYqlw6P+DRZI/D7qS8=
X-Google-Smtp-Source: AAOMgpdu+77ZywWfZCPvOO5yHaWCn396hhS5wlIlM/EVuHA8BVzRZFmlHhSBVRLGUrWkPVjEwgR26Q==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr4337096pgo.374.1532658567307;
        Thu, 26 Jul 2018 19:29:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id c1-v6sm3687725pfi.142.2018.07.26.19.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:29:26 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: tablet: aiptek: Replace GFP_ATOMIC with GFP_KERNEL in aiptek_probe()
Date:   Fri, 27 Jul 2018 10:29:20 +0800
Message-Id: <20180727022920.1233-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aiptek_probe() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/tablet/aiptek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 545fa6e89035..c82cd5079d0e 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1712,7 +1712,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
         }
 
 	aiptek->data = usb_alloc_coherent(usbdev, AIPTEK_PACKET_LENGTH,
-					  GFP_ATOMIC, &aiptek->data_dma);
+					  GFP_KERNEL, &aiptek->data_dma);
         if (!aiptek->data) {
 		dev_warn(&intf->dev, "cannot allocate usb buffer\n");
 		goto fail1;
-- 
2.17.0

