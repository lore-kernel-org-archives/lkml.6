Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75227F11
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmYNWNA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75227F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeF2MwK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:52:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39952 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936352AbeF2MwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:52:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id a6-v6so7227858ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KbNEDlhggOCmZJcGGsux/1SDbrIGgH3sx7KEuPsNXE=;
        b=dmYNWNA4C7Bh+hTGNYRc5e4OVT+8hNXSR3bavV0CQ2BcUAg1cKklPoNLZqyyCDhFCe
         euq/XjypqpRQF2Mz3cPXGAOzmh7NFFf+oXWFIggXAJ/yVA+qg/ObXZ2C4Bm0c7RFHQ2x
         1qPue8VTZ5BFk1HDZOHAya0EoLtScOulDExus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/KbNEDlhggOCmZJcGGsux/1SDbrIGgH3sx7KEuPsNXE=;
        b=dznz8Nbcvhirm6vl75i2M0SttqqxjKOBGGVFYsNsmgZzsd31goMUbGmgmH8fi+v8rD
         teshDX5EzcLNrRR9Nos5h6GrwzRu38fyYH4FAsDK2zce+CCht006AgYlglnw3svhMfWz
         sczqsKWkIAMWd6fVTFe+zVm3XSWdDQKFLyfedAyEvdFloL86tQejOD53klT2/Sp+m5Bw
         tcXIPuSK5cAbZ4Jh2w+6f387biA+tXk+MWQW6FP4kxL9tLYD+p3Jvtl/3V5KI3P85CQe
         xtFYY+qF/b9dhESoDW7FBWoEjVNIaS/LTOzYhX4bUBd6Uuzzmrdgz6ostbYmIf/DWoFc
         mMxQ==
X-Gm-Message-State: APt69E26MFzXVEyDYyBtoi9UOA80arRURq97LzIUyjY3h/KEPN16zRoM
        ZG1m5Ef753/93neWlnAlgVH5Zw==
X-Google-Smtp-Source: AAOMgpfP/8Os7RtswYECEDD1Ss1su0g4M/LTv6BeNduRCitRgabPXGNbunR4+6qaSi5RLQEgwUaYiA==
X-Received: by 2002:a2e:1503:: with SMTP id s3-v6mr10420486ljd.65.1530276726782;
        Fri, 29 Jun 2018 05:52:06 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1532529ljj.54.2018.06.29.05.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 05:52:06 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing new tests
Date:   Fri, 29 Jun 2018 14:52:01 +0200
Message-Id: <20180629125201.24025-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629100248.11560-1-anders.roxell@linaro.org>
References: <20180629100248.11560-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description that kernel config options should be added into a
config file that is placed next to the newly added test.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 3bf371a938d0..6f653acea248 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -156,6 +156,11 @@ Contributing new tests (details)
    installed by the distro on the system should be the primary focus to be able
    to find regressions.
 
+ * If a test needs specific kernel config options enabled, add a config file in
+   the test directory to enable them.
+
+   e.g: tools/testing/selftests/android/ion/config
+
 Test Harness
 ============
 
-- 
2.18.0

