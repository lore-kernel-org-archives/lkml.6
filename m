Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CC22133F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfB0K4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:56:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:5373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0K4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:56:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 02:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="323793103"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2019 02:56:13 -0800
Received: from [10.125.252.116] (abudanko-mobl.ccr.corp.intel.com [10.125.252.116])
        by linux.intel.com (Postfix) with ESMTP id 59E4C580261;
        Wed, 27 Feb 2019 02:56:11 -0800 (PST)
Subject: Re: [PATCH v2 4/4] perf report: support record trace file
 decompression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
 <20190212130914.GK775@krava>
 <92aa09eb-6679-c4d6-5d5d-2fa0cf0af8a1@linux.intel.com>
 <0132ec08-e28b-4102-5053-8f8e21e7fd44@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1b857d94-60f1-eeae-6014-0265860d382c@linux.intel.com>
Date:   Wed, 27 Feb 2019 13:56:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0132ec08-e28b-4102-5053-8f8e21e7fd44@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25.02.2019 19:04, Alexey Budankov wrote:
> 
> On 20.02.2019 17:48, Alexey Budankov wrote:
>>
>> On 12.02.2019 16:09, Jiri Olsa wrote:
>>> On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:
>>>>
>>>> PERF_RECORD_COMPRESSED records are decompressed from trace file into
>>>> a linked list of mmaped memory regions using streaming Zstandard API.
>>>> After that the regions are loaded fetching uncompressed events. When
>>>> dumping raw trace (e.g., perf report -D --header) file offsets of
>>>> events from compressed records are set to zero.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>> Changes in v2:
>>>> - moved compression/decompression code to session layer
>>>
>>> could you please add some automated test for this?
>>>
>>> I think it could be part of the sample synthesize test 

Do you mean this one?

tools/perf/tests/sample-parsing.c

Thanks,
Alexey

>>> or even new script test under tests/shell.. or anything
>>> else really.. just to see that we have some clean
>>> interface for this that we can test
>>
>> This is possible. Let's complete the code review first.
>>
>> Thanks,
>> Alexey
>>
>>>
>>> thanks,
>>> jirka
>>>
>>
