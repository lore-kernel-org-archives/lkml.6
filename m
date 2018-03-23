Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AG47ELsdALz8o4p8m2b8MccbJDg4+nG3/kbVgCMcPEgVG5AZn+C8/F+iXx4UtS73b+UJvgxRCzy5
ARC-Seal: i=1; a=rsa-sha256; t=1521798689; cv=none;
        d=google.com; s=arc-20160816;
        b=BKjHd7l+UXjLT3ABmD1DlEimfFv9Ii2oXVUds6G7bcnHnVto1jrzXiMwBa80DVL06b
         kTEXHh14BHW+8siBim5UMfL9zGPkV1JkdKZ5H9n98rjWkv56Qb2Ub6xYsqY5b0lmWjBl
         rQymsZG9supL2T+HRdYSb0lSVB3lGeUhaFKSfGf8+Li69p2UPQx80lV3qLDM3a/Q27/t
         HjVuMeaZoClwRg29NFeVMj5S+jdP7ZXE8mb0wy2Jq9HR1Cpl7n0hR9gDYZCwgFCULI2p
         51HhL+ZYL55YS1ag4XhIzHm0rE8fsQ4ELsMQkEKyibb/2l0YiZm6r62Q+wuSruf4gPGH
         i7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=STfMMiqwn1HhMHf68FvU0dwGweRxw6EGxHlesjrY7wk=;
        b=d1NNrfNp+hJVVBpGVbwXXJy/5W5Eo4PT1RYhNsIzGCvOvtip/GimVxAENNz1AP5wFe
         BXMGmi52P4gSnlhn3g8GMf5Iyn9MWYEcWBaazi3Z7z5GSsuXR7s3rONCLkoSMhC4d7Sg
         IfpV9ybd+y6wqiGv7D8OXmkT+2h9yKWx3dE6VI8s8/U31/0DCnCN5Vi5ZCEsJ8LGmpwl
         JUIBRaN/+nP/Xj6nAQ2htvYOAe/lYFcxsVBu1Mq83TYIfItkPaawtm0rvDVFwf/Tyjpb
         2R/F3sk+sj8b+kzca7eXnN9VSF4CNKQGCIc5VbMyWO7TwFzz2BYVfxZveYGUNZsV0kzt
         uNdA==
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
	Kate Stewart <kstewart@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/2] COPYING: create a new file with points to the Kernel license files
Date: Fri, 23 Mar 2018 06:51:05 -0300
Message-Id: <20180323095106.23108-2-mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180323095106.23108-1-mchehab@s-opensource.com>
References: <20180323095106.23108-1-mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595721582641062506?=
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

Version 2:
   - Did some text changes at license-rules.rst, based on Matthew
     Wilcox review.

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
index 408f77dc6157..8ea26325fe3f 100644
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
+License version 2 only (GPL-2.0), as provided in LICENSES/preferred/GPL-2.0,
+with an explicit syscall exception described in
+LICENSES/exceptions/Linux-syscall-note, as described in the COPYING file.
+
+This documentation file provides a description of how each source file
+should be annotated to make its license clear and unambiguous.
+It doesn't replace the Kernel's license.
+
+The license described in the COPYING file applies to the kernel source
+as a whole, though individual source files can have a different license
+which is required to be compatible with the GPL-2.0::
 
     GPL-1.0+  :  GNU General Public License v1.0 or later
     GPL-2.0+  :  GNU General Public License v2.0 or later
-- 
2.14.3
