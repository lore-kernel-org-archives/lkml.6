Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A398C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AC920818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBKI0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:26:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:11716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfBKI0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:26:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 00:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="115240623"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2019 00:26:00 -0800
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory to
 aid Intel PT tracing
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190207111901.2399-1-adrian.hunter@intel.com>
 <20190208232924.bpdjuaqufndigtd4@ast-mbp>
 <85ebb8e5-97a0-801a-8d5f-bc09a72047bb@intel.com>
 <20190211081840.j3vhyp3cffftb6m2@ast-mbp>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5ecbd520-b73a-5dca-457d-e00f09bf5a06@intel.com>
Date:   Mon, 11 Feb 2019 10:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211081840.j3vhyp3cffftb6m2@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 10:18 AM, Alexei Starovoitov wrote:
> On Mon, Feb 11, 2019 at 09:54:01AM +0200, Adrian Hunter wrote:
>>
>> Which is not really a real use-case.
> ..
>>> perf analysis with PT becomes inaccurate and main goal
>>> of retaining accurate instruction info is not achieved.
>>
>> For the majority of real use-cases, yes it is.
> 
> In our fleet not a single server is using Intel PT, yet you're
> proposing to penalize all of them with shrinker-based JIT freeing?

I already responded to that.

> There is no negotiation here.

Apart from Peter and Ingo already having indicated a different approach is
preferred, why not? Shouldn't maintainers provide technical reasons.
