Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlMyhkkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeH2KQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:16:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36152 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH2KQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:16:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so1878942pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BZ8paafAEAOqg4SzW9YT1IIB29vB9gDi3AP1D43Ap4Y=;
        b=LlMyhkkWHRqrHa58mb/W9C3EpYVoc+YYFSwm/wNNkoIG56ywZt5+le19q8J5GtShxa
         hnJ8qfvJXnIqSozlbpnKG7HWThqO4efu0E6YIxrdwXNKyx/4GQksXBqpi2rr1MTyi2cR
         y1J5rulObcx+3UBNFGUrp0z6sQQwyDX0fdS38HezoTnj8eze9bkzLFIjrRXAqy8adFdV
         eIW5TVsZn1XxDqDUiPDPLs1JzZgd8sg9z6/1gLxkuN03fAL3g7AjaY1ekIu+mwdJwzIV
         E/kn+Gdpnn2TMSQS9yLaf8vWNuacvKbIzKlH+sYHnNi0xfJzFjYnu0wg2Q4CJlX55rPH
         D3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BZ8paafAEAOqg4SzW9YT1IIB29vB9gDi3AP1D43Ap4Y=;
        b=KvdG2tfU5VrS+e6hnMV3lFan98RHAOnksgJn8p/WonfiKkLJ/wi3wtAsSUqByoKNfe
         hbokFMBOTZyGrbzVp8HPoU//BiYAlXyNJknKcTfBu/okVmJhITqDFtLGvElFItxiVcEA
         BgqRPUX7buw0m2OtRV5f+XZjlGJuclGxegjZHbkDaR4Vg0vJKwnM2KJDyuSNt5ZCpeRE
         uZCaBrwDtUJLPmay/4NCnZI71EDRM/Pde3o/YNI+YMYI2R1xyup9UYH7jKjlkLo7ma45
         L1ZgTTl7MD+wp+ZzQ4YV4lZUvTlTGI5c0cScD3WUv22s5MIiupqPn8f7iqUSW8Ra/3xl
         41HQ==
X-Gm-Message-State: APzg51CZsHJ64IgMVEcVIbvACuIHc4XINyJ2hdnSwKohWrol67/gMrlA
        1yCREI4rroP6pVAvUpXfTWY=
X-Google-Smtp-Source: ANB0VdZEO3KkX4NV7TFH+8eVxb4gmwoocboKO7u713QWtL/89rog7S48HOh8KlAkR/OFd9XEdbSXpQ==
X-Received: by 2002:a62:51c6:: with SMTP id f189-v6mr4551798pfb.7.1535523649724;
        Tue, 28 Aug 2018 23:20:49 -0700 (PDT)
Received: from chris-XPS-13-9343.localdomain (c-174-62-104-253.hsd1.ca.comcast.net. [174.62.104.253])
        by smtp.gmail.com with ESMTPSA id e64-v6sm6758652pfk.87.2018.08.28.23.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 23:20:49 -0700 (PDT)
From:   cphlipot0@gmail.com
To:     namhyung@kernel.org, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, cphlipot0@gmail.com
Subject: [PATCH] perf util: Fix bad memory access in trace info.
Date:   Tue, 28 Aug 2018 23:19:54 -0700
Message-Id: <20180829061954.18871-1-cphlipot0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

In the write to the output_fd in the error condition of
record_saved_cmdline(), we are writing 8 bytes from a memory location
on the stack that contains a primitive that is only 4 bytes in size.
Change the primitive to 8 bytes in size to match the size of the write
in order to avoid reading unknown memory from the stack.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c85d0d1a65ed..7b0ca7cbb7de 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -377,7 +377,7 @@ static int record_ftrace_printk(void)
 
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err = 0;
-- 
2.17.1

