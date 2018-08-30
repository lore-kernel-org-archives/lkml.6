Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D62AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E620644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEonScY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeH3GUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:20:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33564 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3GUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:20:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3-v6so1952959pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T+gBSLKIWpr6x3+kjJ82C1zDULYqXQvhWmfzJYvBd4M=;
        b=dEonScY0UY7yfP7Y7zdLkviuk3djkeHLuBllDlPesDb7pzcMD0ZdG1+nM/VRbMTQOi
         cdTxPRaMDAS6EUCTKYaEuGoDIHpu9+bGL8VRQhQC2cnsxKAEMgsA4KnZxiv/OBxjazu1
         h0YDBe5iCoOVbglDYE5mxWqmhvCO9NoncI3Pek/hQGKDzngkVY8QhIeuT8Vm69Rfts5x
         nK0reM/r7Lvx82ZyErh7S3BfQCZNWHh3dxE44v/0/Pc5K23FE5LYPN52p4uJCwOTZh14
         U6stiKDQCExGTbXzdOWgrVc90EyRHGd65WkichTpkqovXa9aTGx+uF599/95UhO8Oceh
         B4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+gBSLKIWpr6x3+kjJ82C1zDULYqXQvhWmfzJYvBd4M=;
        b=AmG/n97vq04H+v9eg6gNEmVq2r3+k+N5VZZ7BLzYAtVT96t91GKOjNq3vstyGvrgdN
         7psXFE9l3/wBOmEQsZku9Me5vcvdEsMXwheGIOTDqslYE0LBtyhQq8dC8WBNuFIbmBxz
         861s447J/xSjW8AkmiY389QHo6IlqrPv4QqAQc1Q9/FHwPtv16xZ3f0PKTYCumKwSwQ1
         GD9szIKYwyE5TsmyJqpB0UjmJfVSP1GH+NM822b28kKo8Eb7xNpSVuieqQTzFC6LHbHz
         oBc7L6nBEe800n6/g4i1cFdYJV9TIfqZ6TpFKnMi6rJhr3aHWo6jJDD/FdPjO+x+bjke
         wOJg==
X-Gm-Message-State: APzg51CwmMHj6zmsqcuKmGo6IbWbjL4B5dfi3/55nQA2AyaejGw9xPiK
        E3CMmnasQNETfF9sCoMicJE=
X-Google-Smtp-Source: ANB0VdYxFqmd/JlSRCWDfDOjWO1dKmjuBKKc/axavSumERhPTgYebcPZECGZ+JrvrsI5mzB6ndX+xw==
X-Received: by 2002:a63:5ec1:: with SMTP id s184-v6mr7976984pgb.26.1535595665142;
        Wed, 29 Aug 2018 19:21:05 -0700 (PDT)
Received: from chris-XPS-13-9343.localdomain (c-174-62-104-253.hsd1.ca.comcast.net. [174.62.104.253])
        by smtp.gmail.com with ESMTPSA id o20-v6sm18744725pfj.35.2018.08.29.19.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 19:21:04 -0700 (PDT)
From:   cphlipot0@gmail.com
To:     namhyung@kernel.org, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, cphlipot0@gmail.com
Subject: [PATCH] perf event-parse: Use fixed size string for comms
Date:   Wed, 29 Aug 2018 19:19:50 -0700
Message-Id: <20180830021950.15563-1-cphlipot0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

Some implementations of libc do not support the 'm' width modifier
as part of the scanf string format specifier. This can cause the
parsing to fail.  Since the parser never checks if the scanf
parsing was successesful, this can result in a crash.

Change the comm string to be allocated as a fixed size instead of
dynamically using 'm' scanf width modifier. This can be safely done
since comm size is limited to 16 bytes by TASK_COMM_LEN within the
kernel.

This change prevents perf from crashing when linked against bionic
as well as reduces the total number of heap allocations and frees
invoked while accomplishing the same task.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
---
 tools/perf/util/trace-event-parse.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 920b1d58a068..e76214f8d596 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -164,16 +164,15 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 void parse_saved_cmdline(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
-	char *comm;
+	char comm[17]; /* Max comm length in the kernel is 16. */
 	char *line;
 	char *next = NULL;
 	int pid;
 
 	line = strtok_r(file, "\n", &next);
 	while (line) {
-		sscanf(line, "%d %ms", &pid, &comm);
-		tep_register_comm(pevent, comm, pid);
-		free(comm);
+		if (sscanf(line, "%d %16s", &pid, comm) == 2)
+			tep_register_comm(pevent, comm, pid);
 		line = strtok_r(NULL, "\n", &next);
 	}
 }
-- 
2.17.1

