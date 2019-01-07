Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699FC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1782183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfAGQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:27:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfAGQ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:27:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B3E15AB;
        Mon,  7 Jan 2019 08:27:45 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74EC33F5A0;
        Mon,  7 Jan 2019 08:27:41 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: [PATCH v4 01/13] perf/doc: update design.txt for exclude_{host|guest} flags
Date:   Mon,  7 Jan 2019 16:27:18 +0000
Message-Id: <1546878450-20341-2-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update design.txt to reflect the presence of the exclude_host
and exclude_guest perf flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 tools/perf/design.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index a28dca2..0453ba2 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
 way to request that counting of events be restricted to times when the
 CPU is in user, kernel and/or hypervisor mode.
 
+Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
+to request counting of events restricted to guest and host contexts when
+using Linux as the hypervisor.
+
 The 'mmap' and 'munmap' bits allow recording of PROT_EXEC mmap/munmap
 operations, these can be used to relate userspace IP addresses to actual
 code, even after the mapping (or even the whole process) is gone,
-- 
2.7.4

