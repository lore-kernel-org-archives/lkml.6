Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7C27D22
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdkV+KnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A7C27D22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeF2KDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:03:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33541 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbeF2KDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:03:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id t21-v6so6861011lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wgVrrkJBad/iLo8AmZQyV2DAb2LeoFfhBrqh9sChX3c=;
        b=BdkV+KnLaIHKZoXRMluaxw0L1sbB1xztVw+QDrv3bjV8oJHbTepE+WZPJgCAKVljIg
         Dzp9cfcrrDViE/Nn36WaXJIT14swOmk4VQLvxFMZKRv+3i9x7IPQiBjWMfXeWDbrDU3a
         hMaCuys6oon8epHjSqhHQUBBVPJ/t4M41Jo90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wgVrrkJBad/iLo8AmZQyV2DAb2LeoFfhBrqh9sChX3c=;
        b=MXAeB/hYrnYcRBPiC7DeWIJ7LCKBfAJvu5XP616zyNqLxe6TvT5PUKkYxw23ZVAUkg
         cUwxtQGt4n2w1OfPoFe5RpjhcOmXF+ZbOTDbB6PlNaS+XT/yUJbIKka98gcWylpnPH6U
         RVwHnQXXII7eNMpwjP9n4hGflP9Zuq01QgfLja+kopiY57D6QjT5yjM40bv55XlBJUyB
         z2bMxmMptwTyrhpASMliKd5ZRpdf75OYD6Td80Dl74VO+Td+YxI2E+v5EY4Y6hpXdhiZ
         csfVETUzOF9hRkdrut8+r0/nWj7EKfW/af+CMQds11ZgGD7hQKcnti2ZtVC7+5YqihUk
         cy7w==
X-Gm-Message-State: APt69E1a0880UTlNVvUcXR+8y4GLRL2/LohciSTk2NflxYwX1NnIGG9e
        l/atpsXztDjspN6+AjT0PeaBjw==
X-Google-Smtp-Source: ADUXVKLvSVazqGZxZNmEHvFse5jMC+VxZmuWxBZzAUeRV4XG3bTVIlocgXna4vIFqlfp867LhfNKqw==
X-Received: by 2002:a2e:6d11:: with SMTP id i17-v6mr10148179ljc.116.1530266578594;
        Fri, 29 Jun 2018 03:02:58 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id s5-v6sm1487387lji.46.2018.06.29.03.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 03:02:57 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] doc: dev-tools: kselftest.rst: update contributing new tests
Date:   Fri, 29 Jun 2018 12:02:48 +0200
Message-Id: <20180629100248.11560-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description that kernel config options should be added into a
config file that is placed next to the newly added test.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 3bf371a938d0..4c546a35bd58 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -156,6 +156,9 @@ Contributing new tests (details)
    installed by the distro on the system should be the primary focus to be able
    to find regressions.
 
+ * If a new test needs specific kernel options, they should be enabled in
+   then config file in the same directory where the test is added.
+
 Test Harness
 ============
 
-- 
2.18.0

