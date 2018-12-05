Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F30C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C37020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM90l4CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C37020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeLEP55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:57:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33852 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeLEP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:57:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so10224809pfg.1;
        Wed, 05 Dec 2018 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6pkf2GvAJxyMlPiVfjOgB6eVZeqIaQ2IeYx1KI9IiAk=;
        b=iM90l4CIBJjhdHAABDJETrzu51nnql7X++5hjDnJi1holKIR8DPrt+9xRlpvH2Qd3O
         bpNo3FcWA8Xk1pwrCM9sXTGV43tj0bzCMaJGmwIdb0sTWfl/wVmW7EgiCWIZLFCHfmuX
         H8CUHIaMU4YHFeMCNJ0uJ8InW1f7M8ztoVooHk5tAVzzEp6V5qgHff6xm+/2aYkH823Z
         D62gOXn4wKCLOF0QCixrj8H8x+6LNXaWQv5Lu0G7V69Z8onQLLxiRA7Q5wTJT3pUjNLV
         a3fgov7ZxQfD1UzjgNdnLajXl0RCOR/yzBfMWZv1FTo1F8rYALCfS9YsEBhPRID+AAIP
         JSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pkf2GvAJxyMlPiVfjOgB6eVZeqIaQ2IeYx1KI9IiAk=;
        b=ZmWGUoPz4fiTbT4AwwKR9n4sQmaL6NR0GREmlm3dUcuxqgTzZggRajN3AJWFvRVKJu
         /jv3rdOrfGwBWQfsc3mKSHrjBKP7cd+uDlTy1JdR3QY6Dja3uqPQJz3to98YG68R7X5k
         C6YSZMABO/8+YbwNLkAJhkSADSthQ13+oFW6UITgSSRzUkoT9FpzNABcGsCsAY83a0uI
         29iHDU5o1KNg3VDpCz1/5Rj4F1iytHuTuSZUvghEllTHVhvoqfV9kMD43yjm85PkMy8f
         F+G4AgzfnMp3zBrz47iH+KlVvt4SmySGzeHiElglwhXcFMuYG8HY5yCWrKYDvcZ+KLT6
         OUJw==
X-Gm-Message-State: AA+aEWazCu0mEws6lKdVcAR9rHab0SsSzWNHHKD+DprC6BSOaQfCs8Hy
        cVARktglFzxJbNvBrnAGf6wKcmGD4rU=
X-Google-Smtp-Source: AFSGD/V6eARsx1LNeHogTvDQG4r7FV2CwhNy4qiuFJsec6+dQJ5qTQLvgKnQPk9U+XNszh6m0cxnUw==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr20694254pgq.67.1544025476204;
        Wed, 05 Dec 2018 07:57:56 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g65sm104504596pfa.63.2018.12.05.07.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:57:55 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Date:   Wed,  5 Dec 2018 10:57:51 -0500
Message-Id: <20181205155751.15945-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete a line of meaningless return and some useless blank lines. In a function
whose return type is void, returning on the last line is not required.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-revert modify of MODULE_
-delete some blank lines
---
 drivers/cpufreq/cpufreq-nforce2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index dbf82f36d270..33c309a08c64 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -123,8 +123,6 @@ static void nforce2_write_pll(int pll)
 	/* Now write the value in all 64 registers */
 	for (temp = 0; temp <= 0x3f; temp++)
 		pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
-
-	return;
 }
 
 /**
@@ -438,4 +436,3 @@ static void __exit nforce2_exit(void)
 
 module_init(nforce2_init);
 module_exit(nforce2_exit);
-
-- 
2.17.0

