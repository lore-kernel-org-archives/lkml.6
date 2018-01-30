Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeA3Wjj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:39:39 -0500
Received: from terminus.zytor.com ([65.50.211.136]:53545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeA3Wjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:39:37 -0500
Date: Tue, 30 Jan 2018 14:38:29 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-edfbae53dab8348fca778531be9f4855d2ca0360@git.kernel.org>
Cc: jslaby@suse.cz, dan.j.williams@intel.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, dan.j.williams@intel.com, jslaby@suse.cz,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre: Report get_user mitigation for
 spectre_v1
Git-Commit-ID: edfbae53dab8348fca778531be9f4855d2ca0360
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  edfbae53dab8348fca778531be9f4855d2ca0360
Gitweb:     https://git.kernel.org/tip/edfbae53dab8348fca778531be9f4855d2ca0360
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:03:21 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:32 +0100

x86/spectre: Report get_user mitigation for spectre_v1

Reflect the presence of get_user(), __get_user(), and 'syscall' protections
in sysfs. The expectation is that new and better tooling will allow the
kernel to grow more usages of array_index_nospec(), for now, only claim
mitigation for __user pointer de-references.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 400c34e..fdb6068 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -297,7 +297,7 @@ ssize_t cpu_show_spectre_v1(struct device *dev,
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev,
