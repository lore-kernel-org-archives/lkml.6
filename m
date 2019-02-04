Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018E22087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfBDRJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:09:57 -0500
Received: from foss.arm.com ([217.140.101.70]:58690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfBDRJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:09:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6AE1682;
        Mon,  4 Feb 2019 09:09:47 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D7733F589;
        Mon,  4 Feb 2019 09:09:45 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 4/5] cpu/hotplug: Add locked variant of cpuhp_state_add_instance()
Date:   Mon,  4 Feb 2019 17:09:07 +0000
Message-Id: <93599efb6ea546370dd470a31f8e8cf97764a31e.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A helper already exists for nearly every combination of parameters,
except of course the one that I now need.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/cpuhotplug.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..1d6231fe1590 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -290,6 +290,12 @@ static inline int cpuhp_state_add_instance(enum cpuhp_state state,
 	return __cpuhp_state_add_instance(state, node, true);
 }
 
+static inline int cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
+						      struct hlist_node *node)
+{
+	return __cpuhp_state_add_instance_cpuslocked(state, node, true);
+}
+
 /**
  * cpuhp_state_add_instance_nocalls - Add an instance for a state without
  *                                    invoking the startup callback.
-- 
2.20.1.dirty

