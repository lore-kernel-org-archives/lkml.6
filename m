Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10580C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF98320855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfAVMzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:55:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:36707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfAVMzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:55:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 04:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="111722575"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2019 04:55:09 -0800
Received: from [10.252.24.137] (abudanko-mobl.ccr.corp.intel.com [10.252.24.137])
        by linux.intel.com (Postfix) with ESMTP id CAB3E580434;
        Tue, 22 Jan 2019 04:55:06 -0800 (PST)
Subject: Re: [PATCH v4 4/4] perf record: implement --affinity=node|cpu option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <77852017-b6ee-4fe1-4f3d-63827d78078f@linux.intel.com>
 <8086d41c-21eb-1c80-9a62-22c08d961b14@linux.intel.com>
 <20190121115448.GB3852@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <16d51c60-3964-4ed6-30c7-a414cfdbc089@linux.intel.com>
Date:   Tue, 22 Jan 2019 15:55:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121115448.GB3852@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2019 14:54, Jiri Olsa wrote:
> On Wed, Jan 16, 2019 at 12:23:56PM +0300, Alexey Budankov wrote:
>>
>> Implement --affinity=node|cpu option for the record mode defaulting
>> to system affinity mask bouncing.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> changes in v3:
>> - adjusted indentation at record__parse_affinity()
> 
> having problems to apply this one:
> 
> Applying: perf record: allocate affinity masks
> Applying: perf record: bind the AIO user space buffers to nodes
> Applying: perf record: apply affinity masks when reading mmap buffers
> Applying: perf record: implement --affinity=node|cpu option
> error: corrupt patch at line 62
> Patch failed at 0004 perf record: implement --affinity=node|cpu option

It looks like Arnaldo's perf/core is progressing fast.

Currently I have this thing when building clean Arnaldo's perf/core:

  CC       tests/hists_output.o
In file included from util/session.c:26:
util/sample-raw.h:9:6: error: redundant redeclaration of perf_evlist__s390_sample_raw [-Werror=redundant-decls]
 void perf_evlist__s390_sample_raw(struct perf_evlist *evlist,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from util/session.c:13:
util/evlist.h:321:6: note: previous declaration of perf_evlist__s390_sample_raw was here
 void perf_evlist__s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC       tests/hists_cumulate.o
  CC       tests/python-use.o
  CC       util/s390-sample-raw.o

Thanks,
Alexey

> 
> 
> jirka
> 
