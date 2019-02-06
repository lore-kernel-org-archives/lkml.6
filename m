Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A42C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CFC2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U7EK2TeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfBFAMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:12:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43215 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfBFALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so4446004eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GF+co9nWNWjUN94BNpaB2aWNvW9wINEUuHWazMCNu6c=;
        b=U7EK2TeUZReQYTb1uPEAxx2qYhZuAlGn+nmICKWhAjon9K4ISRtNYo5NNQW7Lk6Ec1
         aJ4P3jwEXjrkspiJOdiN14cyK9y5aLuDNmpmnaUq5RlTzseAMM10UtYQE5SL9mEnq8LV
         FBJq1lyr2g3nRrgbHqxTGzVgVi6BwzkObFH4m4YTwjlX5F/15O6cQ0hfttn7WCJUj7Ed
         iB2YHnfzrzQJnUdR/owhNtLZYDTFREDyAIs9zPBtLZf0qH8iAPqZtd96luo2gMKHeCn+
         GtcUMgk/Vg8/1oZzfI0Tq8a7IQMIvFAQLD0t/c9jxvg7A/b21NjJGBXCE40bYthEXsF8
         5pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GF+co9nWNWjUN94BNpaB2aWNvW9wINEUuHWazMCNu6c=;
        b=t4DmRCfKhAtYHbIhLUQ9o3j35iXjeGbzyLvu8j8nynoFWiOK93MHdh8b7WHnyU+9/z
         A7bVHH1M8DxJIP+87yEPXcOFeOyWVYRbQmuPfDStjwZYJt5RXRv+WvMYldCsJRrNwr7/
         s1TnSZdhbqzs+UdgTZJkQ4N8J8e5dNlHpmryiTG4rV+9bAIVtqmxB+SRYhR5C+F0Kkh3
         ozvInzReDDC6pAKNO+4I83gSLaliGzXdQc3e67IMc/UiPG51AbD67aQr6Pba10afwERc
         e7mhQ7/rAaFeoumuCNgNnqhUHDSoc9WPy1OErKCK8kVeRI+7b0iSlKqacz1P+YE7JSMx
         nB8g==
X-Gm-Message-State: AHQUAuZWN/mxp52jBej0c/d7vRRKURoSS5Iq4HDvPb2Zjze0imPxJfpx
        CFf1ZsqXI5sfBi+dr02pYvgqsf8Wh4s=
X-Google-Smtp-Source: AHgI3IZrMlYnNPXZlvuL5vkwk1Mwkk8p32wskf6+WI4llmTK22TtoJIzw803tzDbnwFKd83DURgqdQ==
X-Received: by 2002:a17:906:1686:: with SMTP id s6mr5302892ejd.209.1549411911072;
        Tue, 05 Feb 2019 16:11:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:50 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 31/32] x86/vdso: Align VDSO functions by CPU L1 cache line
Date:   Wed,  6 Feb 2019 00:11:05 +0000
Message-Id: <20190206001107.16488-32-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

After performance testing VDSO patches a noticeable 20% regression was
found on gettime_perf selftest with a cold cache.
As it turns to be, before time namespaces introduction, VDSO functions
were quite aligned to cache lines, but adding a new code to adjust
timens offset inside namespace created a small shift and vdso functions
become unaligned on cache lines.

Add align to vdso functions with gcc option to fix performance drop.

Coping the resulting numbers from cover letter:

Hot CPU cache (more gettime_perf.c cycles - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

Cold cache (lesser tsc per gettime_perf_cold.c cycle - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

Measured on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 4e1659619e7e..2cac4660db05 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,6 +4,7 @@
 #
 
 KBUILD_CFLAGS += $(DISABLE_LTO) -ffunction-sections
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_X86_L1_CACHE_SHIFT)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.20.1

