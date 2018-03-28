Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeC1OAh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:00:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:15783 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753308AbeC1OAg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:00:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,371,1517904000";
   d="scan'208";a="28299678"
Subject: Re: [PATCH v2 4/4] perf: Support perf -vv
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
 <20180328132252.GM3102@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c984a7d9-1e59-93f6-36b5-6ce878039f53@linux.intel.com>
Date: Wed, 28 Mar 2018 22:00:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328132252.GM3102@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 9:22 PM, Jiri Olsa wrote:
> On Wed, Mar 28, 2018 at 10:57:08PM +0800, Jin Yao wrote:
>> We keep having bug reports that when users build perf on their own,
>> but they don't install some needed libraries such as libelf,
>> libbfd/libibery.
>>
>> The perf can build, but it is missing important functionality.
>>
>> This patch provides a new option '-vv' which will print the
>> compiled-in status of libraries.
>>
>> The 'perf -vv' is equal to 'perf -version --build-options'.
>>
>> For example:
>>
>> $ ./perf -vv or ./perf -version --build-options
>> perf version 4.13.rc5.gcb1183
>>                   dwarf: [ on  ]
>>      dwarf_getlocations: [ on  ]
>>                   glibc: [ on  ]
>>                    gtk2: [ on  ]
>>                libaudit: [ OFF ]
>>                  libbfd: [ on  ]
>>                  libelf: [ on  ]
>>                 libnuma: [ on  ]
>> numa_num_possible_cpus: [ on  ]
>>                 libperl: [ on  ]
>>               libpython: [ on  ]
>>                libslang: [ on  ]
>>               libcrypto: [ on  ]
>>               libunwind: [ on  ]
>>      libdw-dwarf-unwind: [ on  ]
>>                    zlib: [ on  ]
>>                    lzma: [ on  ]
>>               get_cpuid: [ on  ]
>>                     bpf: [ on  ]
>> [ on  ]: library is compiled-in
>> [ OFF ]: library is disabled in make configuration
>>           OR library is not installed in build environment
>>
>> v2:
>> ---
>> Use a global variable version_verbose to count the number of 'v'.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/perf.c | 22 ++++++++++++++++++----
>>   tools/perf/perf.h |  1 +
>>   2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
>> index 1b3fc8e..355219e 100644
>> --- a/tools/perf/perf.c
>> +++ b/tools/perf/perf.c
>> @@ -32,7 +32,7 @@
>>   #include <linux/kernel.h>
>>   
>>   const char perf_usage_string[] =
>> -	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
>> +	"perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";
> 
> --build-options is 'perf version' option no?
> 
> jirka
> 

Yes. Command-line something like:

perf --version --build-options or perf -v --build-options.

Is this usage string not correct? If so, I'd like to fix that.

"perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";

Thanks
Jin Yao
