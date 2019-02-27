Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B92C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4406120C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfB0Pk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:40:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:20106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfB0Pk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:40:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 07:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="119533738"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2019 07:40:25 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id 901B05804B4;
        Wed, 27 Feb 2019 07:40:22 -0800 (PST)
Subject: Re: [PATCH v3 0/9] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
 <20190227142804.GB30149@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d6b0a2f0-0ab7-7a60-3bb4-7e2d60af6424@linux.intel.com>
Date:   Wed, 27 Feb 2019 18:40:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227142804.GB30149@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.02.2019 17:28, Jiri Olsa wrote:
> On Tue, Feb 26, 2019 at 08:31:38AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> TESTING:
>>
>> tools/perf/perf test
>>  1: vmlinux symtab matches kallsyms                       : Skip
>>  2: Detect openat syscall event                           : Ok
>>  3: Detect openat syscall event on all cpus               : Ok
>>  4: Read samples using the mmap interface                 : Ok
>>  5: Test data source output                               : Ok
>>  6: Parse event definition strings                        : Ok
>>  7: Simple expression parser                              : Ok
>>  8: PERF_RECORD_* events & perf_sample fields             : Ok
>>  9: Parse perf pmu format                                 : Ok
>> 10: DSO data read                                         : Ok
>> 11: DSO data cache                                        : Ok
>> 12: DSO data reopen                                       : Ok
>> 13: Roundtrip evsel->name                                 : Ok
>> 14: Parse sched tracepoints fields                        : Ok
>> 15: syscalls:sys_enter_openat event fields                : Ok
>> 16: Setup struct perf_event_attr                          : Skip
>> 17: Match and link multiple hists                         : Ok
>> 18: 'import perf' in python                               : FAILED!
> 
> Arnaldo's perf/core is passing for me in here:
> 
> [jolsa@krava perf]$ ./perf test 16 48
> 16: Setup struct perf_event_attr                          : Ok
> 48: Synthesize attr update                                : Ok

Passes for me too when I run in tools/perf/ dir:

[root@nntvtune39 acme]# pwd && tools/perf/perf test 16 48
/root/abudanko/kernel/acme
16: Setup struct perf_event_attr                          : Skip
48: Synthesize attr update                                : Ok
[root@nntvtune39 acme]# cd tools/perf/
[root@nntvtune39 perf]# pwd && tools/perf/perf test 16 48
[root@nntvtune39 perf]# pwd && perf test 16 48
/root/abudanko/kernel/acme/tools/perf
16: Setup struct perf_event_attr               : Ok
48: Synthesize attr update                     : Ok

Thanks,
Alexey

> 
> jirka
> 
