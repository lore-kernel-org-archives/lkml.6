Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeCHN2Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:28:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeCHN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:28:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Mar 2018 08:28:13 -0500
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC V4] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
In-Reply-To: <20180308130358.GC3701@kernel.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
 <20180308130358.GC3701@kernel.org>
Message-ID: <ae102272a8186f0351363511f4ed07f8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-08 08:03, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 07, 2018 at 03:35:47PM -0500, Agustin Vega-Frias escreveu:
>> +++ b/tools/perf/util/parse-events.y
>> @@ -8,6 +8,7 @@
>> 
>>  #define YYDEBUG 1
>> 
>> +#include <fnmatch.h>
>>  #include <linux/compiler.h>
>>  #include <linux/list.h>
>>  #include <linux/types.h>
>> @@ -234,6 +235,10 @@ PE_NAME opt_event_config
>>  	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
>>  		struct perf_pmu *pmu = NULL;
>>  		int ok = 0;
>> +		char *pattern;
>> +
>> +		if (asprintf(&pattern, "%s*", $1) < 0)
>> +			YYABORT;
> 
> +               if (asprintf(&pattern, "?(uncore_)%s*", $1) < 0)
> 
> I completely overlook that you were using this and thus needed that
> extension, duh, thanks for the patience 8-) and for the new patch.
> 

NP Arnaldo, thanks for the quick turnaround on these patches :o)
Just so I know, since these are my first patches on perf tools,
where are perf tools patches queued once acked?

Thanks!

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
