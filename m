Return-Path: <kernel-hardening-return-12808-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49RJfyFHJyntJk/hD3BgfB35/2DxCZ1u5DY+gQ/qhmXtebrxDbeJghDg0kQfHVkGr/v6xn8
ARC-Seal: i=1; a=rsa-sha256; t=1522270670; cv=none;
        d=google.com; s=arc-20160816;
        b=M/u1imv/J1UA7OaY1FZz/6CKmz0RzSZo4MNKlXjl/6oG6n1dSWcw/D8gWmCbLT/6g8
         SS5VuB5EhdxrtKFSy9pZJQbBe+T1WNV7ql6uuRF2kVjOrWWh/Z920qMcYHJ/tQF7M3Xb
         C7MIlWFdreTI1saLD95w3kX1CxLRmj5Yd9MWILDtvwGfJAics2+ed3hJqVxQEgJ99a0J
         zWTkc6aZ5dc9TKeOmqL/pBiSLrQwSHIwjuioJMLv058OPVqAh1n2f3iIdlNbn4+HEIk/
         O9uTI3RVGbocg06FUaegUHsiUv0NGvBtoM2SY7R2XZ9Hes/pQMI8IpcYfdIriEEVgwic
         iGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jTakeIk2RVCKPr0Fnit0gxmPxcjvzLqs49PwjY3BIgk=;
        b=zwIzUr/1ImmW/lovu/iL59HlNe7CTAZ+BbXzhXPEz9+o1+iNI1VAOb08q+HBDo74M/
         cJFTRHeFPeVfAlk73pPnHlk+ko1Vl/QuOc4keB8rq9zVMinLSoskUkC6ziTI+lNZAOf/
         z4Yw2SLI3fNm2mjPTE+RTgxQ5XkpxMs7B4AbRI661Da8KGw6lYFeARNGzeygaL9+MT6A
         DRz4KyKQ4HVdCorPbCHTyiVgPyT2Cv6PWfTvvkeEd6CVfE8/X3fPQCEl+AWTI/e5s5r3
         AEQ4LbITNHHYXxz2Zw2LvMDirQpeCUhNi4RG2mniwE+4xbq7rV2nAjAONMGpruSzDCmH
         6d4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12808-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12808-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12808-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12808-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180328205554.417084780@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:40 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch 2/8] rslib: Cleanup top level comments
References: <20180328205138.301218351@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Cleanup-top-level-comments.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216490067288272?=
X-GMAIL-MSGID: =?utf-8?q?1596216490067288272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

File references and stale CVS ids are really not useful.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rslib.h           |    7 +------
 lib/reed_solomon/decode_rs.c    |   12 ++----------
 lib/reed_solomon/encode_rs.c    |   13 ++-----------
 lib/reed_solomon/reed_solomon.c |    9 +--------
 4 files changed, 6 insertions(+), 35 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -1,16 +1,11 @@
 /*
- * include/linux/rslib.h
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
  *
  * RS code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
  *
- * $Id: rslib.h,v 1.4 2005/11/07 11:14:52 gleixner Exp $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -1,20 +1,12 @@
 /*
- * lib/reed_solomon/decode_rs.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright 2002, Phil Karn, KA9Q
  * May be used under the terms of the GNU General Public License (GPL)
  *
  * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
  *
- * $Id: decode_rs.c,v 1.7 2005/11/07 11:14:59 gleixner Exp $
- *
- */
-
-/* Generic data width independent code which is included by the
- * wrappers.
+ * Generic data width independent code which is included by the wrappers.
  */
 {
 	int deg_lambda, el, deg_omega;
--- a/lib/reed_solomon/encode_rs.c
+++ b/lib/reed_solomon/encode_rs.c
@@ -1,21 +1,12 @@
 /*
- * lib/reed_solomon/encode_rs.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright 2002, Phil Karn, KA9Q
  * May be used under the terms of the GNU General Public License (GPL)
  *
  * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
  *
- * $Id: encode_rs.c,v 1.5 2005/11/07 11:14:59 gleixner Exp $
- *
- */
-
-/* Generic data width independent code which is included by the
- * wrappers.
- * int encode_rsX (struct rs_control *rs, uintX_t *data, int len, uintY_t *par)
+ * Generic data width independent code which is included by the wrappers.
  */
 {
 	int i, j, pad;
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -1,16 +1,11 @@
 /*
- * lib/reed_solomon/reed_solomon.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
  *
  * Reed Solomon code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
  *
- * $Id: rslib.c,v 1.7 2005/11/07 11:14:59 gleixner Exp $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -35,9 +30,7 @@
  * second stage, which does the decoding / error correction itself.
  * Many hw encoders provide a syndrome calculation over the received
  * data + syndrome and can call the second stage directly.
- *
  */
-
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
