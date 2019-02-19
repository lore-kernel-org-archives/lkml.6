Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFADA2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1HAxSvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfBSWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:03:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36882 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:03:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so10770645pgq.4;
        Tue, 19 Feb 2019 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=B1HAxSvDc7FtijdDUm9rWI+yRJlqlKsG+9KBWuJsmSWe9DctoGHgiFBz4Fm5nubpZM
         DqXU2O7qRFhpUHzmLHlRvb9A4fZQIP9PIliEegLI1V8CJ7nUxUfUQg+m58jq1bIgsNWL
         shuRKl/iiJptxMd1DLq0oN0cHQEoAnne2WN5GaEbzma3/UIEInHe+i79LkTxX66abOnl
         Yp1xd7tlo4wLOvfs6jv4+fLtogbpP9n9c3Ib8/Z2EWE36pkA+oWPVHTkYfftSXeMCSSI
         KGJihDA2v3puHTv7aX0LyHbE6vnVOJjOtrhZ0WCqzxwTp5sd5AkgirPtqiUnUxJ+GRg3
         yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suU4k9iE7Md/KfJ4CfzvKVa4/9QAyJfSEidhnmW/+G4=;
        b=ZQiNe7s8yrHZzqxPCDay7b7oxlJmUUcSUP0pHzVpJS+s9LnofG00uoqi3sYj8LxTpY
         rRym4+N1iINAU14aqp/xm3S6wMACVcg6Snnh1XjdEmhdemkIZDoGsBPBaTlW5qgDgFL8
         sKcLfOw+XK8rOi2L6GjKQlTstyBG8bZ8JalXDvj2LlGW2YtxaQ2qItBg+Y6RfLhjsWs9
         7Ht2yoKl1AfqrrbqINwKaWsvMdJcjXgqctQvTNnnuoe8V/bPiMb2nQI2QqXA84lzwaJT
         wPPzmDNfRZ1AgMi8OKy1wwh//ScG35zFX/sGPtYbsc4GMUkJffoqcHw6UNlSVtkXGvYc
         zVrQ==
X-Gm-Message-State: AHQUAubi/NO7rLZWkihP3lYriYq+/3MeJJTz1fsTLOBmXsTf6GCFI8Cd
        nJfQ1W+kBH20nSB+fSi0Yeg=
X-Google-Smtp-Source: AHgI3IYcH7SvUKGkSeCF/bG8u6snGYGAUMZHhBPtrrDlBA+Gp3JLTNiAhLb4VDCjnGok/+XhS+lwHA==
X-Received: by 2002:a62:f598:: with SMTP id b24mr31420441pfm.72.1550613782073;
        Tue, 19 Feb 2019 14:03:02 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:161b])
        by smtp.gmail.com with ESMTPSA id e6sm33539779pfe.59.2019.02.19.14.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:03:00 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Tue, 19 Feb 2019 14:02:46 -0800
Message-Id: <20190219220252.4906-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219220252.4906-1-guro@fb.com>
References: <20190219220252.4906-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freezer.c will contain an implementation of cgroup v2 freezer,
so let's rename the v1 freezer to avoid naming conflicts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/Makefile                        | 2 +-
 kernel/cgroup/{freezer.c => legacy_freezer.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/cgroup/{freezer.c => legacy_freezer.c} (100%)

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..8d5689ca94b9 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 
-obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
+obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/legacy_freezer.c
similarity index 100%
rename from kernel/cgroup/freezer.c
rename to kernel/cgroup/legacy_freezer.c
-- 
2.20.1

