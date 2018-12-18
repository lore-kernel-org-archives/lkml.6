Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC46C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D5D2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ+3FJWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLRMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:04:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43204 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeLRMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:04:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so7713931pgk.10;
        Tue, 18 Dec 2018 04:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QTN9L3fTpeWsyJZhvZ1DPbDaK2OWdDpzdc4ujHbndYM=;
        b=fQ+3FJWjXv8sUaA+gUOmv+KdLKDL6Yq0l+9QpUbnPVDuxp3l5wd1IdSqSeJ59K4blO
         S3WUWTDQN9/nlvSsChNgNCKjroOwzviLHjS+NyDjpF1ZpNhYQIu/xHdfRtNQFSifDy2v
         8NYD7gSS43tWzkjL1VQp5Rvql7RxvVEKVuiFPd2JnTCcnauFBE3xDlWN2Pz8CaV/t9sk
         1jyfK0H28nr369RQoazRdEICzfKFp0xJESS/ggqS3+50i3AXAI/Sx8bTc+iccPAN5eMF
         zC68MHkN3+V07WtzoYzqOuHO1lW2mGeTYkAu0+guga/j+U5Yc1YAmcjyC4owx3Z+rksh
         1DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QTN9L3fTpeWsyJZhvZ1DPbDaK2OWdDpzdc4ujHbndYM=;
        b=RVt8MTUF9TzZLiTnu2FCVYTGl+ASOI9u66OPv87V6uvRMblrjEND8q4XEtURsU4wlZ
         qbG0KRg/ZK4qXv8xX62Tzogsu9pPUW4DiSGSxDIF00RMG4OOosqygl5KqhbaiKoSy8Mo
         uGAOyabVJFomeDgYGJb8w4KCfnQcvN/vNJKbbPIUKp1HZL3xf5eY4aXAidO2jOHxzJm8
         CCqBBFwy0xVNR70E0S1fOlKxeheYmbiz7yvA1NvHhjK0I94I88x6+FPjsix8AZO9Is3A
         TMeKR5KVvJYu7Cp1HudM53f93U/aULUXyTCa5KhC5bo/I/+f4dMHyjS99/16hD2w84YQ
         slWw==
X-Gm-Message-State: AA+aEWa9YPv1tBt6ICXWP3IK2rwi9vg5sqrPN0fwLpeAdhMmeJWMercz
        iok6zPM+wugnHK/7e6edvbw=
X-Google-Smtp-Source: AFSGD/VG1THwofgVwusUFLGl/A1DcZe54dwyEVQ5X7hGKo+YJ2suO8FiDWmGlRkTOukCu2CrQ+nKJA==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr14996139pgp.46.1545134676768;
        Tue, 18 Dec 2018 04:04:36 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:3dd3:3693:8487:3f39])
        by smtp.gmail.com with ESMTPSA id 4sm30871885pfq.10.2018.12.18.04.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 04:04:36 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()
Date:   Tue, 18 Dec 2018 20:04:25 +0800
Message-Id: <20181218120425.32223-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function r8a66597_endpoint_disable() and r8a66597_urb_enqueue() may
be concurrently executed.
The two functions both access a possible shared variable "hep->hcpriv".

This shared variable is freed by r8a66597_endpoint_disable() via the
call path:
r8a66597_endpoint_disable
  kfree(hep->hcpriv) (line 1995 in Linux-4.19)

This variable is read by r8a66597_urb_enqueue() via the call path:
r8a66597_urb_enqueue
  spin_lock_irqsave(&r8a66597->lock)
  init_pipe_info
    enable_r8a66597_pipe
      pipe = hep->hcpriv (line 802 in Linux-4.19)

The read operation is protected by a spinlock, but the free operation
is not protected by this spinlock, thus a concurrency use-after-free bug
may occur.

To fix this bug, the spin-lock and spin-unlock function calls in
r8a66597_endpoint_disable() are moved to protect the free operation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Add __acquires/__releases markings for r8a66597_endpoint_disable().
  Thanks Greg for good advice.
---
 drivers/usb/host/r8a66597-hcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 984892dd72f5..42668aeca57c 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1979,6 +1979,8 @@ static int r8a66597_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
 
 static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
 				      struct usb_host_endpoint *hep)
+__acquires(r8a66597->lock)
+__releases(r8a66597->lock)
 {
 	struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
 	struct r8a66597_pipe *pipe = (struct r8a66597_pipe *)hep->hcpriv;
@@ -1991,13 +1993,14 @@ static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
 		return;
 	pipenum = pipe->info.pipenum;
 
+	spin_lock_irqsave(&r8a66597->lock, flags);
 	if (pipenum == 0) {
 		kfree(hep->hcpriv);
 		hep->hcpriv = NULL;
+		spin_unlock_irqrestore(&r8a66597->lock, flags);
 		return;
 	}
 
-	spin_lock_irqsave(&r8a66597->lock, flags);
 	pipe_stop(r8a66597, pipe);
 	pipe_irq_disable(r8a66597, pipenum);
 	disable_irq_empty(r8a66597, pipenum);
-- 
2.17.0

