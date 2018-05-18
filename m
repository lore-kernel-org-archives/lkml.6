Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeERHV5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:21:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:15400 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeERHV4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:21:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="40931554"
Subject: Re: [PATCH v2 2/3] perf report: Use perf_evlist_forced_leader to
 support '--group'
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
 <1526648260-30540-3-git-send-email-yao.jin@linux.intel.com>
 <20180518070441.GB30793@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2079e88e-7c15-9589-3ce8-9fe831bf60f1@linux.intel.com>
Date: Fri, 18 May 2018 15:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518070441.GB30793@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 3:04 PM, Jiri Olsa wrote:
> On Fri, May 18, 2018 at 08:57:39PM +0800, Jin Yao wrote:
>> Since we have created a new function perf_evlist_forced_leader,
>> so now remove the old code and use perf_evlist_forced_leader
>> instead.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 4c931af..63fe776 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -202,12 +202,8 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
> 
> there's comment in this place, which no longer applies in here:
> 
> 
> /*
>   * Events in data file are not collect in groups, but we still want
>   * the group display. Set the artificial group and set the leader's
>   * forced_leader flag to notify the display code.
>   */
> 
> could you please move/change/apply it to perf_evlist_forced_leader
> 
> thanks,
> jirka
> 

Oh, yes, I should move the comment to perf_evlist_forced_leader.

I will do it in next version.

Thanks
Jin Yao

>>   static void setup_forced_leader(struct report *report,
>>   				struct perf_evlist *evlist)
> 
>>   {
>> -	if (report->group_set && !evlist->nr_groups) {
>> -		struct perf_evsel *leader = perf_evlist__first(evlist);
>> -
>> -		perf_evlist__set_leader(evlist);
>> -		leader->forced_leader = true;
>> -	}
>> +	if (report->group_set)
>> +		perf_evlist_forced_leader(evlist);
>>   }
>>   
>>   static int process_feature_event(struct perf_tool *tool,
>> -- 
>> 2.7.4
>>
