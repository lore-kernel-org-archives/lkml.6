Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeC3JeV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:34:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750790AbeC3JeU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:34:20 -0400
Date: Fri, 30 Mar 2018 11:34:15 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v4 0/6] Support perf -vv
Message-ID: <20180330093415.GA17902@krava>
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 05:27:10PM +0800, Jin Yao wrote:
> We keep having bug reports that when users build perf on their own,
> but they don't install some needed libraries such as libelf,
> libbfd/libibery.
> 
> The perf can build, but it is missing important functionality. And
> users may complain that perf has issue or bug.
> 
> This patch-set support to print the status of compiled-in libraries.
> 
> Once users think perf missing some functionality, it should be very
> easy for them to check the libraries status.
> 
> For example:
> 
> $ ./perf version --build-options
>     or
>   ./perf --version --build-options
>     or
>   ./perf -v --build-options
>     or
>   ./perf -vv
> 
> perf version 4.13.rc5.g6727c5
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                   gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>               libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> 
> v4:
> ---
> 1. Also print the macro name. That would make it easier
>    to grep around in the source looking for where code
>    related a particular features is located.
> 
> 2. Update since HAVE_DWARF_GETLOCATIONS is renamed to
>    HAVE_DWARF_GETLOCATIONS_SUPPORT

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
