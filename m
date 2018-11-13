Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04318C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1ED223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LviLNsQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1ED223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeKNDOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:14:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40165 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbeKNDOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:14:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so2157870wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFeLViPlWIv3TR0VsHeNzQH70D2rbNWOkId0Zk8OVps=;
        b=LviLNsQAKG83i1IqdnPxhXEZynE8/s5A1FzO6TtGAQVgXRMoerSTRsJ+3PjAHMkFs8
         Kz0ezbx3BVLvctVTB1HqvhBfJRDNeIH/q1UqdZ+Gi0Wj8LB/+WVlQtmopqXniwRUfkDC
         8psKGvnRw6VShjY/+v+13gEB0bSAQJGXbLs/VgIgQdVabP7tHLn8a0tCxyxhzVh5pXGl
         TjsEqEkFY7+ShHaP1NnEOMLZwsXtOGKZOvDlcv2pmTV3OK2urOO48+a6ITvib/fyvVPO
         cy8oCy1a3E8GLY1R/1R7yXReVpUddo8ojzGQt0SZPMVx9Pv9CBTC9Oaus89q6RqoX17y
         kHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFeLViPlWIv3TR0VsHeNzQH70D2rbNWOkId0Zk8OVps=;
        b=SSe4W6+rY+A289o+8nuAPoZ86lt4lD9zVNoCNHA7T1jP7xb1phxN54Qd9ts0DiUpky
         6+t5T9GojFVjk/QsBGhu9jc5vEcwDbc2kvWEgxTX42+KIGeWwK0peAoB6VUsFc5BjP/v
         MjPQozXFLhc5bcTBfPxbEPObqHjcjsDMxVL/VR8JoUygSEWgZyknmQrt9kij8C0bzZfL
         8a90DHU66MeB74ZVNN4SSBlH0C6PQvLIeHvjNDXbYo24JQJZjMRtLwypeOV2Yel0MCa7
         LDayjAH9mqeetEvwd4iwYErGCMASFEU0oHeFkQKNoizuvl8wyT37LCwdxQQkCZenM/DI
         7vvw==
X-Gm-Message-State: AGRZ1gKzJmhH/XC4dPjDZum4KVkuDJGVQYWrjfWbxJoBEI1NtJWNAqPZ
        Su6fNt6fHPHkG6AMqtG2hrM=
X-Google-Smtp-Source: AJdET5cmgeLcOKXF8JesbOAVRqFBBD9t1lyFMa0toRv6MyURtgVHTtm9GRI0V13OW3jMdqBbaaMKhQ==
X-Received: by 2002:a1c:1792:: with SMTP id 140-v6mr3935895wmx.117.1542129348912;
        Tue, 13 Nov 2018 09:15:48 -0800 (PST)
Received: from localhost.localdomain (ip1f12fd1d.dynamic.kabel-deutschland.de. [31.18.253.29])
        by smtp.gmail.com with ESMTPSA id f18-v6sm14780769wre.57.2018.11.13.09.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:15:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: pi433: remove GPL boiler plate text
Date:   Tue, 13 Nov 2018 18:13:40 +0100
Message-Id: <20181113171340.7442-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX identifier is a legally binding shorthand,
which can be used instead of the full boiler plate text.

All source and header files have SPDX identifiers.
Remove the GPL boiler plate text to reduce file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/pi433/pi433_if.c       | 10 ----------
 drivers/staging/pi433/pi433_if.h       | 10 ----------
 drivers/staging/pi433/rf69.c           | 10 ----------
 drivers/staging/pi433/rf69.h           | 10 ----------
 drivers/staging/pi433/rf69_enum.h      | 10 ----------
 drivers/staging/pi433/rf69_registers.h | 10 ----------
 6 files changed, 60 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index c85a805a1243..786478671190 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -14,16 +14,6 @@
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #undef DEBUG
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 2d4fa77c793e..9feb95c431cb 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -15,16 +15,6 @@
  * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef PI433_H
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 4fa6c0237e59..e19b9ce794a8 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 /* enable prosa debug info */
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 319b86c14234..d43a8d87d5d3 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #ifndef RF69_H
 #define RF69_H
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index de3b7e32dad7..3ee1952245c2 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef RF69_ENUM_H
diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index ea19c1ca7509..f925a83c3247 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 /*******************************************/
-- 
2.19.1

