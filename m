Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B4ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF752150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF752150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJQW5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:57:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:41696 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeJQW5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:57:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 08:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="96035872"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2018 08:01:29 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
In-Reply-To: <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net> <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
Date:   Wed, 17 Oct 2018 18:01:28 +0300
Message-ID: <871s8o62if.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Budankov <alexey.budankov@linux.intel.com> writes:

> Since it reduces to single cpu context (and single task context) at all times, 
> ideally, it would probably be coded as simple as this: 
>
> 	perf_rotate_context()
> 	{
>             cpu = this_cpu_ptr(&cpu_context)
>             for_every_pmu(pmu, cpu)
>                     for_every_event_ctx(event_ctx, pmu)
> 	                    rotate(event_ctx, pmu)
> 	}
>
> so rotate(event_ctx, pmu) would operate on common events objects semantics 
> and memory layout, and PMU specific code handle SW/HW programming differences.

Ok, what's event_ctx and how does that simplify things?

Regards,
--
Alex
