Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E646C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9521928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsLqI56H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbeLVADN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLVADL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so3159203plq.7;
        Fri, 21 Dec 2018 16:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6BTJfzWIelD7mVbuHLF+in+X9LUwJiyPSv1dibuIj4=;
        b=jsLqI56HTTsqPVi3FX3oDfH+umsq+zqs513EUQXSMHgRXBe4lnwCYBxA+mnMQhTsgf
         ctCjKne4LV487O8kl+UKHNKeqjizRXwpi7JuHZkFseu/z91NQjr7wugBNBEGpwRyU0W5
         CqfHVsSIgfqHODmdFdgkWgek7xqpYziz7U3ipIRjkIOZZuE8LaQ1nhgU7le5n8d7XmFu
         rD9JN3Co42nNjA15DrDL/f/L8si7h8yH8nZbHU6TIyCyr7iHCFMqH+xek2Wo0d+R3hv0
         0RQZyHO722DaBD4frDUYoZmqJ51vtNhCoByIN9LA77yUDOzQRg6AwbjflyooaXDyf1Vo
         Sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6BTJfzWIelD7mVbuHLF+in+X9LUwJiyPSv1dibuIj4=;
        b=kyIsfROMP3V4DYN+PH2Pu2gw0f35WomYJ85QUQ/L/DMnCIYY8XJrXBJYhnZDDEzFol
         DVdq9fAHhty3dRFmWuTtgn+tWV7p+8nDUqCUynxCCMfMjkIG9HRVLz38Xkye7KSSqQQ7
         Nz6r3umvQrB91PPv/oD7rUo547GvvXV2tLS7DKUN5VLHh2pBEjMwxc2g4zfng5EUc2T8
         i9H4uL6NZ2LPQ0AWHOSBLMPZP6MHcSa+6hEsO70f6NAAzuELO1pxbkoNUqFzcLxyqprD
         RX9EUTDE5KZURsLfX68uqyLzjQ8IS9bTG5+e2hPgHXRmPdqpyYdNWzDTnXtAgll5ghDz
         2L2w==
X-Gm-Message-State: AJcUukfFiPBNxDOhu2acIpIqTuZMgqvR5OUVdt+69g9O9pBpf4X6rcg4
        /jT3usXcSGxxZcLc0i5W1IM=
X-Google-Smtp-Source: ALg8bN6fKvdphU99HCrvfLn4KGB0ZPQtY2LQICPrTzSMMLdFXbEzsLqAPCF7B+3Ne0fQ5wWyH7o5nw==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr4586432plb.312.1545436990898;
        Fri, 21 Dec 2018 16:03:10 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:10 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Fri, 21 Dec 2018 16:03:01 -0800
Message-Id: <20181222000307.28231-2-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
References: <20181222000307.28231-1-guro@fb.com>
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
2.19.2

