Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73223C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BF320645
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr1exaOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BF320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHUTa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:30:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38445 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbeHUTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:30:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so14750611ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DIvmzclGMOgA+W91vUjE27zddajZBvQC3lNlsIHZ01Q=;
        b=Gr1exaOnk4zPSLxAeXvBqVfUUIY+aDezHEda7G5pPCKnN/zEu0qTQ//REJKiBamjzB
         bRwz9lsPtTnEWesCivpTmuqT0NWk41/2KDcoOlR+m3rYaZ1t8CNmhRZyYlIcHXz+qEic
         3KJLplsaX9JDwIlFI0fLJm4p4eTRCQzcuja2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DIvmzclGMOgA+W91vUjE27zddajZBvQC3lNlsIHZ01Q=;
        b=Bmu3mtpV+ot9ZG0oKPxndyu9bXN8k2r/b58R4jJCU/VO+Lj8ob/WncgXr0xW7AlVps
         +oqRyaaYjVu/6P8qIQ+sptj/BlgbVRGNkhVlf0ZfwBeEe3eYSLzekHLsQMODNSIpPqEJ
         VGBHEirM98Ert/tjMeFkNYP3fRI5ferPz6NNKBGwj7bNKBhYn0mAl4ifKwkkpEkA5VpI
         T5RiDIzGFE54mK46C911IymLHN5GAfayiatcg61MObuOvN8suxmcrZKaMaiMxF2YbjPE
         6uQwXZt6d/ItoXbwsQ9rTs/p1Qn45ZEtJ6Whidnb1TPRxOLO0Xnjfgtxf7pBE+UBW1ve
         9qAQ==
X-Gm-Message-State: AOUpUlGHCpxeOYrnNzQoPdS7M+mzvdGZrttsfOuo2xnql7kr8waIDmex
        DqD//7jq4Ze/rx4PkGlL+TTAuA==
X-Google-Smtp-Source: AA+uWPzFIFR4+SCwLNVclXlLVAnd5UuXOWVW5/ei2KyQmXFql/A90QKcPW3ABtIUm2/nhh3a4Rs99g==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr33366092ljj.53.1534867809764;
        Tue, 21 Aug 2018 09:10:09 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id f18-v6sm2117285lja.85.2018.08.21.09.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 09:10:09 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: android: move config up a level
Date:   Tue, 21 Aug 2018 18:10:03 +0200
Message-Id: <20180821161003.16737-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kselftest-merge' assumes that the config files for the tests are
located under the 'main' test dir, like tools/testing/selftests/android/
and not in a subdir to android.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst            | 2 +-
 tools/testing/selftests/android/{ion => }/config | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/android/{ion => }/config (100%)

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
diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/config
similarity index 100%
rename from tools/testing/selftests/android/ion/config
rename to tools/testing/selftests/android/config
-- 
2.18.0

