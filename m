Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeERA2O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:28:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:10089 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeERA2N (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="40849127"
Subject: Re: [PATCH] perf annotate: Support multiple events without group
To: Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1525960762-19520-1-git-send-email-yao.jin@linux.intel.com>
 <20180517162750.GB18538@kernel.org> <20180517202741.GD12497@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <072a16a9-ed3d-5be4-3aeb-c55988124c3f@linux.intel.com>
Date: Fri, 18 May 2018 08:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517202741.GD12497@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 4:27 AM, Jiri Olsa wrote:
> On Thu, May 17, 2018 at 01:27:50PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, May 10, 2018 at 09:59:22PM +0800, Jin Yao escreveu:
>>> See example,
>>>
>>> perf record -e cycles,branches ./div
>>> perf annotate main --stdio or
>>> perf annotate main --stdio2 or
>>> perf annotate main
>>>
>>> The "perf annotate" should show both cycles and branches on the
>>> left side, but actually it only shows one event cycles.
>>>
>>> It works with events group like:
>>> perf record -e "{cycles,branches}" ./div
>>>
>>> It should work too even without group.
>>
>> Humm, I think that this should be done the way it is for perf report,
>> i.e. you select the group output by using --group, no?
>>
>> Jiri, isn't that how it is done in 'perf report' for non-explicit
>> groups?
> 
> yep, if there's no event group, the --group will enable the group
> output in report.. sounds ok to follow this also in annotate
> 
> 'perf report' TUI offers list of events to choose from
> and the --stdio version prints report for each event
> annotate could do the same
> 
> jirka
> 

Hi Jiri, Arnaldo,

OK, thanks, I will look at --group and see how it works.

Yes, using a unified interface (--group) for non-explicit groups is a 
good choice.

Thanks
Jin Yao
