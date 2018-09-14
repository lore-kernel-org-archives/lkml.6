Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D49ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CED20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CED20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeINOvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:51:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:62088 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbeINOvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:51:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 02:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="88716932"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2018 02:37:45 -0700
Received: from [10.125.251.160] (abudanko-mobl.ccr.corp.intel.com [10.125.251.160])
        by linux.intel.com (Postfix) with ESMTP id CD75158053F;
        Fri, 14 Sep 2018 02:37:42 -0700 (PDT)
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava> <20180914082858.GH24224@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
Date:   Fri, 14 Sep 2018 12:37:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914082858.GH24224@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2018 11:28, Jiri Olsa wrote:
> On Fri, Sep 14, 2018 at 10:26:53AM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
>>>> The threaded monitoring currently can't monitor backward maps
>>>> and there are probably more limitations which I haven't spotted
>>>> yet.
>>>>
>>>> So far I tested on laptop:
>>>>   http://people.redhat.com/~jolsa/record_threads/test-4CPU.txt
>>>>
>>>> and a one bigger server:
>>>>   http://people.redhat.com/~jolsa/record_threads/test-208CPU.txt
>>>>
>>>> I can see decrease in recorded LOST events, but both the benchmark
>>>> and the monitoring must be carefully configured wrt:
>>>>   - number of events (frequency)
>>>>   - size of the memory maps
>>>>   - size of events (callchains)
>>>>   - final perf.data size
>>>>
>>>> It's also available in:
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>>>   perf/record_threads
>>>>
>>>> thoughts? ;-) thanks
>>>> jirka
>>>
>>> It is preferable to split into smaller pieces that bring 
>>> some improvement proved by metrics numbers and ready for 
>>> merging and upstream. Do we have more metrics than the 
>>> data loss from trace AIO patches?
>>
>> well the primary focus is to get more events in,
>> so the LOST metric is the main one
> 
> actualy I was hoping, could you please run it through the same
> tests as you do for AIO code on some huge server? 

Yeah, I will, but it takes some time.

> 
> thanks,
> jirka
> 
