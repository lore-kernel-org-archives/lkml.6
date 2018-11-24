Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61996C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247D820672
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="QrnTtzgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247D820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeKXLKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:10:10 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38089 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeKXLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:10:08 -0500
Received: by mail-qk1-f172.google.com with SMTP id d19so9306765qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x88JxqRyJmkqgb6zPiUNR+dj6+6T2tT0sA6D0Zd/yFA=;
        b=QrnTtzguXjAVzz9+YhYgJ+zW2PW6aMXLHx/uQdcgGm78HvU9xQK5o2G0VJ6lRbbt4p
         Ca2ef7igmNyLj9AZDxQvRE6CvcFsLM3ia70jyATSXWdOHquvpqQVubjhzAOxvttlvFQs
         6uN5HKvCeDDXItcBaVUMjang+uiJs/hP0pEcyJSywCIjCHnD82W2D/aJ/E66fzYlRA12
         zxeCy57W5jtTGezEI/QlcWePUWG/Ned4+13NJer+6ShqKuXaMedatJjTwTmdnnALKHA/
         TlLHROe7EW5X1QSb5+NOMkRbGNCUYBAE2qPAVN9pDHoQ7LiyvwSZdxun8CmCB1O5ImyD
         W5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x88JxqRyJmkqgb6zPiUNR+dj6+6T2tT0sA6D0Zd/yFA=;
        b=Lw5uW1KGM2Fk9F2qhJCw9ou6yqive1wcu7j9Z2azuqrfdtS1TQbSKyw5SXqrO4EygL
         sBF1fii8xeHSMzs8pAHq5TZoRCXpjKGZmVr1Du0ybm9uIy1vQcCjKgW9UZccEWN6typf
         4TVkLQGF7E/rFMqBvSZMNyZwdZFJII7/iPTobseaZiRdhCiULAAc3NPnw2FQGsxjKoNd
         49R2PESVKCEoV7sT1Q9lIHFD4MRliUX5nUDAyeMKPIEW1vHEZ13fWMepkHITebiDAk7J
         mEvAmpB+osPeGxO9cX8izAQr6txXbWWLrYXs9LEOatY+7+LZS+wPAN2l5juecgNNnlgh
         +Bsw==
X-Gm-Message-State: AA+aEWY9HzpIfr1bS53sso0m+WdV0kEqlL17QimcQ9gXBaRu8tOm+g2+
        r7AiQx0Jp7K68wMxEMDy1Ny0zQ==
X-Google-Smtp-Source: AFSGD/VsPsh4edKacrzUDOVHSfVV9/9iVsX84/FoMakT99I8ARYLFXsU6NALxeC64sa+tzpd/Sf44g==
X-Received: by 2002:a37:a703:: with SMTP id q3mr16176071qke.272.1543019026580;
        Fri, 23 Nov 2018 16:23:46 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:46 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v3 5/7] staging:iio:ad2s90: Replace license text w/ SPDX identifier
Date:   Fri, 23 Nov 2018 22:23:10 -0200
Message-Id: <20181124002312.6923-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the license boilerplate text at the top of ad2s90.c
and, instead, adds the SPDX GPL-2.0 license identifier, which solves the
checkpatch.pl warning:
"WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - none

Changes in v2:
 - Changed GPL-2.0-only identifier to GPL-2.0
 - Removed license boilerplate text
 - Rewritten patch message to reflect these modifications

 drivers/staging/iio/resolver/ad2s90.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 4721e9bbb8b0..678351dabe6b 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
-- 
2.18.0

