Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D13B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D13B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeGQQeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:34:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeGQQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:34:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6HG0oaJ1568359
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 09:00:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6HG0o4O1568356;
        Tue, 17 Jul 2018 09:00:50 -0700
Date:   Tue, 17 Jul 2018 09:00:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dewet Thibaut <tipbot@zytor.com>
Message-ID: <tip-fbdb328c6bae0a7c78d75734a738b66b86dffc96@git.kernel.org>
Cc:     thibaut.dewet@nokia.com, alexander.sverdlin@nokia.com,
        mingo@kernel.org, tony.luck@intel.com, linux-edac@vger.kernel.org,
        bp@suse.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tony.luck@intel.com,
          alexander.sverdlin@nokia.com, thibaut.dewet@nokia.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de,
          tglx@linutronix.de, linux-edac@vger.kernel.org
In-Reply-To: <20180716084927.24869-1-alexander.sverdlin@nokia.com>
References: <20180716084927.24869-1-alexander.sverdlin@nokia.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/MCE: Remove min interval polling limitation
Git-Commit-ID: fbdb328c6bae0a7c78d75734a738b66b86dffc96
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

Commit-ID:  fbdb328c6bae0a7c78d75734a738b66b86dffc96
Gitweb:     https://git.kernel.org/tip/fbdb328c6bae0a7c78d75734a738b66b86dffc96
Author:     Dewet Thibaut <thibaut.dewet@nokia.com>
AuthorDate: Mon, 16 Jul 2018 10:49:27 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Jul 2018 17:56:25 +0200

x86/MCE: Remove min interval polling limitation

commit b3b7c4795c ("x86/MCE: Serialize sysfs changes") introduced a min
interval limitation when setting the check interval for polled MCEs.
However, the logic is that 0 disables polling for corrected MCEs, see
Documentation/x86/x86_64/machinecheck. The limitation prevents disabling.

Remove this limitation and allow the value 0 to disable polling again.

Fixes: b3b7c4795c ("x86/MCE: Serialize sysfs changes")
Signed-off-by: Dewet Thibaut <thibaut.dewet@nokia.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180716084927.24869-1-alexander.sverdlin@nokia.com
---
 arch/x86/kernel/cpu/mcheck/mce.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c102ad51025e..8c50754c09c1 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2165,9 +2165,6 @@ static ssize_t store_int_with_restart(struct device *s,
 	if (check_interval == old_check_interval)
 		return ret;
 
-	if (check_interval < 1)
-		check_interval = 1;
-
 	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
 	mutex_unlock(&mce_sysfs_mutex);
