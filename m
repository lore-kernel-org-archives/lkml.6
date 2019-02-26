Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EBC217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162050;
	bh=aL8uqSauDNO6m95fi+nIwZll7kr53geRXWAs7bbuzqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=CJ5mhuHQjazuz78tW9NB/EMC/56KqPrWShR7ckvE3NkoBvXIEUiJxCMn2z2xE0D4z
	 zYHUvkP8pjEsHG1BbDCDninYC45V0hIYh9Dpu58FGmj54NAOgYnAEueVVMtSuxsNDR
	 usDAf5AVspCAbXCedmyYMhArnoU3rSp4N3ROhYwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfBZGUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53114 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfBZGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:40 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so2316060itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=u8iQeFd3+q6vcBHMyH6ksfTOXcUOhzvjlm+XiSQnqJM=;
        b=lr+GKG8f3kES6AKySIO+po3jZCGdr3w4nZLEwdzs3ZR41eForE2QmABHpw/siYG+Jo
         kvWjQTsYYX128CA76sTB26gO71ERJCCipzTADFqUDYOqOpiOv7ww0et2gWru+fhQhwW/
         uyjPI9OtbBG2N3aMrssqX1fBm0q3W4fcLoZpRNu+sAoIsTk1Bdzpfd9Vp7Ypmx/ulr8z
         p1lrVS9tFsfhkCVYvvi5F2aUIU3QuXiSuTZGg+A55I1WcIhdSAScyamOz/EDYBMO9zz4
         V/bqotbUydeMNOIS2Nf2UpKUsdNL9CyYGWhpL2EmWdcZ4qLjnI0anZfzRSgCp5F7AZC+
         /U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=u8iQeFd3+q6vcBHMyH6ksfTOXcUOhzvjlm+XiSQnqJM=;
        b=LSjz1E2Bb2gdUna/pWoqZkarUBeIC+0PFgzk9A7MBoaKtR/0fN90Q1fgEKKoENwIhx
         xch5fCFInhK8nPraD8PVhpugKufN8eSVttOD28Y5F3cGYzZrkpYpTcnfvWlTwAo5Ag+6
         WPJ26ChzG+ufFEHZ3uxtcuWhuOTwuc+tNRqmx3rJvE1tgd3KRl5Xlfoo/ekcdBQV+Re6
         3YNB5jcra3U4zR/uM6R5rH4dGMAeiq/LquwFsQ99mSrp6pAJY11ov7FR/Oa1aKWFI6+8
         SDaTBv9bPkEH3HAsNZf7FXAs0jeuf+S+o7l6wJhGELnq7yJyecEieH9h5IR1dn5F6F1n
         4CJQ==
X-Gm-Message-State: AHQUAuZPFaAi3Vmu6OZOMFzpLgRQM/wM7h4dfPPt4VROf/aajWWrZPvV
        +cR+cGrLq3MqJNUf6Ni/jFI=
X-Google-Smtp-Source: AHgI3Ia1UNU4obauUiA4MIa28Z8Ji4y4uEW6aa5oIooVCZIQzSf31Yv5oLj/YVAJQ+l/Cr7ESs8gvQ==
X-Received: by 2002:a02:59dc:: with SMTP id v89mr12016797jad.98.1551162038867;
        Mon, 25 Feb 2019 22:20:38 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:38 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 13/14] topology: Create core_threads sysfs attribute
Date:   Tue, 26 Feb 2019 01:20:11 -0500
Message-Id: <8c68d2dfd5d516316444b1a25fe550bb42733eb8.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Create CPU topology sysfs attributes:
"core_threads" and "core_threads_list"

These attributes represent all of the logical CPU threads that share the
same core.

These attriutes is synonymous with the existing "thread_siblings" and
"thread_siblings_list" attribute, which will be deprecated.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 8 ++++----
 drivers/base/topology.c       | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2794dbe8e559..e67915a8a512 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -36,15 +36,15 @@ drawer_id:
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-thread_siblings:
+core_threads:
 
 	internal kernel map of cpuX's hardware threads within the same
-	core as cpuX.
+	core as cpuX. (deprecated name: "thread_siblings")
 
-thread_siblings_list:
+core_threads_list:
 
 	human-readable list of cpuX's hardware threads within the same
-	core as cpuX.
+	core as cpuX. (deprecated name: "thread_siblings_list");
 
 package_threads:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5f4405a08c6e..73efadf5e6d4 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -53,6 +53,10 @@ define_siblings_show_func(thread_siblings, sibling_cpumask);
 static DEVICE_ATTR_RO(thread_siblings);
 static DEVICE_ATTR_RO(thread_siblings_list);
 
+define_siblings_show_func(core_threads, sibling_cpumask);
+static DEVICE_ATTR_RO(core_threads);
+static DEVICE_ATTR_RO(core_threads_list);
+
 define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
@@ -83,6 +87,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
+	&dev_attr_core_threads.attr,
+	&dev_attr_core_threads_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
 	&dev_attr_package_threads.attr,
-- 
2.18.0-rc0

