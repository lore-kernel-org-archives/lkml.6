Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95EFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888D20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUovaMA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7888D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeINXHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:36 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48720 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeINXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id u129-v6so7941208qkf.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bFfkCPo6MxZVeUkMs4YXiEX2DGM+fhv7DZ7PrkcHdmM=;
        b=WUovaMA0KoqsOgD1eWIilu5c6g2Kgu+2nAQ5LFcNGPyNu6ShsC4Oh1OrjbB0qSuZql
         7Dx60Ju6D52m4ZUPbi6VgRVZkkz28ixCMfa0iL8MeNArOpKKhxKKMIH5u1gFTasSQfNj
         /MXrPkJYkIHFz2mUf+qzPbKdovB6fTfmYLsVWbPrNOoibYIf5t9J6NXSokPjdDRSSmvx
         S1r/NpVjJgzGkOrHhVnTyf1JRn4SncripgjXX8pLDcO10/DNy395yQTFA5b1hjoGKcKX
         SJ7zFZLRcgZQGxD5j2JWWBy/RZrn1jZaWLeprHukXd/W759HL2ZD57nJ7NMFWxvB7RBH
         S6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFfkCPo6MxZVeUkMs4YXiEX2DGM+fhv7DZ7PrkcHdmM=;
        b=M8CXLQiNG3Ml2mTrj/7weBsOJnMZ7bDk59ZAvnPLGdHtPZgCgx39AbUTNnJkKQ6Lyj
         SRjm02msdqbzrBvr5ifUwxWeySGLLIMHl9i7qwLu87z59O6Tw7+CxDwnSSYizN1w0Pji
         XRbzO8c83hQkMbE2f83nlDV9BxGkzsKn0Endl1e32fVs7Gy5tql393yMjZFppntHCoYP
         fll7WecCy6V3aeuGU/hxG/Yg6bc+f4E0BupFaVxsVY/BYMUp8FQd6dj/zMyrLLJrbCn9
         SDlgQnRP2sjonMh0N2QDz/SCVemE9pELqdn2WFUttK+P4CDFHzN2uTN0IezWhYkSI+7Y
         TXcA==
X-Gm-Message-State: APzg51AglrnhPEqm8STPu69oVd4xKyF5fZQyDBc5vVf96NFTPTkSda5F
        DrOO3kscJhM/fTtlTAy6dyD5oZE0
X-Google-Smtp-Source: ANB0VdZA/I5gvoCQUQCduO8Aiq2IHxG2IXOmWBu0HqnV175n1Nhzg5H00eR27JGDR1jB95sGh56Js0TF
X-Received: by 2002:aed:2452:: with SMTP id s18-v6mr4259840qtc.20.1536947521691;
 Fri, 14 Sep 2018 10:52:01 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:05 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-4-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 04/21] platform: goldfish: pipe: Remove redundant struct declarations
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

goldfish_pipe_command is defines just after declaration and
nothing refers to goldfish_pipe before it is defined.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8747ec330b7b..6b21671c75ee 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -82,8 +82,6 @@ enum {
 };
 
 struct goldfish_pipe_dev;
-struct goldfish_pipe;
-struct goldfish_pipe_command;
 
 /* A per-pipe command structure, shared with the host */
 struct goldfish_pipe_command {
-- 
2.19.0.397.gdd90340f6a-goog

