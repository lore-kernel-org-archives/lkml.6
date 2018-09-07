Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBABC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC332083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8f/H3hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC332083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIGUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:51:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36336 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIGUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:51:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so12713526ljj.3;
        Fri, 07 Sep 2018 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kUCEmSe6QxwGDon79jCc33ks8ZtnQVp2Pa9N6MgRY7g=;
        b=D8f/H3hyni4qDW0E4eRLLovKc1su3zhrJR5HXFY6YSW4FRmQ1ws6dKF2HN8RDyfD1o
         jamMgsatUnk8cOAQX6371Ik42qUHEl03MbISTMEHsKd4SRGonnN9K31c1x+bp0jw1MxS
         2qEUkmmHugfnlwgsHmaprC+KFXhqlzMxJy6i249qkgK/GwwP7ISvtGGA0m+HytJVn1Cn
         zalkRjZ7UrlkybzmofTCzxxCfmm2A//UkhqqOutB1F/vGVINCqwWpZ9Q+5Is77HG5awV
         IdGd4umnyEmjpU9zss4v9MtT4xfcAo/HKMTc+5j2mEUjOjT8b6kkGTZY77Lsw5P2gCVS
         yBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kUCEmSe6QxwGDon79jCc33ks8ZtnQVp2Pa9N6MgRY7g=;
        b=pbP5j5dC7R8mcPxftvooV6WnVAUUGElyOfLQlmS5O+ZHE7z4Kae5ihR8gXdn6+yw82
         L/MLzWs1saGlI3kam/8GQRcOMXwsmBg3dLbFZ+UGpUmW3hPvO/BBi9P3xcFuPAjUbprD
         uQJ8XNJijMhxbtROUvXE1NJFctLFDsxVG7hOpugJs4w0haTDkzg3XJlLqHpfxpVCg9TT
         YJIMvYxy3pCDAtCtaQ0w/NZSgf1dZUKLFI31PcBbRKL9DLGs72+380oVwUvwlF5Qysa1
         2Ect38GqPTufxqXYUIPUvZ6BHhcYlV8zGyZPyenmXuyEUgcFcjprBIi1+5/ON/IX+3tR
         /qtA==
X-Gm-Message-State: APzg51AfLnnJYB0jDl0E3BzoJfpfBd4uGqs3ZgikEcWcjxS2qcgTxl6v
        W3C5MDotWCz7WpNS9w2Clvs=
X-Google-Smtp-Source: ANB0VdYyIYHpwZ/3gMaC8wYjdz8FikAXsmeBQyPeIgOfihGUmhGJ+bWPj5n0C35/u+ACTB7iQM4jag==
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr5267231ljh.98.1536336603485;
        Fri, 07 Sep 2018 09:10:03 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id y16-v6sm1359643lje.30.2018.09.07.09.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:10:02 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 19:09:55 +0300
Message-Id: <20180907160955.23291-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f53fb41efb7b..7aa3dcad2175 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
 void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs, int transition_failed)
 {
-	if (unlikely(WARN_ON(!policy->transition_ongoing)))
+	if (WARN_ON(!policy->transition_ongoing))
 		return;
 
 	cpufreq_notify_post_transition(policy, freqs, transition_failed);
-- 
2.17.1

