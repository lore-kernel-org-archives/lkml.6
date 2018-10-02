Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80259C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439CC20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439CC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeJBMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:55:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJBMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:55:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w926CphI1858062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 23:12:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w926CpUi1858059;
        Mon, 1 Oct 2018 23:12:51 -0700
Date:   Mon, 1 Oct 2018 23:12:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-57d15877033e44e9ac283b8c6e82cc67bf6a0aa6@git.kernel.org>
Cc:     hpa@zytor.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jeyu@kernel.org, schwidefsky@de.ibm.com, mingo@kernel.org,
        peterz@infradead.org, linux@roeck-us.net
Reply-To: heiko.carstens@de.ibm.com, hpa@zytor.com,
          ard.biesheuvel@linaro.org, tglx@linutronix.de,
          schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
          jeyu@kernel.org, keescook@chromium.org, peterz@infradead.org,
          mingo@kernel.org, linux@roeck-us.net
In-Reply-To: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] s390/vmlinux.lds: Move JUMP_TABLE_DATA into output
 section
Git-Commit-ID: 57d15877033e44e9ac283b8c6e82cc67bf6a0aa6
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

Commit-ID:  57d15877033e44e9ac283b8c6e82cc67bf6a0aa6
Gitweb:     https://git.kernel.org/tip/57d15877033e44e9ac283b8c6e82cc67bf6a0aa6
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sun, 30 Sep 2018 18:49:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 08:08:08 +0200

s390/vmlinux.lds: Move JUMP_TABLE_DATA into output section

Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
region") moved the __jump_table input section into the __ro_after_init
output section, but inadvertently put the macro in the wrong place in
the s390 linker script. Let's fix that.

Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20180930164950.3841-1-ard.biesheuvel@linaro.org

---
 arch/s390/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 4042bbf3f9ad..457713f48734 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -64,9 +64,9 @@ SECTIONS
 	__start_ro_after_init = .;
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
+		JUMP_TABLE_DATA
 	}
 	EXCEPTION_TABLE(16)
-	JUMP_TABLE_DATA
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
