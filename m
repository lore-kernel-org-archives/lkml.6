Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2606C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D142145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D142145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLAHnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:43:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40257 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeLAHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:43:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so6296694oth.7;
        Fri, 30 Nov 2018 12:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFbB9VVaPQ1F0JZ8j58+ADCTN6NJYVEdcYZ/7UyBiUc=;
        b=nmb4mzapDo5FrJyYY0OrC35t28oxq/y3crwHPT9UVkBmMIa7eKMo2A54RSzv+douT5
         sPqpw5qfF1ETP4XsQk4twaa7QpEE5S7YSqtOePDwgXlRBgQDh4zyJ+2R5MOJqW1BIjVR
         FvD6JxjcGVutWE8cIgwfbhLqW00/UVLwtAvAwSD0SbDbuWW5jh8uC07RsGb2lkG4PYaO
         38h4yr8ZpZSjG8QQwKWuaIaBWjnRbPx+vivSkY8irwJi5H3yZlJ/yzlcwZd/BYEKbqIN
         +08MSFABVEndsNjUF9/MFp0+6gkICTKx0Cbc0l7bBroDogXv3ImaBaWVl9xZ7/GqrxJV
         L5iw==
X-Gm-Message-State: AA+aEWZMSe0wHXXknK7lPSvVRnI4IS8MMfBaQ8j6R52g1muphl+5cGbN
        uNChxBacE8BfF6dghuVWCVrbt18=
X-Google-Smtp-Source: AFSGD/XAg5FKdJdcrNbKa0qfkGD4OQCzosyTuOpXzR6BMC+LeYSfRMrkWx5OFcawdO1utKoZmzQKaQ==
X-Received: by 2002:a9d:6a09:: with SMTP id g9mr4584046otn.179.1543609956610;
        Fri, 30 Nov 2018 12:32:36 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 30sm2550641ots.52.2018.11.30.12.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:32:36 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [RFC PATCH] of: Add a GitLab CI config file for unittests
Date:   Fri, 30 Nov 2018 14:32:32 -0600
Message-Id: <20181130203232.5743-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a GitLab CI config file running the DT unittest in a usermode
Linux build. The corresponding CI job can be found here:

https://gitlab.com/robherring/linux-dt-unittest/pipelines

This CI job can be duplicated by others by creating a kernel repo on a
GitLab instance and configuring GitLab CI to use
drivers/of/.gitlab-ci.yml config file.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/.gitlab-ci.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/of/.gitlab-ci.yml

diff --git a/drivers/of/.gitlab-ci.yml b/drivers/of/.gitlab-ci.yml
new file mode 100644
index 000000000000..44a4824f5c33
--- /dev/null
+++ b/drivers/of/.gitlab-ci.yml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+image: registry.gitlab.com/robherring/docker-images/ubuntu-kernel-build
+
+variables:
+  ARCH: um
+
+job-unittest:
+  artifacts:
+    paths:
+      - "*.log"
+
+  script:
+    - echo -e "CONFIG_OF=y\nCONFIG_OF_UNITTEST=y\nCONFIG_OF_OVERLAY=y" > kernel/configs/extra.config
+    - make defconfig extra.config
+    - make -s -j $(nproc) vmlinux | tee build.log
+    - TMP=/tmp ./vmlinux > boot.log || true
+    - grep -E '\#\#\# dt-test \#\#\# end of unittest - [0-9]* passed, 0 failed' boot.log
-- 
2.19.1

