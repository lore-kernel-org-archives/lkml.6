Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0861C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B832089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rs4efpw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfAHJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:25:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42453 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfAHJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:25:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so2378490lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WycOcE4uFWLGgoA3dJR5IbUT56bdWuS9TAeWpDfvyoc=;
        b=Rs4efpw8EMiIKa0vPZSJvrbSa5EpU6eIkILvsHPoo4M+yCljkZSbo2uQ06r8oWj3zG
         scqMInPqThSjih+7iG+CZouJccNEZNkkXF/iiQ0u0/I4K4sZfGZJZtLrF2dNQ0jns4Av
         oJwauOHbWF5gB6uhS56DTVxJMgRXAeJzSD3Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WycOcE4uFWLGgoA3dJR5IbUT56bdWuS9TAeWpDfvyoc=;
        b=LY1YBAHvIHd2DXP0w0ycLTmRA0upcGgei//gP4libe9k7k159ftPTS2eh1kxlSxv7B
         siGfzMAtwXU2h4nfg98FndWCHw8n76igt39Y2KS/MrBjAGNkXsw2Qey3CwdUuTT8r8Xa
         WkH4u0bO6Wstbu+ziE5Px6Tsxz3r9c4qEHjC45PVru6jRrF4cR3j2bcySyn5SX7c1Zdh
         iefLrf8u04lQFCbOdZnDt4br3jN7OjugoKodCRgIbD5RpB72zLBUh3ysNOStyQr/TzC+
         RA/V1PctyrqXY4a9YZx57+AkdKvqqU8arFGNqDLi9i/274eIALByh0D1zanGKQEhhM5y
         hoFQ==
X-Gm-Message-State: AJcUukdM5tZAYItORBnJeWtcBeA/uaIJS4rS3gQiTLCCz6TNP1gYs0lE
        6/25lcY06+D2ha7X9Kh3Sfe3Hg==
X-Google-Smtp-Source: ALg8bN6/3lQZynhZJT/bMHv3vB/lbwZ2lh/zl5XMCpbv5GS9qg5wjZjyo+/rE0Azf6xF/aNCgR73fQ==
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr561920lfe.152.1546939529506;
        Tue, 08 Jan 2019 01:25:29 -0800 (PST)
Received: from localhost (c-4f66025c-74736162.cust.telenor.se. [79.102.2.92])
        by smtp.gmail.com with ESMTPSA id q10-v6sm10574108ljj.3.2019.01.08.01.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 01:25:28 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/networking: remove timestamping clean target
Date:   Tue,  8 Jan 2019 10:25:25 +0100
Message-Id: <20190108092525.12817-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cda261f421ba ("selftests: add txtimestamp kselftest") introduced
a warning:

Makefile:14: warning: overriding recipe for target 'clean'
../../lib.mk:137: warning: ignoring old recipe for target 'clean'

Theres no need for timestamping to have its own 'clean' target. The
lib.mk file's 'clean' target gets included to the timestamping Makefile
and that should be enough.

Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/networking/timestamping/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index 9050eeea5f5f..1de8bd8ccf5d 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -9,6 +9,3 @@ all: $(TEST_PROGS)
 top_srcdir = ../../../../..
 KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
-
-clean:
-	rm -fr $(TEST_GEN_FILES)
-- 
2.20.1

