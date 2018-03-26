Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeCZJAu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:00:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:30881 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCZJAt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:00:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="28846344"
Date: Mon, 26 Mar 2018 02:00:31 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/3] Support perf -vv
Message-ID: <20180326090031.GN13724@tassilo.jf.intel.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 12:07:01AM +0800, Jin Yao wrote:
> We keep having bug reports that when users build perf on their own,
> but they don't install some needed libraries such as libelf,
> libbfd/libibery.
> 
> The perf can build, but it is missing important functionality. And
> users may complain that perf has issue or bug. 
> 
> This patch-set support 'perf -vv' which will print the compiled-in
> status of libraries. Once users think perf missing some functionality,
> it should be very easy for them to check the libraries status.

I don't think this solves the problem. How should the user know
that they need to run perf -vv. Also normal users don't know
that libelf is needed for symbols for example.

We need a warning that is visible together with the symbols
and that clearly describes the problem.

-Andi

> 
> For example:
> 
> $ ./perf -vv
> perf version 4.13.rc5.g9b7a81b
>                  dwarf: [  on ]
>     dwarf_getlocations: [  on ]
>                  glibc: [  on ]
>                   gtk2: [  on ]
>               libaudit: [ off ]
>                 libbfd: [  on ]
>                 libelf: [  on ]
>                libnuma: [  on ]
> numa_num_possible_cpus: [  on ]
>                libperl: [  on ]
>              libpython: [  on ]
>               libslang: [  on ]
>              libcrypto: [  on ]
>              libunwind: [  on ]
>     libdw-dwarf-unwind: [  on ]
>                   zlib: [  on ]
>                   lzma: [  on ]
>              get_cpuid: [  on ]
>                    bpf: [  on ]
> 
> Jin Yao (3):
>   perf config: Add -DNO_GLIBC to CFLAGS
>   perf version: Print the status of compiled-in libraries
>   perf: Support perf -vv
> 
>  tools/perf/Makefile.config   |   2 +
>  tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h         |   1 +
>  tools/perf/perf.c            |   6 +++
>  4 files changed, 134 insertions(+)
> 
> -- 
> 2.7.4
> 
