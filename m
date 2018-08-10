Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0EC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABACA223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mesosphere-com.20150623.gappssmtp.com header.i=@mesosphere-com.20150623.gappssmtp.com header.b="JwwSOKAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABACA223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mesosphere.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeHJQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:06:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeHJQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:06:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so4796131edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mesosphere-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AWAguikDijfbzcqD1ZpWCydKOJSDz+QvoVWIUTEsZuY=;
        b=JwwSOKAND34lysLNzT5x8s2nTWTzDYmCondOT1xKCCsHCn0NGFesmxZegM6ck43bOw
         xFvLvtRBYkvc9QpZ37xVfRMjFeHp1KmWIbENs2QdePH+aPTwjiWhUH0YVSVAzGz2Mf+c
         XCh7vwYacgKdRUD10E+5HyFoVvb3LX17CfrsCod+spF0enfh60DB4I0lHWzCTzWs5gzw
         NhkFlz4fL25L20n3ol281TpcPpDuIQ5l9y153RhgT48LaBxTu7m3zdBHxpRZX1MMSE+K
         PNGdExNCbmRvGZY9W/NdwtPVo0AM6eJxAJ3zgB3UtRugXSRUdE2skbE0bLRBnjYNxNIW
         BKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AWAguikDijfbzcqD1ZpWCydKOJSDz+QvoVWIUTEsZuY=;
        b=qHqzb4OwGTO2DC9td+jnNn0A0tKONmOlvLExu9S0N+5/9YjJE1UqndijBgh7b/NTdY
         27xcpVkkykxseOx3pxIPXhnY7xkylE5BQBGzG7zHoC5vwWQU0nnl9/pQfrCCV3JESDi8
         u0RcvCssCz3kD5xMsMpvZI4czcTZX5FT33tGBVaPGiu3y8uxzF69nDqbRlCFcP6QvjJG
         7/dU9qxF2KSrFIzTKog4kslMMtYLMLZ8fwd5tdg+wNEUbIecfuRaJ5udcBkdI/zxAcAZ
         CqVCLXFNDsLjckqUJ54Rwm0v9qcwdPteslMoY2U7Qur3PtJsROcBZuzJFGWBt9JQcQvC
         q2QA==
X-Gm-Message-State: AOUpUlEzxI1clT/6wKDpGNAFAakxScWMW38Scx1Vn8TIGa7Olnwb4nPb
        GpOY2NEgTn6RH7AXT4zkY6lNIg==
X-Google-Smtp-Source: AA+uWPxZziK4cLsAwv1uGuqsXO+ldEONvDg/TJjVUkK2p2NvGUvni6Ev4Ghfoe5TM7K5BKi3XlQPiQ==
X-Received: by 2002:a50:d01a:: with SMTP id j26-v6mr8486122edf.15.1533908194623;
        Fri, 10 Aug 2018 06:36:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:920:1961:8000:91a4:c122:87f:cfa0])
        by smtp.gmail.com with ESMTPSA id i15-v6sm7989827ede.66.2018.08.10.06.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:36:33 -0700 (PDT)
From:   Benno Evers <bevers@mesosphere.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Benno Evers <bevers@mesosphere.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf tools: Check for null when copying nsinfo.
Date:   Fri, 10 Aug 2018 15:36:13 +0200
Message-Id: <20180810133614.9925-1-bevers@mesosphere.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument to nsinfo__copy() was assumed to be valid, but some code paths
exist that will lead to NULL being passed.

In particular, running 'perf script -D' on a perf.data file containing an
PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
the event stream will lead to a segfault.

Since all calling code is already checking for a non-null return value,
just return NULL for this case as well.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Benno Evers <bevers@mesosphere.com>
---
Changes from v1:
  Added Signed-off-by line.

 tools/perf/util/namespaces.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 5be021701f34..cf8bd123cf73 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
+	if (nsi == NULL)
+		return NULL;
+
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
 		nnsi->pid = nsi->pid;
-- 
2.17.1

