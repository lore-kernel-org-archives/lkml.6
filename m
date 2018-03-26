Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCZNGg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:06:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:57487 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeCZNGf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:06:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214731220"
Subject: Re: [PATCH v1 0/3] Support perf -vv
To: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com, yao.jin@intel.com
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <20180326090031.GN13724@tassilo.jf.intel.com> <20180326090704.GH6207@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <03729f52-2112-d9dc-141e-5ac927fadb7c@linux.intel.com>
Date: Mon, 26 Mar 2018 21:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326090704.GH6207@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2018 5:07 PM, Jiri Olsa wrote:
> On Mon, Mar 26, 2018 at 02:00:31AM -0700, Andi Kleen wrote:
>> On Tue, Mar 27, 2018 at 12:07:01AM +0800, Jin Yao wrote:
>>> We keep having bug reports that when users build perf on their own,
>>> but they don't install some needed libraries such as libelf,
>>> libbfd/libibery.
>>>
>>> The perf can build, but it is missing important functionality. And
>>> users may complain that perf has issue or bug.
>>>
>>> This patch-set support 'perf -vv' which will print the compiled-in
>>> status of libraries. Once users think perf missing some functionality,
>>> it should be very easy for them to check the libraries status.
>>
>> I don't think this solves the problem. How should the user know
>> that they need to run perf -vv. Also normal users don't know
>> that libelf is needed for symbols for example.
>>
>> We need a warning that is visible together with the symbols
>> and that clearly describes the problem.
> 
> IIRC we decided to go *with* the message in the perf report
> or other affected command that would suggest to run 'perf -vv'
> for more details
> 
> jirka
> 

Hi Andi,

For how the users know they should run 'perf -vv', as the discussion 
with Jiri and Arnaldo, the message will be displayed if necessary when 
users perform perf report or other perf commands. That could be 
implemented in a follow-up patch (not in this patch-set).

For let user know what the library they need, maybe we can add more 
information in 'perf -vv', for example, add something like,

"Please install libelf-dev, libelf-devel or elfutils-libelf-devel before 
building perf"

Thanks
Jin Yao

>>
>> -Andi
>>
>>>
>>> For example:
>>>
>>> $ ./perf -vv
>>> perf version 4.13.rc5.g9b7a81b
>>>                   dwarf: [  on ]
>>>      dwarf_getlocations: [  on ]
>>>                   glibc: [  on ]
>>>                    gtk2: [  on ]
>>>                libaudit: [ off ]
>>>                  libbfd: [  on ]
>>>                  libelf: [  on ]
>>>                 libnuma: [  on ]
>>> numa_num_possible_cpus: [  on ]
>>>                 libperl: [  on ]
>>>               libpython: [  on ]
>>>                libslang: [  on ]
>>>               libcrypto: [  on ]
>>>               libunwind: [  on ]
>>>      libdw-dwarf-unwind: [  on ]
>>>                    zlib: [  on ]
>>>                    lzma: [  on ]
>>>               get_cpuid: [  on ]
>>>                     bpf: [  on ]
>>>
>>> Jin Yao (3):
>>>    perf config: Add -DNO_GLIBC to CFLAGS
>>>    perf version: Print the status of compiled-in libraries
>>>    perf: Support perf -vv
>>>
>>>   tools/perf/Makefile.config   |   2 +
>>>   tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
>>>   tools/perf/builtin.h         |   1 +
>>>   tools/perf/perf.c            |   6 +++
>>>   4 files changed, 134 insertions(+)
>>>
>>> -- 
>>> 2.7.4
>>>
