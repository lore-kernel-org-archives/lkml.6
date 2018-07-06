Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B73123F47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etx+NE26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B73123F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGFMMG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:12:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42477 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753705AbeGFMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:12:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id g12-v6so8502528edi.9;
        Fri, 06 Jul 2018 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mftl/mOuvu6HsHP5ZP/JeHPcVpMHCGuSfwDn6xwbACc=;
        b=etx+NE263oMtlyLz/fjE6cX1UaAlk49IG17fUwkbDfmQtaoaiFfgcE/Wpp4zXtsENP
         gIxFp5aj8yZ8V8dpGWMf3znbkbyUaUpo5W7tkuvvF/H0+OMZIeftud8StyZ5m7OAxb2/
         Xpm6X++B7WMdRyj/ERPLPv7CV3kwxbbEYLzjgGMKAUEBe35RzdDVqamHTHjXHE+1rG+H
         IXin3mKxxmQHpanrcokb1u2Y57URd2Icx4FpcPGKEor1aEllFPlEGyESUrv7hX2bhlXW
         9eZk/POWAb3xsIGYmI1yvhR8nwk9uu5m9cRdQYwdUkmplCy7jDDXfkwh/TuwHYPQ1T0a
         Tb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mftl/mOuvu6HsHP5ZP/JeHPcVpMHCGuSfwDn6xwbACc=;
        b=K4Lb9Jh7Gbs8zL0EzPxpSEzHSvwu2gEVrVxybLUykKL0UOPywEXebM/g3xat9CZPET
         SkT53reQd+dtUPEIeMBbILiWSpYy843fmp8rJhmUNDaj5RNvzb4oq+ppVQd4vjXREGhV
         9/eD6Ilck/zScoGX5624ll7CVRZEimra+KYZxYV+hGk2y4p6ulIvCE4828KUrnfpcAJ3
         C4HTZOHCvLSYCeazM70ZoKFnrSomhDHRBIxQwikPTD/e26Jnm47QEJbcPJ5+GAsZVO0Y
         kr0BqJr7g57SX1ZDE1fPGDLiSH/8GYeaXio+qIb0WWJMh3qR+PbW9tMCSxvDNd7o4NV5
         muDg==
X-Gm-Message-State: APt69E1jQVypALkbfaXrvJTuk9KR/GbH7A9anm5PeqJvNfszostAoqHs
        R/irQ6l2kjsO0ouhkQ7m15k=
X-Google-Smtp-Source: AAOMgpfyOApEDU9k7iqnGpsILH1k/NF9gU3PKnzklOkZgRdTSImQMl/zQEywi9cJwvjgC7TAybT5RQ==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr10952865edb.174.1530879121285;
        Fri, 06 Jul 2018 05:12:01 -0700 (PDT)
Received: from christian-SVF14A1C5E.mip.uni-hannover.de (ip116.173.mip.uni-hannover.de. [130.75.173.116])
        by smtp.gmail.com with ESMTPSA id p23-v6sm3752817edm.31.2018.07.06.05.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 05:12:00 -0700 (PDT)
From:   Christian Thoms <christian.thoms93@gmail.com>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Thoms <christian.thoms93@gmail.com>,
        linux-kernel@i4.cs.fau.de,
        Sebastian Hillert <sebastian.hillert1@gmail.com>
Subject: [PATCH] drivers: input: Add SPDX-License-Identifier
Date:   Fri,  6 Jul 2018 14:11:52 +0200
Message-Id: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDX-License-Identifier marked by checkpatch.pl

Signed-off-by: Christian Thoms <christian.thoms93@gmail.com>
Signed-off-by: Sebastian Hillert <sebastian.hillert1@gmail.com>
---
 drivers/input/apm-power.c     | 6 +-----
 drivers/input/evbug.c         | 6 +-----
 drivers/input/evdev.c         | 5 +----
 drivers/input/ff-core.c       | 6 +-----
 drivers/input/ff-memless.c    | 6 +-----
 drivers/input/input-compat.c  | 5 +----
 drivers/input/input-leds.c    | 5 +----
 drivers/input/input-mt.c      | 5 +----
 drivers/input/input-polldev.c | 7 ++-----
 drivers/input/input.c         | 7 +------
 drivers/input/joydev.c        | 6 +-----
 drivers/input/matrix-keymap.c | 5 +----
 drivers/input/mousedev.c      | 5 +----
 drivers/input/sparse-keymap.c | 5 +----
 14 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/drivers/input/apm-power.c b/drivers/input/apm-power.c
index 650177a..dd413df 100644
--- a/drivers/input/apm-power.c
+++ b/drivers/input/apm-power.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Input Power Event -> APM Bridge
  *
  *  Copyright (c) 2007 Richard Purdie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/evbug.c b/drivers/input/evbug.c
index cd4e667..337c0ff 100644
--- a/drivers/input/evbug.c
+++ b/drivers/input/evbug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
@@ -7,11 +8,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d..b8456e6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Event char devices, giving access to raw input device events.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 66a46c8..3086166 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Force feedback support for Linux input subsystem
  *
@@ -6,11 +7,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 2743ed46..f25377d 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Force feedback support for memoryless devices
  *
@@ -6,11 +7,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index fda8d6d..435e9d1e 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 32bit compatibility wrappers for the input subsystem.
  *
  * Very heavily based on evdev.c - Copyright (c) 1999-2002 Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/export.h>
diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 99cc784..82b5ded 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * LED support for the input layer
  *
  * Copyright 2010-2015 Samuel Thibault <samuel.thibault@ens-lyon.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index cf30523..1c38816b 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Input Multitouch Library
  *
  * Copyright (c) 2008-2010 Henrik Rydberg
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/input/mt.h>
diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 78df5a7..13d4219 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic implementation of a polled input device
-
- * Copyright (c) 2007 Dmitry Torokhov
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
+ * Copyright (c) 2007 Dmitry Torokhov
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 6365c19..de7bc24 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1,15 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The input core
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  */
 
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
 #define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
 
 #include <linux/init.h>
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4c1e427..cb63628 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Joystick device driver for the input driver suite.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  * Copyright (c) 1999 Colin Van Dyke
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 8b3a575..c2cc853 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Helpers for matrix keyboard bindings
  *
@@ -6,10 +7,6 @@
  * Author:
  *	Olof Johansson <olof@lixom.net>
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index e082280..6c61108 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Input driver to ExplorerPS/2 device driver module.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  * Copyright (c) 2004      Dmitry Torokhov
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 0cad5e7..54ec9a0 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic support for sparse keymaps
  *
@@ -7,10 +8,6 @@
  * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
  * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
  * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/input.h>
-- 
2.7.4

