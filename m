Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuOtFtLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2447C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeG0EFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:05:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40294 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeG0EFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:05:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so2321209pgp.7;
        Thu, 26 Jul 2018 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RMYnp9oteqapWB1Tgj+wT9vMRQaECIr4N8ZuYxkVN04=;
        b=fuOtFtLKGd9yUD6hwXKwV3iQEYqyAkdScubYeqWSgD54izDBSr1cGqecvpeCBOtRD3
         X6biAgy0NLFUXElzM2TD/JL8ZF42zyniKe7IlUJFx+6Hga2Z4JZYaQwp/qtWvkIltO4e
         Px4ZP48BVZ6svz3Uuwzj5ees559YdOuIq0JHKdcgsh2HZQmQg5IctC+wi7FhTBDWPCew
         wlHuC2afpHe0j49DalPLxj0Bw1y7cGl7cClBFb0pAVD6w+D0Y1UZAQMK2B+Tm9kp9vBA
         tW5UBwbsjKheYgCkudxskxzoACtptQMem8/BvyJ/2nrIkLmgPk9acWfQr0WQoQ2oLf5p
         KcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMYnp9oteqapWB1Tgj+wT9vMRQaECIr4N8ZuYxkVN04=;
        b=CV6GSzGus5ESaKBfDBCuMtMQF+/YBSpOxLbTckxhqX43V0h5Aop7wOI5rWk1Xspa6p
         BUpY+PyyyvU2vB1/JOpMy2iUrJb/pd7l3DerVyLAVcK6gxrZ2DZtpsxu1/qlOBZmFfU+
         LlP/Z2fwFCUsjKagluMKINa0KnZZDq8k+6KYqZTFJxkyQQL4RrXATjLV0f/50O/I0Ntd
         XfwghQv4DZ6GRCw0ApH+xpdq7/jRkJzT/BxLS1bpZW8Kc3LCnQh5dVDniPp1uwMzmcLw
         sWp7HTyFM1X/hPQ+Iqu7q5kCT2kI/NcV8LYFGPyu3wL2r8MaSQ8ouWcZq/zC3k8qZ8Qa
         BCxA==
X-Gm-Message-State: AOUpUlGiaelyI5rOmgUIkEnamH/dtyDduGP0vKUo5rRFcQn889ezht7I
        Ef8APDuYRss9kNvZXrSbxsg=
X-Google-Smtp-Source: AAOMgpf6D8ibeiNlLO8HmzShlBZrIo6fnTc6SRq4gp5ISeavx5FCzyRzVgU4bYXQ71A2De8bXYsFVQ==
X-Received: by 2002:a65:5cc5:: with SMTP id b5-v6mr4198138pgt.425.1532659537835;
        Thu, 26 Jul 2018 19:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id z20-v6sm6369814pfd.99.2018.07.26.19.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:45:37 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: hisax: callc: Replace GFP_ATOMIC with GFP_KERNEL in init_PStack()
Date:   Fri, 27 Jul 2018 10:45:30 +0800
Message-Id: <20180727024530.1849-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_PStack() is never called in atomic context.
It calls kmalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hisax/callc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/callc.c b/drivers/isdn/hisax/callc.c
index ddec47a911a0..0faecb723f13 100644
--- a/drivers/isdn/hisax/callc.c
+++ b/drivers/isdn/hisax/callc.c
@@ -1012,7 +1012,7 @@ dummy_pstack(struct PStack *st, int pr, void *arg) {
 
 static int
 init_PStack(struct PStack **stp) {
-	*stp = kmalloc(sizeof(struct PStack), GFP_ATOMIC);
+	*stp = kmalloc(sizeof(struct PStack), GFP_KERNEL);
 	if (!*stp)
 		return -ENOMEM;
 	(*stp)->next = NULL;
-- 
2.17.0

