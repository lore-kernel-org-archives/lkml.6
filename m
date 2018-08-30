Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E228DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D12D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLP0Qu/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D12D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeHaCkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38367 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeHaCkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so8573457ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erVrCysKiZkUoBFgBS/wIisVLwo9fAt990Lc3dJ0ptw=;
        b=RLP0Qu/PoupWVvukgh3fTyEh2oPr2V59ZJkzxgxPkrcsQdmyHGyIUJSRc2g8YP5OA9
         mNk9hoL7wal0k64dco17ZdA6l1oTOjrHiWJjt2jfuS3Daa2Jud5j6OXikUmrBun7cZHL
         QSNH1YJxUi6fjJ/3/0Z/F4pQKZEtgIonIK5uR/GVdcLCLQ/AFVaY4HJWOITldVSyqeJI
         JjMZMV2FvEJzKKT8yU7FSbvDW8WrXPch8Vg+yk82SOZ+Uqn6IXlHSexdP7rQNLGTgTw9
         aOfvoV3+rd+keCiKF5pWc1VUEZ3wKWbv7Lg3KbZEnVewM9Hmo9oYSItfk9qy26WvxDR8
         1VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erVrCysKiZkUoBFgBS/wIisVLwo9fAt990Lc3dJ0ptw=;
        b=k/ybaSmobwXtC9Fcum0JdmuJ/EDNRvvnPfyN2kYk65l8cietflKfqvd0qVaOjFmj+x
         XBDPxXxmjE0UKC+Wx3Uihwtf5AH4i0h7o4cbOPzp6kCxc9ADIZX4dAa5d6/yp3QLeH3s
         NO4ztPiwd9DfCee80F0DlCOIDcm7ZmMGs9wInLjXMzNyi2U2JJ2OFCRzXgQat5vOJPd0
         BhiQq86y1PvOwqoN+jW7Dhn7/q6vzbWuzNoJqJ6WFgv/nnBH7vjR3OHpMyU9ormN96oI
         b89iI3n4SKbj+sYCuj6O7iclMT2eMFU2fbwfmACIkcb+Q4L4zr+o9UvmGnryspnTmwau
         bGfg==
X-Gm-Message-State: APzg51A0JIaO2WB9vhNwG4Mf8AAlax3fl7032ORrZ+xEn9cYgJj8wPSU
        T8WWRa1AEvR0yKsfmsi259SOE7xbMNk=
X-Google-Smtp-Source: ANB0VdbL+zdzIPB5SilR+C4YWd0Gvz6jAia5yGVUMFovZPjxrwayT8P+y1UQHDo/VyEHdJ6YN2rDEQ==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr8292702ljk.14.1535668534401;
        Thu, 30 Aug 2018 15:35:34 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:33 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 09/23] cpufreq: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:15 +0300
Message-Id: <20180830223429.30051-10-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
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

