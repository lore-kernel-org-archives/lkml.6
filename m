Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C076C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB47020874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeZhyGHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB47020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeFQT7i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:59:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51177 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbeFQT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:59:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so10799524wmd.0;
        Sun, 17 Jun 2018 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UHsZZyNUXqt1XAGH/gvRFV868PDA/0BUanBpRgvjugQ=;
        b=WeZhyGHi7eNWmj0S5t7r+CiL+230B6/nf1qKgcZd2DIxwnnsDW6ncX6N4dLKAXzdfK
         adBlcTXrqK+QFNGTEfT22TcOXW5vpf4GQ90BbLGzzt3SmAQNYtZ0u+2iwYTDAPB3SKDb
         d0lOgbDCgbJRGZQHJokVJC/XwHkjZt4IEUus056txCquAtVam6weGF0q+RlVqZTsIhHQ
         /VQlH3LGdxOvejj2CxDJoFWzbi2NPoQscoHpbJ/DIbrO8DtVfHny84iIIlUBR4x7AFj5
         LxB1HCcOyQt7PaydIYRePSubOGJb4CLKJHO2wcu51qCEJ7eep31ZSHj4usIVLUBH8tq+
         o7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UHsZZyNUXqt1XAGH/gvRFV868PDA/0BUanBpRgvjugQ=;
        b=VzPXz3M1ZQEt/oGbcl3pfly9U1qhNauZ6NNOdSbdhcvIE8a7NakpXcR2La65bRAiw8
         nfnkcaphGRrQJWvbbicDJZRdL3tiy3imC96NzlTsxwEHBvpZPjKIYkbsPaUkk6B/PfMc
         Odlog5woQ6Bd3Dbd9hk5X71wtrQuLjxN1HezlpeE4VVQqmacrBTO5iBqsxoHDpcy+NDs
         N7gODopBuE5hy2I1Oqxu2nT9YaCJKSopXGLg90xygj8Y9zqJk3ORYHF66BhclOLnxx6j
         ko1uPQempGf75buTzcBhIi5pzoQoo8b3UCMTCz8ByDhe9mu3t3qmhJiILBy9lAyR/bud
         tKkQ==
X-Gm-Message-State: APt69E0aMGcFhcIPyA+pXgdXFSnFIf/Xr+p+g/2LnKVRX+HqFMUt09/5
        1b9Ra4jWE7zvG4e7UqZZB2mlWXy0
X-Google-Smtp-Source: ADUXVKJWGcnW+kz6Vo0Cg7HfF8/2K+u92V5yL1mmnWWnR0Nt2ULD5WHY+Zg2UW6afxbia46xlwnqHg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11-v6mr6526212wme.148.1529265575159;
        Sun, 17 Jun 2018 12:59:35 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id q17-v6sm14125392wrr.7.2018.06.17.12.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 12:59:34 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: kryo: Fix possible error code dereference
Date:   Sun, 17 Jun 2018 21:58:42 +0200
Message-Id: <20180617195842.22818-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614202921.32535-1-ilia.lin@gmail.com>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

In event of error returned by the nvmem_cell_read() non-pointer value
may be dereferenced. Fix this with error handling.
Additionally free the allocated speedbin buffer, as per the API.

Fixes: 9ce36edd1a52 (cpufreq: Add Kryo CPU scaling driver)
Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index d049fe4b80c4..74b9b93d511b 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
@@ -127,6 +129,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		BUG();
 		break;
 	}
+	kfree(speedbin);
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
-- 
2.11.0

