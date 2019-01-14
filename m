Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD8C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfANKWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:22:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfANKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:22:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0EALtHu2002819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Jan 2019 02:21:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0EALtvb2002816;
        Mon, 14 Jan 2019 02:21:55 -0800
Date:   Mon, 14 Jan 2019 02:21:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-b62928ff55290e47a7d546d427bf7b4ccf5ea944@git.kernel.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, bp@suse.de, tony.luck@intel.com, mingo@kernel.org,
        hch@lst.de
Reply-To: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tony.luck@intel.com, bp@suse.de, mingo@kernel.org,
          hch@lst.de
In-Reply-To: <20190110153645.40649-1-andriy.shevchenko@linux.intel.com>
References: <20190110153645.40649-1-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Switch to use the new generic UUID API
Git-Commit-ID: b62928ff55290e47a7d546d427bf7b4ccf5ea944
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

Commit-ID:  b62928ff55290e47a7d546d427bf7b4ccf5ea944
Gitweb:     https://git.kernel.org/tip/b62928ff55290e47a7d546d427bf7b4ccf5ea944
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 10 Jan 2019 17:36:45 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 14 Jan 2019 11:16:55 +0100

x86/MCE: Switch to use the new generic UUID API

Switch the code to use the new, generic helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190110153645.40649-1-andriy.shevchenko@linux.intel.com
---
 arch/x86/kernel/cpu/mce/apei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 1d9b3ce662a0..c038e5c00a59 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -64,11 +64,11 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 #define CPER_CREATOR_MCE						\
-	UUID_LE(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		0x64, 0x90, 0xb8, 0x9d)
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
 #define CPER_SECTION_TYPE_MCE						\
-	UUID_LE(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		0x04, 0x4a, 0x38, 0xfc)
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
 
 /*
  * CPER specification (in UEFI specification 2.3 appendix N) requires
@@ -135,7 +135,7 @@ retry:
 		goto out;
 	/* try to skip other type records in storage */
 	else if (rc != sizeof(rcd) ||
-		 uuid_le_cmp(rcd.hdr.creator_id, CPER_CREATOR_MCE))
+		 !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE))
 		goto retry;
 	memcpy(m, &rcd.mce, sizeof(*m));
 	rc = sizeof(*m);
