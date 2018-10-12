Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE82C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B4920868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B4920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJLRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:53:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:34341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbeJLRxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:53:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 03:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="80896763"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2018 03:21:23 -0700
Received: from [10.125.251.247] (abudanko-mobl.ccr.corp.intel.com [10.125.251.247])
        by linux.intel.com (Postfix) with ESMTP id B1D2C58015C;
        Fri, 12 Oct 2018 03:21:20 -0700 (PDT)
Subject: Re: [PATCH v13 3/3]: perf record: extend trace writing to multi AIO
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
References: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
 <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
 <20181012094901.GA22076@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2f711022-41ec-275c-7f9f-a1f269b23b37@linux.intel.com>
Date:   Fri, 12 Oct 2018 13:21:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012094901.GA22076@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.10.2018 12:49, Namhyung Kim wrote:
> Hi,
> 
> On Thu, Oct 11, 2018 at 09:59:19PM +0300, Alexey Budankov wrote:
>>
<SNIP>
>> @@ -1882,8 +1913,8 @@ static struct option __record_options[] = {
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>>  #ifdef HAVE_AIO_SUPPORT
>> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
>> -		     NULL, "Enable asynchronous trace writing mode",
>> +	OPT_CALLBACK(0, "aio", &record.opts,
>> +		     "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
> 
> One question.  It seems you used a very large N in your test result.
> Why did you limit it to 4 here?  Is it something different?  Maybe
> you'd better making it a macro constant for future changes..

Yes, it's less than values used during metrics measurements.
There is still no good rationale behind top border value 
because currently it is a kind of implementation detail. 
Defining as a macro makes sense for easier source code management.

Thanks,
Alexey

> 
> Otherwise looks good to me.  For the 3 patches
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
