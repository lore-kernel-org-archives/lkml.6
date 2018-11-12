Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318FF224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAbk9zkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318FF224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbeKMJAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:00:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37190 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKMI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so2340306pfm.4;
        Mon, 12 Nov 2018 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=RAbk9zkPZHU73V/pK9HJWFONWB4aHEDEO1YKmJUtT09knC+yce1MRedNm6dLLrjWkD
         G7QOevbIFA/GtlKT9ev6br+u06XYT69WnEB0mM2SG0Yg0V0WcZm+OkDn+iaTIT9BDGEM
         SGe2BjTQyFBaw57C6KtQizEl10XfAwOESeNWgFYpIOovWr8hHT5cSTXrFd/I5kaYbdye
         iX1okgmGUzKaZUSfSy1I9nV0Jxys4II2KeN9GJ7BuftQ9rlhNvARIgbTZGhhAMK87hZX
         NNhtHVI3/WOBzx73AVW4wstZ89ujYcKWmMhpfRIuVNVQgQ72wArqg0GOb4awky9XBlv2
         ta9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=R06WRy5MRWTB/RC19F2Q1NoH5Ln0TDIEQcr5MSD5JDzA3qIDURJ16/I9WaezKP3f6h
         FMlpwt9kOwiMLwrx83gllDFox6jRRjI3YIEvEkxk0Ra7r3rkrv5T0F8MpnqnjK+6E+ri
         SgH0GdBSKbcAZcLCjrm3UmaHF679xRTDCVAesQM5z3rsRcd6aNMiD+QJaIpqLUPhts+X
         SWVJvqokR8/Xr47w7s0Clr41q2JsB8d1rUKqwDeaWVHUNPAjb+061HEuUeYz6tAR4ZG1
         FtMNOlR7HFhpTyyB8k0x5PoYqJWKo3Nf6jfsCyWYioF2vBzoBSroPR8Chu7sdfTuWt9C
         i+LQ==
X-Gm-Message-State: AGRZ1gLOU1aAjk9LLCdteV6trawya42DKWrOmro4G3d4YXEDg7gP11Ci
        0k8r19VHUYeGuDtcdhFAV+fPpS+T8SI=
X-Google-Smtp-Source: AJdET5dzFahWJ6XXWQ+eXM/lXlRV+kgGqClh1PQIxSOJeI4GUnQS5rIXAmUL3V/Vx7G3BfVIkDvchg==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr1814042pgl.127.1542063866670;
        Mon, 12 Nov 2018 15:04:26 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:26 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/6] cgroup: rename freezer.c into legacy_freezer.c
Date:   Mon, 12 Nov 2018 15:04:17 -0800
Message-Id: <20181112230422.5911-3-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112230422.5911-1-guro@fb.com>
References: <20181112230422.5911-1-guro@fb.com>
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
2.17.2

