Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87BE207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfBFJMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:12:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:21952 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfBFJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:12:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 01:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="272877872"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2019 01:12:09 -0800
Subject: Re: [PATCH 0/6] perf thread-stack: x86 retpolines
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190110095525.GC25764@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0a4fc425-40e6-feb0-8872-15d5c356c015@intel.com>
Date:   Wed, 6 Feb 2019 11:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110095525.GC25764@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/19 11:55 AM, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 11:18:29AM +0200, Adrian Hunter wrote:
>> Hi
>>
>> Here are some patches to improve the exported call graph, primarily to deal
>> with x86 retpolines.
>>
>>
>> Adrian Hunter (6):
>>       perf tools: Fix split_kallsyms_for_kcore for trampoline symbols
>>       perf thread-stack: Tidy thread_stack__push_cp() usage
>>       perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
>>       perf thread-stack: Represent jmps to the start of a different symbol
>>       perf thread-stack: Improve thread_stack__no_call_return()
>>       perf thread-stack: Hide x86 retpolines
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Can these be applied?

> 
> thanks,
> jirka
> 
>>
>>  tools/perf/scripts/python/export-to-postgresql.py |   2 +-
>>  tools/perf/scripts/python/export-to-sqlite.py     |   2 +-
>>  tools/perf/util/symbol.c                          |   2 +
>>  tools/perf/util/thread-stack.c                    | 235 ++++++++++++++++++----
>>  tools/perf/util/thread-stack.h                    |   3 +
>>  5 files changed, 208 insertions(+), 36 deletions(-)
>>
>>
>> Regards
>> Adrian
> 

