Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeDCLLl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:11:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755311AbeDCLLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:11:40 -0400
Date: Tue, 3 Apr 2018 04:10:59 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-9a3b7e5e65c4b4d332df5f607c0838c3fb918673@git.kernel.org>
Cc: hpa@zytor.com, kirill.shutemov@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, aryabinin@virtuozzo.com,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org
In-Reply-To: <20180402121025.10244-1-kirill.shutemov@linux.intel.com>
References: <20180402121025.10244-1-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Fix documentation of module mapping range
 with 4-level paging
Git-Commit-ID: 9a3b7e5e65c4b4d332df5f607c0838c3fb918673
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

Commit-ID:  9a3b7e5e65c4b4d332df5f607c0838c3fb918673
Gitweb:     https://git.kernel.org/tip/9a3b7e5e65c4b4d332df5f607c0838c3fb918673
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 2 Apr 2018 15:10:25 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Apr 2018 12:59:02 +0200

x86/mm: Fix documentation of module mapping range with 4-level paging

Commit:

  f5a40711fa58 ("x86/mm: Set MODULES_END to 0xffffffffff000000")

changed MODULES_END back to a fixed value, but didn't update the documentation
of memory layout for 4-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: f5a40711fa58 ("x86/mm: Set MODULES_END to 0xffffffffff000000")
Link: http://lkml.kernel.org/r/20180402121025.10244-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/mm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index ea91cb61a602..5432a96d31ff 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -20,7 +20,7 @@ ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
 ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
 ... unused hole ...
 ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
-ffffffffa0000000 - [fixmap start]   (~1526 MB) module mapping space (variable)
+ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
 [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
 ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
 ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole
