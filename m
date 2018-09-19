Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F1BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC12214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjV+Kejn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC12214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeISN1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:27:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38994 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeISN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:27:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so2302680pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2gmqlvgWnuhnzgSQM//m0TlOlbcMkWwyT7FT/P5ZWOs=;
        b=gjV+KejnHgh73TdZ35w5u4kfQshro06nCVAmdFdKKERhuX3WwCnJeBkvRWLdGab+vW
         tXeX9ETq9emMJ/3qDQIbhOEz64JL9nXpdjqhejc6SKUAxetIeTCz3MDsY/bqu1fupKI5
         aNUWdcp3FW2keYXbOtmRFDVVZoZyxgvbm9XlEzP1MUg5fkVr2KOTZr/1sX8CY8pbxMZ8
         l7Ei3OnjcHG7eH2OjHZS4JKVSXumd8Y4WN/HCaM60DXi1Qa4T+dIa2IEEaLYvLfk+wGD
         711gfOF1DTccNWy2a190K12ZneLRXf3MGAq2s7uQWCftslr555hbeVB5bmg7djf7l7/f
         mKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2gmqlvgWnuhnzgSQM//m0TlOlbcMkWwyT7FT/P5ZWOs=;
        b=ZAkS+u42VwUzZRKAP1foE1bxgM/41J8k9wS7Ee9U/oCMKj+2M6sifD/7rZgsGupPns
         fMu7NpU+7PjWs2Su1ahz0LzIGDEAAq0BmbFHLr12Rz6L5xiZ7u8MPdr3KgLemGEErkVB
         LNJbR0OB2qCdjRFCRfBn06x84XM5+DfyKEmzszb5ZG367DCQCiUdnzeOhtIwPcu7aNb8
         HXTLh8VanakaeywShXdTOyikitHRc8J0fYC41b87tTzxWFDpEGOJEdHsSYuC8H4LHFJs
         tdoPQzgf9vrlVKvOFM/1oZX1QHV1IcP2DjU3gHVWwKVQrGm4nSCQ4AfutjAJi36eoBz3
         0ZhA==
X-Gm-Message-State: APzg51AmMb4ynw1fDLQRzMIekAyA9Z6gxyuC80Bx/Osq70SfT15qi5nj
        yjlSZwgyKOXAyUq3zaMoTMVlz4mG
X-Google-Smtp-Source: ANB0VdY8RmfcAc7C/mTeNPYtOR8zWZeW7Lerh32tucD7xf1Or7LCkWQsEGtwuIS50GCmWauMKz8FKw==
X-Received: by 2002:a63:5b1b:: with SMTP id p27-v6mr31264409pgb.322.1537343435082;
        Wed, 19 Sep 2018 00:50:35 -0700 (PDT)
Received: from localhost.localdomain ([61.101.44.96])
        by smtp.gmail.com with ESMTPSA id c17-v6sm28546123pfk.187.2018.09.19.00.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 00:50:34 -0700 (PDT)
From:   Sangwon Hong <qpakzk@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf tool: Add missing subcommand `version`
Date:   Wed, 19 Sep 2018 00:49:11 -0700
Message-Id: <20180919074911.41931-1-qpakzk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't subcommand `version` when typing `perf help`.

Before :

$ perf help | grep version
 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

So add perf-version in command-list.txt for listing it
when typing `perf help`.

After :

$ perf help | grep version
 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
   version         display the version of perf binary

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 2d0caf20ff3a..bc6c585f74fc 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -30,3 +30,4 @@ perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
+perf-version			mainporcelain common
-- 
2.17.1

