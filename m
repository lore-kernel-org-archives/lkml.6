Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeCUCLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:11:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:18994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeCUCLM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:11:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="29820779"
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
From: "Jin, Yao" <yao.jin@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
Message-ID: <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
Date: Wed, 21 Mar 2018 10:11:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I'm still thinking it's worth displaying the warning when perf missing 
some libraries.

Somebody just told me that perf didn't work well. While after some 
investigations, I found it's just missing some libraries when building 
the perf.

But I have spent some time on getting the root cause. If with this 
patch, it should be very easily to know that.

Thanks
Jin Yao

On 1/12/2018 10:22 AM, Jin, Yao wrote:
> 
> 
> On 1/11/2018 11:30 PM, Jiri Olsa wrote:
>> On Thu, Jan 11, 2018 at 07:03:06PM +0800, Jin Yao wrote:
>>> We keep having bug reports that when users build perf on their own,
>>
>> we already have same warnings during the build
>>
> 
> Yes, there will be warnings displayed during the build if some libraries 
> are missing.
> 
> While I do find the users (especially the new perf user) don't notice 
> the warning. They only care about the success of build.
> 
> Once they use this perf version and find something working strangely, 
> they will say that perf may have bug. :(
> 
>>> but they don't install some needed libraries like libelf, 
>>> libbfd/libibery.
>>
>> how about saying that in the symbol column,
>> instead of poluting report's output, like:
>>
>>     $ perf report --stdio
>>
>>     # Overhead  Command  Shared Object     Symbol (disabled)
>>     # ........  .......  ................  ......................
>>
> 
> I just think it'd better provide some hints to user. For example, 
> "symbol is disabled and you need to install libelf/xxx", say something 
> like that.
> 
> But it looks the column can't contain too much information (i.e. no more 
> space to contain the entire hints).
> 
> Any idea? Or just add this warning in verbose mode?
> 
>> also your change does not affect tui mode
>>
>> annotation for some reason does not start at all.. could be
>> little more verbose ;-)
>>
>> jirka
>>
> 
> Yes, it doesn't affect tui mode.
> 
> Or we just add this warning in verbose mode?
> 
> e.g. perf report -v?
> 
> Thanks
> Jin Yao
