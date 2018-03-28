Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeC1N5r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:57:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:15227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbeC1N5q (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:57:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,371,1517904000";
   d="scan'208";a="28298752"
Subject: Re: [PATCH v2 3/4] perf version: Print the compiled-in status of
 libraries
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-4-git-send-email-yao.jin@linux.intel.com>
 <20180328131053.GL3102@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4375e4ec-dba9-a442-25f1-ae8f706d52c9@linux.intel.com>
Date: Wed, 28 Mar 2018 21:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328131053.GL3102@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 9:10 PM, Jiri Olsa wrote:
> On Wed, Mar 28, 2018 at 10:57:07PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +
>> +static void library_status(void)
>> +{
>> +	STATUS(HAVE_DWARF_SUPPORT, dwarf);
>> +	STATUS(HAVE_DWARF_GETLOCATIONS, dwarf_getlocations);
>> +	STATUS(HAVE_GLIBC_SUPPORT, glibc);
>> +	STATUS(HAVE_GTK2_SUPPORT, gtk2);
>> +	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
>> +	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
>> +	STATUS(HAVE_LIBELF_SUPPORT, libelf);
>> +	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>> +	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>> +	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
>> +	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
>> +	STATUS(HAVE_SLANG_SUPPORT, libslang);
>> +	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
>> +	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
>> +	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
>> +	STATUS(HAVE_ZLIB_SUPPORT, zlib);
>> +	STATUS(HAVE_LZMA_SUPPORT, lzma);
>> +	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
>> +	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
>> +
>> +	on_off_print("on");
>> +	printf(": library is compiled-in\n");
>> +
>> +	on_off_print("OFF");
>> +	printf(": library is disabled in make configuration\n");
>> +	printf("         OR library is not installed in build environment\n");
> 
> [jolsa@krava perf]$ ./perf -vv
> perf version 4.16.rc6.gcc183d
>                   dwarf: [ on  ]
>      dwarf_getlocations: [ on  ]
>                   glibc: [ on  ]
>                    gtk2: [ on  ]
>                libaudit: [ OFF ]
>                  libbfd: [ on  ]
>                  libelf: [ on  ]
>                 libnuma: [ on  ]
> numa_num_possible_cpus: [ on  ]
>                 libperl: [ on  ]
>               libpython: [ on  ]
>                libslang: [ on  ]
>               libcrypto: [ on  ]
>               libunwind: [ on  ]
>      libdw-dwarf-unwind: [ on  ]
>                    zlib: [ on  ]
>                    lzma: [ on  ]
>               get_cpuid: [ on  ]
>                     bpf: [ on  ]
> [ on  ]: library is compiled-in
> [ OFF ]: library is disabled in make configuration
>           OR library is not installed in build environment
> 
> did anyone asked for this ^^^ help messages? I don't think they are necessary
> 
> jirka
> 

No one ask for this. Since it's not very necessary, I will remove this 
message.

Thanks
Jin Yao
