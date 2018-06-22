Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F58C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC02491E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRNCiUw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC02491E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeFVVln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:41:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36449 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeFVVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:41:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so4055717plp.3;
        Fri, 22 Jun 2018 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=flrwo5qekPUqH9jcbphXhA4UST8cF3rFFudUaZk4MDY=;
        b=ZRNCiUw2P4bsGZfFmI1WqulBobIy89yoac0+k3xwev6naGpKRtMurJ9q5ekfo2lior
         NdnDdRDuuhcI0c+99HiMQNzTyyd0gHWVLWQO2aS1jwHT9gMKNoxC8yowwwTmkV4IX2Td
         PfRySHTDP99fz3FeH3KW4dCk/TSeJSZu5Zq4xcYxpLaufPQ3OOfPQZ5kJByAmcehPaTT
         9mAtPIO/agAIB/6UvFWLp9BRpNO/SXL78/yBIQtQPFk+rSgp04dPnsL/lcB+41hb4Os6
         P+QsWeNJstF1U45eYskpAsIg13UXc3BU1VizfjdeUG4oWQZEOv2hSB/u5v+VXNT5pJka
         iO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=flrwo5qekPUqH9jcbphXhA4UST8cF3rFFudUaZk4MDY=;
        b=lhIP+BbWWeojoyt6yEh7idURfYOszFFmb5n6tYr4YfEDylt4nkp8F9FnTaNJug6Nw2
         ZIDVrK6yPsCCWM343zvtprTnoCqCVHcD0jklS4DOXBj6B65fdlR84zj5i+XBk6JCEHqu
         cHzoZYFOuX2fftpTwLeM1ENcjETVGB1eczSKQjdUXlzj6q/f6v9IC60XWuhgS06tMN0U
         fl2R1KYs7HTqWGFfzze27DrdkuwfAcEmhMCVWJHUl2b3fVxcBDuztkYQZ74wybSce2ZP
         vuWdcJAFRx3uXekNSiiVtMzT8SG9yjhJoCajJSM4QRbCi3746/PebcBzSCyj0aS9Kx5A
         h0zA==
X-Gm-Message-State: APt69E2cW2CFjGQezz3fBsocVdrv4kAAfEPdy9N+cZzkucEbonKQw33Z
        BUrbI8HpjUag1/Vhb1xxsZOQltHJ
X-Google-Smtp-Source: ADUXVKJvP36bQEE8w2mKXKoGbQm6bjm6bArLPf3XTnLHsyhwXL3RtjXj2176lfcZrTRd9cxKFi17sw==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr176015plz.188.1529703701610;
        Fri, 22 Jun 2018 14:41:41 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.149])
        by smtp.gmail.com with ESMTPSA id r188-v6sm12293146pgr.78.2018.06.22.14.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 14:41:40 -0700 (PDT)
From:   Jeffrin Jose T <ahiliation@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH v2] selftests: bpf: notification about privilege required to run test_lwt_seg6local.sh testing script
Date:   Sat, 23 Jun 2018 03:10:32 +0530
Message-Id: <20180622214032.6527-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test needs root privilege for it's successful execution.

This patch is atleast used to notify the user about the privilege
the script demands for the  smooth execution of the test.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
---
 tools/testing/selftests/bpf/test_lwt_seg6local.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
index 1c77994b5e71..30575577a8b2 100755
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
@@ -21,6 +21,15 @@
 # An UDP datagram is sent from fb00::1 to fb00::6. The test succeeds if this
 # datagram can be read on NS6 when binding to fb00::6.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+msg="skip all tests:"
+if [ $UID != 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 TMP_FILE="/tmp/selftest_lwt_seg6local.txt"
 
 cleanup()
-- 
2.17.0

