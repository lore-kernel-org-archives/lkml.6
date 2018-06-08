Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xCwgD00nGluaDgAAmS7hNA
	; Fri, 08 Jun 2018 06:51:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3896607E4; Fri,  8 Jun 2018 06:51:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7JVJQ1Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D78C602FC;
	Fri,  8 Jun 2018 06:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D78C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeFHGvp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:51:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42446 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeFHGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:51:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so18383782lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7W1yzcnJNHKQrgraPILtxT9yr1QxYFzVWYM+zREzulI=;
        b=g7JVJQ1Qcw2bDXC59EEZrED106BJqlUAt3Ej6pkQnHC5rZkZLRA+vn86UXus/xV+Fx
         kO1Cqrrmpjc6EmReZ5YvsAEidC4CEfBGPPNl5KwCejpx2phzW9Cs3kD8BiumT7THJjva
         Mh1rfYCajmd93bW2C8DnzUvUkFAyUtQOcdRVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7W1yzcnJNHKQrgraPILtxT9yr1QxYFzVWYM+zREzulI=;
        b=E/M2mqRjw9+CGt1b9auM40l/yAVjeU3Kuq/dDDiyIU6QD7YL2K0Nkynl1OgCAeLRjg
         zFOfP6F4eCRmBDRuqG1C7TXRq9/7HuXNZr2kEPd/zYVW1DK1Cqx/Mf2S7NDRiwodAtbO
         LNZADH2XMvFjfivHMMExxL5nN5xB81uFjr4F6/uwZ9MN1I7+eRKCQxU9hg+MUPIlcYjg
         PDrZrCZ+tfJlHNWX3G+eJwLoHzbOkqgKXY5gTcm14ustYlNbLn2Z+xh22a/83b3G9fRt
         KFQEfhjJpSphKJ7ZrJWzp85ktVvEANyb950TWi4zmfvAJQH2Okxd3+golysMcmn5PI4j
         CheQ==
X-Gm-Message-State: APt69E0TCdcBDq2vmyPZgMn1IJm6fqZ8gAArAjCPbuGfYz0NhB+A2LAS
        CFiC1/VsA2lGIsOCXwbFqjjX0A==
X-Google-Smtp-Source: ADUXVKJGxkhdwmByU2A6NOCYztEo3fzr/1qfLT2NmPQB7mFOn9F7LOoZhJP9tsWwyqFFi4JMPqc0Mw==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr3003244lff.5.1528440702473;
        Thu, 07 Jun 2018 23:51:42 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id q78-v6sm6988379lfd.35.2018.06.07.23.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 23:51:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net, ys114321@gmail.com,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: bpf: fix urandom_read build issue
Date: Fri,  8 Jun 2018 08:51:27 +0200
Message-Id: <20180608065127.28115-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CADYN=9JEi2=YcC0KD555atZFiJNbP8Y9O0UME+63iTpSSd=ttg@mail.gmail.com>
References: <CADYN=9JEi2=YcC0KD555atZFiJNbP8Y9O0UME+63iTpSSd=ttg@mail.gmail.com>
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 607ed8729c06..7a6214e9ae58 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -16,9 +16,7 @@ LDLIBS += -lcap -lelf -lrt -lpthread
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 all: $(TEST_CUSTOM_PROGS)
 
-$(TEST_CUSTOM_PROGS): urandom_read
-
-urandom_read: urandom_read.c
+$(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 	$(CC) -o $(TEST_CUSTOM_PROGS) -static $< -Wl,--build-id
 
 # Order correspond to 'make run_tests' order
-- 
2.17.1
