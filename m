Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18319C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E259720851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfAQXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:15:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfAQXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:15:26 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGsc-0000y1-Nj; Fri, 18 Jan 2019 00:15:22 +0100
Message-Id: <20190117231501.453156872@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 18 Jan 2019 00:14:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Subject: [patch 7/9] smb3: Cleanup license mess
References: <20190117231416.111952141@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Precise and non-ambiguous license information is important. The recently
added aegis header file has a SPDX license identifier, which is nice, but
at the same time it has a contradictionary license boiler plate text.

  SPDX-License-Identifier: GPL-2.0

versus 

  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
  *   (at your option) any later version.

Oh well.

Assuming that the SPDX identifier is correct and according to x86/hyper-v
contributions from Microsoft GPL V2 only is the usual license.

Remove the boiler plate as it is wrong and even if correct it is redundant.

Fixes: eccb4422cf97 ("smb3: Add ftrace tracepoints for improved SMB3 debugging")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
---

P.S.: This patch is part of a larger cleanup, but independent of other
      patches and is intended to be picked up by the maintainer directly.

---
 fs/cifs/trace.c |   10 ----------
 fs/cifs/trace.h |   10 ----------
 2 files changed, 20 deletions(-)

--- a/fs/cifs/trace.c
+++ b/fs/cifs/trace.c
@@ -3,16 +3,6 @@
  *   Copyright (C) 2018, Microsoft Corporation.
  *
  *   Author(s): Steve French <stfrench@microsoft.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 #define CREATE_TRACE_POINTS
 #include "trace.h"
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
@@ -3,16 +3,6 @@
  *   Copyright (C) 2018, Microsoft Corporation.
  *
  *   Author(s): Steve French <stfrench@microsoft.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cifs


