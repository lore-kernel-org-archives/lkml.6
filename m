Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF45CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14E222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f7cMWEOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfBLVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44236 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732002AbfBLVmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so143713edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CJkTbgJKOf88jN5+EgmNcUAF0M4eYSxUZoWqS4bWAE=;
        b=f7cMWEOtPGa3jZLsH7hxYOFTebuDoAGpNDD4/NdGRVixUtpB3SAQ5XPzOJxrWe3wI2
         rgKwgtFgxqqALIelG+W0z4wJc0FQf3KLKxxCukfHi3hh75uT9rPhdBimIeKOCb9/85le
         dbo0/9RMRIXfxmw75OMgaKm/5Xv45C6Dsk91Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CJkTbgJKOf88jN5+EgmNcUAF0M4eYSxUZoWqS4bWAE=;
        b=BAwawCAfwywYGuHqa92BFodJV4OpP0AFeagMtS/xv/jtbbq4dkNOxZpGqNLHvFhsIS
         crb4IOKYCRoSd6R3gzGJo/g5IRmmcsMt/HzRK5v+KonP22Nn/d2hfWXfBmPjPCk5f8PV
         o2cjDSD5hEoVeaHCC3OBelroc5Dmc8igNesWxFzxiLl1JvHA205LhFwQ662WcPQ9L/qu
         8jsb4R7RdW7K/YswX2IFwSHId2wIbxpSfytxGg1SU9kr5wZb8FombWCJmQmZgAAQRbCC
         3681gyHO73MWwux1hYvFAvzJQa1gsCaUTT8742r1m5QoSZ0OKhLowtVurGiYQ9V87wNj
         uv3w==
X-Gm-Message-State: AHQUAubJK7NTfT1ZIl5lTd6LJqUq/GO3uSPvUIx2LTZv+zS6VkJSE8oW
        MAyKmh1wrWqC+7sTUYpLA+OWVQ==
X-Google-Smtp-Source: AHgI3IYqDHlyTHPy2gjWpREAoQDXmitARjvnAHQb8vuQcpPY97D6ufvrhhJJ5hPRMxCIgJmXaP8s3A==
X-Received: by 2002:a17:906:34c2:: with SMTP id h2mr4146244ejb.234.1550007730978;
        Tue, 12 Feb 2019 13:42:10 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:10 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 13/14] ACPI: remove unused __acpi_handle_debug macro
Date:   Tue, 12 Feb 2019 22:41:49 +0100
Message-Id: <20190212214150.4807-14-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bcdfbb2bea24..07b9fa507824 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -953,9 +953,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.20.1

