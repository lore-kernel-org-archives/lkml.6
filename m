Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5CC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E125D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAULRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:17:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAULRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:17:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBGfXS2492625
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:16:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBGf5H2492621;
        Mon, 21 Jan 2019 03:16:41 -0800
Date:   Mon, 21 Jan 2019 03:16:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-486efe9f8e30bac1e236f867df164f4966f3e207@git.kernel.org>
Cc:     paulus@samba.org, andrew.murray@arm.com, mingo@kernel.org,
        mpe@ellerman.id.au, linux@armlinux.org.uk, mattst88@gmail.com,
        peterz@infradead.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        ink@jurassic.park.msu.ru, rth@twiddle.net, mark.rutland@arm.com,
        bp@alien8.de, shawnguo@kernel.org, hpa@zytor.com,
        will.deacon@arm.com, benh@kernel.crashing.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          ink@jurassic.park.msu.ru, mark.rutland@arm.com, rth@twiddle.net,
          bp@alien8.de, shawnguo@kernel.org, hpa@zytor.com,
          will.deacon@arm.com, benh@kernel.crashing.org, paulus@samba.org,
          mingo@kernel.org, andrew.murray@arm.com, mpe@ellerman.id.au,
          linux@armlinux.org.uk, mattst88@gmail.com, peterz@infradead.org,
          acme@kernel.org, linux-kernel@vger.kernel.org,
          s.hauer@pengutronix.de
In-Reply-To: <1547128414-50693-3-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-3-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Add function to test for event exclusion
 flags
Git-Commit-ID: 486efe9f8e30bac1e236f867df164f4966f3e207
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

Commit-ID:  486efe9f8e30bac1e236f867df164f4966f3e207
Gitweb:     https://git.kernel.org/tip/486efe9f8e30bac1e236f867df164f4966f3e207
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:24 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:19 +0100

perf/core: Add function to test for event exclusion flags

Add a function that tests if any of the perf event exclusion flags
are set on a given event.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-3-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..54a78d22f0a6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_any_exclude_flag(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return attr->exclude_idle || attr->exclude_user ||
+	       attr->exclude_kernel || attr->exclude_hv ||
+	       attr->exclude_guest || attr->exclude_host;
+}
+
 static inline bool is_sampling_event(struct perf_event *event)
 {
 	return event->attr.sample_period != 0;
