Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C1DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4930D25EE4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uELxE8/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930D25EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964786AbeFYRPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:15:33 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:45397 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeFYRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:15:30 -0400
Received: by mail-ua0-f201.google.com with SMTP id n7-v6so4259448uak.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=Zub7ViUOsmj+AevHRwGRuUDiiz0//f8K6SFVme4s8Ac=;
        b=uELxE8/+eiO59MrqSGG3f2xcB/sF/McDy2qHhkAdEmwm/Sh6L7UG/SeZMDKKSmuiI8
         0R+Rjt1qWixlR+ZwTBRT44zFmEKIUFHhTq3X5wmyNvtSXnmPv8lD9UT0+WEBVGSeT9co
         8GT1Sr4HMlkRrrjcQhnah9HDex1KKjk9KN5Kc8dudtjmSYEM32kpxurhtnHaG9/fDnm2
         uVuA0p+Yd9KMUDKoP047UnAAecSH7hWlSHtgVQXEBJQ8xmu0+GdbWOGY+XfA8z3zUuTz
         svezsKoAOOc6h0HrYo8CfjyyloyxAT1Ut9XMzxLvCU9E0OhIJRrnwRaDm7KHS+sO/E/B
         rOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=Zub7ViUOsmj+AevHRwGRuUDiiz0//f8K6SFVme4s8Ac=;
        b=LBd8Ar0WeaAwyHKYgRC4rVAxHtQDxFdewZ2kgu+PCzJXBLEbjsaZD9f+vG60rOfN7w
         a3nwm1a2pPxbeTaAvL4cxr79JgZ1vhZRifRHCn8udXKRYA33pBnnjMFNM/97Lktxr+N1
         UuNso9zDyWXbtW6rmWGpq4ZD32Xi2nlAYvzL/RvsJMpoE1ejux9nznKmjVuO7gqUiLiZ
         GBj+VnjU5JUexX0uomqebb3P5nMnJ/UyhX/j15mqGVDDwmxPo2WD+pX+9VuSQnyGMQnS
         23v6SzZjxubQMBRHq/+LsAI3j3TMJknCfMxPVLn5o7WUs6JEsP7XNhui483QrKwRZdeN
         Kg9A==
X-Gm-Message-State: APt69E0VtP/RnB/nqbRV356KbtzFvk9axDJz83YkfLYogni+rFTfXIqY
        0YsFFE0rR+w5yPfTHXE+JfhYQSI6Nc7z
X-Google-Smtp-Source: AAOMgpddcJUDT7m68L3mWfdUH2o+b3Df1o9M7c7Ffvx/K3Rg7FyP+iwAwAwa5Qy4M9NQPJeMxwH39NG3AUEu
MIME-Version: 1.0
X-Received: by 2002:a1f:1b04:: with SMTP id b4-v6mr1164610vkb.19.1529946929661;
 Mon, 25 Jun 2018 10:15:29 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:15:26 -0700
Message-Id: <20180625171526.173483-1-gthelen@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] writeback: update stale account_page_redirty() comment
From:   Greg Thelen <gthelen@google.com>
To:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 93f78d882865 ("writeback: move backing_dev_info->bdi_stat[] into
bdi_writeback") replaced BDI_DIRTIED with WB_DIRTIED in
account_page_redirty().  Update comment to track that change.
  BDI_DIRTIED => WB_DIRTIED
  BDI_WRITTEN => WB_WRITTEN

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 337c6afb3345..6551d3b0dc30 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2490,8 +2490,8 @@ EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
 /*
  * Call this whenever redirtying a page, to de-account the dirty counters
- * (NR_DIRTIED, BDI_DIRTIED, tsk->nr_dirtied), so that they match the written
- * counters (NR_WRITTEN, BDI_WRITTEN) in long term. The mismatches will lead to
+ * (NR_DIRTIED, WB_DIRTIED, tsk->nr_dirtied), so that they match the written
+ * counters (NR_WRITTEN, WB_WRITTEN) in long term. The mismatches will lead to
  * systematic errors in balanced_dirty_ratelimit and the dirty pages position
  * control.
  */
-- 
2.18.0.rc2.346.g013aa6912e-goog

