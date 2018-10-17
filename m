Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8911CECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D7E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dXWicsKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D7E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJRHKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:10:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43291 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeJRHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:10:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so31500868wrt.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+dUhoXBBHl3SC/3Lokaey4o4O2TBX1X87J7hUnXOkI=;
        b=dXWicsKrluGg+NtdbqFYbuWIeMa/DgfJj+OIU3G1VE9xpO/Z8lUrRz35+zlQFATBww
         MRR04lWhIuss+HniwFWtKqQvP870LQzfGOnqmRAt69zs0LcaHQzln1TnRVev0HY8v8tp
         CCQKqMQblCH5BfJ185QDCORmYaFZo0aP4PR7T+cShPa3pr1derlyDUZbHy40VtXMjXg4
         3jJwljWteaR5qdwCb8GetL6QahH7bQ+HQXxhVpasi13s6FL1H3ifDtTleQUFeZqLVWPL
         jn0t0YBo+WzCq38ksMa5zQdih+sR0sb9v7HvIqHLlVOtKwF+HstT2rQZXUPnyga22ise
         Cmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+dUhoXBBHl3SC/3Lokaey4o4O2TBX1X87J7hUnXOkI=;
        b=MMu+GaDIip2q1zEf1Cu3R2KZox6NJ8PUaDq86ZRU69/sl6FGBEfIX25S5qiedwcwX5
         m4dMyboirOliHwB+FYir+F4E/V/plyOUJO0WbzJsvf7EiU5+gZm9rKyLDBQHVHJ3m2TD
         UqG5mAc2+ELwq1qr1tuO0P8O5Cgvf80EoYjirhZfrc7oa/HaDG+yuxllWQwM6xeMts4a
         Q4zEcxdS81WAUd/qo23IrotJBFy7UjBj5OeCDXmB00XeVize+OWomMEK4sS8ICQCazgk
         NsVOpvjln/7NcFnQIsrfN3y+EEraqmD+TH6C25sjTjMm/RcT/yLF4cl9ggpDRMTDmkct
         kQRQ==
X-Gm-Message-State: ABuFfohRfNZhdlf1G40j3M/ZkeVeEddWIdyvs9gK2fuV4uG2p2AHWx/p
        r+atAvcxm3SU+pJZ/7aPbwYSoVG4hG25Wg==
X-Google-Smtp-Source: ACcGV62nJK3epsXZbGdYdWp40K1ztt9D1i/SR+FLGwFTzUwr/FUfUlF7P/9m1t4+ZTrLo7UFKRx5FQ==
X-Received: by 2002:a5d:4a12:: with SMTP id m18-v6mr25900350wrq.278.1539817940996;
        Wed, 17 Oct 2018 16:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id v76-v6sm4212803wmd.32.2018.10.17.16.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:12:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/1] fs: cap max_files at LONG_MAX
Date:   Thu, 18 Oct 2018 01:11:49 +0200
Message-Id: <20181017231149.26302-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017231149.26302-1-christian@brauner.io>
References: <20181017231149.26302-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu counters can only deal with long ints but max_files is declared
as an unsigned long. We have already started to reject anything exceeding
LONG_INT in the file-max sysctl as well [1].
Should we ever have the need and precision for unsigned long percpu
counters we can simply switch to that api for the sysctls and then lift the
LONG_MAX cap from files_maxfiles_init() as well.

Note, that in a quick discussion with Tejun investigating percpu unsigned
long counters it became obvious that technically, both LONG_MAX and
ULONG_MAX should be unreachable. Given that an fd is usually larger than 2
bytes one would likely run out of address space before even reaching the
LONG_MAX limit.

[1]: https://lkml.org/lkml/2018/10/17/74

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file_table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index e49af4caf15d..2e3cddce20d6 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -10,6 +10,7 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -386,4 +387,11 @@ void __init files_maxfiles_init(void)
 	n = ((totalram_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;
 
 	files_stat.max_files = max_t(unsigned long, n, NR_FILE);
+
+	/*
+	 * The percpu counters only handle long ints so cap maximum number of
+	 * files at LONG_MAX.
+	 */
+	if (files_stat.max_files > LONG_MAX)
+		files_stat.max_files = LONG_MAX;
 }
-- 
2.19.1

