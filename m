Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1388E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bun0wgKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBHWfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:35:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45277 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfBHWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:35:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2335103plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6GftFjwiUCvtcxvEAR034ySjK3PZ5xc2bnvkHKBDpk=;
        b=bun0wgKexaPR9h1OnV4KNy3aKndX2kD6XNTFbuR6SjmfPYmiiApvRoy+EDadujf8lr
         L6DiA66LmluEXijU+iVgYFs9wY+QXXCf81bQHP4QfS00zuGXMK2AsEKfclZoAWEp1jpO
         CVMMYWzNdbm+jPau6bNJ0StEAHUAKJ1B/FrDj/YovDMrGLhqW5250mMpiRSzKEvOWRCR
         BYl/fT7VKrpROvNNb7xSRMTNljt2JIv0jL0jYXgp6g3psaivxqLrTv26pUpuyqCOMoMW
         tdGzEva6qK6vbQVPGeafzaWet2C85C/8cZX22Xasad3TIgHCdQso7fuwSsiJ6oapASho
         +FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6GftFjwiUCvtcxvEAR034ySjK3PZ5xc2bnvkHKBDpk=;
        b=V6/dMh49IFSksUbU+4iohpfWAVyCVFLmamXZmUqnEomMC6MfHhYjgUHXXxLJufNCaT
         E12hAmgDn6+W9vI2TU7s3FNfs9g6rxtMRIC+lQqC1fAhHNtUZkpnUd9vzelOmdOcL1Jj
         eD8+FVCfPMQnUiHJKcE3M3N5u4naVYqxEmWgjyQowhzhVOyutAMaRhGsNgN72lPMRuwI
         36llv0RssWpWV/1URHnOmpZf3wPulXXUxPEld/re64jMTsM27YDqAaYzAaC46HcGrdpj
         Q3jfiUZhQpvro1OCiM0J3t6IvPi1W5fU5lbzMdb8Ohd3CJeX+OHrM46vMMJOhhfCZ+XK
         HNrg==
X-Gm-Message-State: AHQUAuYMM+IJW4twpAQhZHiFrNnTTET02eJQ59YbuEWW3GH5jgks1Edy
        CsbyUs5FyEc20/vDwIxQM9cb5A==
X-Google-Smtp-Source: AHgI3IZbdR+luYjf6iojCCnmknIkV2mhrkTAJ9dJF/07q98Gth8zpCHzJpWXXtIH6n9fiUHHMtP57A==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr24548278pla.252.1549665345364;
        Fri, 08 Feb 2019 14:35:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h8sm3610634pgv.27.2019.02.08.14.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 14:35:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Add proper header file for symbols
Date:   Fri,  8 Feb 2019 15:35:43 -0700
Message-Id: <20190208223543.31836-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit e22c1c751140 ("perf thread: Don't include symbol.h,
symbol_conf.h is enough")'

Compilation of the perf tools is broken when using the functionality
provided by the openCSD library:

[...]

...                       timerfd: [ on  ]
...                  sched_getcpu: [ on  ]
...                           sdt: [ OFF ]
...                         setns: [ on  ]
...                    libopencsd: [ on  ]

[...]

  CC       util/arm-spe.o
  CC       util/arm-spe-pkt-decoder.o
  CC       util/s390-cpumsf.o
  CC       util/cs-etm.o
  CC       util/parse-branch-options.o
util/cs-etm.c: In function ‘cs_etm__mem_access’:
util/cs-etm.c:297:24: error: storage size of ‘al’ isn’t known
  struct  addr_location al;

And rightly so since file cs-etm.c doesn't include symbol.h, something
that is rectified in this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b3f882d6e2f..0b11d653cfbe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -25,6 +25,7 @@
 #include "machine.h"
 #include "map.h"
 #include "perf.h"
+#include "symbol.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "thread-stack.h"
-- 
2.17.1

