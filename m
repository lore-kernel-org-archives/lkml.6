Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2FDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F77C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RocxJCVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F77C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLKLz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:55:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46040 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6818849plm.12;
        Tue, 11 Dec 2018 03:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k27n73fQlgWGQRe3Ovzbe9wT07z2hRcSnkRn+qEUwiw=;
        b=RocxJCVvzts+9R84N3FXnWxM/Y+9NkJWsCVKOUpB8IQhSbZ2RSHmtLz48vwE4OW5Uk
         LYpVAstKvHwsrVwJKYMC+UuJXGDD1lEJMYwWBECbEeF44MB9C/wRrqifGCWLWYZpLPON
         iN+J9XLbe8ea4QOJg19fQRyjFzMhmeRvRVD3yRNTSdPtJ9fnvs6Nb5cNmcyXKL5GTzCk
         wLfZmljCn1R2Uyxj5762JiyLfH4tKjesMqEKBMGVkrXTHX18bcO9QCFAZ5m//ZMqrLQx
         Gl1Adh4MmdWrhIklSQ2SQbj/OfYjhhNfR7DMqUDq91AnI4RBaT9IpOrgtiIUlwdCca/i
         mewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k27n73fQlgWGQRe3Ovzbe9wT07z2hRcSnkRn+qEUwiw=;
        b=UXo8hcH0RH59u5TCnett/Wc4Q6bljw9WSzt+S/BABOcmuXv0+nC+5RPvRclbxvVO7p
         Co1pIwACmA9QEWWPxTFftrfeh2zXpOi4K4+tM2IV7aLKzIywml73osIQe7GQ7Oy98KgC
         8hdpU7AGD+Y8ixJ6Gv7u4deLHK2ersSw8/xrhBC0IEVayQCJeS6anYxh0ByNUhl9tAX4
         5OY8opwZzbcgJSVYYbd3EuoFZ30qYcOwn+tW4iMxMie2ouk9fZ0Sg59RICnegt3uwmGo
         zVOlJXWMcm7Bm77sZNs+I0NpzvNJbwL+Kzy6PSd4QQOCYdqw6486XfaxcW9Qoe4jAawz
         nxuA==
X-Gm-Message-State: AA+aEWaiJSB+W2XoNNxS6BNieJapXC6OQivpnx9hBJXD7YR2aVI/os5g
        /JAgwYctTF+/HU+x2TiuN8w=
X-Google-Smtp-Source: AFSGD/WKrcoxhA9Ab6B2VShOoV0OUuennftNG1d5NegWfJbjKEUiVgpRiz70KArVUrUEdi6DanXJ7w==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr15440314plk.40.1544529355078;
        Tue, 11 Dec 2018 03:55:55 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id h124sm18710202pfg.143.2018.12.11.03.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:54 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 5/7] selftest/bpf: Fix PEP8 ambiguous variable name
Date:   Tue, 11 Dec 2018 20:56:05 +0900
Message-Id: <20181211115607.13774-6-alice.ferrazzi@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/test_offload.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index f80c4f13991d..0f9130ebfd2c 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -623,8 +623,8 @@ def check_no_extack(res, needle):
 
 def check_verifier_log(output, reference):
     lines = output.split("\n")
-    for l in reversed(lines):
-        if l == reference:
+    for line in reversed(lines):
+        if line == reference:
             return
     fail(True, "Missing or incorrect message from netdevsim in verifier log")
 
-- 
2.19.2

