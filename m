Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeC2Ht1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:49:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:30153 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeC2Ht0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:49:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="28517287"
Subject: Re: [PATCH v3 0/5] Support perf -vv
To: Ingo Molnar <mingo@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
 <20180329072006.yrsujdaayek2wpfo@gmail.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ef9f7e74-d94a-895d-fb26-35f2820fd95f@linux.intel.com>
Date: Thu, 29 Mar 2018 15:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329072006.yrsujdaayek2wpfo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2018 3:20 PM, Ingo Molnar wrote:
> 
> * Jin Yao <yao.jin@linux.intel.com> wrote:
> 
>> For example:
>>
>> $ ./perf version --build-options
>>      or
>>    ./perf --version --build-options
>>      or
>>    ./perf -v --build-options
>>      or
>>    ./perf -vv
> 
> Thank you, the UI looks perfect to me!
> 
>> perf version 4.13.rc5.g4c1df1
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
> 
> ... and it's a nice touch that this is now printed in color, like the perf build
> system does.
> 

Yes, the printing is in color yet. Green for [on] and red for [OFF]. :)

> BTW., perhaps it would be nice to also print the macro name that is used within
> the sources:
> 
>                    dwarf: [ on  ]    # HAVE_DWARF_SUPPORT
>       dwarf_getlocations: [ on  ]    # HAVE_DWARF_GETLOCATIONS
>                    glibc: [ on  ]    # HAVE_GLIBC_SUPPORT
>                     gtk2: [ on  ]    # HAVE_GTK2_SUPPORT
>                 libaudit: [ OFF ]    # HAVE_LIBAUDIT_SUPPORT
> 	...
> 
> ?
> 
> That would make it easier to grep around in the source looking for where code
> related a particular features is located.
> 

Good idea, thanks! I will support it in v4.

> BTW. #2: to the compulsive perfectionist in me "HAVE_DWARF_GETLOCATIONS" is now
> sticking out like a sore thumb: it's the only library flag left that doesn't have
> the _SUPPORT suffix. Rename it to HAVE_DWARF_GETLOCATIONS_SUPPORT perhaps?
>
 > Thanks,
 >
 > 	Ingo
 >

OK, I will rename it to HAVE_DWARF_GETLOCATIONS_SUPPORT in v4.

Thanks
Jin Yao
