Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MN+NFrcPGVuzEwAAmS7hNA
	; Thu, 07 Jun 2018 10:57:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 40FED6089E; Thu,  7 Jun 2018 10:57:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeX0lX7T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A43D960115;
	Thu,  7 Jun 2018 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A43D960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeFGK54 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:57:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40178 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbeFGK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:57:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so13970816lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2p9UJOln1Mqy/huqQApabcsxfD60KbqoiCfk+WFGTA=;
        b=KeX0lX7TpyRn/HUD+QvPa5RmmHoQU3pJSAhngxjxaN+6ycyQ9eoYx7131h9LV6CJM4
         hfC+ZfuPunzYDMMUDmwbcCM4znqkc6SCe4JeydCCRVFW4MrErFlG4AR6s7N4VJkXBF2V
         GgcZxLvmX3AcNijVUAPqY40iUZyptyeyjg650=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2p9UJOln1Mqy/huqQApabcsxfD60KbqoiCfk+WFGTA=;
        b=TNZQKYOFsTVK8Er3/9+B7kvP3ST+QtOHpSSU9Zgf3DJGd2t1zt+dv1gpjD9Fw2BHbN
         L6dZBQd5YeK9V96AN2eToDwwgbjbHtAhs65eqlJNwdlG2TQta0sT13WkAGsLG3bq2+a1
         VPVlx7VOYOiAQDXQfeP9xs9694IYkzmBsTXikPsb3z0qQEyIzft91mXaDmdL1gTaL/Ud
         8BDKKqmmD/6rZMrcrM3rGjbySpQb7gelkv4vKiv+/VkAjDftbQaKmQyjFF4GlKbAhBMZ
         HPFoomG3cUkUlJRoSpr6Khfnr7hM6G1sjq2xf/hOjhWJ951IlVxueCrtghgzJxuqUhR9
         Tz5w==
X-Gm-Message-State: APt69E26JaRC9n4udZLU/cKlc4+X+zMq1Ruv3NvQJDgNJek6yX6LrYYW
        R+tsalzlKjKNSLzwV/64Z/44AQ==
X-Google-Smtp-Source: ADUXVKJkuvbmdMjeojl9IQntEvn0ryzdrlq+sXYOmlIcoHB5xhbdSoI6XZrxeHqyEHtjHDdLHcFs7g==
X-Received: by 2002:a19:5512:: with SMTP id n18-v6mr894623lfe.133.1528369072322;
        Thu, 07 Jun 2018 03:57:52 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id p28-v6sm3642520lfh.24.2018.06.07.03.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 03:57:50 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: fix urandom_read build issue
Date: Thu,  7 Jun 2018 12:57:12 +0200
Message-Id: <20180607105712.553-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc complains that urandom_read gets built twice.

gcc -o tools/testing/selftests/bpf/urandom_read
-static urandom_read.c -Wl,--build-id
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf
-I../../../../include/generated  -I../../../include    urandom_read.c
urandom_read -lcap -lelf -lrt -lpthread -o
tools/testing/selftests/bpf/urandom_read
gcc: fatal error: input file
‘tools/testing/selftests/bpf/urandom_read’ is the
same as output file
compilation terminated.
../lib.mk:110: recipe for target
'tools/testing/selftests/bpf/urandom_read' failed
To fix this issue remove the urandom_read target and so target
TEST_CUSTOM_PROGS gets used.

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 607ed8729c06..67285591ffd7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -16,10 +16,8 @@ LDLIBS += -lcap -lelf -lrt -lpthread
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 all: $(TEST_CUSTOM_PROGS)
 
-$(TEST_CUSTOM_PROGS): urandom_read
-
-urandom_read: urandom_read.c
-	$(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
+$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
+	$(CC) -o $@ -static $< -Wl,--build-id
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-- 
2.17.1
