Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-53684-1526876599-2-17428945776132339384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526876599; b=W01SdRuDU8fXwcxKQIN0ZEkEknnuYDFYqt++U7gumJOgW/Vc+M
    u3zL9D8USLK54ZBQEnDDdNC+UB4Ysj9dgWUUNa0XZKPfFU6zoU8Jgl9EQoPCqzvs
    VJ/GATn9504l15M0ePIczXG46lk96txH6C/fvKeY9aw6izDV5fuDATCBeiqF98qw
    iYuHcyUzSN9WgYvHqZ5/pxg1ga2329GYVmwpisBfZLUOFj0HUiPJ7yROWa2rS1Yh
    6wzcDOZjKk/RXIxOeWNR2MsVlPqFGuGEJfSoOIbF9R1okVlKy5UlhhvDo+WLFaFN
    LUIOy/QBi9rxqy5To27XsY3cRlMZM/02rVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526876599; bh=PvvLz94JzB2eteXjTeikBUVnlUW1A5
    hp3xnAjn7Xid4=; b=JhuGx8+aGeFUbcd9D6ldjymISnwzLUNQVAbERtN9abRe8t
    cHzyyO7V4ostWT7cN+cgkYXGEpMrqrJGilQbw4OCpVKdtvbDy4IvxLGaPHwM8y0D
    jU5JthRz6j72/vJcEFq0GO1BRw6t93/nliD2iAS4h4IlAQXDYMBfzjPdy8iqT6oR
    V9CHEKLG385IlpYgYk3uzVK/0HBfO2S/DPlijaC0AicIgY/IdcSwcBhlix1N0KI+
    3pbp1Zfr34y33mzdmsKVtfbs/MjVoYf8GojjkxdvE1vovSBf5EkrsMO36ShKxb+s
    yAHJUSTCT/u/ZFcOmPbkm4x9SWFsMh1r/oGfh3Ag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFzZR3OarCTSDxND2GObO+QwXK47GP+u6wW8NOCWen7pMecScj3TNQpu+Gv/vL3gJcrkJMWKdMgS6aOiETQ+TY05SB1URcJsrPmRw9g72tSqEI7OrLAC
    qvX9QOVq7mdbtbrwDbBkCSGMZqJiyRlME0P1QmbMoIaxhxOgvIzCJdaT+r4g05xLqWoTZoIpcBSKsyUIQ3iZf2gVID8t8RSw2bFKi2UgOla8pfnFFzsRN+Wq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=JfrnYn6hAAAA:8 a=BRUvAFpzPGeqnYAwX-oA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeEUEXR (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 00:23:17 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:13538
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750704AbeEUEXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 May 2018 00:23:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DYDgApSQJb/+U/0XZbHgEGDINDgV4og?=
 =?us-ascii?q?3WUfEsGgQc0fJNKgWQeGAGEQIITITcVAQIBAQEBAQECbCiFUlYoAQwCGA4CSRY?=
 =?us-ascii?q?ThRYMpX6CHBoCiCKCD4EJhyyBDIEHgQ8vhxwcgxiCVAKFQIZgY4QHh0IJiySDM?=
 =?us-ascii?q?4E3g22CUH6ECgErkXEyIoFSTS4Kgn6QWzIwegEBjzcBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DYDgApSQJb/+U/0XZbHgEGDINDgV4og3WUfEsGgQc0fJN?=
 =?us-ascii?q?KgWQeGAGEQIITITcVAQIBAQEBAQECbCiFUlYoAQwCGA4CSRYThRYMpX6CHBoCi?=
 =?us-ascii?q?CKCD4EJhyyBDIEHgQ8vhxwcgxiCVAKFQIZgY4QHh0IJiySDM4E3g22CUH6ECgE?=
 =?us-ascii?q?rkXEyIoFSTS4Kgn6QWzIwegEBjzcBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,425,1520870400";
   d="scan'208";a="81069066"
Subject: [REPOST PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 21 May 2018 12:21:30 +0800
Message-ID: <152687649097.8263.7046086367407522029.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
failure.

It isn't possible to unset one if the other is set because it
introduces a circular dependency.

But adding "depends on AUTOFS_FS = n" will make autofs4 appear
under the autofs entry which should call attention  to it. It
also results in AUTOFS4_FS being removed from .config for any
setting of AUTOFS_FS except n.

Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
awareness of the change to smooth the transition.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 fs/autofs4/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 53bc592a250d..2c2fdf989f90 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,6 +1,7 @@
 config AUTOFS4_FS
 	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
 	default n
+	depends on AUTOFS_FS = n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -30,3 +31,10 @@ config AUTOFS4_FS
 	  - any "alias autofs autofs4" will need to be removed.
 
 	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
+
+	  NOTE: Since the modules autofs and autofs4 use the same file system
+		type name of "autofs" only one can be built. The "depends"
+		above will result in AUTOFS4_FS not appearing in .config for
+		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
+		appear under the AUTOFS_FS entry otherwise which is intended
+		to draw attention to the module rename change.
