Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210E520853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5udt4Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210E520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeINXIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:51 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:41292 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:51 -0400
Received: by mail-io1-f74.google.com with SMTP id q24-v6so9292887iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D9eQ2tItZegBigcLUTC2Q80PXYCFSB1C4Fwb6yw5AEU=;
        b=p5udt4YcsnlF1iMhqGeuy7GHMkYxALcbphbOTnhKFi3Qe6PjbxnQgHsNUMkYx9UP+q
         WwcQAUe75JyHosFxBnGHEQTYC8iVepu046k0HZZmxZDLAciK8a2vPRpQnishKhh8VscU
         f7/jSJTj0E81M+Gjrxu7RhosEz/wy7/KZ3BF4+GYKY7qcJmstbkR9RnNbv9mFwG6/zyj
         asaY4q8c8lWEVk/9/UU1WcOmc8MtmmvM53SKRuiMbAzfziiF3lN0Z02C4K8gpcLSpWtF
         I1GUukVPPrdyux0PLoLy2cKd3uq4Svx780UhEkyCGHBR+a/Kagj54aIY3B9cXlSTknnr
         0+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D9eQ2tItZegBigcLUTC2Q80PXYCFSB1C4Fwb6yw5AEU=;
        b=gUo78OweXZgMJCrdRM0ZRbCGJ7GHfN1XuijVkijWvcX6EBaLIB9LrKGbuQj4bel4IL
         SpjYtIAqumxOsIbL8m3osKv4r99UBQ8KxIO5JlMThH4ZXJUd+v/MDiMSC3RnGObTJ+/4
         xF9a9wQks1VWabK42jigaW1SyJVZpMRIfrzfAA+Ga3C8xJvjFG1apZgDQ3MP+EWT/6p6
         ThgdLztBfpibdeq0hI5k8O229ZEiURtiWkFupnL0HKmNRI/bwQPpgUm6Ujbcgjl4wFGV
         VvkYY4oEgBj97A7ZDllFopCs48JSpu0goECvoq8qfVUiOxUFBPCebFssGNQ8CGIqR7Bm
         3XSg==
X-Gm-Message-State: APzg51AaliljRtx4zFNtEWC1/9xsxW69qzvKVf8iz5srg3lqjXDUFklz
        fa4PcU0T2mDl07NUigiOH6isE2Lp
X-Google-Smtp-Source: ANB0VdadqVuB/cgwE0fu1wwvX/968GcuMX0Hv9rs/whGY5cyToDtTcE18CvENGfufyuXnn3nTPIyfxCe
X-Received: by 2002:a6b:1504:: with SMTP id 4-v6mr10542159iov.79.1536947597164;
 Fri, 14 Sep 2018 10:53:17 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:22 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-21-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 21/21] platform: goldfish: pipe: Fix allmodconfig build
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The changes fixes these errors:

WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/goldfish/goldfish_pipe_v1.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/goldfish/goldfish_pipe_v2.o
see include/linux/module.h for more information
ERROR: "goldfish_pipe_device_v2_init" [drivers/platform/goldfish/goldfish_pipe.ko] undefined!
ERROR: "goldfish_pipe_device_v1_init" [drivers/platform/goldfish/goldfish_pipe.ko] undefined!
scripts/Makefile.modpost:92: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1
Makefile:1206: recipe for target 'modules' failed
make: *** [modules] Error 2

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index acb105dbd9fd..354b4a7d18bb 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,5 +1,5 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o \
-	goldfish_pipe_v1.o goldfish_pipe_v2.o
+obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_all.o
+goldfish_pipe_all-objs := goldfish_pipe.o goldfish_pipe_v1.o goldfish_pipe_v2.o
-- 
2.19.0.397.gdd90340f6a-goog

