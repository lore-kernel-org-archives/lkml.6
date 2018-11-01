Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B3C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIkn9/te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B3C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKAKe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:34:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39622 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeKAKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:34:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so7514858pla.6;
        Wed, 31 Oct 2018 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tiiStvhrs8btuXa0jGw4HN8nMpuI2p8G//vdpzbYWXQ=;
        b=VIkn9/tesll6aQF/ONOZthBNKQZrxk77AacCwpuGJGophbzD49+3I4kWRrjjb4mZso
         IeeK0M0Ei+jadP80hCf8MrDdMA/fGJ6AFhXxDlWj1uVJKtVoKZhiGwzNv7qaVBoOfoYz
         Jb2ogvm1ACEOcFBmup7qjDdoNUl1SftIYe/WmQadO2YctB3LGgV5Q9ox40uUbAJurkQz
         AmVn8oPzQM8NsXQrE27zMDd9MlwyFSGIHxwV2cvzvKI7bfLX053RdINyPDTyxuiiGAwP
         3vNFISm1EHwQbDdKhrU5s0069ytHp0QNiadEd1t5AufWpCCb34zTfN4BZghG+AuNLDqn
         u2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tiiStvhrs8btuXa0jGw4HN8nMpuI2p8G//vdpzbYWXQ=;
        b=GcgFbsrZJoJT6rkR1GtBEPncESvNoFE+xfUbRAv07PBhDEO1MBIoMb+T5Ku4Tp6aR+
         vq6N7UKe56EF4S+E1YTjaIyWLmo8KO0MdCGAVm8uf4l6NADhqoVOUF84br2zJYBmvpQa
         f9oBZGpp6Myn3c4lx3Xlps2b6DKU9WleXGpJ+A4fo16WmX5VUMoAVYMnC/2OtgmS7ec1
         KGtRbMtN3mnoN9wsyaRPYusFgYpfodtzyz3C1WzvOpBRde4ksZl5jTVfnTcW/rDM+t6s
         DyKzEnRoUF7kYWDD6J6Y82/QQEG6Ng4SNX+aZlK5S+dJ/4ygQS/nEA7kiodmTKjkmkf7
         gWTQ==
X-Gm-Message-State: AGRZ1gJLXw1eAzIY/kIuTFi+WE6K1C2/fwX7/ZX8hJjT/r1c+9xq6Zqb
        ESy3t/ez6wcIv3RxZNmW8vzf9IQI1KY=
X-Google-Smtp-Source: AJdET5dgU9a5xCO2+b1F4VhraipmfbNdk8kHvhWhK0ZWpn3a8fXJjn1mKrkzwouCzAIK26fP0ar4RQ==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr5775928plt.106.1541036051644;
        Wed, 31 Oct 2018 18:34:11 -0700 (PDT)
Received: from penguin.lxd ([175.156.134.220])
        by smtp.gmail.com with ESMTPSA id c128-v6sm24756171pfb.147.2018.10.31.18.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:34:11 -0700 (PDT)
From:   Zhao Wei Liew <zhaoweiliew@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, trivial@kernel.org,
        Zhao Wei Liew <zhaoweiliew@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: cpufreq: Correct a typo
Date:   Thu,  1 Nov 2018 01:32:46 +0000
Message-Id: <20181101013257.659-1-zhaoweiliew@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the admin-guide documentation for cpufreq.

Signed-off-by: Zhao Wei Liew <zhaoweiliew@gmail.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 47153e64dfb5..7eca9026a9ed 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -150,7 +150,7 @@ data structures necessary to handle the given policy and, possibly, to add
 a governor ``sysfs`` interface to it.  Next, the governor is started by
 invoking its ``->start()`` callback.
 
-That callback it expected to register per-CPU utilization update callbacks for
+That callback is expected to register per-CPU utilization update callbacks for
 all of the online CPUs belonging to the given policy with the CPU scheduler.
 The utilization update callbacks will be invoked by the CPU scheduler on
 important events, like task enqueue and dequeue, on every iteration of the
-- 
2.11.0

