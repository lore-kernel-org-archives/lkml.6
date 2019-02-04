Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7858C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE362073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfBDUpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:45:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfBDUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:45:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14KjR1l565343
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 12:45:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14KjRYa565340;
        Mon, 4 Feb 2019 12:45:27 -0800
Date:   Mon, 4 Feb 2019 12:45:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-1c1522d32ac49065f88e5a8b3d6e3a5613b20118@git.kernel.org>
Cc:     tglx@linutronix.de, bp@suse.de, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, yazen.ghannam@amd.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: tony.luck@intel.com, linux-edac@vger.kernel.org, bp@suse.de,
          tglx@linutronix.de, mchehab@kernel.org,
          linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190201225534.8177-6-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-6-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Git-Commit-ID: 1c1522d32ac49065f88e5a8b3d6e3a5613b20118
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

Commit-ID:  1c1522d32ac49065f88e5a8b3d6e3a5613b20118
Gitweb:     https://git.kernel.org/tip/1c1522d32ac49065f88e5a8b3d6e3a5613b20118
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 1 Feb 2019 22:55:54 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 4 Feb 2019 19:29:13 +0100

EDAC, mce_amd: Print ExtErrorCode and description on a single line

Save a log line by printing the extended error code and the description
on a single line. This is similar to how errors are printed in other
subsystems, e.g. "#, description". If we don't have a valid description
then only the number/code is printed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190201225534.8177-6-Yazen.Ghannam@amd.com
---
 drivers/edac/mce_amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7e29ceabdf6f..f286b880f981 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -965,13 +965,12 @@ static void decode_smca_error(struct mce *m)
 
 	ip_name = smca_get_long_name(bank_type);
 
-	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
+	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
 
 	/* Only print the decode of valid error codes */
 	if (xec < smca_mce_descs[bank_type].num_descs &&
 			(hwid->xec_bitmap & BIT_ULL(xec))) {
-		pr_emerg(HW_ERR "%s Error: ", ip_name);
-		pr_cont("%s.\n", smca_mce_descs[bank_type].descs[xec]);
+		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 	}
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
