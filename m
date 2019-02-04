Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5956AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C3A2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfBDRJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:09:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:09:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0DB15AD;
        Mon,  4 Feb 2019 09:09:43 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AAA93F589;
        Mon,  4 Feb 2019 09:09:41 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 2/5] cpu/hotplug: Export __cpuhp_state_add_instance_cpuslocked()
Date:   Mon,  4 Feb 2019 17:09:05 +0000
Message-Id: <76aa8ce6c6526aeb2ccfce04b203b0a24f50a097.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only member of the family not exported already, but
happens to be the one I need to fix a bug in a modular driver.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..c1bd8ed7546e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1683,6 +1683,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	mutex_unlock(&cpuhp_state_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);
 
 int __cpuhp_state_add_instance(enum cpuhp_state state, struct hlist_node *node,
 			       bool invoke)
-- 
2.20.1.dirty

