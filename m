Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C70FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A522BC6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULk8DqA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A522BC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966562AbeF0UJh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:09:37 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33195 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965948AbeF0UJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:09:35 -0400
Received: by mail-wr0-f170.google.com with SMTP id k16-v6so3229632wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ev0bfZtPrZKRpOHLVd2q7W3o3rYQMh1JUUoUCYKs5uE=;
        b=ULk8DqA8lwGiOZjc4wy6YxZlNn9nYlMO4ni+reOZobWPcptYQaeODeUqvKXFj+QQWr
         6yocNfCaS+6sH41Uq6mHdVAk/FrgNS0cJvRdCdptTXDI4hH2JyVb75m4INQfuYD9VRH9
         YWeLDsN4jiQW+KB9uchIwdYqy5FB7JaZ+rCCh5eZ6eV6CBkDja6x4pLfXAJJs91/vz/y
         89ZUqpeaos8yG3k54H8DeQGlLcDtY2LouNLuLqsMkEzb6OkF8E0d1d+ys/j5tFCM2xr2
         BWfQxLL+jh7aRQECkgcLKelNHQDNVF9l2lOBau/v2Ongm9PvoDpjkRTUrDObAb2TSHNH
         K3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ev0bfZtPrZKRpOHLVd2q7W3o3rYQMh1JUUoUCYKs5uE=;
        b=SDb9wrSggjrK/HBvd/3Ql9dMlZavqJHdf507Nfb5dY60xtCQEWASEhnbNag/d1tYAm
         kQZFGiy0sqlsASFJkmQWVw+VZj/X8xu2jAysOdgCkVKeEKWm0tOyCH9oiEmcblNOveHv
         uVlq2PQcX9wYWHPI4AYVNjnJzzFp0TsyknD8W1FAoDqWzA4P5hZeGwghG9Wksdy2mGot
         qRZteVxpft5UQ289jYfCQ1QIp66k+OyLluwleHmEi5F2fuvAlNZqiJ8cF3TqupXCHtDo
         cbOJvkuXREO3fphCOvmePw4SPo2YAHVp7ByLnt1xcVbP6nnR6OiUPIpgKCneD7Rpuapu
         2czA==
X-Gm-Message-State: APt69E3Lo7xHGW34xoc0FPBMZVv4bg6JU3k5jVojoN7t/gz6EmxvnsQP
        Entdiln/2oIEA15QZE82vsZw
X-Google-Smtp-Source: AAOMgpcht8NjaJTjkaJkdwGJcMXYSiwRXzRiRNTDW43ctC8KZ5fwhMRm+ljYjCRLYa4+lofQpbgX+A==
X-Received: by 2002:adf:81c5:: with SMTP id 63-v6mr3295423wra.88.1530130174790;
        Wed, 27 Jun 2018 13:09:34 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id e3-v6sm8145790wmd.2.2018.06.27.13.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:09:33 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:09:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use .%02u format
Message-ID: <20180627200932.GD18434@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both /proc/loadavg and /proc/uptime use the following format string:

	%lu.%02lu

Fractional part definitely doesn't need "unsigned long" as it is
by definition in [0, 99] range which fits into "unsigned int".

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/loadavg.c |    4 ++--
 fs/proc/uptime.c  |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -11,7 +11,7 @@
 #include <linux/time.h>
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
+#define LOAD_FRAC(x) LOAD_INT(((unsigned int)(x) & (FIXED_1 - 1)) * 100)
 
 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
@@ -19,7 +19,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02u %lu.%02u %lu.%02u %ld/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -22,11 +22,11 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 	get_monotonic_boottime(&uptime);
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
-	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
+	seq_printf(m, "%lu.%02u %lu.%02u\n",
 			(unsigned long) uptime.tv_sec,
-			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
+			(unsigned int)(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
 			(unsigned long) idle.tv_sec,
-			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
+			(unsigned int)(idle.tv_nsec / (NSEC_PER_SEC / 100)));
 	return 0;
 }
 
