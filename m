Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9961C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4F2170B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTDIMd/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA4F2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeI1Ant (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:43:49 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39316 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1Ant (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:43:49 -0400
Received: by mail-qt1-f179.google.com with SMTP id c25-v6so3829100qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=loTXTlvBcVtIiQvpsl09CrLSJ+Y20ZA6ds1SUL7VoJw=;
        b=QTDIMd/2vveNiP6HweVmcQXIavxbqYI/25kO/atV/jdcX9IB9Dk3Zn21nKFy9pv1wL
         QmE+wQzI4Xt1Kn42PW46iBUY8oqzR6id7mRB2kbx6YpAOcKOlFqpminjNIC5AvSEnNlP
         Dm0BO8qpw/3Tsj/bJFjgH66CHYFN6w0hgi3prFK8+AOuGh4rWi5ucKdb3pY3XvPh086W
         FkFl2aBoQ/kRM5Ye+kli8UUawMXIobi/0DqylRIHYucFlDd1ccsEvhzq0t2TY6EnNNA6
         IUcR934aPd1HOOVs6vRWw23zOVY0F3J2fTjwdLqsnTjs2IczjBAiNQ7MqsjMWC+e6z7x
         WGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=loTXTlvBcVtIiQvpsl09CrLSJ+Y20ZA6ds1SUL7VoJw=;
        b=DjFiZDbK3qjkR5tB9FjeaVjOsyhfXlyY1dMreL5ErIUwDt8Anf4ETg4FsWge0LsB42
         uOWPfK4c5A5HKnTeDWka/6CCYVYdUsNl5GJ7kiWa27952VLMQkBzx7uaYJFnn8sP+L4/
         C/i1hFNYvjQbBFFz7ERjmqN4VkPVsfvA110MOPcTjQ24m7fp8FkqvqnP8bzfpw5TVViJ
         xRNs8PZlO748ztq1i1OI618jZMIGGHe/tfk/yy0sF1xqOfHaD9M54zOzMb4gBFuVUoji
         JXgjRJqc5JNsZY1ROyRHtTo4iUM9yiiAOBi6/uAvN4Y6mEXj9SUZcS3oLY7w0gC7Z1aD
         VsgQ==
X-Gm-Message-State: ABuFfoigkyh6e3/rA/yGOBTujbDhu/UAThtGg/8qL5Sl83mo3IRbOvJX
        nMp6520PaMAqW6xiEOmEdEM=
X-Google-Smtp-Source: ACcGV60oUK8TF317c2ht/145tE1V0gZL3SYktzvnlBCu6plO/DI6fd896/ykUYj4Blm09Vv9JSkgAA==
X-Received: by 2002:ac8:6c8:: with SMTP id j8-v6mr9365463qth.314.1538072655706;
        Thu, 27 Sep 2018 11:24:15 -0700 (PDT)
Received: from localhost.localdomain ([187.66.107.61])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1492988qkc.53.2018.09.27.11.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:24:15 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     jikos@kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, trivial@kernel.org,
        miguel.ojeda.sandonis@gmail.com, richard.weinberger@gmail.com,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH TRIVIAL v3 1/3] CREDITS: punctuation fix
Date:   Thu, 27 Sep 2018 15:23:44 -0300
Message-Id: <20180927182346.2257-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 CREDITS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 5befd2d71..b82efb36d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
 W: http://www.linuxdiskcert.org/
 D: Random SMP kernel hacker...
 D: Uniform Multi-Platform E-IDE driver
-D: Active-ATA-Chipset maddness..........
+D: Active-ATA-Chipset maddness...
 D: Ultra DMA 133/100/66/33 w/48-bit Addressing
 D: ATA-Disconnect, ATA-TCQ
 D: ATA-Smart Kernel Daemon
-- 
2.19.0

