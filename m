Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D652C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BE720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2EfoCCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BE720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLJIxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:53:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeLJIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:53:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so9576020wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RhEccwMmtKbXni8WbCuC9MbU3ATtmsHEMgXp+M5cHn4=;
        b=k2EfoCCtoFQYVyLkCyTr/cgGYJ6VG6uJxyLicesF9OiSZTkOpWQ9j/3g7JWAfjgo81
         F0vCCvVfUryNVdqFjFquN7AhOKy1eGmrA9uCXlsI7I1NZ0aoDUh0SJORtrtF2NsCpX74
         VwCCXZbPEdw/xXZWISF3wyB/Oq/qsJ1/O/MV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RhEccwMmtKbXni8WbCuC9MbU3ATtmsHEMgXp+M5cHn4=;
        b=MG+qvvHcTSB3SB5Feq1cISrgwtKgM7bZzvo87H0j/yw3/ZDnWe2F/yyBl81u2pUTEi
         BaxoaXfbzvGcVHB8oU0Mx0XEl+bEHdKE9dozgp+Prwq7FQ94cNXMcqu6TtEvn9wmzeag
         5OXzryMxVGA3uWpI8RWlbZi9c0/3gQRwz9pfa+u61IxsByvIKi+G4bTjTKKHbREI+4hz
         TCjnaEVLKtTFYTOL/LOKirCdj6j02FndXqtB7VkN2zXu37HZN/98zjpEWKutnBChCmzo
         gpXQCDr71W0WgRas6mR58adg8+5fN0aV6w/1osPnBzCnhkp4h/kyGQN5Os3zN28OZlPC
         smyw==
X-Gm-Message-State: AA+aEWZS8wasnMiIDTQmymO2RJCjqs0+abneK7Svfdzp5HOjWMsPb7cb
        0gt0M1Td6UZmf/jdMC+Muy8gUw==
X-Google-Smtp-Source: AFSGD/VCjboe0d+yOjjsW9h9Lv0AQhytmN5DOMp9jJoPhw+QGsX3xLQxfAW+w4I47E2Fcngyod9ulw==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr9732610wrx.53.1544431998293;
        Mon, 10 Dec 2018 00:53:18 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 00:53:17 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/6] perf cs-etm: Correct packets handling
Date:   Mon, 10 Dec 2018 16:52:55 +0800
Message-Id: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf cs-etm module converts decoder elements to packets and then we have
more context crossing packets to generate synthenize samples, finally
perf tool can faciliate samples for statistics and report the results.

This patch series is to address several issues found related with
packets handling and samples generation when worked firstly on branch
sample flags support for Arm CoreSight trace data, so this patch series
is dependency for sample flags setting, will send another dedicated
patch series for sample flags later.

In this patch series, the first two patches are mainly to fix issues in
cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
and this can fix the wrong branch sample caused by the missed packets
swapping; patch 0002 is to fix the wrong samples generation with stale
packets at the end of trace block.

Patch 0003 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
a more general packet type to present trace discontinuity, so it can be
used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
elements.

Patch 0004 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0005 is used to support EO_TRACE packet, which also introduces
the tracing discontinuity at the end of trace and we should save last
trace data for it.

Patch 0006 is used to generate branch sample for exception packets.

This patch series is applied on the acme's perf/core branch [1] with
latest commit 4085fed6373f ("perf trace: Add ordered processing");
Since Rob's patch 'perf: Support for Arm A32/T32 instruction sets in
CoreSight trace' has been merged into perf/core branch, this patch
series can directly be applied onto perf/core branch.

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v1:
* Synced the consistent code in patch 0001 for condition checking.
* Introduced new function cs_etm__end_block() for flushing packet
  at the end of trace block.
* Added new patch 0003 to rename CS_ETM_TRACE_ON to
  CS_ETM_DISCONTINUITY.
* Used the same one packet type CS_ETM_DISCONTINUITY for all
  trace discontinuity (include support TRACE_ON/EO_TRACE/NO_SYNC
  packets).
* Removed tracking exception number patch, which will be added in
  sample flag patch series.


Leo Yan (6):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
  perf cs-etm: Treat NO_SYNC element as trace discontinuity
  perf cs-etm: Treat EO_TRACE element as trace discontinuity
  perf cs-etm: Generate branch sample for exception packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 40 +++++++++----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
 tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
 3 files changed, 102 insertions(+), 25 deletions(-)

-- 
2.7.4

