Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D596ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE034208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX93QBDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE034208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeGOVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:10:01 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44820 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:10:01 -0400
Received: by mail-yb0-f196.google.com with SMTP id b21-v6so585936yba.11;
        Sun, 15 Jul 2018 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsGY5Xm7ad3vCnkvV8VamiJD2mq8jlETWmIgK5C+DK4=;
        b=DX93QBDsgYBkqL5QmfrkqII3WyzJLUUgD0Unu843IEgpOR/Q1xa6WpaloCT0t79shn
         8cwzv92H4ibUeAs1uD04jUOCFhH3EASaRsPa8kcKFqbzAdFgrUfBhwaIGs/DIUz+LIUw
         4c4HujdaUXnHzBoxPJr0FEZz0RMZd8wjRPL1ZpcaVjZGBwz96zu5DHXoXS/pfcOacHk5
         2lOeCyWDH+E4peyO4cVuW6O1SV5/vyV5+ynG7pN8aVQsZV5GMfyd0T7g1TQxH2Vc06ix
         g5utWlhS8WPgJVFLK8JEenZTZWzyvilT2uosRGNi3s/lutRt88lLhtC4CXWNgXzO2wwY
         /+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsGY5Xm7ad3vCnkvV8VamiJD2mq8jlETWmIgK5C+DK4=;
        b=KUB4xmYptI3O9JhYY9JCGER2Zrf5Y6uLNPtwEtPkxy8c1dCviwpHsJ1qFkDW0n23BC
         LOnr+yF6U10gLwNQHMbvNIp7x5j9RLlbCaqJiOebXJZ2NXXFq/tSBXvsMsi9CgtOWL5R
         nh/SH7A5Dr7W5/gBsPGsCXwr3tKf7cVCtIWedxgcRn/jiYcCBxHLRXvMKRS5MTDP03ao
         8GHI+1qDtskT/8zjleOYAHHIa02Y/hT/mAwYkv9d0p90CsNs5F4DibG9OiXQZ15LDaZA
         TDGIwIX5Mk3RGi6LvHccIDji6rGgC54gmChE4YtQ1v67dlPsko9rZSHBzQj/6U71aL0T
         jzqw==
X-Gm-Message-State: AOUpUlHyE19d86T5dx3PYyepIEWtuhgOcYD0ft1JKRm/Ga2OZGwTJS44
        W5mxH6nBHcsUoqmWnVvSYMo=
X-Google-Smtp-Source: AAOMgpeyAVN+rEOX+RUt8ezTZfbeTT/En3rzzV4CF8Vrnv/tzbR7s043mjH/TMNn5SpB0LhyUfvUlQ==
X-Received: by 2002:a5b:c89:: with SMTP id i9-v6mr7616060ybq.201.1531687551726;
        Sun, 15 Jul 2018 13:45:51 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id g203-v6sm473571ywb.69.2018.07.15.13.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:45:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 04/11] iio: 104-quad-8: Update license boilerplate
Date:   Sun, 15 Jul 2018 16:45:44 -0400
Message-Id: <bd80be65f742fdedfafcd708033ffd0d9ddae0f7.1531685025.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the boilerplate license text by making use of a
SPDX license identifier line.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7735..72b6352e09f0 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
-- 
2.18.0

