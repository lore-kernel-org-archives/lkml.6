Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeC1NW4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:22:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751166AbeC1NWz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:22:55 -0400
Date: Wed, 28 Mar 2018 15:22:52 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v2 4/4] perf: Support perf -vv
Message-ID: <20180328132252.GM3102@krava>
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
 <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:57:08PM +0800, Jin Yao wrote:
> We keep having bug reports that when users build perf on their own,
> but they don't install some needed libraries such as libelf,
> libbfd/libibery.
> 
> The perf can build, but it is missing important functionality.
> 
> This patch provides a new option '-vv' which will print the
> compiled-in status of libraries.
> 
> The 'perf -vv' is equal to 'perf -version --build-options'.
> 
> For example:
> 
> $ ./perf -vv or ./perf -version --build-options
> perf version 4.13.rc5.gcb1183
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
> [ on  ]: library is compiled-in
> [ OFF ]: library is disabled in make configuration
>          OR library is not installed in build environment
> 
> v2:
> ---
> Use a global variable version_verbose to count the number of 'v'.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/perf.c | 22 ++++++++++++++++++----
>  tools/perf/perf.h |  1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 1b3fc8e..355219e 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -32,7 +32,7 @@
>  #include <linux/kernel.h>
>  
>  const char perf_usage_string[] =
> -	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
> +	"perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";

--build-options is 'perf version' option no?

jirka
