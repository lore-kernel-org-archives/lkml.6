Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD46C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A571214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX10IYTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A571214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeFUQFq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:05:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36843 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:05:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so7167383wma.1;
        Thu, 21 Jun 2018 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=r8uLl6M1uXXGqQcDkyHgTl1ul5em8oqaQFL7Ae+OJyU=;
        b=NX10IYTCmyXTtu/XCMR3wU4pEaypaV2uCKAvY75OiXrHIYW1DCYr6tdeXNIeR4gy1O
         hrOBBB6WYnJfGdfMBjOEkEiyTsy4PKyFMSSM1lYuvjUN/6dyRSglLNjtpaaGT1Or72Ps
         j25YRvwz/L8QfWk2cKSce5iofdcc3tCZyU/Ckax5fkFz+y9hW9ka+V39uoZ7178DFvMY
         QSV5gXMg4++YyJ5Ky77wATEhc1KTwvH7kY60ao0So6T8oFTqq+Kh8gOnarh5c7fSJuF1
         x0japqw8xpUhCQCcErXEcM/t4TwXIuDj1myAzEwH7KtzHe5krnnYxJwIs88CcKlBZzd+
         jBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r8uLl6M1uXXGqQcDkyHgTl1ul5em8oqaQFL7Ae+OJyU=;
        b=cR6Z5RjqaJERvEZC0iia2+UXkDbwx94qB4XGKiro3+Og9POQvOcSUOeuHfahNZpxg5
         J9vtWsRlJfLgltH4kEeUvXwfoNugkXOhH/jO/E1okbqtwOGUZ/9Ivek+6xi9cN++Mykd
         hvR9bgVsiYOsShYb1cms1EpKk1p6CdN59ueNy1FGKuYNMLKTni7+08C2YZOACom6cLZh
         GZeqmduwi2DQuy317G87NT/TmOEFN3Wj+tCVDQytAU5I6fPLbEE33eTACln5sd7DoePX
         FW2FjC1FCbSpYOpU9cbM/9EDZ6r9kRq+LzLzQK5BNNBc7E7QjPBRJciGfJaXXno708RV
         NwOg==
X-Gm-Message-State: APt69E2jOKa5XOMbKPA5gU240rkY0QsOfthudr+ZthXmmoVfTUuPJo5d
        Xbh6kHHXCwP7d9lNKL6gQw==
X-Google-Smtp-Source: ADUXVKL7HKZ+CpAdWvfsjKG0eFpGq/xDxy3FbVX7GzirDPWH0PIXAwCQQSotll2mc6Ud3/WWlo3Xrg==
X-Received: by 2002:a1c:f407:: with SMTP id z7-v6mr5420791wma.143.1529597142599;
        Thu, 21 Jun 2018 09:05:42 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id v14-v6sm6123920wro.33.2018.06.21.09.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 09:05:41 -0700 (PDT)
Date:   Thu, 21 Jun 2018 19:05:30 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] i2c: slave: Apply SPDX Lincense-Information
Message-ID: <20180621160530.GA20061@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX license header eases work for developers and machines to know the
license that is governing a particular file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..6f56e65 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux I2C core slave support code
  *
  * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <dt-bindings/i2c/i2c.h>
-- 
2.7.4

