Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E62082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BQeLV017"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2E62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeKCGdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:33:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKCGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:33:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so1501215pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kLzO9MafblSHtEsANRdd2rJ0NKIfD1wbR4srE4hISEM=;
        b=BQeLV017g+iVu4YUURKiI1VX3PN3PvIwXwp/Pgh+eAukS7t7hPaMhQg8yb78zLPPPe
         rqC1EfiqGTHLNTps3xaXM/9QFt8PmW77RB7huFhOhIDeuZ8ZGqyRjVKDHL/4l8PtIpbA
         RqsSR2Pt7K9D6vtoYnnNvf7/XFiqgIWZJdmp1tDkjndf2BWoGZiZBFlGwkEpjwjA2t+S
         o5xZPEETbF8ZDaq1t893aJuZlE12Bigg8PzGYRBUtbbebOM6pZrU2QAY1Ri+11i1/YjD
         lTbeJaQokup6duwnjzID4Vv+9fsfw3WkHtgwQdGOKLnckf3VUNRc2eFU5KnSgRwHfvD2
         et8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kLzO9MafblSHtEsANRdd2rJ0NKIfD1wbR4srE4hISEM=;
        b=H/X1hR8HMJwqSovMn4Xc0Xs8PrQAW2qfHfqUyFlQMBwymg2uD8WRykoMxA5xXWKNYT
         Jy8MfcFhGzla9ys4XG8EeiOm7xcfhLeYdK6jp/MCZ5Wq1hnVM1tNIZoBBIDGpxOD2I71
         yOefgESJtAGFbVuY+IjqR2hyTEG5pZGVpe/MGShJRb3mYIjQ51cSWvfwuRCjn246Q6bT
         w/FdlxvqxDByjL7djxt5sx7JT6gYjrnWFnBwuqyB0U8k//jMDIwFUb/1RSFJt8ypX4yT
         9IksdgRGBtg2S+64CnzfcIKaF8I+xeiIaHvRizcQLyAgZWFqkwAGfOWWL67+r8iHuYmM
         8qtg==
X-Gm-Message-State: AGRZ1gK0ZFXlG6KOOeUTadfWHvIZT/bvwD/R3XRf2yfoxC3LbNsuOZXl
        +9v7eREaQENKm6GjAt3R7FznDA==
X-Google-Smtp-Source: AJdET5dacdXN4XjRAqGfz/oN1CW56+/UGZr2MNy/iE/BDLYcuLyvtGHYJqZB6I9LKNDARLh2980IGA==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr12499129pgg.52.1541193857140;
        Fri, 02 Nov 2018 14:24:17 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id b75-v6sm578973pfb.96.2018.11.02.14.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:24:15 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] kdb: fix strncpy warning
Date:   Fri,  2 Nov 2018 14:24:05 -0700
Message-Id: <20181102212405.5911-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb does a strncpy(a, b, strlen(b)+1), which makes no sense. Might as
well do a strcpy at this point.

Fixes this warning:

In function 'strncpy', inlined from 'kallsyms_symbol_next' at kernel/debug/kdb/kdb_support.c:239:4:
./include/linux/string.h:253:9: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 kernel/debug/kdb/kdb_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 990b3cc526c8..d5af8b38b84d 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -236,7 +236,7 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
 
 	while ((name = kdb_walk_kallsyms(&pos))) {
 		if (strncmp(name, prefix_name, prefix_len) == 0) {
-			strncpy(prefix_name, name, strlen(name)+1);
+			strcpy(prefix_name, name);
 			return 1;
 		}
 	}
-- 
2.11.0

