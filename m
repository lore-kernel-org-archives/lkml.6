Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF16C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616E3206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616E3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJBRCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:02:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46811 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:02:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AJCEv1917753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:19:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AJCH41917750;
        Tue, 2 Oct 2018 03:19:12 -0700
Date:   Tue, 2 Oct 2018 03:19:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Message-ID: <tip-2d580c160ada91049fc24b244ed74d8775bd1c96@git.kernel.org>
Cc:     msys.mizuma@gmail.com, corbet@lwn.net, mingo@kernel.org,
        bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
        hpa@zytor.com, bhe@redhat.com, m.mizuma@jp.fujitsu.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: m.mizuma@jp.fujitsu.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, bhe@redhat.com,
          torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
          msys.mizuma@gmail.com, corbet@lwn.net, mingo@kernel.org
In-Reply-To: <20181001140843.26137-4-msys.mizuma@gmail.com>
References: <20181001140843.26137-4-msys.mizuma@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] Documentation/kernel-parameters.txt: Document
 rand_mem_physical_padding=
Git-Commit-ID: 2d580c160ada91049fc24b244ed74d8775bd1c96
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

Commit-ID:  2d580c160ada91049fc24b244ed74d8775bd1c96
Gitweb:     https://git.kernel.org/tip/2d580c160ada91049fc24b244ed74d8775bd1c96
Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
AuthorDate: Mon, 1 Oct 2018 10:08:43 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 11:47:22 +0200

Documentation/kernel-parameters.txt: Document rand_mem_physical_padding=

This kernel parameter allows the modification of the padding used
for the physical memory mapping section when KASLR memory is enabled.

For memory hotplug capable systems, the default padding size,
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, may not be enough.

The option is useful to adjust the padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181001140843.26137-4-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf54b974..45f614cd2a61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3529,6 +3529,24 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR is enabled.
+			If the padding size is not enough, you can see
+			'Set rand_mem_physical_padding=XX ...' in system
+			boot message, so set the parameter as the message suggests.
+
+			This parameter is useful for memory hot-add capable
+			systems. Such systems may have more space than
+			actual memory size to hot-add memory. If the
+			padding size is not enough and memory is hot-added,
+			the hot-adding will fail because it destroys the
+			system memory map. So, the padding size needs to be
+			adjusted in such a system.
+			The default value is the value of
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
