Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBAE20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay8QJgsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBAE20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeK0CD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:03:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39055 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeK0CD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:03:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so6711512pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=//tPueLUVR6LXP3YJz8CCfrGr5OAVWbzXeLfYqx4uYI=;
        b=Ay8QJgspR8wbmgsN4GgIWPN/2i/YIbROBuLFoD+06Zt2FeA+ic+d+PZWyE2Jwe94nV
         c/TGbX1FFh7lGsIckY9oBPhT72an7L3TOdX9xYnV30qOYGuRzpe7/88i8Zk8ZsAfsH9D
         9Uv7HuRMXeQAJ+jpi30N03JU5A+8fkciZCugnHKgPJ/P4jdAj4/9Fbm5aUctzIJGw0tB
         YxJ9saI6RDIHa7yfSh6gPInLOfDotyWn01J1hxNXwwEQS/hOEOlM1iyVSoJ1b1ew3rfh
         xFiOCCDwjAMCEpHAc+cnq4GCSB3Za2c3ECMAbrxIfFdwU2xpq7qnbBo4vyXsC1DJz01w
         oArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=//tPueLUVR6LXP3YJz8CCfrGr5OAVWbzXeLfYqx4uYI=;
        b=QfGS+/BdeNiFrO4r4XbYxvPSPRuiebZrJMSSWJOuh2HWalrnyM7fJ49AaF2OwZ4tnm
         vmFlUNx7RUmL0/j7gXc1M9H501NGoDGnqUBLKFcgfuaZ/ZsW+vLWY8HZY4sJEu9XK5oF
         VLV+VSnN0qd5dEvlSO5CBEd3P723CWPHgRdbjcFiFYPV4xplyEsIWyUZ2NVoXbf+hxjf
         33VZZxMTaBhpY3suhpck1/8RMV0Fmo726qHLhA59tfhzQJzf7gmEu5AzBbUUzQCuSBZi
         /Pgj5Y5waNHFtWUr4DX3CqFH0+Zkt8fvtxFiVsQzpW6XKjUz/QPQDkG5fRZe1tLasbJl
         G4Lg==
X-Gm-Message-State: AA+aEWZ2PNzdB/ua9pRgZEGzoHgyiCyb19Xe4DbhQ7P5Lq94CVCKBAPe
        K2u7EKIA3vij0E0FwvYB2AQ=
X-Google-Smtp-Source: AFSGD/U9F/h50wSO7MEGd2gDnRFoUKUxr5mxRwKc63pTVAn7bJ0yTOuhVLqpjgCvupGLLCSwrDB0+g==
X-Received: by 2002:a63:bd1a:: with SMTP id a26mr25002163pgf.121.1543244944899;
        Mon, 26 Nov 2018 07:09:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l5-v6sm736722pfl.73.2018.11.26.07.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:09:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ebiederm@xmission.com, akpm@linux-foundation.org,
        christian@brauner.io, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] signal: remove some duplicated includes
Date:   Mon, 26 Nov 2018 10:09:00 -0500
Message-Id: <20181126150900.32235-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty.h and fs.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/signal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9a32bc2088c9..b319f06e23f7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -19,8 +19,6 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
-#include <linux/fs.h>
-#include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/coredump.h>
 #include <linux/security.h>
-- 
2.17.0

