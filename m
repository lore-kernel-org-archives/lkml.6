Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE802080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYBf/sIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE802080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeJ3Ex0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:53:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35828 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJ3Ex0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:53:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so4887185ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PE9axsRjosjJ3T7nxoPev2GfqHe3Uv/m+p22kVrDbkc=;
        b=dYBf/sITMcZfMFpbBEUQf9AN9ogyJfhuDfI9mTJ/1oWQs45JloVTBj9OwLpv6npLft
         H9dfosfxforkSkAJJsTjzvp+iX5QgYVattsSo6txofdwRP0m7hcgpJqcFvsnNOv+3JG9
         kUmIh5aB4uHkPUMjFviMViIsggI91Bxu79rUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PE9axsRjosjJ3T7nxoPev2GfqHe3Uv/m+p22kVrDbkc=;
        b=aIcyyVFIX5Ihqym7+1ZuQO4HFtN+6gEaV33oWA7xplx65i11lK0THIRw9zC8JkUsEc
         L3550wfQ2x0/HehhJItPKNaWp2WJxliogEP+BduA0b8P5FT+ZjubY/FVRbnbvAom/q3h
         cAdOeAZsqqYPMgeOHpEiTG9D+5kv4i+yIrYAFUvnXePNaYjw03vyUhK4Sr2OYiPVcc9B
         WhN4PUmA4LOsL0QuvQ+LA80jfLTrffpVmU54QjGn4McCXNL4Tt4pjD2cWXLf5hZjpYGu
         xrPZ6ZNCK1ovXM6yMGJyb93aQQgmZAmZjMkN7VH7FcMfztMwEWWEYGtDbEwQGUTybXdp
         XmFg==
X-Gm-Message-State: AGRZ1gJ0T4GN07NXgr8QrR2kpWc+cQUx1+7DMkU/5y0TEzaqevt7Y4yK
        oFGuny4HSM93DamsWrzhk+qhcA==
X-Google-Smtp-Source: AJdET5fStIYU91QUSccY8fOQLQfhwLV6Pux18sSgw5yvhGwjR9c9t6H6wZ2zsw6bKSMQ8Hw3j7QN+Q==
X-Received: by 2002:a2e:760a:: with SMTP id r10-v6mr10286819ljc.97.1540843393276;
        Mon, 29 Oct 2018 13:03:13 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id g2-v6sm500969ljg.9.2018.10.29.13.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 13:03:12 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH v2] codafs: Fix build using bare-metal toolchain
Date:   Mon, 29 Oct 2018 22:03:11 +0200
Message-Id: <20181029200311.16947-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is self-contained project and can be built with bare-metal
toolchain. But bare-metal toolchain doesn't define __linux__. Because of
this u_quad_t type is not defined when using bare-metal toolchain and
codafs build fails. This patch fixes it by defining u_quad_t type
unconditionally.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/linux/coda.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/coda.h b/include/linux/coda.h
index d30209b9cef8..0ca0c83fdb1c 100644
--- a/include/linux/coda.h
+++ b/include/linux/coda.h
@@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
 #ifndef _CODA_HEADER_
 #define _CODA_HEADER_
 
-#if defined(__linux__)
 typedef unsigned long long u_quad_t;
-#endif
+
 #include <uapi/linux/coda.h>
 #endif 
-- 
2.19.1

