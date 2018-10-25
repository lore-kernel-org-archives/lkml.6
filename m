Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E86ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049932054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LU+YlPup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049932054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJZFtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:49:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38832 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeJZFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:49:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id g7-v6so6569228plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QbCm2b2jNj8XmLM7XlmD64yFu5BCDMsTfbaLrwEEm/U=;
        b=LU+YlPup8hvUy7rlwpRbnGWtbuoJ+95RpB8tnnEQCfJnStc9SUQAz5GhNWpqR4Xxzl
         bTHbt+4HE6kjQfyJWIXVWpPJS39KJxA1frw5JESn7UbS8ay7h4koEloNYsb862HAsW4d
         nrZlOJG3AS8J28qsvYW7mmrE519JmIgktPk5r9g3hjW4RD2q80I59MznJRTCC6qBiC1q
         tLvlQRxLs9v//OWZ/H+CG3nbO1c3QWIr7+0C1xn102nOa3PxqEOylQtUaJAniPNXrKt8
         gPwLPzw977Z2lMTTcYVHHbzw5BFdXKVQudWeoaOtSKTmfRxfnbhm6pVaLIhKjjxMGbp8
         lNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QbCm2b2jNj8XmLM7XlmD64yFu5BCDMsTfbaLrwEEm/U=;
        b=KUGrh4Le8dn6diaT+J0je7Jpm99T+oUqH57QVkpe1wkfL1x/fgAqgaAGrF17uGISRE
         X1BZHIV+DruxtMgCFNJWyFIQRMaD8IMV7eHc4pKd13s6eiE/8pCO6K5sPiVWMtMDCqIK
         ansQYCg5kc+WZPpLCuOFXA1j/x/cYyhO5oYdn0yVxfuK5/5sMw1gXn1oBndOpfK7jVuk
         Gsr7CVQvpr2Bpie9qladWHN2zYKq9b1Rul/fHqdYFuM8lJ9EXQVmopmOmMapkS8tpXP6
         Jdlj6vODjTD75C3N6yd5/JkNCIZKXMZt23GC9jOC83WHyFIbHKZqZy7tp1n35bzdn/VK
         waEQ==
X-Gm-Message-State: AGRZ1gJJEAA6G8oKZ2Km57CQVwWjCdErRkGT9JW1ZEkgbJzRbCC/S0qr
        XWdq/fshWiBwNNLaqot2x1rUDNYrHAA6bswoUjbd5Q==
X-Google-Smtp-Source: AJdET5d3jVmD8n48xCNKE/8QXcx56Ser8wW3DsyKEE2GOxB7s8RPMkAEjad154BGMBGN6vpBvmlnhDCjEu9nY6Gw5HAjQA==
X-Received: by 2002:a63:3049:: with SMTP id w70-v6mr595838pgw.18.1540502124732;
 Thu, 25 Oct 2018 14:15:24 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:13:52 -0700
Message-Id: <20181025211352.112096-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v1] net: ipv6: fix racey clock check in route cache aging logic
From:   Brendan Higgins <brendanhiggins@google.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where, with certain settings, the aging logic does not use the
time passed in as the current time, but instead directly checks jiffies.

This bug can be reproduced with (and this fix verified with) the test
at: https://kunit-review.googlesource.com/c/linux/+/1156

Fixes: 31afeb425f7f ("ipv6: change route cache aging logic")
Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1156
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2a7423c394560..54d28b91fd840 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1734,7 +1734,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
-	} else if (time_after(jiffies, rt->dst.expires)) {
+	} else if (time_after(now, rt->dst.expires)) {
 		RT6_TRACE("purging expired route %p\n", rt);
 		rt6_remove_exception(bucket, rt6_ex);
 		return;
-- 
2.19.1.568.g152ad8e336-goog

