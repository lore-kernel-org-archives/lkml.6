Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55133C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0976F21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oscIUCGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0976F21755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeHNCXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:23:55 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:53530 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:23:55 -0400
Received: by mail-ua1-f73.google.com with SMTP id w11-v6so8593217uaj.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vyvqsKUUjRa3pg9m7sb8yRGNYXrlVc9ogTxAYcN868A=;
        b=oscIUCGF8FMPcZSiRZ8tHmH9TtS+ONflIlwp00DOPlzOK5mK5QCiUC3rT3n41KswTq
         mpCwIzbvdzRCOkLyN9Cllbd1qFzYZurH3CqMmQ4pVff2WJYAJuEXajAp8D9VXLEeC4jy
         niCyCrlpWfpxJUnyV7bmE9ylazvsfzpXQYWxCgTBUqVIwUJCel1jYBKBqIejuwad9cvb
         o8irBqF2RotiVKHk+1OPAi2q25XwPWIXZsPmKsXeG8yGQ1wUfzdxzAQnt1GB3OLLItM3
         /e+EAxi1k/D9cgN+5CEuuJdvO2OAZcoh+iX/oNFyrGBKZMCoHLjVJOpKZ2rGzudXS7Ie
         JOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vyvqsKUUjRa3pg9m7sb8yRGNYXrlVc9ogTxAYcN868A=;
        b=DaAdQKsuntxIqFMmf52Z6GaXM0vHXaz8lLd4Gtdd8S514o3XN4Z+UVWjVGrQz1kkuR
         up10DnpwkD89W+psKS7Zo/u9Omn3c5v8W/POBGRBx3G+W2ZGkZdLRXFd7RasC9ZD3Rn7
         rJIPnYZJceRCtTYWoQfE60hGe0LMxvTFUqmCCIeh6y1TsEYX88LDVQtxFhZoZDnXRbrG
         Qmg/U9DG+uCltyu2umRDOnvMmEqbtJRaZUfByoiR5rOu7kwK7eN3SbPQ7UrPPRQkZmuX
         Cv+S7sc7+ggOn3a6iJxw/BR7hCHcAcPdDFHUXN1i6Lqv0lUGiWFJrzCVHucYP4kR8px4
         nSHQ==
X-Gm-Message-State: AOUpUlFS8fEGfDw13s2Coo+Wc/QtDK8MoBIWOOtMpbXk44o2z5Q2lRwm
        YcQ0ls5ByFvxFjqSIVTFiXfxcIUW
X-Google-Smtp-Source: AA+uWPyABxozlf/PHOppBkQu1Y2pAU0LzNNINL+GLK4bNRO3//4xluidHRQBOv3ZLZ4CS7UPjcVnd4c3
X-Received: by 2002:a1f:350b:: with SMTP id c11-v6mr10473780vka.78.1534203565661;
 Mon, 13 Aug 2018 16:39:25 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:34 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-3-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 3/9] platform: goldfish: pipe: Fix checkpatch warning
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Function's opening brace has to be at the beginning of the next line.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 065b2eaab9cc..0607897c6a59 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -587,7 +587,8 @@ static void signalled_pipes_add_locked(struct goldfish_pipe_dev *dev,
 }
 
 static void signalled_pipes_remove_locked(struct goldfish_pipe_dev *dev,
-	struct goldfish_pipe *pipe) {
+	struct goldfish_pipe *pipe)
+{
 	if (pipe->prev_signalled)
 		pipe->prev_signalled->next_signalled = pipe->next_signalled;
 	if (pipe->next_signalled)
-- 
2.18.0.865.gffc8e1a3cd6-goog

