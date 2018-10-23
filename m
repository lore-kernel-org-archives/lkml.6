Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73530C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C12075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C12075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeJWTgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:36:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37567 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:36:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so1219832eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ER9L03kjqZTsjytxhz/GCLIvb20Sr9rRBPoribawJt0=;
        b=q4hmW1teFI2ce6feRgPShbatdWDs5u4r5U7FLCCBS3662opzyaD7ATKffgRUlX3ZCL
         wtmzTWmsCRhCwkL0oeDdnOQzkiS+s4MLF/zQRDNoD13veFj7e/1eZTgnnjrtpzTZo9MN
         kua5C8YXumFmW1MER8uSfbS8FnyzKhHTZdn+THalNuM4JKmlpgFL5yvRaaWPmtwj6nXA
         ZXPOn50yYBBzoruXuhU4nfq8jKDovboAY29Yd5Mtp2eXjmVt55WJTrPZcrjM80Meh87P
         8oMDw8qnZf1VQZ3e3kO8HM2faXXsSOwUyPJlMetRuHXUWd39K6cArEcXQCXC2YLFwMs+
         yTeA==
X-Gm-Message-State: AGRZ1gLLkHiivsIONHvYUFgCiAMLhEz/O29URzjcgoONN7bOjEioclL6
        9UrwYAVuHudUCgBdbqD21tA=
X-Google-Smtp-Source: AJdET5clJUeTR8kiBJTqEin/E3iErEaNVfxX1WpqTCfagq02k54+tm6EPt7p3eA79gdOi9tSHMSLMQ==
X-Received: by 2002:a50:ad4a:: with SMTP id z10-v6mr584664edc.252.1540293198432;
        Tue, 23 Oct 2018 04:13:18 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id e10-v6sm290590ejl.25.2018.10.23.04.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:13:17 -0700 (PDT)
From:   efremov@linux.com
To:     KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc:     Denis Efremov <efremov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for the task_setscheduler hook
Date:   Tue, 23 Oct 2018 14:12:55 +0300
Message-Id: <20181023111255.30446-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The task_setscheduler hook was changed in the commit
"security: remove unused parameter from security_task_setscheduler()"
(b0ae19811375). The arguments @policy, @lp were removed from the hook.
This patch updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index accf6f34ac8e..ae3766720264 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -655,10 +655,8 @@
  *	Return 0 if permission is granted.
  * @task_setscheduler:
  *	Check permission before setting scheduling policy and/or parameters of
- *	process @p based on @policy and @lp.
+ *	process @p.
  *	@p contains the task_struct for process.
- *	@policy contains the scheduling policy.
- *	@lp contains the scheduling parameters.
  *	Return 0 if permission is granted.
  * @task_getscheduler:
  *	Check permission before obtaining scheduling information for process
-- 
2.17.2

