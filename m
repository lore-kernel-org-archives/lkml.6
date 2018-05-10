Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965977AbeEJAtb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:49:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:1849 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964863AbeEJAta (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:49:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,383,1520924400";
   d="scan'208";a="44657324"
Subject: Re: [PATCH] perf annotate: Display multiple events for --stdio
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
 <20180509164251.GH13491@kernel.org> <20180509172429.GL13491@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7f78244e-2945-d526-5db0-776fc1f562ce@linux.intel.com>
Date: Thu, 10 May 2018 08:49:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509172429.GL13491@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2018 1:24 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 09, 2018 at 01:42:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, May 09, 2018 at 11:57:15PM +0800, Jin Yao escreveu:
>>> When we perform following command lines:
>>>
>>> perf record -e "{cycles,branches}" ./div
>>> perf annotate main --stdio
>>>
>>> Only shows one event "cycles" and the displaying format is not correct.
>>>
>>>   Percent         |      Source code & Disassembly of div for cycles (44550 samples)
>>> -----------------------------------------------------------------------------------
>>
>> Please indent command output (two spaces before all lines) to avoid
>> scripts breaking due to mistaking lines starting with --- as the end of
>> the patch.
>>
>> Applying.
> 
> Also you forgot to add this:
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Fixes: f681d593d1ce ("perf annotate: Remove disasm__calc_percent() from disasm_line__print()")
> 
> Which I've just added, to help with stable@ processing.
> 
> - Arnaldo
> 

Actually I notice this issue during fixing another issue. :)

Another issue is, without using group, the multiple events can't be 
supported well in perf annotate.

perf record -e cycles,branches ./div
perf annotate main --stdio

It should show both cycles and branches on the left side but actually it 
only show cycles.

I will post patches for fixing this (working on the patch now).

Thanks
Jin Yao
