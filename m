Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E2C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIKLSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:18:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:18:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6K5qI2135587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:20:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6K5dr2135584;
        Mon, 10 Sep 2018 23:20:05 -0700
Date:   Mon, 10 Sep 2018 23:20:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zubin Mithra <tipbot@zytor.com>
Message-ID: <tip-2766d2ee960c52adc415931130dd6910158dd04d@git.kernel.org>
Cc:     zsm@chromium.org, keescook@chromium.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, hpa@zytor.com
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, zsm@chromium.org,
          keescook@chromium.org
In-Reply-To: <20180810154314.96710-1-zsm@chromium.org>
References: <20180810154314.96710-1-zsm@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Add __ro_after_init annotations
Git-Commit-ID: 2766d2ee960c52adc415931130dd6910158dd04d
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

Commit-ID:  2766d2ee960c52adc415931130dd6910158dd04d
Gitweb:     https://git.kernel.org/tip/2766d2ee960c52adc415931130dd6910158dd04d
Author:     Zubin Mithra <zsm@chromium.org>
AuthorDate: Fri, 10 Aug 2018 08:43:14 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 14:55:36 +0200

perf/x86: Add __ro_after_init annotations

x86_pmu_{format,events,attr,caps}_group is written to in
init_hw_perf_events and not modified after. This makes them suitable
candidates for annotating as __ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com
Cc: groeck@chromium.org
Link: http://lkml.kernel.org/r/20180810154314.96710-1-zsm@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c0d019..7a6fb9b2bec5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1584,7 +1584,7 @@ static void __init pmu_check_apic(void)
 
 }
 
-static struct attribute_group x86_pmu_format_group = {
+static struct attribute_group x86_pmu_format_group __ro_after_init = {
 	.name = "format",
 	.attrs = NULL,
 };
@@ -1715,7 +1715,7 @@ static struct attribute *events_attr[] = {
 	NULL,
 };
 
-static struct attribute_group x86_pmu_events_group = {
+static struct attribute_group x86_pmu_events_group __ro_after_init = {
 	.name = "events",
 	.attrs = events_attr,
 };
@@ -2230,7 +2230,7 @@ static struct attribute *x86_pmu_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group x86_pmu_attr_group = {
+static struct attribute_group x86_pmu_attr_group __ro_after_init = {
 	.attrs = x86_pmu_attrs,
 };
 
@@ -2248,7 +2248,7 @@ static struct attribute *x86_pmu_caps_attrs[] = {
 	NULL
 };
 
-static struct attribute_group x86_pmu_caps_group = {
+static struct attribute_group x86_pmu_caps_group __ro_after_init = {
 	.name = "caps",
 	.attrs = x86_pmu_caps_attrs,
 };
