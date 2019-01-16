Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31064C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043CD20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbfAPKnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:43:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44639 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392139AbfAPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:43:30 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjifO-0005Gy-0g; Wed, 16 Jan 2019 11:43:26 +0100
Message-Id: <20190116104127.590053479@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 16 Jan 2019 11:26:52 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [patch 1/2] LICENSES: Add GCC runtime library exception text
References: <20190116102651.489113812@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit added SPDX identifiers to the SuperH low level library code
which originates from GCC. This code is licensed under the GPL 2.0 or later
with the GCC runtime library exception.

Unfortunately the authors did not bother to add the exception text to the
LICENSES directory so spdxcheck fails with:

 arch/sh/lib/ashiftrt.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/ashlsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/ashrsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/lshrsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/movmem.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/udiv_qrnnd.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/udivsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/udivsi3_i4i-Os.S: 1:42 Invalid Exception ID: GCC-exception-2.0
 arch/sh/lib/udivsi3_i4i.S: 1:42 Invalid Exception ID: GCC-exception-2.0

Add the exception text along with the required tags which allow automated
checking.

Fixes: 4494ce4fb4ff ("sh: lib: convert to SPDX identifiers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 LICENSES/exceptions/GCC-exception-2.0 |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- /dev/null
+++ b/LICENSES/exceptions/GCC-exception-2.0
@@ -0,0 +1,18 @@
+SPDX-Exception-Identifier: GCC-exception-2.0
+SPDX-URL: https://spdx.org/licenses/GCC-exception-2.0.html
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-2.0-only, GPL-2.0-or-later
+Usage-Guide:
+  This exception is used together with one of the above SPDX-Licenses to
+  allow linking the compiled version of code to non GPL compliant code.
+  To use this exception add it with the keyword WITH to one of the
+  identifiers in the SPDX-Licenses tag:
+    SPDX-License-Identifier: <SPDX-License> WITH GCC-exception-2.0
+License-Text:
+
+In addition to the permissions in the GNU Library General Public License,
+the Free Software Foundation gives you unlimited permission to link the
+compiled version of this file into combinations with other programs, and to
+distribute those programs without any restriction coming from the use of
+this file. (The General Public License restrictions do apply in other
+respects; for example, they cover modification of the file, and
+distribution when not linked into another program.)


