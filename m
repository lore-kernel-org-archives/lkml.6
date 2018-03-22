Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AG47ELvb8fD5ZfQFEbcu/gEwbOUA9NWQHKIxbUoaJpkJFC2ZIS/OsnFsMZUPcEwTQ92kDnLKqSMx
ARC-Seal: i=1; a=rsa-sha256; t=1521712464; cv=none;
        d=google.com; s=arc-20160816;
        b=V5mgrp1twwIyny97cY/II1w3WF4E13l8UNcMvBhDO5iHbvnke/+f8WLMrlEV+lyoAm
         yypJlIisvF71WrrdjsSsxhbpVAU1Y2PRUCW1Jmfidz5MCXHm2lbMq9NhuipxtSPtHW6E
         Ua4tTbM5/pPhfv4fULdAZu2dRg2mnW7P/UWmg/Fq+8nIeUbEz5nTzRraLqqSon3hGbMx
         ICQirSnj1v4as77RZY5DQR8a8v6rF2q8yBt4ehVZaaMsXbKwVXQwgEE3rO/2BWrQPPWk
         4L6ZoNP4YZ2wIwMqGedD3zZNu1MCGH43SN3NfR/QypIC3IYEwtGBuM5oLCxur2mLkVlm
         GVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rnuO5eskbMtR4XM/JO8VheYoDeQ5j6RDRKaWcoZeOhY=;
        b=DGKUPnWmMrlXmnzL53EMTGY0ZZWjUY1HB5kT2EILJ4yoBF/Pls+IzOlNMOibGnO2gw
         3nYsHp/aKTBTJWj7qhsmL9r+vnzwcgdm0YfVFbfQHDw/Gkshl6SFNRQqLUx1QWeZSRy0
         YykhqfkgxQ9NjjORXBFZIC3cNvhgyw4sEJ3Hmlywa7ExB6Tm6m6y7mKM7y7bdXWhlDxr
         jrWM6eSLt7Ejwo52dFsksO0bfj3ZIFN1HwbxI+4myWFpQ+ItGMV+lG3zAMW6cJPcOykK
         JqhfuWUurzh+il28vXosUSYBIWMPKRCjUX6AbrsLVe3obyI2Cv6itG3Vbkt8rA5Vaw4s
         wZsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-doc <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonas Oberg <jonas@fsfe.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 1/2] COPYING: create a new file with points to the Kernel license files
Date: Thu, 22 Mar 2018 06:54:13 -0300
Message-Id: <20180322095414.24019-2-mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322095414.24019-1-mchehab@s-opensource.com>
References: <20180322095414.24019-1-mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595631169729056837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the addition of SPDX patchset, the contents of COPYING file
is now duplicated at two other files under LICENSE:
	LICENSES/preferred/GPL-2.0
	LICENSES/exceptions/Linux-syscall-note

It is easy to check that the contents of the licence written on
those files are identical with COPYING using:

	$ diff -upr COPYING LICENSES/preferred/GPL-2.0
	$ diff -upr COPYING LICENSES/exceptions/Linux-syscall-note|less

Also, a new file was added, with describes how SPDX should work at
the Kernel source files:
	Documentation/process/license-rules.rst

Instead fo having it copying the contents of two files, and not
even mentioning the third one, replace it by a file whose content
points to the other tree files, preserving the Kernel's license.

Adjust license-rules.rst accordingly.

Please notice that this file preserves the Kernel license as
is, without any changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 COPYING.new                             | 18 ++++++++++++++++++
 Documentation/process/license-rules.rst | 20 +++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)
 create mode 100644 COPYING.new

diff --git a/COPYING.new b/COPYING.new
new file mode 100644
index 000000000000..da4cb28febe6
--- /dev/null
+++ b/COPYING.new
@@ -0,0 +1,18 @@
+The Linux Kernel is provided under:
+
+	SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+
+Being under the terms of the GNU General Public License version 2 only,
+according with:
+
+	LICENSES/preferred/GPL-2.0
+
+With an explicit syscall exception, as stated at:
+
+	LICENSES/exceptions/Linux-syscall-note
+
+In addition, other licenses may also apply. Please see:
+
+	Documentation/process/license-rules.rst
+
+for more details.
diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 408f77dc6157..bba178e68a0c 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -4,15 +4,17 @@ Linux kernel licensing rules
 ============================
 
 The Linux Kernel is provided under the terms of the GNU General Public
-License version 2 only (GPL-2.0), as published by the Free Software
-Foundation, and provided in the COPYING file.  This documentation file is
-not meant to replace the COPYING file, but provides a description of how
-each source file should be annotated to make the licensing it is governed
-under clear and unambiguous.
-
-The license in the COPYING file applies to the kernel source as a whole,
-though individual source files can have a different license which is
-required to be compatible with the GPL-2.0::
+version 2 only (GPL-2.0), as written at LICENSES/preferred/GPL-2.0,
+with an explicit syscall exception described at
+LICENSES/exceptions/Linux-syscall-note, as described in the COPYING file.
+
+This documentation file is not meant to replace the Kernel's license,
+but provides a description of how each source file should be annotated
+to make the licensing it is governed under clear and unambiguous.
+
+The license described in the COPYING file applies to the kernel source
+as a whole, though individual source files can have a different license
+which is required to be compatible with the GPL-2.0::
 
     GPL-1.0+  :  GNU General Public License v1.0 or later
     GPL-2.0+  :  GNU General Public License v2.0 or later
-- 
2.14.3
