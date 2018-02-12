Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934469AbeBLMYL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:24:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:25322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbeBLMYK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:24:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="19291638"
Subject: Re: [PATCH] perf report: Fix wrong jump arrow
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1517223473-14750-1-git-send-email-yao.jin@linux.intel.com>
 <20180209151549.GL3451@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b432d9c6-60c1-b83c-8de8-b5c77ef0be0e@linux.intel.com>
Date: Mon, 12 Feb 2018 20:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209151549.GL3451@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Thanks for applying the patch. Yes the issue only happens on skl+.

The committer notes are very good and clear.

Thanks
Jin Yao

On 2/9/2018 11:15 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 29, 2018 at 06:57:53PM +0800, Jin Yao escreveu:
>> When we use perf report interactive annotate view, we can see
>> the position of jump arrow is not correct. For example,
>>
>> 1. perf record -b ...
>> 2. perf report
>> 3. In interactive mode, select Annotate 'function'
>>
>> Percent│ IPC Cycle
>>         │                                if (flag)
>>    1.37 │0.4┌──   1      ↓ je     82
>>         │   │                                    x += x / y + y / x;
> 
> Applied and added this to the cset log, please check:
> 
> Committer notes:
> 
> Please note that only from LBRv5 (according to Jiri) onwards, i.e. >=
> Skylake is that we'll have the cycles counts in each branch record
> entry, so to see the Cycles and IPC columns, and be able to test this
> patch, one need a capable hardware.
> 
> While applying this I first tested it on a Broadwell class machine and
> couldn't get those columns, will add code to the annotate browser to
> warn the user about that, i.e. you have branch records, but no cycles,
> use a more recent hardware to get the cycles and IPC columns.
> 
> - Arnaldo
> 
