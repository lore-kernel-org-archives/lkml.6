Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97763C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D6621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="an/dob+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D6621564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHXQWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:22:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44431 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeHXQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:22:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so6583935lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2FHUghnZPnzW+Olj0z+RL1R23rMcP/IaxBNeVxcPJeo=;
        b=an/dob+c5UePlzOnJ3RH1TjdMkTjpEP1xtFfO4nhLCQIxIExqyZeU3M6XIrl4hQouQ
         BESzwmlxZ8bytCUxocpoMvBQULtnLGo2AXmkQy5cdR5CkQlBF8ykmZEzhKMg2Fi3MJEv
         tgzM0h8wfwtujccfTz4C/svQYUwRqoa6cZuS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2FHUghnZPnzW+Olj0z+RL1R23rMcP/IaxBNeVxcPJeo=;
        b=VJFdInmjmDOcfXdF5iLab2eGhvqqEl/iJL7T27wwmssM7P7UAIJWkljuRU4kT2Xbmm
         v23806AMOAm+oFWeEuGgJnQUDXzcj0jKckUZzfrLB0YbYTFAOqIZhQtjN/tReprEwPH2
         3+2schO6bnA8KTccOJH4Nd8fmrSiAP7NXJz5zqf3rI8oXLzW1wy56EeCWjSwf6pqAWso
         FkVpCau/RrQMhFv9uZTFOkiyGMp2LtYcR6zmTGSGESNAieb9NWW5/yAmL1JdNjzIz6tk
         zba3cxnbHHh2uT64qExJamcLh42q/dX9+txiq7gIz+78JI1zQAXifV+CxN97ioDMh4wq
         H8iA==
X-Gm-Message-State: APzg51CRK/x4qxvOf8/Swacf3Fyhv7/QYu7gSbOxn7bgW8zRKb3iaP+e
        xmiROGQ9FBYo20MJRIIL+dOATA==
X-Google-Smtp-Source: ANB0Vdan0hg2dSNyOIng4AGXxUtWS8u+vA2eYGMxHWfejlKLKjYhcB48cu8Bsz/1mYakbAcOrxx+9g==
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr1254558lfe.143.1535114901827;
        Fri, 24 Aug 2018 05:48:21 -0700 (PDT)
Received: from localhost (c-4c3770d5.07-21-73746f28.bbcust.telenor.se. [213.112.55.76])
        by smtp.gmail.com with ESMTPSA id y85-v6sm1324298lfi.46.2018.08.24.05.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:48:21 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] doc: dev-tools: kselftest.rst: update config file location
Date:   Fri, 24 Aug 2018 14:47:44 +0200
Message-Id: <20180824124744.9842-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config fragment files should be placed in
tools/testing/selftests/<testdir>/config

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 6f653acea248..dad1bb8711e2 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -159,7 +159,7 @@ Contributing new tests (details)
  * If a test needs specific kernel config options enabled, add a config file in
    the test directory to enable them.
 
-   e.g: tools/testing/selftests/android/ion/config
+   e.g: tools/testing/selftests/android/config
 
 Test Harness
 ============
-- 
2.11.0

