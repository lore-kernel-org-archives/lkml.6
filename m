Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD18C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CC420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWIkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:40:06 -0500
Received: from gateway20.websitewelcome.com ([192.185.61.9]:46040 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfAWIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:40:06 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 83499400CC7C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:40:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mE4rgLo4PdnCemE4rgOyWI; Wed, 23 Jan 2019 02:40:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41690 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmE4r-003zVw-3E; Wed, 23 Jan 2019 02:40:05 -0600
Subject: Re: [PATCH] perf tests: evsel-tp-sched: Fix bitwise operator
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190122233439.GA5868@embeddedor> <20190123083338.GK27625@krava>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <7b2a7cad-3feb-fe79-04aa-31d53de19fa7@embeddedor.com>
Date:   Wed, 23 Jan 2019 02:40:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123083338.GK27625@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmE4r-003zVw-3E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:41690
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 2:33 AM, Jiri Olsa wrote:
> On Tue, Jan 22, 2019 at 05:34:39PM -0600, Gustavo A. R. Silva wrote:
>> Notice that the use of the bitwise OR operator '|' always leads to
>> true in this particular case, which seems a bit suspicious due to
>> the context in which this expression is being used.
>>
>> Fix this by using bitwise AND operator '&' instead.
>>
>> This bug was detected with the help of Coccinelle.
>>
>> Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> nice catch
> 

Glad to help. :)

> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Thanks
--
Gustavo

> thanks,
> jirka
> 
> 
>> ---
>>
>> NOTE: Notice that this code has been there since 2012. So, it would
>>       be helpful if someone can double-check this. Thanks.
>>
>>  tools/perf/tests/evsel-tp-sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
>> index 5f8501c68da4..5cbba70bcdd0 100644
>> --- a/tools/perf/tests/evsel-tp-sched.c
>> +++ b/tools/perf/tests/evsel-tp-sched.c
>> @@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
>>  		return -1;
>>  	}
>>  
>> -	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
>> +	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
>>  	if (should_be_signed && !is_signed) {
>>  		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
>>  			 evsel->name, name, is_signed, should_be_signed);
>> -- 
>> 2.20.1
>>
