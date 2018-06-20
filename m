Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29437C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYI9oxpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA78420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFTWyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:54:23 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38954 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:54:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so1742260lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IJzs1OGc38xuPuDMWsSk9sOrvuLqUvGuzWUjII0lBzs=;
        b=TYI9oxpuJY7jMlWX25DKFuy0jpM3wGnt1s1T2Vebc21N81WzCrao/U1VO+jck9pCyW
         s/oJOijTjhy34WiipMHAxxwigsxUgE0I2j5qiPXPSUOEKaCHwGAGoRpxR+XscnqaLyS6
         2Nt06/3ZlbWm/N9s72nBOA2tlGVR61uOsz6vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IJzs1OGc38xuPuDMWsSk9sOrvuLqUvGuzWUjII0lBzs=;
        b=BDswC/bxc7n8mjH+mQNmXklln9KzQr7IeRmlab2CjXk/gfsICxag3s5vjFpjAVXTf7
         dntPSUWnT5q36KanHu7yhZk0HI46qnmCzU8pTka60fyzPi3Op8X6Tq5waf8cbNCc/WCy
         F9qrGWrpvEQZE9QzfxEhrt7VTP89Q2bHPOHC/ObBHbduOCFiumQhlds1VoXpekYXdAEK
         tX1iT0l3aSSiSXP9DkaNZRqyaD8jsy1i1cm1iyYxClT09pkSv94jKtdnb9lBAgcetvWE
         tPiK5S9AcIweLSQhw+3h5pCeGH6+UkMDC4vWgTibXAWx594/mTLtKAxZWl3YxxBIJZZR
         Oe5A==
X-Gm-Message-State: APt69E3DwlFu41kJz8COf1Pp+tnURlrNMCVzOP/YCDnM7WWQTOIASeJH
        J2XDgW/xfb3tfNDMmMseYyvZ2A==
X-Google-Smtp-Source: ADUXVKKXK/G1Sa6KFPjYGrBRGrqrV3CvpXXklr6aAF3knVT5kXjOzWsVbpbkcJTqEmiAVBkoUdUWRA==
X-Received: by 2002:a2e:29cf:: with SMTP id p76-v6mr16422744ljp.12.1529535260592;
        Wed, 20 Jun 2018 15:54:20 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id d4-v6sm616088ljg.44.2018.06.20.15.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 15:54:20 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: cgroup: add gitignore file
Date:   Thu, 21 Jun 2018 00:54:12 +0200
Message-Id: <20180620225412.7894-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the executable 'test_memcontrol' to a .gitignore file.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/cgroup/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/cgroup/.gitignore

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
new file mode 100644
index 000000000000..95eb3a53c381
--- /dev/null
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -0,0 +1 @@
+test_memcontrol
-- 
2.17.1

