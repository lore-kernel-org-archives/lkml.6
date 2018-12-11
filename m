Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C971B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwvNbU9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C971B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53689 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so1083140wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0xLf3aem1vzf4H8wFJd5N/TwF8GP4yaYTkHAgIk8oEc=;
        b=VwvNbU9lZKLc+Y2c74QwselZ8HynQkbR9SKH6SvYczrrl6K8zB1Wx2d3DAyKpbYmvo
         1ClMh1ZVA0bl8+HtEF0LY/GABmQ184O6JTCoEERgdqwK12qEfQCH/qqauptEVfOkwIDF
         98KTh0wkyBn01uujOkgcheSOHPnAqltUfapBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xLf3aem1vzf4H8wFJd5N/TwF8GP4yaYTkHAgIk8oEc=;
        b=Ta5DyaLk2o66OmsrC7/Ercmg87m7C/xXIDMoOW9r7th1eJKp/hIDcTph9tFEejxC7X
         B5WYLyeNdikVb6WtrhUcjLeqYwaMKjdwCATKSEbtomFqEAb79RvQ9WpiOydeu2daAUSs
         5EgCRtxE0lnaC0Tr5RInTky7HNdaTsna6hkYMcXfsUM7Ayt0x7FjCYIccaP+48QSwkCT
         3M94JmytArqmFsCIunXTwxUICjkuGqiqP2odvWCPnyf03a8geNyNnN3w/1BjF4hVXKqx
         3+uS5Ol47EUUxIjvOKXPVZFLEktVOFdgNE/zad1NzTlguPHO4axaMSH7Ktvn+N+QuS/a
         1jcQ==
X-Gm-Message-State: AA+aEWbUwn4RoNswnoAD6XxOzBOGAL8ZYfZzCO+2au8OHtB+bupVYWyK
        cx7/wb/KGlfKYqO1i5GIkGyRMUiTvaE1tg==
X-Google-Smtp-Source: AFSGD/W9vrjOwA7NvaqQdsKPsDMOaTOfXCMEykKZNDi5Ka33RLq/OnTmvjvHqf0yfQO2WSDgqsEayA==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1385634wmb.44.1544514024252;
        Mon, 10 Dec 2018 23:40:24 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:23 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/8] perf cs-etm: Correct packets handling
Date:   Tue, 11 Dec 2018 15:38:20 +0800
Message-Id: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
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

Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
discontinuity packet generation by using one code block; patch 0004 is to
refactor enumeration cs_etm_sample_type.

Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
a more general packet type to present trace discontinuity, so it can be
used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
elements.

Patch 0006 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0007 is used to support EO_TRACE packet, which also introduces
the tracing discontinuity at the end of trace and we should save last
trace data for it.

Patch 0008 is used to generate branch sample for exception packets.

Credit to Mike Leach and Robert Walker who made me clear for underlying
mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
explanation for why we can treat NO_SYNC and TRACE_ON elements as the
same, so except following Mike & Rob suggestion for trace discontinuity
consolidation, most commit log of patches 0006/0007 also come from
Mike's explanation.

This patch series is applied directly on the acme's perf/core branch [1]
with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
use of the ordered_events code").

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v2:
* Addressed Mathieu's comments and suggestions for minor refactoring
  for removing unused field 'cs_etm_decoder::trace_on' and added one
  dedicated patch to refactor enumeration cs_etm_sample_type.
* Added Mathieu's 'reviewed' tags;  Very appreciate Mathieu's many
  suggestion for crossing several patch series.

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


Leo Yan (8):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
  perf cs-etm: Refactor enumeration cs_etm_sample_type
  perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
  perf cs-etm: Treat NO_SYNC element as trace discontinuity
  perf cs-etm: Treat EO_TRACE element as trace discontinuity
  perf cs-etm: Generate branch sample for exception packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 42 +++++++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
 tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
 3 files changed, 100 insertions(+), 29 deletions(-)

-- 
2.7.4

