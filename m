Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66931218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165236;
	bh=OrUA62ERpuiFxDLzOlW+Mjkp/3+pAaRUJoXpXqHvoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ScPuTbDAQCTQZUWMsMhhpAd6mRDLoTdZWDiNEW18sMPmRiUgmsoh2loE88gHsuRFT
	 AMacD+h10OGnMPC7INxH6QLYV4m9aZ9wz59/h+HO8hLlDnboFeBzQadRNA6h3wtasM
	 ghHeqwHrY0RzRBbh9vWR8pBbA+5zdGxgweot5RHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeLRUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeLRUdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:33:53 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F26921871;
        Tue, 18 Dec 2018 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165233;
        bh=OrUA62ERpuiFxDLzOlW+Mjkp/3+pAaRUJoXpXqHvoy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NJx4f1FQLb0jQhp4gOMbkyRROUMe/G1f8JCi8siv9bg8YQnjasqDg8LHPfmwfPcKA
         LJyyDMDdEBkBj/c6S5GAXn15NTLWhzii40UYqni19nNs+KBUfJpKXTq0Qw9B6ZyMqh
         I1Re2npaKNu1u/SXR1EElVK7do4uDghpwbIj71bk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 1/7] tracing: Remove unnecessary hist trigger struct field
Date:   Tue, 18 Dec 2018 14:33:20 -0600
Message-Id: <d4e066c0f509f5f13ad3babc8c33ca6e7ddc439a.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

hist_field.var_idx is completely unused, so remove it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82e72c48a5a9..d29bf8a8e1dd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -61,7 +61,6 @@ struct hist_field {
 	char				*system;
 	char				*event_name;
 	char				*name;
-	unsigned int			var_idx;
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
-- 
2.14.1

