Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FEC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A1D20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A1D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeGVQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:21:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeGVQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:21:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFNkO43458548
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:23:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFNkXI3458545;
        Sun, 22 Jul 2018 08:23:46 -0700
Date:   Sun, 22 Jul 2018 08:23:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-c4326563d9abe86ad54474f9e9142bd2663eede5@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de, tglx@linutronix.de,
        hdegoede@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, andriy.shevchenko@linux.intel.com
Reply-To: hpa@zytor.com, peterz@infradead.org,
          andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org,
          hdegoede@redhat.com, tglx@linutronix.de, lukas@wunner.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org
In-Reply-To: <20180720014726.24031-10-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-10-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efivars: Call guid_parse() against guid_t type of
 variable
Git-Commit-ID: c4326563d9abe86ad54474f9e9142bd2663eede5
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

Commit-ID:  c4326563d9abe86ad54474f9e9142bd2663eede5
Gitweb:     https://git.kernel.org/tip/c4326563d9abe86ad54474f9e9142bd2663eede5
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 20 Jul 2018 10:47:26 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:44 +0200

efivars: Call guid_parse() against guid_t type of variable

uuid_le_to_bin() is deprecated API and take into consideration that variable,
to where we store parsed data, is type of guid_t we switch to guid_parse()
for sake of consistency.

While here, add error checking to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-10-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/efivarfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 71fccccf317e..8c6ab6c95727 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -86,7 +86,9 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 	/* length of the variable name itself: remove GUID and separator */
 	namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;
 
-	uuid_le_to_bin(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
+	err = guid_parse(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
+	if (err)
+		goto out;
 
 	if (efivar_variable_is_removable(var->var.VendorGuid,
 					 dentry->d_name.name, namelen))
