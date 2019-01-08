Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09232087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTdmjYDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfAHJWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:22:37 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42539 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:22:37 -0500
Received: by mail-lf1-f53.google.com with SMTP id l10so2372571lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ax0uMiVNPiSo04Ja4arLcCjK+baeUa/LvrEOIzZscYw=;
        b=DTdmjYDw0ntSmd23pR1bz9GAAscNmGD/+fimtV+HL4IsU8H+P01UdezUPmIN22HbtM
         l+p/tgh9tGAk19Va9n/RxhIZDnuqwRJypCt9b9M5Mm1IQxzpRJ/CLA9XQum3vduy8aSk
         bTrhZH2lG1QiOqrGzz8Siq9bG38s+eAe76ioA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ax0uMiVNPiSo04Ja4arLcCjK+baeUa/LvrEOIzZscYw=;
        b=q2lGE3+xjI48Ov+qA/4PZnHIqodkVWdF2U+ctfNf2r8Qxn+ONwcD+Lr8AO1StBKA+O
         TJPwTbRgRV0yLI6rII0b3l6XXkUT0ZQW4oXgAX1Iu8DwQcCNe6AwJUl6pN6GYQALbEH7
         q0W/eZA7xRd/Q4F+J30EUJC3QNin1doMRFdzVz8UsasYyi1GddKrbsxwtPFhrj+jK4w3
         +zQBThRaxBY7GdDSfHMCSaR/9hxITNRAbNWiSvr1y3ktZivtxPu0hQ1OMzv8/fcrd8W4
         cih2lGfeBpo1D9ndAAqXwPZ7ijdKTGq7kD5lM8opvMpoD/ZBWj+5iuwOj4OS8aBeW6Qu
         VFgQ==
X-Gm-Message-State: AJcUukc/jfBihDbeIG+GlP2RgUto0W8qreVVYwTUyVr+c8uYShGzK+bw
        UqkmCVV/pYXwoHEmvYAzSjlx8w==
X-Google-Smtp-Source: ALg8bN5ssOoXaSWQjNKOQ96wOkldU1DijHb0qiHCDIVZ9nhQsLRwuLX3tL8xEfu1WwTzgy4mT4ySzg==
X-Received: by 2002:a19:4287:: with SMTP id p129mr598888lfa.135.1546939355250;
        Tue, 08 Jan 2019 01:22:35 -0800 (PST)
Received: from localhost ([79.102.2.92])
        by smtp.gmail.com with ESMTPSA id o68sm5430358lfe.59.2019.01.08.01.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 01:22:34 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: add missing executables to .gitignore
Date:   Tue,  8 Jan 2019 10:22:23 +0100
Message-Id: <20190108092223.12467-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 8c4905b995c6 ("libbpf: make sure bpf headers are c++ include-able")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4a9785043a39..6c17b6557e5d 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -11,6 +11,7 @@ test_progs
 test_tcpbpf_user
 test_verifier_log
 feature
+test_libbpf
 test_libbpf_open
 test_sock
 test_sock_addr
-- 
2.20.1

