Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C84FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D3120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCpLwFza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D3120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeINXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:05 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50253 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:04 -0400
Received: by mail-pl1-f201.google.com with SMTP id h4-v6so4656447pls.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FFi5cTUKPemO9g3tz1O4tkSYuYrCjt8z3WPiMwOwVjM=;
        b=mCpLwFza70bkudCjJACzT2iJ4vZsscz08vHJ838D7I8lkmHse9+VDJtXukKaTixkt+
         KkhobCmKJ1WzTsg0TAzUTgHMjm1Qs+/afduVrCwfDCn81JHdO4H4IhDLqsQcOw50afIB
         MTDpn8BEJpOLGNClUGyj41PE6IDOo3O/Jy3gGdRlSwqGtG23vrSNA/a1S/7GA84EAUa/
         m0uCcvt+AOnJbSGPw4WI2uRIvCnWf9r1C3Rpj3rGw17ySUvdtmTaFdjeSL0/ZLJwTGna
         PBNetwcF1AIIdML7b9t8e75InfhMuT2LAV0sNSwabgZxlaUcamweyNJCmbwQ8uI8sv0P
         91LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FFi5cTUKPemO9g3tz1O4tkSYuYrCjt8z3WPiMwOwVjM=;
        b=MYpyhg7KhxN/x7RZTv0QxpAs4cyxru3ukvEJ9InMACIaAOku0IWkuervoFD3A84k5a
         l1DRsw7zABqbeunGpvJHfkZvtU6VFz53q+3L41yiO5C4lEojM/cWAPMu2TJICgdT6yJB
         g55h2gnnI8BK64otsbCNJhTE7R1QvBDdt/vVtcrIbR5kg/aB9PrKmMs95K4ueDb0iOEQ
         ruxX91pAfgBUO7pAqj1NA5vt5PWLbKykcUgBAAtaiIki7qlhi141bFKU5QXLLZ/5hEW4
         O+l9vjuQV3vbLsKleWyYKSQ8bxVRI1dHj2ThaXHI4xSuDSD1JBpeRVd4z4lCFNVGLTxD
         /VQA==
X-Gm-Message-State: APzg51ASJX5/IyMOExLenC2tSEwlG1n34/lq4tyPuyMTWhkGwT4+4O38
        +6klsdbQ8PZ6Ey8UzumX1iUEKgT+
X-Google-Smtp-Source: ANB0VdZ5SjzDCYrgM7+EqOOsdeLsRIXhjTgHdhnbb2MjcvHFC39hEygQMaEI+Z3xkpu6UgpL9AnXzZoF
X-Received: by 2002:a63:c0f:: with SMTP id b15-v6mr768587pgl.80.1536947551584;
 Fri, 14 Sep 2018 10:52:31 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:11 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-10-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 10/21] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
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

This is the v2 driver. The next few patches will add v1.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/Makefile                              | 2 +-
 .../platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c} (100%)

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index e0c202df9674..81f899a987a2 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
+obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_v2.o
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
similarity index 100%
rename from drivers/platform/goldfish/goldfish_pipe.c
rename to drivers/platform/goldfish/goldfish_pipe_v2.c
-- 
2.19.0.397.gdd90340f6a-goog

