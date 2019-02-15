Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3221B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gebaehCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfBOT6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:58:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34852 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:58:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id v7so8087334lfd.2;
        Fri, 15 Feb 2019 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyGpuqy/ZhXMRh4iUw/Fi8lOBjfC9HvqCP6X0SvuftM=;
        b=gebaehCfuzdx+ry+ViDMWm/VKHFnLfui4urSN3mGQ7OH/lJnELwg1l2adOiwqOG6lM
         +MN5Mjoenu5D0dVatPZO4gJITWdt8fi4nBsz6bon+cAHrY4YAugD+6ipnM0TskGa5CgO
         6LyVR78amrZY7dWusiYxYa2pVqFZRAcRgkqp3jxb1rBHeCPld0TqEcnq9VIIB+vkGd0P
         3e8ZWjQHQVrp17efrlqod5S0/EKWNdqcFaq9ZxodFW2hpQkdkg4FO+B9XXMeB9QpkmCC
         hJ5ZwQa4Md0YpyW9a7OX4MQw5fD7HNW7XmPXJtMzJykEpNYlhaOTQoDFsP2h6ez/XLwM
         0Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyGpuqy/ZhXMRh4iUw/Fi8lOBjfC9HvqCP6X0SvuftM=;
        b=Q/ID5DC4Bur4J2rQMgwXHDGQtWgxDNDX0zTxFtHTSkROQMoaySYxHILcb9HSzzhBOL
         ka/LaEirOIQX+O03UT225XGyAss6juhuBR6PAdxOvHqH9OMlC6Fm5YIVCfsf/0u+p5ap
         UvzWOjzqxTP/sHahi8yf06dBDaSRBejBxQA/S0Fn8zD/xbdviZlYUjwSa6rWT17FGkjs
         1b4qUtwU54XcYX6qgtfYivOQtcV6jRuCi8T+7Tpi90EJyb+aaBRGhiSHpYpQgoBhyW33
         9IVV8PQYcEFf7syyOx3YIdn27C/IVQYS2ydztSnYRyoRhKkB7P1LBTfpIIsRuucAzFAu
         tdrA==
X-Gm-Message-State: AHQUAuYYm5bRisd+paghwsvBs5J6RbRC+IFgFDQM2RGNPQyEAm3A+yJV
        gfmH8hGFYh3oCHCfQ9jyt3WdkJ5/
X-Google-Smtp-Source: AHgI3IY1x6YSztM4B00vE65Rrk63ANtqgGnEiqSY/X8CigeUk5VAR7R61zgj6sLKVNhlHMcQUlTY/w==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr5112297lfi.62.1550260701400;
        Fri, 15 Feb 2019 11:58:21 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id y17-v6sm1441790lja.94.2019.02.15.11.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 11:58:20 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] iio: chemical: sps30: fix attribute kernel version
Date:   Fri, 15 Feb 2019 20:57:59 +0100
Message-Id: <20190215195759.31304-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.22 has never existed and this change was actually added to 4.21
hence fix the numbering.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-sps30 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
index 143df8e89d08..bef52f3e47bc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
@@ -1,6 +1,6 @@
 What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
 Date:		December 2018
-KernelVersion:	4.22
+KernelVersion:	4.21
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Writing 1 starts sensor self cleaning. Internal fan accelerates
--
2.20.1

