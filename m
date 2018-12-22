Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA124C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA192080D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi39ZJSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbeLVSO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:14:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeLVSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:14:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so8236925wrt.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qryxcSK/qN7f3QLM05sUKORh6EIqA2JjuUZ9v5Oxawc=;
        b=Pi39ZJSEJmZtvm6/uN9FOwXz8v4FatzjRfMoIg2yNjcgUZRj+BBiAXFS9CNZuJpd5m
         LqqDTzPNDaPZt2UH3fhX+MTmumuoqH5qzVU6u7DpqwyH6Sr0owZF2aUPp1QtSe6hUvGM
         +ral/+OXJluxZ2alexIqweC2AbVl2JUuJknRmF3LYKoaWzibV6Jw0rZ3y25k8pEiZDOj
         A/hq2X0Isgb7QkGspOfxWKJajp6FMb/rTkr1xDmHUU+oheUXw7oOewHfelyfzRvfanyl
         T8+AXBEkHeVUbAOyQcb/YVtn1EaN18CEAQMcrh+kxtJZJKGQ3sF5H4vfGpSaPAago8Wl
         JH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qryxcSK/qN7f3QLM05sUKORh6EIqA2JjuUZ9v5Oxawc=;
        b=ne+9ic9IlRVIzAs9BqEZ/h3TxJMn5fNIRxV0kgzgW8WWiS4wGEWXvxYfz46IZJkofm
         HigGQkH7CrgCdtp5hcpK4FnDl0xihdkaNP++PcrbizNOD459UkMgSmxl7k+KERq7PlhA
         TyjXFGyFnaCCFo4Xm8RbBVWG6hN3Zl6FzJeGCldtnrdZgqxJGR5WchQJniyuDLDsIp17
         smIwyVkwxulKYHRz46SBT8j7oj6W/aL7CxT9Q48KugAQMf8ulKM8UQ9VNKU/Z7+4YtdH
         K4+Pp2sEkvNhAkxFG38SLvLhEe6u3nMco8zTjeZJj9uVZgWQAwVZI9qS0tnFVEF2hDvq
         itVQ==
X-Gm-Message-State: AJcUukfeENF1irilM/YmyIhv4mXPhPYkeAg20aK04Uj9rFHRYnlzUcsf
        bZ9FwL87a4pWZL5KW7v4Qnoqc4Dc
X-Google-Smtp-Source: ALg8bN5Eo3G2Qfpr4uGgQsDHVt2ALXYl7KBsN9NubczL7VYlok/nD6nzT0iw/fx2zZirdN9h3rSn4w==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr5641090wrv.121.1545471995855;
        Sat, 22 Dec 2018 01:46:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id t70sm17632687wmd.36.2018.12.22.01.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 01:46:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     insop.song@gainspeed.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: gs_fpgaboot: add SPDX identifiers
Date:   Sat, 22 Dec 2018 10:46:23 +0100
Message-Id: <20181222094624.2194-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satisfies a checkpatch warning and is the preferred
method for notating the license.

The SPDX identifier is a legally binding shorthand, which
can be used instead of the full boiler plate text.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/gs_fpgaboot/gs_fpgaboot.c | 12 +-----------
 drivers/staging/gs_fpgaboot/gs_fpgaboot.h | 12 +-----------
 drivers/staging/gs_fpgaboot/io.c          | 13 +------------
 drivers/staging/gs_fpgaboot/io.h          | 12 +-----------
 4 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/gs_fpgaboot/gs_fpgaboot.c b/drivers/staging/gs_fpgaboot/gs_fpgaboot.c
index fa8b27e091a2..3e154562c64d 100644
--- a/drivers/staging/gs_fpgaboot/gs_fpgaboot.c
+++ b/drivers/staging/gs_fpgaboot/gs_fpgaboot.c
@@ -1,14 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/staging/gs_fpgaboot/gs_fpgaboot.h b/drivers/staging/gs_fpgaboot/gs_fpgaboot.h
index 986e841f6b5e..5cf12c14cca4 100644
--- a/drivers/staging/gs_fpgaboot/gs_fpgaboot.h
+++ b/drivers/staging/gs_fpgaboot/gs_fpgaboot.h
@@ -1,14 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0+ */
 
 #include <linux/firmware.h>
 
diff --git a/drivers/staging/gs_fpgaboot/io.c b/drivers/staging/gs_fpgaboot/io.c
index 83a13ca7259a..3d17ca557611 100644
--- a/drivers/staging/gs_fpgaboot/io.c
+++ b/drivers/staging/gs_fpgaboot/io.c
@@ -1,15 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/staging/gs_fpgaboot/io.h b/drivers/staging/gs_fpgaboot/io.h
index bc5d99cbda8f..9bd86a92e90f 100644
--- a/drivers/staging/gs_fpgaboot/io.h
+++ b/drivers/staging/gs_fpgaboot/io.h
@@ -1,14 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0+ */
 
 #define GPDIR	0
 #define GPCFG	4	/* open drain or not */
-- 
2.20.1

