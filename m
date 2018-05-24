Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbeEXFcv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:32:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39340 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeEXFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:32:49 -0400
X-Google-Smtp-Source: AB8JxZpaEybM37t399oL7G0fIhPDU/UzKvnQq2OQ8cJouRi5uu9vY/2RhXXVlCe9YeETREXeNzWBTw==
Date: Thu, 24 May 2018 07:32:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/18] perf/core improvements
Message-ID: <20180524053244.GA19588@gmail.com>
References: <20180523202106.17286-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2996123e7e589d78e73cfeb7e7f14d49127eb1b0:
> 
>   Merge tag 'perf-core-for-mingo-4.18-20180519' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-05-19 13:32:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180523
> 
> for you to fetch changes up to 22916fdb9c50e8fb303bdcedca88fd8798a85844:
> 
>   perf kcore_copy: Amend the offset of sections that remap kernel text (2018-05-23 10:26:44 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements:
> 
> . Create extra kernel maps to help in decoding samples in x86 PTI entry
>   trampolines (Adrian Hunter)
> 
> . Copy x86 PTI entry trampoline sections in the kcore copy used for
>   annotation and intel_pt CPU traces decoding (Adrian Hunter)
> 
> - Support 'perf annotate --group' for non-explicit recorded event
>   "groups", showing multiple columns, one for each event, just like
>   when dealing with explicit event groups (those enclosed with {}) (Jin Yao)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (14):
>       perf machine: Add nr_cpus_avail()
>       perf machine: Workaround missing maps for x86 PTI entry trampolines
>       perf machine: Fix map_groups__split_kallsyms() for entry trampoline symbols
>       perf machine: Allow for extra kernel maps
>       perf machine: Create maps for x86 PTI entry trampolines
>       perf machine: Synthesize and process mmap events for x86 PTI entry trampolines
>       perf kcore_copy: Keep phdr data in a list
>       perf kcore_copy: Keep a count of phdrs
>       perf kcore_copy: Calculate offset from phnum
>       perf kcore_copy: Layout sections
>       perf kcore_copy: Iterate phdrs
>       perf kcore_copy: Get rid of kernel_map
>       perf kcore_copy: Copy x86 PTI entry trampoline sections
>       perf kcore_copy: Amend the offset of sections that remap kernel text
> 
> Jin Yao (4):
>       perf evlist: Introduce force_leader() method
>       perf report: Use perf_evlist__force_leader to support '--group'
>       perf annotate: Support '--group' option
>       perf annotate: Show group event string for stdio
> 
>  tools/perf/arch/x86/util/Build     |   2 +
>  tools/perf/arch/x86/util/event.c   |  76 +++++++++++++
>  tools/perf/arch/x86/util/machine.c | 103 +++++++++++++++++
>  tools/perf/builtin-annotate.c      |   7 ++
>  tools/perf/builtin-report.c        |  13 +--
>  tools/perf/util/annotate.c         |   6 +-
>  tools/perf/util/env.c              |  13 +++
>  tools/perf/util/env.h              |   1 +
>  tools/perf/util/event.c            |  36 ++++--
>  tools/perf/util/event.h            |   8 ++
>  tools/perf/util/evlist.c           |  15 +++
>  tools/perf/util/evlist.h           |   3 +
>  tools/perf/util/machine.c          | 175 +++++++++++++++++++++++++++--
>  tools/perf/util/machine.h          |  23 ++++
>  tools/perf/util/map.c              |  22 +++-
>  tools/perf/util/map.h              |  15 ++-
>  tools/perf/util/symbol-elf.c       | 219 +++++++++++++++++++++++++++++++------
>  tools/perf/util/symbol.c           |  49 +++++++--
>  18 files changed, 711 insertions(+), 75 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/event.c
>  create mode 100644 tools/perf/arch/x86/util/machine.c

Pulled, thanks a lot Arnaldo!

	Ingo
