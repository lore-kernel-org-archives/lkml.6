Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD64DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9C820881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA1Ijx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:39:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:55387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfA1Ijx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:39:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 00:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="133693789"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2019 00:39:51 -0800
Received: from [10.125.252.29] (abudanko-mobl.ccr.corp.intel.com [10.125.252.29])
        by linux.intel.com (Postfix) with ESMTP id 3838C58028E;
        Mon, 28 Jan 2019 00:39:49 -0800 (PST)
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <27127a53-4393-ab69-ff61-0d0a36a629a0@linux.intel.com>
 <20190128082023.GA15461@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <28a1a12f-f3a0-d8cc-7312-435d19b49e65@linux.intel.com>
Date:   Mon, 28 Jan 2019 11:39:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128082023.GA15461@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2019 11:20, Jiri Olsa wrote:
> On Mon, Jan 28, 2019 at 10:13:20AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>> ---
>>> Alexey Budankov (4):
>>>   perf record: allocate affinity masks
>>>   perf record: bind the AIO user space buffers to nodes
>>>   perf record: apply affinity masks when reading mmap buffers
>>>   perf record: implement --affinity=node|cpu option
>>>
>>>  tools/perf/Documentation/perf-record.txt |   5 ++
>>>  tools/perf/builtin-record.c              |  45 +++++++++-
>>>  tools/perf/perf.h                        |   8 ++
>>>  tools/perf/util/cpumap.c                 |  10 +++
>>>  tools/perf/util/cpumap.h                 |   1 +
>>>  tools/perf/util/evlist.c                 |   6 +-
>>>  tools/perf/util/evlist.h                 |   2 +-
>>>  tools/perf/util/mmap.c                   | 105 ++++++++++++++++++++++-
>>>  tools/perf/util/mmap.h                   |   3 +-
>>>  9 files changed, 175 insertions(+), 10 deletions(-)
>>>
>>> ---
>>> Changes in v5:
>>> - avoided multiple allocations of online cpu maps by 
>>>   implementing it once in cpu_map__online()
>>> - reduced indentation at record__parse_affinity()
>>
>> Are there any more comments on this patch set?
> 
> sry for late reply.. there was a mayhem in here
> last week because of the devconf ;-)

Aww, I see. Thanks for update.

-Alexey

> 
> I'll review it today, but I think there were no more issues
> 
> jirka
> 
