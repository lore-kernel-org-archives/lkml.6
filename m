Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1144DC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB98724C1A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXRuuZVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB98724C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeFWONM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:13:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38619 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeFWONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:13:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so4184202pgf.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TrypbCDZKuim9Od/iCHNAQKGhgD1CxB9oz/uU8r0S3k=;
        b=vXRuuZVvbYDJzAwgcshGvRSF0jxzJiQr0XppUwkFgO0etGuSO1s+EMUJeilfgY9GWf
         IMfz2c6gooaqvxVjHSmdDWVGzKjAtLCzkXkF0ETZiXY27sb8L8ZSVHquh+Zw2u+2Ohil
         cJuCUMolSMzI/GDv8baDV/Gm+eTZhdHFN+bB9Oms+JrnsY4QrxMlBBiW9tpA4bVIgyim
         fNhouP1qGg75cotvMLuUUv3jW3hXMP3g/k6fmJiqA5iGZJv8MHqIjBYKA3LKysSGdYTl
         qqXtKN98BlEhOGyfDpNBBbQQ0nxytD5YR0xG+bzKeOLou8qYhSnSHYnVI8nWs7kU40ar
         dgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TrypbCDZKuim9Od/iCHNAQKGhgD1CxB9oz/uU8r0S3k=;
        b=iPZWx64WPVnEuf5a93DniXdDn+Yau7CIzzUDMmsFmXDICEz1IoEiMjvBloSG6zpD4e
         xa79jSfEDMFOPOsi+Rc97TyrQuSqvEeL0Krzmc9DZie+gRoXOAe/EbVJZCcydqCjlnDL
         DA8i+BZ7QdLqP7IIQjISE3E/xChEx/qxV7+IjoC8WfM88Om821MFJlfdomW/TqaJs2ea
         4Vs6pacXKFcywQvKFrSM+WZ5Fjs+DoNdsdoQvTsncZ2Sp515H8qZOkqcdNDy/SZrzMKo
         qFauxNeXsJFub1mlyITn+2whWNgw/6KhDDEwdH8agEV0xQ4Vqemj6lDrfg913I4WjRQl
         8tTQ==
X-Gm-Message-State: APt69E1q7AX11R9UKd2zgCfxz5/uyqkgSlUMghesX9hyfe9KKfUIG5RF
        x2DNfoa5+nVItpI1dKLCuOulDg==
X-Google-Smtp-Source: ADUXVKI2bXf6SB7auV+tpkGqa7O6SLTC3RvZnCYsbHooZ9aQJwQJvN+9oMVMB+JgEFbW+xLvNce2rg==
X-Received: by 2002:a62:5601:: with SMTP id k1-v6mr6066126pfb.212.1529763190901;
        Sat, 23 Jun 2018 07:13:10 -0700 (PDT)
Received: from dest.didichuxing.com ([52.229.160.192])
        by smtp.gmail.com with ESMTPSA id v78-v6sm21851120pfd.64.2018.06.23.07.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 07:13:09 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v10 1/2] Move enum oom_constraint in oom.h
Date:   Sat, 23 Jun 2018 22:12:50 +0800
Message-Id: <1529763171-29240-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

This patch will make some preparation for the follow-up patch: Refactor
part of the oom report in dump_header. It puts enum oom_constraint in
oom.h.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 include/linux/memcontrol.h | 1 +
 include/linux/oom.h        | 7 +++++++
 mm/oom_kill.c              | 7 -------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..513b74b3115b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -28,6 +28,7 @@
 #include <linux/eventfd.h>
 #include <linux/mm.h>
 #include <linux/vmstat.h>
+#include <linux/oom.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
 
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6adac113e96d..40cc561f8557 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -15,6 +15,13 @@ struct notifier_block;
 struct mem_cgroup;
 struct task_struct;
 
+enum oom_constraint {
+	CONSTRAINT_NONE,
+	CONSTRAINT_CPUSET,
+	CONSTRAINT_MEMORY_POLICY,
+	CONSTRAINT_MEMCG,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e77bc51..1045c5bc7c37 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -237,13 +237,6 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	return points > 0 ? points : 1;
 }
 
-enum oom_constraint {
-	CONSTRAINT_NONE,
-	CONSTRAINT_CPUSET,
-	CONSTRAINT_MEMORY_POLICY,
-	CONSTRAINT_MEMCG,
-};
-
 /*
  * Determine the type of allocation constraint.
  */
-- 
2.14.1

