Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1850833-1519358935-2-3902832587797452849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519358935; b=my8fJ635JOn79rECGfHWOTceyH5GcNFS0nPnSQ+3lgyOC6r
    yhBCzbKOUM98f1VysP6d/OkXh9Elf287eUTXHkFvmqluoLR6oHzc0r2JcvJ7E/rx
    4K/QTP6U9YA14c66wQunJ4Q/FrbITrRoIznop6km+nBE7L7M5n++8MMcrUcpGu7T
    klk8VqcZbgEYfJnBbsYvSdS9WEIyBybI/hecqaYRiF7vvf9VyC4IlvaXQp8qq/YG
    7+MawS4QbAZVfOsboL2ixALiHwTFBtAT6nm0pYuozfBQ71TT1LIlu/KHGuKdqfCF
    jf8ESM5Up5bynMb469Ta2n97leNHz3hdY7MzNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519358935; bh=+nKB3nvkyFOkdAsYHnA998knL/
    R/v24ySX3IvZlWEBg=; b=mcjftXTwKuJSN6bVugf5F+JNACjOKFcnGfjrmHjUE6
    dkQqZNkFlsQA/wb75lhg9hyCpM0kTfk3vkc0FWW02ppTm9cefEZDiZK3UXUdBmb4
    BNBpXnQyExvfEHkeEJH2EtRBalpKsz26BL6pbjnp0ogQTsVUUZUaDv2MazogB2v8
    YunGXrq0rpvPHYWy3zh0laaQ7mHfUXR8uq+VPaLXzIgiOFK/MibXxUsxvlVXpaeI
    vq4CLAv/lxaXjhMnvEwsfEO80Hg9lvqYco+S9Dt62Qkj3Rvk2fAJpdS2d1L0NK8P
    3c8bbWs+hb+X7uf1MK9eKlGnHztW2DvjL8IjQ9h+sxCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OYRYO6q3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CqB9lu+T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OYRYO6q3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CqB9lu+T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBWEIj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 23:08:39 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34068 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBWEIi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 23:08:38 -0500
X-Google-Smtp-Source: AH8x227eUq3NBasNYstCSJlXEp1WAve2tyVVZ2sE8RoSoAq8VLZuFe8yRDs5nQd3RXL/0vC8o1AOWg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Bart=C5=82omiej=20=C5=BBo=C5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Date: Fri, 23 Feb 2018 09:38:28 +0530
Message-Id: <6b737a9c285840b4b2036fa51b692ee835664ec8.1519358505.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit a307a1e6bc0d ("cpufreq: s3c: use cpufreq_generic_init()")
accidentally broke cpufreq on s3c2410 and s3c2412. These two platforms
don't have a CPU frequency table and used to skip calling
cpufreq_table_validate_and_show() for them. But with the above commit,
we started calling it unconditionally and that will eventually fail as
the frequency table pointer is NULL.

Fix this by calling cpufreq_table_validate_and_show() conditionally
again.

Cc: stable@vger.kernel.org # v3.13+
Fixes: a307a1e6bc0d ("cpufreq: s3c: use cpufreq_generic_init()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..6bebc1f9f55a 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -351,7 +351,13 @@ struct clk *s3c_cpufreq_clk_get(struct device *dev, const char *name)
 static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = clk_arm;
-	return cpufreq_generic_init(policy, ftab, cpu_cur.info->latency);
+
+	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
+
+	if (ftab)
+		return cpufreq_table_validate_and_show(policy, ftab);
+
+	return 0;
 }
 
 static int __init s3c_cpufreq_initclks(void)
-- 
2.15.0.194.g9af6a3dea062
