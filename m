Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224eHPzAX2cqcFHgES+ULZzf02f2UlbVvnF4GKE6IezXO1XCFskS2b4B/74aqDOFhdNQ53AB
ARC-Seal: i=1; a=rsa-sha256; t=1519218107; cv=none;
        d=google.com; s=arc-20160816;
        b=LK0fjlrNqwaMu7rftOOQpPwpDhrmgmxIftWUvIlfARMv5Bxq1ilMfYnvVUIzS6wGMf
         VnsYCRoLvCXpfLO/vSqRKfF/Zcq35CF7lygW7GsjbvJxlyaUYCRZUn1MLiWm7CK4FAKA
         EacDhlE52lxPUz3U4vKGXSLnAtRbt0zLkwfJVmuJpiQpnD7hasWDB3zXnun8MYCv6i5z
         L5+J6/3Lf7OgyalcNo9oid6g4i8GjnDD1ko9QM+GN6KVXRVGjoUj4qtY+7a4UH5Or+eT
         q45Ru7aMB9MIj7kzgTQPFWb2ItEag/5YQ0K8QjyhadhU1/jWml52GgTNOWCyee5Hxnvj
         Zp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pHeEfihvlXdXa7eJyR3mWoxt/CK1XrHSzf1gQqeYuz4=;
        b=iXz0jMlTaKQAYNW1WIcLyY1ctrjpu5FHKlMSRtTGnQW8s8Hrau+6R+yxi202Xbu5re
         hBrUt48nrwWDh/Xj/4BWseX5wxlkgMD57iUij0WH9ohKocCDwY36jYzgDdepyC6+OgCb
         WlylxYsMw7PY96B5z/Go8/mdGA2AjqeryvTJGUoRKBqlwMMmZfuc1MRpI60Yb9qCRD7I
         EZSkTqCgy4YP5WU7CjsDqtksxQyU/syL7x3Mg+4vtBz7gWKgaVZearOL+U18dL4XY7p4
         Ds4kFJYXZZrAp+fsM2ALVxwy/JSaM2Mosp2k5cQpPg0kMnVxVIWXf1pd0kQD4gLwYV/A
         dU6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 083/167] kmemcheck: rip it out for real
Date: Wed, 21 Feb 2018 13:48:14 +0100
Message-Id: <20180221124528.967682943@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015646345734238?=
X-GMAIL-MSGID: =?utf-8?q?1593015646345734238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit f335195adf043168ee69d78ea72ac3e30f0c57ce upstream.

Commit 4675ff05de2d ("kmemcheck: rip it out") has removed the code but
for some reason SPDX header stayed in place.  This looks like a rebase
mistake in the mmotm tree or the merge mistake.  Let's drop those
leftovers as well.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kmemcheck.h |    1 -
 arch/x86/mm/kmemcheck/error.c    |    1 -
 arch/x86/mm/kmemcheck/error.h    |    1 -
 arch/x86/mm/kmemcheck/opcode.c   |    1 -
 arch/x86/mm/kmemcheck/opcode.h   |    1 -
 arch/x86/mm/kmemcheck/pte.c      |    1 -
 arch/x86/mm/kmemcheck/pte.h      |    1 -
 arch/x86/mm/kmemcheck/selftest.c |    1 -
 arch/x86/mm/kmemcheck/selftest.h |    1 -
 arch/x86/mm/kmemcheck/shadow.h   |    1 -
 include/linux/kmemcheck.h        |    1 -
 mm/kmemcheck.c                   |    1 -
 tools/include/linux/kmemcheck.h  |    1 -
 13 files changed, 13 deletions(-)

--- a/arch/x86/include/asm/kmemcheck.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/arch/x86/mm/kmemcheck/error.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
--- a/arch/x86/mm/kmemcheck/error.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/arch/x86/mm/kmemcheck/opcode.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
--- a/arch/x86/mm/kmemcheck/opcode.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/arch/x86/mm/kmemcheck/pte.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
--- a/arch/x86/mm/kmemcheck/pte.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/arch/x86/mm/kmemcheck/selftest.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
--- a/arch/x86/mm/kmemcheck/selftest.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/arch/x86/mm/kmemcheck/shadow.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/include/linux/kmemcheck.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
--- a/mm/kmemcheck.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
--- a/tools/include/linux/kmemcheck.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
