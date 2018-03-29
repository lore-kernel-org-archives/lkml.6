Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeC2Awg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:52:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:49235 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbeC2Awf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:52:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,374,1517904000";
   d="scan'208";a="215651601"
Subject: Re: [PATCH v2 4/4] perf: Support perf -vv
To: Ingo Molnar <mingo@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
 <20180328154622.65ate24g7be2xg3a@gmail.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e0682929-5cc1-386e-fb53-e8971469e61c@linux.intel.com>
Date: Thu, 29 Mar 2018 08:52:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328154622.65ate24g7be2xg3a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 11:46 PM, Ingo Molnar wrote:
> 
> * Jin Yao <yao.jin@linux.intel.com> wrote:
> 
>> $ ./perf -vv or ./perf -version --build-options
>> perf version 4.13.rc5.gcb1183
> 
> My suggestion was to add the 'version' subcommand like Git has, not a "-version"
> option:
> 
>    $ git version
>    git version 2.14.1
> 
> Thanks,
> 
> 	Ingo
> 

Hi Ingo,

Sorry about that. Actually I find it's a bug in my patch. The 'perf 
-vxyz' is mapped to 'perf --version' mistakenly. So 'perf -version' will 
be mapped to 'perf --version' and 'perf -vabc' will be mapped too.

I will fix this bug.

Currently, 'perf -v', 'perf version' and 'perf --version' have the same 
behavior.

So I will let:
'perf -v --build-options',
'perf version --build-options',
'perf --version --build-options',
'perf -vv'
have same output.

For example,

$ ./perf version --build-options
perf version 4.13.rc5.gcb1183
                  dwarf: [ on  ]
     dwarf_getlocations: [ on  ]
                  glibc: [ on  ]
                   gtk2: [ on  ]
               libaudit: [ OFF ]
                 libbfd: [ on  ]
                 libelf: [ on  ]
                libnuma: [ on  ]
numa_num_possible_cpus: [ on  ]
                libperl: [ on  ]
              libpython: [ on  ]
               libslang: [ on  ]
              libcrypto: [ on  ]
              libunwind: [ on  ]
     libdw-dwarf-unwind: [ on  ]
                   zlib: [ on  ]
                   lzma: [ on  ]
              get_cpuid: [ on  ]
                    bpf: [ on  ]

Thanks
Jin Yao
