Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F982C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8D02147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8D02147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeHPV0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:26:14 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:44617 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbeHPV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:26:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 64F05837F242;
        Thu, 16 Aug 2018 18:26:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nest27_8c9423c30c95f
X-Filterd-Recvd-Size: 12627
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Aug 2018 18:26:05 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] license-rules.rst and LICENSES: Use only spdx version 3 with -only and -or-later
Date:   Thu, 16 Aug 2018 11:26:03 -0700
Message-Id: <f9a4cd2b1c1cd7938a4e0b8aa9489a0ad96669ca.1534443693.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current linux-kernel source git tree has a mixture of the deprecated
spdx version 2 and the newer version 3 uses.

Update the process/license-rules.rst file to show only the version 3 style
and use only the version 3 styles in LICENSES.

Add a script to update all old versions in the tree as well.

I suggest this be applied and the script be run and applied immediately
after an -rc1.  The script could also be used at any time after the initial
use to update any other deprecated spdx license uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/license-rules.rst | 60 ++++++++++++++++-----------------
 LICENSES/preferred/GPL-2.0              |  6 ----
 LICENSES/preferred/LGPL-2.0             |  8 ++---
 LICENSES/preferred/LGPL-2.1             |  8 ++---
 scripts/update_spdx_v2_licenses.sh      | 15 +++++++++
 5 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100755 scripts/update_spdx_v2_licenses.sh

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 8ea26325fe3f..2b294611b6c1 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -16,12 +16,12 @@ The license described in the COPYING file applies to the kernel source
 as a whole, though individual source files can have a different license
 which is required to be compatible with the GPL-2.0::
 
-    GPL-1.0+  :  GNU General Public License v1.0 or later
-    GPL-2.0+  :  GNU General Public License v2.0 or later
-    LGPL-2.0  :  GNU Library General Public License v2 only
-    LGPL-2.0+ :  GNU Library General Public License v2 or later
-    LGPL-2.1  :  GNU Lesser General Public License v2.1 only
-    LGPL-2.1+ :  GNU Lesser General Public License v2.1 or later
+    GPL-1.0-or-later  :  GNU General Public License v1.0 or later
+    GPL-2.0-or-later  :  GNU General Public License v2.0 or later
+    LGPL-2.0-only     :  GNU Library General Public License v2 only
+    LGPL-2.0-or-later :  GNU Library General Public License v2 or later
+    LGPL-2.1-only     :  GNU Lesser General Public License v2.1 only
+    LGPL-2.1-or-later :  GNU Lesser General Public License v2.1 or later
 
 Aside from that, individual files can be provided under a dual license,
 e.g. one of the compatible GPL variants and alternatively under a
@@ -98,21 +98,21 @@ License identifier syntax
    "(", ")" .
 
    License identifiers for licenses like [L]GPL with the 'or later' option
-   are constructed by using a "+" for indicating the 'or later' option.::
+   are constructed by using the '-or-later' option.::
 
-      // SPDX-License-Identifier: GPL-2.0+
-      // SPDX-License-Identifier: LGPL-2.1+
+      // SPDX-License-Identifier: GPL-2.0-or-later
+      // SPDX-License-Identifier: LGPL-2.1-or-later
 
    WITH should be used when there is a modifier to a license needed.
    For example, the linux kernel UAPI files use the expression::
 
-      // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note
 
    Other examples using WITH exceptions found in the kernel are::
 
-      // SPDX-License-Identifier: GPL-2.0 WITH mif-exception
-      // SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+      // SPDX-License-Identifier: GPL-2.0-only WITH mif-exception
+      // SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0
 
    Exceptions can only be used with particular License identifiers. The
    valid License identifiers are listed in the tags of the exception text
@@ -123,28 +123,28 @@ License identifier syntax
    to be selected.  For example, some dtsi files are available under dual
    licenses::
 
-      // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+      // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
    Examples from the kernel for license expressions in dual licensed files::
 
-      // SPDX-License-Identifier: GPL-2.0 OR MIT
-      // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-      // SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
-      // SPDX-License-Identifier: GPL-2.0 OR MPL-1.1
-      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT
-      // SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause OR OpenSSL
+      // SPDX-License-Identifier: GPL-2.0-only OR MIT
+      // SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+      // SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0
+      // SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
+      // SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) OR MIT
+      // SPDX-License-Identifier: GPL-1.0-or-later OR BSD-3-Clause OR OpenSSL
 
    AND should be used if the file has multiple licenses whose terms all
    apply to use the file. For example, if code is inherited from another
    project and permission has been given to put it in the kernel, but the
    original license terms need to remain in effect::
 
-      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) AND MIT
+      // SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) AND MIT
 
    Another other example where both sets of license terms need to be
    adhered to is::
 
-      // SPDX-License-Identifier: GPL-1.0+ AND LGPL-2.1+
+      // SPDX-License-Identifier: GPL-1.0-or-later AND LGPL-2.1-or-later
 
 License identifiers
 -------------------
@@ -168,7 +168,7 @@ kernel, can be broken down into:
 
    Examples::
 
-      LICENSES/preferred/GPL-2.0
+      LICENSES/preferred/GPL-2.0-only
 
    Contains the GPL version 2 license text and the required metatags::
 
@@ -204,17 +204,17 @@ kernel, can be broken down into:
 
    File format examples::
 
-      Valid-License-Identifier: GPL-2.0
-      Valid-License-Identifier: GPL-2.0+
-      SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+      Valid-License-Identifier: GPL-2.0-only
+      Valid-License-Identifier: GPL-2.0-or-later
+      SPDX-URL: https://spdx.org/licenses/GPL-2.0-only.html
       Usage-Guide:
         To use this license in source code, put one of the following SPDX
 	tag/value pairs into a comment according to the placement
 	guidelines in the licensing rules documentation.
 	For 'GNU General Public License (GPL) version 2 only' use:
-	  SPDX-License-Identifier: GPL-2.0
+	  SPDX-License-Identifier: GPL-2.0-only
 	For 'GNU General Public License (GPL) version 2 or any later version' use:
-	  SPDX-License-Identifier: GPL-2.0+
+	  SPDX-License-Identifier: GPL-2.0-or-later
       License-Text:
         Full license text
 
@@ -338,7 +338,7 @@ kernel, can be broken down into:
 
       SPDX-Exception-Identifier: Linux-syscall-note
       SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-      SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+      SPDX-Licenses: GPL-2.0-only, GPL-2.0-or-later, GPL-1.0-or-later, LGPL-2.0-only, LGPL-2.0-or-later, LGPL-2.1-only, LGPL-2.1-or-later
       Usage-Guidance:
         This exception is used together with one of the above SPDX-Licenses
 	to mark user-space API (uapi) header files so they can be included
@@ -353,7 +353,7 @@ kernel, can be broken down into:
 
       SPDX-Exception-Identifier: GCC-exception-2.0
       SPDX-URL: https://spdx.org/licenses/GCC-exception-2.0.html
-      SPDX-Licenses: GPL-2.0, GPL-2.0+
+      SPDX-Licenses: GPL-2.0-only, GPL-2.0-or-later
       Usage-Guidance:
         The "GCC Runtime Library exception 2.0" is used together with one
 	of the above SPDX-Licenses for code imported from the GCC runtime
diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
index ff0812fd89cc..cabbb1779d45 100644
--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,6 +1,4 @@
-Valid-License-Identifier: GPL-2.0
 Valid-License-Identifier: GPL-2.0-only
-Valid-License-Identifier: GPL-2.0+
 Valid-License-Identifier: GPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
 Usage-Guide:
@@ -8,12 +6,8 @@ Usage-Guide:
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
-    SPDX-License-Identifier: GPL-2.0
-  or
     SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
-    SPDX-License-Identifier: GPL-2.0+
-  or
     SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
diff --git a/LICENSES/preferred/LGPL-2.0 b/LICENSES/preferred/LGPL-2.0
index 957d798fe037..443c5569c4f5 100644
--- a/LICENSES/preferred/LGPL-2.0
+++ b/LICENSES/preferred/LGPL-2.0
@@ -1,15 +1,15 @@
-Valid-License-Identifier: LGPL-2.0
-Valid-License-Identifier: LGPL-2.0+
+Valid-License-Identifier: LGPL-2.0-only
+Valid-License-Identifier: LGPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/LGPL-2.0.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU Library General Public License (LGPL) version 2.0 only' use:
-    SPDX-License-Identifier: LGPL-2.0
+    SPDX-License-Identifier: LGPL-2.0-only
   For 'GNU Library General Public License (LGPL) version 2.0 or any later
   version' use:
-    SPDX-License-Identifier: LGPL-2.0+
+    SPDX-License-Identifier: LGPL-2.0-or-later
 License-Text:
 
 GNU LIBRARY GENERAL PUBLIC LICENSE
diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
index 27bb4342a3e8..8738a8d578fa 100644
--- a/LICENSES/preferred/LGPL-2.1
+++ b/LICENSES/preferred/LGPL-2.1
@@ -1,15 +1,15 @@
-Valid-License-Identifier: LGPL-2.1
-Valid-License-Identifier: LGPL-2.1+
+Valid-License-Identifier: LGPL-2.1-only
+Valid-License-Identifier: LGPL-2.1-or-later
 SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
   tag/value pairs into a comment according to the placement
   guidelines in the licensing rules documentation.
   For 'GNU Lesser General Public License (LGPL) version 2.1 only' use:
-    SPDX-License-Identifier: LGPL-2.1
+    SPDX-License-Identifier: LGPL-2.1-only
   For 'GNU Lesser General Public License (LGPL) version 2.1 or any later
   version' use:
-    SPDX-License-Identifier: LGPL-2.1+
+    SPDX-License-Identifier: LGPL-2.1-or-later
 License-Text:
 
 GNU LESSER GENERAL PUBLIC LICENSE
diff --git a/scripts/update_spdx_v2_licenses.sh b/scripts/update_spdx_v2_licenses.sh
new file mode 100755
index 000000000000..4d422cab600a
--- /dev/null
+++ b/scripts/update_spdx_v2_licenses.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+
+# GPL variants without \+ that should use -only
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])(\s|\)|$)'
+spdx_replace='\1-only\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"
+
+# GPL variants with \+ that should use -or-later
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])\+(\s|\)|$)'
+spdx_replace='\1-or-later\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"
-- 
2.15.0

