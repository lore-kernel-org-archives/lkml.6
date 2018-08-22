Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87985C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FE0208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FE0208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeHVXOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:14:15 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:50701 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728156AbeHVXOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:14:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3FD731822493A;
        Wed, 22 Aug 2018 19:48:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net19_2893f9c3d022b
X-Filterd-Recvd-Size: 6414
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Aug 2018 19:47:58 +0000 (UTC)
Message-ID: <d0d292a4d9637c1a94eb40abd8a4ee2dd1f0d823.camel@perches.com>
Subject: Re: [PATCH V2] license-rules.rst and LICENSES: Use only spdx
 version 3 with -only and -or-later
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Wed, 22 Aug 2018 12:47:57 -0700
In-Reply-To: <alpine.DEB.2.21.1808222115050.1652@nanos.tec.linutronix.de>
References: <9f90ed3678d32bdde88d63e877880dcb08a97e15.1534519501.git.joe@perches.com>
         <7275a821f20ba080b6a262089ceeaf8fa94d4bab.camel@perches.com>
         <CA+55aFyd5D9Rj2Wm+rP9QnZg2Jd_LKqPTKTmPv+doYN=JXra=w@mail.gmail.com>
         <alpine.DEB.2.21.1808222115050.1652@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 21:17 +0200, Thomas Gleixner wrote:
> On Wed, 22 Aug 2018, Linus Torvalds wrote:
> > On Wed, Aug 22, 2018 at 11:01 AM Joe Perches <joe@perches.com> wrote:
> > > 
> > > How likely is it that this is applied at rc1?
> > 
> > I'm staying out of the crazy license name bikeshedding, so it's going
> > to be up to the people who have decided they care.
> > 
> > I think whoever *did* care and argued for the change to the SPDX
> > format is a hopeless wanker. "GPL-2.0{-only,-or-later}" is in no ways
> > better than the "GPL-2.0{,+}" that was in an earlier version of the
> > SPDX spec
> > 
> > So I want nothing at all to do with pointless patches. Life is too
> > short to deal with this.
> > 
> > Other people disagree, so I expect I will get these kinds of stupid
> > noise patches through the usual channels.
> 
> I'm not a great fan of that change either. We have settled on a well
> documented and machine readable format. External tools have to be able to
> deal with SPDX versions anyway and if we do this now, then we have the next
> round of pointless churn in a year when the SPDX folks decide to rename yet
> another license identifier which is used in the kernel.

Whatever best.

If ever there's another SPDX version, the kernel might have to
add support for the style in LICENSES.

Perhaps it's better to stick to a single SPDX version style for
all kernel files.

Right now, there are already several -only and -or-later uses.

$ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
144

So perhaps a patch and a tool to do the reverse conversion:
---
 LICENSES/exceptions/Linux-syscall-note |  2 +-
 LICENSES/preferred/GPL-2.0             |  6 ------
 scripts/update_spdx_v2_licenses.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)
 create mode 100755 scripts/update_spdx_v2_licenses.sh

diff --git a/LICENSES/exceptions/Linux-syscall-note b/LICENSES/exceptions/Linux-syscall-note
index 9abdad71fafd..6b60b61be4e9 100644
--- a/LICENSES/exceptions/Linux-syscall-note
+++ b/LICENSES/exceptions/Linux-syscall-note
@@ -1,6 +1,6 @@
 SPDX-Exception-Identifier: Linux-syscall-note
 SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
 Usage-Guide:
   This exception is used together with one of the above SPDX-Licenses
   to mark user space API (uapi) header files so they can be included
diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
index ff0812fd89cc..b8db91d3a1cb 100644
--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,7 +1,5 @@
 Valid-License-Identifier: GPL-2.0
-Valid-License-Identifier: GPL-2.0-only
 Valid-License-Identifier: GPL-2.0+
-Valid-License-Identifier: GPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
@@ -9,12 +7,8 @@ Usage-Guide:
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
     SPDX-License-Identifier: GPL-2.0
-  or
-    SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
     SPDX-License-Identifier: GPL-2.0+
-  or
-    SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
 		    GNU GENERAL PUBLIC LICENSE
diff --git a/scripts/update_spdx_v2_licenses.sh b/scripts/update_spdx_v2_licenses.sh
new file mode 100755
index 000000000000..83533f15bc5e
--- /dev/null
+++ b/scripts/update_spdx_v2_licenses.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This script should update all files in a git tree that use the newer
+# version 3 SPDX license identifiers GPL-x.y-or-later and GPL-x.y-only to use
+# the version 2 SPDX license style used with + or nothing.
+
+# The following styles are intended to be converted
+
+# GPL-1.0-or-later	->	GPL-1.0+
+# GPL-2.0-only		->	GPL-2.0
+# GPL-2.0-or-later	->	GPL-2.0+
+# LGPL-2.0-only		->	LGPL-2.0
+# LGPL-2.0-or-later	->	LGPL-2.0+
+# LGPL-2.1-only		->	LGPL-2.1
+# LGPL-2.1-or-later	->	LGPL-2.1+
+
+# GPL variants without \+ that should use -only
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])-only(\s|\)|$)'
+spdx_replace='\1\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"
+
+# GPL variants with \+ that should use -or-later
+
+spdx_find='(SPDX-License-Identifier:\s[\s\(]*.*\bL?GPL-[12].[01])-or-later(\s|\)|$)'
+spdx_replace='\1+\2'
+git grep -P --name-only "$spdx_find" -- './*' ':(exclude)LICENSES/' | \
+    xargs -r perl -p -i -e "s/$spdx_find/$spdx_replace/"

