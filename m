Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65253C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C4F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C4F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK3VG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:06:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:06:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9ustC3261293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:56:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9usX33261290;
        Fri, 30 Nov 2018 01:56:54 -0800
Date:   Fri, 30 Nov 2018 01:56:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Julien Thierry <tipbot@zytor.com>
Message-ID: <tip-6935b3c43da96bb48017b2a3bc1d4f93899f9b28@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@kernel.org,
        bhsharma@redhat.com, dave.hansen@intel.com, zhuyifei1999@gmail.com,
        arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, marc.zyngier@arm.com, luto@kernel.org,
        hdegoede@redhat.com, matt@codeblueprint.co.uk, bp@alien8.de,
        sai.praneeth.prakhya@intel.com, peterz@infradead.org,
        joe@perches.com, torvalds@linux-foundation.org,
        jonathanh@nvidia.com, sedat.dilek@gmail.com,
        julien.thierry@arm.com, tglx@linutronix.de,
        eric.snowberg@oracle.com
Reply-To: mingo@kernel.org, dave.hansen@intel.com, bhsharma@redhat.com,
          hpa@zytor.com, ard.biesheuvel@linaro.org,
          matt@codeblueprint.co.uk, hdegoede@redhat.com, luto@kernel.org,
          natechancellor@gmail.com, linux-kernel@vger.kernel.org,
          arend.vanspriel@broadcom.com, zhuyifei1999@gmail.com,
          marc.zyngier@arm.com, jonathanh@nvidia.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          bp@alien8.de, sai.praneeth.prakhya@intel.com, joe@perches.com,
          julien.thierry@arm.com, eric.snowberg@oracle.com,
          tglx@linutronix.de, sedat.dilek@gmail.com
In-Reply-To: <20181129171230.18699-3-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/fdt: Indentation fix
Git-Commit-ID: 6935b3c43da96bb48017b2a3bc1d4f93899f9b28
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

Commit-ID:  6935b3c43da96bb48017b2a3bc1d4f93899f9b28
Gitweb:     https://git.kernel.org/tip/6935b3c43da96bb48017b2a3bc1d4f93899f9b28
Author:     Julien Thierry <julien.thierry@arm.com>
AuthorDate: Thu, 29 Nov 2018 18:12:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:29 +0100

efi/fdt: Indentation fix

Closing bracket seems to end a for statement when it is actually ending
the contained if. Add some brackets to have clear delimitation of each
scope.

No functional change/fix, just fix the indentation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0c0d2312f4a8..a3614f9b5f75 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -376,7 +376,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 	tables = (efi_config_table_t *) sys_table->tables;
 	fdt = NULL;
 
-	for (i = 0; i < sys_table->nr_tables; i++)
+	for (i = 0; i < sys_table->nr_tables; i++) {
 		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
 			fdt = (void *) tables[i].table;
 			if (fdt_check_header(fdt) != 0) {
@@ -385,7 +385,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 			}
 			*fdt_size = fdt_totalsize(fdt);
 			break;
-	 }
+		}
+	}
 
 	return fdt;
 }
