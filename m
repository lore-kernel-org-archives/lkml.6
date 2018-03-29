Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeC2HUM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:20:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34049 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC2HUK (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:20:10 -0400
X-Google-Smtp-Source: AIpwx49H3Ltrpj0HScHBSsXv+fiEwd++s2mfPvFiilkw3mYLCWWN3XQc9qWkwLuUxGG8ZF7qkqd7JQ==
Date: Thu, 29 Mar 2018 09:20:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v3 0/5] Support perf -vv
Message-ID: <20180329072006.yrsujdaayek2wpfo@gmail.com>
References: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> For example:
> 
> $ ./perf version --build-options
>     or
>   ./perf --version --build-options
>     or
>   ./perf -v --build-options
>     or
>   ./perf -vv

Thank you, the UI looks perfect to me!

> perf version 4.13.rc5.g4c1df1
>                  dwarf: [ on  ]
>     dwarf_getlocations: [ on  ]
>                  glibc: [ on  ]
>                   gtk2: [ on  ]
>               libaudit: [ OFF ]
>                 libbfd: [ on  ]
>                 libelf: [ on  ]
>                libnuma: [ on  ]
> numa_num_possible_cpus: [ on  ]
>                libperl: [ on  ]
>              libpython: [ on  ]
>               libslang: [ on  ]
>              libcrypto: [ on  ]
>              libunwind: [ on  ]
>     libdw-dwarf-unwind: [ on  ]
>                   zlib: [ on  ]
>                   lzma: [ on  ]
>              get_cpuid: [ on  ]
>                    bpf: [ on  ]

... and it's a nice touch that this is now printed in color, like the perf build 
system does.

BTW., perhaps it would be nice to also print the macro name that is used within 
the sources:

                  dwarf: [ on  ]    # HAVE_DWARF_SUPPORT
     dwarf_getlocations: [ on  ]    # HAVE_DWARF_GETLOCATIONS
                  glibc: [ on  ]    # HAVE_GLIBC_SUPPORT
                   gtk2: [ on  ]    # HAVE_GTK2_SUPPORT
               libaudit: [ OFF ]    # HAVE_LIBAUDIT_SUPPORT
	...

?

That would make it easier to grep around in the source looking for where code 
related a particular features is located.

BTW. #2: to the compulsive perfectionist in me "HAVE_DWARF_GETLOCATIONS" is now 
sticking out like a sore thumb: it's the only library flag left that doesn't have 
the _SUPPORT suffix. Rename it to HAVE_DWARF_GETLOCATIONS_SUPPORT perhaps?

Thanks,

	Ingo
