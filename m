Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeDDFZz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:25:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35388 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDFZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:25:53 -0400
X-Google-Smtp-Source: AIpwx4+MRq9AlzpzT6c1XYYwYTbFcj3v2O82X7DjtNVavy1AH4y1AIouatbankZXb//rPLaL/dUzVw==
Date: Wed, 4 Apr 2018 07:25:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/17] perf/core improvements and fixes
Message-ID: <20180404052548.iyntuvweumellzi3@gmail.com>
References: <20180404022158.12190-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
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
> The following changes since commit 1159e09476536250c2a0173d4298d15114df7a89:
> 
>   perf/x86/intel: Enable C-state residency events for Cannon Lake (2018-03-31 11:28:36 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180403
> 
> for you to fetch changes up to 51125a29a395048fdb3429b8c4ca0ada57097744:
> 
>   perf trace: Remove redundant ')' (2018-04-03 16:16:41 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Show only failing syscalls with 'perf trace --failure' (Arnaldo Carvalho de Melo)
> 
> 	e.g: See what 'openat' syscalls are failing:
> 
>   # perf trace --failure -e openat
>    762.323 ( 0.007 ms): VideoCapture/4566 openat(dfd: CWD, filename: /dev/video2) = -1 ENOENT No such file or directory
>    <SNIP N /dev/videoN open attempts... sigh, where is that improvised camera lid?!? 8-) >
>    790.228 ( 0.008 ms): VideoCapture/4566 openat(dfd: CWD, filename: /dev/video63) = -1 ENOENT No such file or directory
>   ^C#
> 
> - Show information about the event (freq, nr_samples, total period/nr_events) in
>   the annotate --tui and --stdio2 'perf annotate' output, similar to the
>   first line in the 'perf report --tui', but just for the samples for
>   the annotated symbol (Arnaldo Carvalho de Melo)
> 
> - Introduce 'perf version --build-options' to show what features were
>   linked, aliased as well as a shorter 'perf -vv' (Jin Yao)
> 
> - Add a "dso_size" sort order (Kim Phillips)
> 
> - Remove redundant ')' in the tracepoint output in 'perf trace' (Changbin Du)
> 
> - Synchronize x86's cpufeatures.h, no effect on tools (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (9):
>       tools headers: Synchronize x86's cpufeatures.h
>       perf trace: Show only failing syscalls
>       perf hists browser: Rename perf_evsel_browser_title to a more descriptive name
>       perf hists: Introduce hists__scnprint_title()
>       perf hists: Move hists__scnprintf_title() away from the TUI code
>       perf ui browser: Move the extra title lines from the hists browser
>       perf annotate: Introduce annotation__scnprintf_samples_period() method
>       perf annotate browser: Show extra title line with event information
>       perf annotate stdio2: Print more descriptive event information header
> 
> Changbin Du (1):
>       perf trace: Remove redundant ')'
> 
> Jin Yao (5):
>       perf config: Add some new -DHAVE_XXX to CFLAGS
>       perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
>       perf version: Print the compiled-in status of libraries
>       perf tools: Add 'perf -vv' as an alias to 'perf version --build-options'
>       perf version: Add man page
> 
> Jiri Olsa (1):
>       tools include: Add config.h header file
> 
> Kim Phillips (1):
>       perf tools: Add a "dso_size" sort order
> 
>  tools/arch/x86/include/asm/cpufeatures.h  |   2 +
>  tools/include/tools/config.h              |  34 ++++++++
>  tools/perf/Documentation/perf-report.txt  |   1 +
>  tools/perf/Documentation/perf-trace.txt   |   3 +
>  tools/perf/Documentation/perf-version.txt |  24 ++++++
>  tools/perf/Makefile.config                |   8 +-
>  tools/perf/builtin-trace.c                |  11 ++-
>  tools/perf/builtin-version.c              |  82 +++++++++++++++++++-
>  tools/perf/perf.c                         |   6 ++
>  tools/perf/perf.h                         |   1 +
>  tools/perf/ui/browser.c                   |   8 +-
>  tools/perf/ui/browser.h                   |   2 +
>  tools/perf/ui/browsers/annotate.c         |  31 +++++++-
>  tools/perf/ui/browsers/hists.c            | 125 +++++++-----------------------
>  tools/perf/util/annotate.c                |  48 ++++++++++--
>  tools/perf/util/annotate.h                |  12 +++
>  tools/perf/util/dwarf-aux.c               |   2 +-
>  tools/perf/util/hist.c                    |  81 +++++++++++++++++++
>  tools/perf/util/hist.h                    |   7 ++
>  tools/perf/util/map.h                     |   4 +
>  tools/perf/util/sort.c                    |  41 ++++++++++
>  tools/perf/util/sort.h                    |   1 +
>  22 files changed, 418 insertions(+), 116 deletions(-)
>  create mode 100644 tools/include/tools/config.h
>  create mode 100644 tools/perf/Documentation/perf-version.txt

Pulled, thanks a lot Arnaldo!

	Ingo
