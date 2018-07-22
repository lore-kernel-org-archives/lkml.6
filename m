Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7D2C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8820874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C8820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeGVQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:20:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeGVQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:20:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFNDif3458520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:23:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFNDRj3458517;
        Sun, 22 Jul 2018 08:23:13 -0700
Date:   Sun, 22 Jul 2018 08:23:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-e8f4194d9b98aa13f9f567a0056bbf683d2b1ab8@git.kernel.org>
Cc:     peterz@infradead.org, andriy.shevchenko@linux.intel.com,
        tbaicar@codeaurora.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        hpa@zytor.com, lukas@wunner.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          andriy.shevchenko@linux.intel.com, tbaicar@codeaurora.org,
          hdegoede@redhat.com, mingo@kernel.org, ard.biesheuvel@linaro.org,
          hpa@zytor.com, tglx@linutronix.de, lukas@wunner.de,
          torvalds@linux-foundation.org
In-Reply-To: <20180720014726.24031-9-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-9-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/cper: Use consistent types for UUIDs
Git-Commit-ID: e8f4194d9b98aa13f9f567a0056bbf683d2b1ab8
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

Commit-ID:  e8f4194d9b98aa13f9f567a0056bbf683d2b1ab8
Gitweb:     https://git.kernel.org/tip/e8f4194d9b98aa13f9f567a0056bbf683d2b1ab8
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 20 Jul 2018 10:47:25 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:43 +0200

efi/cper: Use consistent types for UUIDs

The commit:

  2f74f09bce4f ("efi: parse ARM processor error")

... brought inconsistency in UUID types which are used across the CPER.

Fix this by moving to use guid_t API everywhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-9-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b73fc4cab083..a7902fccdcfa 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -472,7 +472,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 #if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
-	} else if (!uuid_le_cmp(*sec_type, CPER_SEC_PROC_ARM)) {
+	} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 		struct cper_sec_proc_arm *arm_err = acpi_hest_get_payload(gdata);
 
 		printk("%ssection_type: ARM processor error\n", newpfx);
