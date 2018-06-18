Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C44BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D3620874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDRV5d5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D3620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFRFKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:10:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42253 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeFRFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so6960270pgu.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wv0RJDy6mIMdgxWKBBko5JPPQqEImMcrVm3QSpw1mvc=;
        b=PDRV5d5RedsQYNFTQtyqBpSx1+HJd/W0Sdd7jYDd8gnQgYmnLe1k+YnWS6AnsDAJ2j
         2tLa2KGfwboQhJQlUPCr3avymqAfXF/ZtiOoiUBrB+fVZk9SRPVMDAGP+MiOoqlgxxTd
         AVqYpqNZiPjgV8k9P5yIV2gxsIF0LVP9BMch8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wv0RJDy6mIMdgxWKBBko5JPPQqEImMcrVm3QSpw1mvc=;
        b=hQFQBwtyiOs4FhNihVOpxbh7lAb0MDm40vGUiZ8vkVIXN7xv0oCAM2BeljI+QlmBwZ
         z6iK94/L8vDHFZwy29ad7/JL5RqQJ7VaNXmf0rZn+1ai4TxfGtU8MzJmxZipNS1Upk5e
         zH6RKWHRMSkHz2wB/z+SzoQZggvr+/rsgQW19yCvxi/aobn8Y1cyJJ8rchD4yCwkf3SQ
         zWkEKODS/jOXx0OH1BI1MDft5Ewj79zP+bO5a7H9EQmrZZrVsJ+RgC5+f4m7HZQ/BhH4
         F1yruBbFTu/de59x/wwuGPS4p27wZSBn/e7Jqao57xhgJlS2Su5GiUAg9alEeAC/f9vv
         yF2A==
X-Gm-Message-State: APt69E1dNgWXyi6PkjdaUh4BTp3W9B690Lw8BXDGiKOl+FHXDwvBHw1o
        WirlFk2LZ1s/7jiAzHCaxu9ijA==
X-Google-Smtp-Source: ADUXVKKYwFPLNe4YfCbQuNS/w8Nh7vlk1xk3SHI5UnwglPWlDrj80kyApbzTiDKSJefFO9pC4NonNg==
X-Received: by 2002:a65:450c:: with SMTP id n12-v6mr9805708pgq.242.1529298632344;
        Sun, 17 Jun 2018 22:10:32 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/6] perf cs-etm: Fix tracing packet handling and minor refactoring
Date:   Mon, 18 Jun 2018 13:09:53 +0800
Message-Id: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due the current code is missing to handle cs-etm start tracing packet
and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.

This patch series is to fix cs-etm tracing packet handling:

Patch 0001 is to add invalid address macro for readable coding;

Patch 0002 is one minor fixing to return error code for instruction
sample failure;

Patches 0003~0006 are fixing patches for start tracing packet
and CS_ETM_TRACE_ON packet.

This patch series is applied on acme tree [1] on branch perf/core with
latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
packets").  Also applied successfully this patch series on Linus tree
on 4.18-rc1.

This patch series has been verified on Hikey620 platform with below two
commands:
perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
perf script -F cpu,event,ip,addr,sym -k ./vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git


Leo Yan (6):
  perf cs-etm: Introduce invalid address macro
  perf cs-etm: Bail out immediately for instruction sample failure
  perf cs-etm: Fix start tracing packet handling
  perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
  perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
    packet
  perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
 3 files changed, 68 insertions(+), 14 deletions(-)

-- 
2.7.4

