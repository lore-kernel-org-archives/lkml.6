Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B74C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A49206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWrEGUen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfAGSur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:50:47 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:51421 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfAGSur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:50:47 -0500
Received: by mail-vs1-f74.google.com with SMTP id p1so458033vsc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hiYA6A/pXaRcCE19K0KMQmsKHOEpZcYgXt+IVfRv0cQ=;
        b=KWrEGUenE48D3d49efaGz1nWuX5p0BIxSJUDRMEWafMETddPOMRqV1sDgfIJ9WOufp
         iYNbsyaCP/rknDALjF7tfNL9T8dXMMGdSRq+AJOwXLFWEudCofLOTZInka6JEzlMP4AQ
         z36UCkez7Dr6zU16t3+p5j2hkwBqqaxrbYe39PvqvhHKHrZFo1JdyvZV+jmX3RB/igiC
         iHXsP8+vUuIpAjHbYQwh/EGzVUhfFexAU03hHwRovZE3gJXqAI7KNQPXeMmWcDriCytJ
         WlXR9mSTri7r9ItD7LXEJpiB5Fiyk3qiUu3btdS5/Iga5OHhVhDP943syI26Nq/fVK2D
         jR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hiYA6A/pXaRcCE19K0KMQmsKHOEpZcYgXt+IVfRv0cQ=;
        b=U2w7weNS2IYTWIsKVUCnHr+QwK1JF9Kxrrin1RYdB1A5cZQ4ptw7aoZxK/xIRaKYQM
         tXKLMTZeptWwv26z9XmLk2M8Df9qWemSeYOY+i+2m01KtDmbFKoH63r3Pc1iN6FcI5up
         7az8PxJYWm190486ecUdnzAc9SYu/lk3m9AXnrs8hhTmBcP0XZCX0TglrkT1DNkGomPW
         Orkmrhxu7mWvNQBhu1kThyoLjjzkjvuJap2nmBsLsAcuRoHI8EKUOLj1Z8u5/1gPN8Ks
         0buexQed5QFOSs59I99CtYfn1OJqIbNS53kgW5s+43xvAhXPVv5QmN5yTSQR7PPRszzv
         Otyw==
X-Gm-Message-State: AA+aEWZBudnSlNEbrqV3lcluN/K1TTLPHHrQ33CMYuBv56MpGX4v87xv
        hx6yl40NS2Zzsx4rI2IKIv8I1ANz
X-Google-Smtp-Source: AFSGD/UR8GO+fsL633KdayYMgf0LBX0AdgTb6mERSLB938PhWzu9aQE5TOnwNYIIHDiMkWFWe8RvJxlB
X-Received: by 2002:a67:8050:: with SMTP id b77mr52771286vsd.19.1546887046118;
 Mon, 07 Jan 2019 10:50:46 -0800 (PST)
Date:   Mon,  7 Jan 2019 10:50:37 -0800
Message-Id: <20190107185039.190919-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 1/3] drivers: platform: goldfish: fix the checkpatch
 complain in Kconfig
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

prefer 'help' over '---help---' for new help texts

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - New change, a minor cleanup.

 drivers/platform/goldfish/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index 479031aa4f88..74fdfa68d1f2 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -2,7 +2,7 @@ menuconfig GOLDFISH
 	bool "Platform support for Goldfish virtual devices"
 	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
 	depends on HAS_IOMEM
-	---help---
+	help
 	  Say Y here to get to see options for the Goldfish virtual platform.
 	  This option alone does not add any kernel code.
 
@@ -12,7 +12,7 @@ if GOLDFISH
 
 config GOLDFISH_PIPE
 	tristate "Goldfish virtual device for QEMU pipes"
-	---help---
+	help
 	  This is a virtual device to drive the QEMU pipe interface used by
 	  the Goldfish Android Virtual Device.
 
-- 
2.20.1.97.g81188d93c3-goog

