Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A480C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACDC23EA7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfkDB0Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACDC23EA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFVIHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:07:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33085 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:07:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so5587468wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yXGGzV4rWD9Tqmq4ojKa3xn8COkpcI8/a0nFkhpn7q8=;
        b=mfkDB0XqNAWFT8yDveM8KRWCGyLALMZaPHWvWkTsCj58vqYKD4RKqyYuBH9pEECFhE
         NMkTrghCT5fOw9Yofo7tLsmLJb6bkcRPqdhAtxjPrSzahDp9UjStGnaUlo533Yhp3bbJ
         PyCDNJhFJBv3lStV0YvdMUr9eFl3OMvnrL1JCcukLnRRDxYvjAl9BBXrzl6ZfJ7jST1+
         ew84nJG4dBY+OqfASqtX3NWKw06GliaJX6dui6+5JKNSr6xsbx4ck3M3/IABZxKvuleF
         mIB4/yf7jNzHSC/ONqNn73QiNfPhdfNvZnAvASd9WwqSFRltGmPQIBDGgYVrx8h6aizi
         qGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yXGGzV4rWD9Tqmq4ojKa3xn8COkpcI8/a0nFkhpn7q8=;
        b=aDdefcyxaQsKv7NTrLoegPa9gjrSHc6avESfREZM9f1GJ036hJAYdGZLBKlqjSyywI
         DxYaTCgxkOtQhdcGeNL6mWkHwkUq7cH2pl2NbsH0hoTbV8NU6C/rQxXL9sHlClNZbek/
         ouuFsSzV7IqHldl566PImrPVX4s5rd5O1hNuicJrqy1JB3nUt/ZCPhzavnFqbYIuC/27
         xaNBff1bens3RNF/Py7/c3jZT9hmRcnQfgj0i7skYSM6qB5NrnzGpL32/TX+Q4SeH6LE
         tBuO0g73lGy8voyGm+WQeS3Y8kJ8WfDFueAZbacdXXM2Jjft4aCiVj2Pp2HLeta4pGCI
         /IZg==
X-Gm-Message-State: APt69E0Ktqkg9y+YVNfHOMSPiCN5bXzXvPs4sDg8aXJNfs60O8SqpG47
        fCOI416yfDPd4CiNQXl5yg==
X-Google-Smtp-Source: ADUXVKIge+09ul51fYCFr1UuA6TEgwz7yO2lwSIa9PmGfIckWsnOqAYjW01+pB/XaRdI6MF6qR/GzQ==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr897837wmi.92.1529654859091;
        Fri, 22 Jun 2018 01:07:39 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id l78-v6sm2071731wmb.39.2018.06.22.01.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 01:07:38 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:07:25 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     robin.murphy@arm.com, arnd@arndb.de, peterz@infradead.org,
        punit.agrawal@arm.com, tglx@linutronix.de, marc.zyngier@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drivers/bus: arm-cci: use SPDX license information
Message-ID: <20180622080725.GA6576@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX license helps developers and machines to know the license governing
a particular file hence easing work

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/bus/arm-cci.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a9..74a2e0a 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * CCI cache coherent interconnect driver
  *
  * Copyright (C) 2013 ARM Ltd.
  * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/arm-cci.h>
-- 
2.7.4

