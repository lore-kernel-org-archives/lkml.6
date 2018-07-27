Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFCB20883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtThO+bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFCB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbeG0DqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:46:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbeG0DqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:46:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so2297756pgp.9;
        Thu, 26 Jul 2018 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=09aB4mnXUPWnw9QWfGKDkygcyLROE1Zekoe4famf4AM=;
        b=UtThO+bDbWi2YH87tt6mBKqPsFNYXYTxzopwd1LVTHjt1hGhuUfy4HCqEVVEoAgOMg
         KFl6TEu6I8twFD9IIx/R9/4hFcTFjhhyWG8MuaZmMzBsxh5E7CF46f6aA2ufoPNNQJx5
         RYJ/GruIhYBjemBCmIjceTrUM3yOWf4s7Y9lIRyN0JX8f18i4x4RXbp1hRJkoEQ97B4V
         RkUBtwp4ZUwsT/sjPZC9ttpGQOCphkUphcvKC6tLBIEigZf/fC4ifaAt/7Vn4jB6uO4a
         fhfWbRSgsZisGUSmTMi2ZafD4RtSrw34Idbod6QHLB4ZciQLZ2gcZxFYtagjBQU99/Kg
         jZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=09aB4mnXUPWnw9QWfGKDkygcyLROE1Zekoe4famf4AM=;
        b=MXXYvP1lMdcntX3Tt95jI0qr0xD0pHQxYJ5vN4z+HPUARHpSbHQ9cuVf/hUuk4E610
         tgdETASAh+2y/ExzxEwctcl/YBNA6Uk4f7woaCGvi+OxM7GeVSHz/FT5UbDdFuf9Demf
         D78x5KbsVbF458TMvbrlWCXImh7vbwY6IRez5aJzrVrHo6O+aNca3hmr13inhL3cHvc9
         OceCCcRaRkOpZyWIVSAPuX2pYZBqTATX36wJcjAVQLzHlxe/KILa/HiOqsdx28TP9Spd
         feFjhgJuoU8Mx+O0BkS8V3OKoxnn8qk5wJnpX6I2vLSb4xSY6VaDrWZM9w94TmCgW2JF
         pt8g==
X-Gm-Message-State: AOUpUlHRxn6sCGTGdVxbTZ2RLMAfTLn1/efqxqFD2Ck3fMNOrRsIkjBa
        bR7607/kM7vXjtHgxAhjVa8=
X-Google-Smtp-Source: AAOMgpeSoU2ZBATsEJEDoj09W31mlSu5SQ9oy/SDfnE79bhVZBHSOe3H7L0vyX1nXBGPZI1lA3Or0Q==
X-Received: by 2002:a63:b213:: with SMTP id x19-v6mr4147714pge.393.1532658386788;
        Thu, 26 Jul 2018 19:26:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3844842pgi.87.2018.07.26.19.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:26:26 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dmitry.torokhov@gmail.com, gustavo@embeddedor.com,
        arvind.yadav.cs@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: mouse: appletouch: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 10:26:18 +0800
Message-Id: <20180727022618.1007-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atp_open(), atp_recover() and atp_resume() are never 
called in atomic context.
They call usb_submit_urb() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/mouse/appletouch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 032d27983b6c..f593ec96c95f 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -810,7 +810,7 @@ static int atp_open(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
 
-	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	dev->open = true;
@@ -976,7 +976,7 @@ static int atp_recover(struct atp *dev)
 	if (error)
 		return error;
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
@@ -994,7 +994,7 @@ static int atp_resume(struct usb_interface *iface)
 {
 	struct atp *dev = usb_get_intfdata(iface);
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
-- 
2.17.0

