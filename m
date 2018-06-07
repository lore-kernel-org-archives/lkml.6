Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Kxb2J84aGVtvZgAAmS7hNA
	; Thu, 07 Jun 2018 11:45:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9561F608BF; Thu,  7 Jun 2018 11:45:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2E76C607E7;
	Thu,  7 Jun 2018 11:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E76C607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeFGLpQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:45:16 -0400
Received: from mx56.baidu.com ([61.135.168.56]:27378 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753229AbeFGLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:45:15 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 07:45:13 EDT
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id BB8BF11C0049;
        Thu,  7 Jun 2018 19:35:02 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/acpi: fix the comments in acpi_parse_lapic
Date: Thu,  7 Jun 2018 19:35:02 +0800
Message-Id: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be permit to preallocate memory for all NR_CPUS

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..8ae88605a5eb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -223,7 +223,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
-	 * to not preallocating memory for all NR_CPUS
+	 * to preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
 	if (!apic->apic_id_valid(apic_id)) {
@@ -260,7 +260,7 @@ acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
-	 * to not preallocating memory for all NR_CPUS
+	 * to preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
 	acpi_register_lapic(processor->id,	/* APIC ID */
-- 
2.16.2
