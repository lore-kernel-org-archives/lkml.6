Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8598C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA5213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BA5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeIMCej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:34:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMCei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:34:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CLRqxX2779001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 14:27:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CLRpj82778998;
        Wed, 12 Sep 2018 14:27:51 -0700
Date:   Wed, 12 Sep 2018 14:27:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zubin Mithra <tipbot@zytor.com>
Message-ID: <tip-49e73246cbe6fe0df9cae2db87f31cdc3a0b2b61@git.kernel.org>
Cc:     torvalds@linux-foundation.org, groeck@chromium.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        zsm@chromium.org, peterz@infradead.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          groeck@chromium.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, peterz@infradead.org, zsm@chromium.org
In-Reply-To: <20180912164510.23444-1-zsm@chromium.org>
References: <20180912164510.23444-1-zsm@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/pt: Annotate 'pt_cap_group' with
 __ro_after_init
Git-Commit-ID: 49e73246cbe6fe0df9cae2db87f31cdc3a0b2b61
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  49e73246cbe6fe0df9cae2db87f31cdc3a0b2b61
Gitweb:     https://git.kernel.org/tip/49e73246cbe6fe0df9cae2db87f31cdc3a0b2b61
Author:     Zubin Mithra <zsm@chromium.org>
AuthorDate: Wed, 12 Sep 2018 09:45:10 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 12 Sep 2018 21:16:16 +0200

perf/x86/intel/pt: Annotate 'pt_cap_group' with __ro_after_init

'pt_cap_group' is written to in pt_pmu_hw_init() and not modified after.
This makes it a suitable candidate for annotating as __ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Link: http://lkml.kernel.org/r/20180912164510.23444-1-zsm@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8d016ce5b80d..3a0aa83cbd07 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -95,7 +95,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%x\n", pt_cap_get(cap));
 }
 
-static struct attribute_group pt_cap_group = {
+static struct attribute_group pt_cap_group __ro_after_init = {
 	.name	= "caps",
 };
 
