Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35707C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DA921872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2ZSrLHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfAXAWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:22:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54492 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAXAWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:22:15 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so2178118ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 16:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq26wBwdphGhxuD+bxSAg1THJpV9yeIbnvU9pP25ugg=;
        b=V2ZSrLHtPGy/QsRaIVfwbLq5z50RyCplDtJXZD+mYEt+A4b0DQekuo/ZHBjl9avzmK
         wLnlbf345GHtuNxJEEgBCwIvcDWlspoy4408WqXG2NGffO9tVHFuIDIrxrj8LnVjsBI/
         81jQ/4VdHPZYf0yAYCUZCviqii8GZZTY6AAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq26wBwdphGhxuD+bxSAg1THJpV9yeIbnvU9pP25ugg=;
        b=sNt++/C6neL3jybMLWJOXKLth0U+9ul49O4vJwGcvbbI2CJzJDXWef4QICFkyWNzj9
         pAkA80yMG4aAAiK7enedbUlb/DAK41UaEn76crji22eMhgu4dfG+/h67BMnOMhu1Z1nP
         LqI9wR4ojKxFKCUGOybFoh0YDaL0M0MfZDvn7h+zMS+2GcBhC4CD5SmzlNpTJktIQqS6
         MlJi0Eswesas9UTbKSHj383ImFyORSGXYtp6qt6jKMY+p82x0A8ov+dfc5bxXPGKR0ua
         9SHZAny6eiqFRzgQEBZIFLXuh4GAaWzM9J2s5Ia3UsRg9M0HpUqm3fXhhCrHHDrr4Hn0
         bBsQ==
X-Gm-Message-State: AJcUukdCTUb+LbZQWvYaa5GbrAhVeWH1ERm4VshmL1pxWpOa+S4GyViP
        6ftJxu6osWoWIK59m0ZAuG3Bfnt8tOcWsoTeJVr0rw==
X-Google-Smtp-Source: ALg8bN5vDM8g0uhzGEp4oUuFFTMPPk1J39z4bNDEp9807L9tGf4zyswfDCKYyWwJjZpor9i+wlaAQjdtxl9PTpXthW8=
X-Received: by 2002:a02:570d:: with SMTP id u13mr2886958jaa.71.1548289334699;
 Wed, 23 Jan 2019 16:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20190119014347.27441-1-leo.yan@linaro.org>
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 23 Jan 2019 17:22:03 -0700
Message-ID: <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 18:44, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch seris adds support for sample flags so can facilitate perf
> to print sample flags for branch instruction.
>
> Patch 0001 is used to save last branch information in packet structure,
> this includes instruction type, subtype and condition flag to help
> making decision for which branch instruction it is.  It passes related
> information from decoder layer to cs-etm.c, so we use cs-etm.c as a
> central place to set sample flags.
>
> Patch 0002 is used to set sample flags for instruction range packet.
>
> Patch 0003 is used to set sample flags for trace discontinuity packet.
>
> Patches 0004/0005/0006 are preparation for exception packet handling:
> Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
> traceID/metadata tuple to access metadata pointer based on traceID, this
> can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
> ETMv4 have totally different definition for exception numbers.
>
> Patch 0007 sets sample flags for exception packet; patch 0008 support
> sample flags for exception return packet.
>
> This patch series is applied on the acme's perf core branch with the
> with latest commit 02bb912ae451 ("perf tools: Replace automatic const
> char[] variables by statics").
>
> After applying this patch series, we can verify sample flags with below
> command:
>
>   # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Since you are going for another iteration please add a "before" and
"after" example.

Thanks,
Mathieu


>
> Changes from v5:
> * Addressed Rob's suggestion to add specification info for exception
>   number encoding;
> * Added Rob's review tag in patch 0007.
>
> Changes from v4:
> * Fixed typos in comments, and removed redundant info from commit log;
> * Addressed Mathieu's suggestion to add helper functions for metadata
>   fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
> * Addressed Mathieu's suggestion to include headers with alphabetical
>   order.
>
> Changes from v3:
> * Fixed typos in commit logs;
> * Rearranged fields in cs_etm_packet by grouping with same variable
>   types;
> * Fixed ETMv4 exception number which pointed by Mike;
> * Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
>   instruction to distinguish them;
> * Refine ETMv4 return exception packet handling.
>
> Changes from v2:
> * Addressed Mathieu's suggestion to split one big patch to 3 small
>   patches for setting sample flags, one is for instruction range
>   packet, one is for discontinuity packet and one is for exception
>   packet.
> * Added supporting for ETMv3 exception packet.
> * Followed Mathieu's suggestion to move all sample flags handling
>   from decoder layer to cs-etm.c, thus it has enough info to set flags
>   based on trace context in single place.
>
> Changes from v1:
> * Moved exception packets handling patches into patch series 'perf
>   cs-etm: Correct packets handling'.
> * Added sample flags fixing up for TRACE_OFF packet.
> * Created a new function which is used to maintain flags fixing up.
>
>
> Leo Yan (8):
>   perf cs-etm: Add last instruction information in packet
>   perf cs-etm: Set sample flags for instruction range packet
>   perf cs-etm: Set sample flags for trace discontinuity
>   perf cs-etm: Add exception number in exception packet
>   perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
>   perf cs-etm: Add traceID in packet
>   perf cs-etm: Set sample flags for exception packet
>   perf cs-etm: Set sample flags for exception return packet
>
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
>  tools/perf/util/cs-etm.c                      | 405 +++++++++++++++++-
>  tools/perf/util/cs-etm.h                      |  48 ++-
>  4 files changed, 482 insertions(+), 18 deletions(-)
>
> --
> 2.17.1
>
