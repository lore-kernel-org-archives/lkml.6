Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E1AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849420811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwMVkgw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7849420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLKL4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:56:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6548814pgu.0;
        Tue, 11 Dec 2018 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksf+l9dgiALe7Zg9ZUU9BOjXKuL1SU9cdW27O4NHX4M=;
        b=CwMVkgw9GzZcCxJXyQ0LHHoMBv9La3EOZB9qZHDPVNMQOvOB078DAcUCpAhf1igO3v
         ptPvHKrINtN/vS37dcKt+MTjwBzpsthzERX7DwiPFkXegEJ6nigkdaSxgQu1moNSZGPL
         P9MU+FSGBhucDIfJL9dW+N3VW4JNUQXb/J9sCLNn4gIGiAoJpqq2dTPqG3jfN2uYqeA1
         DUg2vsTcyoOZ5YKeRxp9AHC1C2cJTeNNROZbD+GTvs5n7G7Nzc1WnEMA43pCqGMU1zOB
         w80nYGjXpXyj4vDEu5I29HKtLxRdvfKiX49bTh1vg8fbWzdzraIn+/8q6HOt4EuHfyTc
         GxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksf+l9dgiALe7Zg9ZUU9BOjXKuL1SU9cdW27O4NHX4M=;
        b=K8s/KxZudhbDxO9hfRkYnBm/xNwvApm42EM1f0k6fjrIMGhJohqdTplh6F8VSK+eP7
         dpZkq8h8dRKpP7LcDPk1SmtJWUL7sUUcvHRf3gZVH6LkFMYCdUGZY2ofYKI6Qzo+pldz
         +IAgNBkJBE0ranQ5tFygAcANcTkqXOHmENsI8kUfL0d4XOjYm27UBRdYQWEDj5VYhYfX
         cvHFB9lFNA37bhmxF0XztENH+HbcnCEfCE+083fmIyE19EzrHYSFLU7aYppv90ydZSGF
         Ogg4zXiE4FxxS9tJjGFskCCDTbT16Wy2sxQfLbkh+1sK1aipYp5hUt+goGPGJ8UswKPw
         TcuQ==
X-Gm-Message-State: AA+aEWaiwKhIOSGj5jRSvz29FkiDNPtg8t1/ZfZ1cNv2tk8nTyFqn1u9
        XZEThsJlRXrkZTHAKpmP1PQ=
X-Google-Smtp-Source: AFSGD/WA2ox449NyaVmkXh21gR+qv6b8B+IjJVeNOLyQxJIJBoI4jWv+cC6Zym9g+xCnptlPEid/lQ==
X-Received: by 2002:a63:3287:: with SMTP id y129mr14406986pgy.337.1544529358134;
        Tue, 11 Dec 2018 03:55:58 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id q75sm19795928pfa.38.2018.12.11.03.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:57 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 6/7] selftest/bpf: remove redundant parenthesis
Date:   Tue, 11 Dec 2018 20:56:06 +0900
Message-Id: <20181211115607.13774-7-alice.ferrazzi@gmail.com>
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
 tools/testing/selftests/bpf/test_offload.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 0f9130ebfd2c..b06cc0eea0eb 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -140,7 +140,7 @@ def cmd_result(proc, include_stderr=False, fail=False):
 
 
 def rm(f):
-    cmd("rm -f %s" % (f))
+    cmd("rm -f %s" % f)
     if f in files:
         files.remove(f)
 
-- 
2.19.2

