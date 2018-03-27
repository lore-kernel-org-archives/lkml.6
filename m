Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeC0Jza (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:55:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0Jz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:55:28 -0400
Date: Tue, 27 Mar 2018 02:55:12 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-547edaca247abf910e32f0cd883ba83b8fc6d0ed@git.kernel.org>
Cc: tglx@linutronix.de, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        kai.huang@linux.intel.com, mingo@kernel.org, thomas.lendacky@amd.com,
        hpa@zytor.com
Reply-To: dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, kai.huang@linux.intel.com,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        thomas.lendacky@amd.com
In-Reply-To: <20180315134907.9311-2-kirill.shutemov@linux.intel.com>
References: <20180315134907.9311-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Update comment in detect_tme() regarding
 x86_phys_bits
Git-Commit-ID: 547edaca247abf910e32f0cd883ba83b8fc6d0ed
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

Commit-ID:  547edaca247abf910e32f0cd883ba83b8fc6d0ed
Gitweb:     https://git.kernel.org/tip/547edaca247abf910e32f0cd883ba83b8fc6d0ed
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Thu, 15 Mar 2018 16:49:06 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 27 Mar 2018 11:49:58 +0200

x86/mm: Update comment in detect_tme() regarding x86_phys_bits

As Kai pointed out, the primary reason for adjusting x86_phys_bits is to
reflect that the the address space is reduced and not the ability to
communicate the available physical address space to virtual machines.

Suggested-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org
Link: https://lkml.kernel.org/r/20180315134907.9311-2-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/cpu/intel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3f8d7a3b6447..6106d11ceb6b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -587,11 +587,8 @@ detect_keyid_bits:
 	}
 
 	/*
-	 * Exclude KeyID bits from physical address bits.
-	 *
-	 * We have to do this even if we are not going to use KeyID bits
-	 * ourself. VM guests still have to know that these bits are not usable
-	 * for physical address.
+	 * KeyID bits effectively lower the number of physical address
+	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
 	 */
 	c->x86_phys_bits -= keyid_bits;
 }
