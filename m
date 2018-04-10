Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeDJFXe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:23:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45152 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJFXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:23:32 -0400
X-Google-Smtp-Source: AIpwx484SGXbsZhJYXP8CIL6jPnmEyP5I3k/9feus4s4eZVnbn5zxo36wyFFCwkafKYhkaM5ViT4yA==
Date: Tue, 10 Apr 2018 07:23:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/13] perf/urgent fixes
Message-ID: <20180410052327.cc3gbojz3he55ncg@gmail.com>
References: <20180409193437.14199-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
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
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit d1e7e602cd64cf61f87dbf30df07c24df9eb1d99:
> 
>   perf/x86/intel: Move regs->flags EXACT bit init (2018-04-05 09:28:40 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180409
> 
> for you to fetch changes up to fcbd8fa44664e99a5d8c7ab97f1afdd82472f973:
> 
>   perf tests clang: Fix function name for clang IR test (2018-04-09 11:13:09 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> . Fix the --stdio2/TUI annotate output to include group details,
>   be it for a recorded '{a,b,f}' explicit event group or when
>   forcing group display using 'perf report --group' for a set of
>   events not recorded as a group (Arnaldo Carvalho de Melo)
> 
> . Fix display artifacts in the ui browser (base class for the
>   annotate and main report/top TUI browser) related to the extra
>   title lines work (Arnaldo Carvalho de Melo)
> 
> . perf auxtrace refactorings, leftovers from a previously partially
>   processed patchset (Adrian Hunter)
> 
> . Fix the builtin clang build (Sandipan Das, Arnaldo Carvalho de Melo)
> 
> - Synchronize i915_drm.h, silencing a perf build warning and
>   in the process automagically adding support for a new ioctl
>   command (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf auxtrace: Make auxtrace_queues__add_buffer() allocate struct buffer
>       perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering
> 
> Arnaldo Carvalho de Melo (8):
>       perf annotate: Show group details on the title line
>       perf annotate browser: Fixup vertical line separating metrics from instructions
>       perf ui browser: Fixup cleaning unused lines at the bottom
>       perf report: Remove duplicated 'samples' in lost samples warning
>       tools headers uapi: Synchronize i915_drm.h
>       perf hists browser: Show extra_title_lines in the 'D' debug hotkey
>       perf hists browser: Remove leftover from row returned from refresh
>       perf tools: No need to include namespaces.h in util.h
> 
> Sandipan Das (3):
>       perf tools: Fix perf builds with clang support
>       perf clang: Add support for recent clang versions
>       perf tests clang: Fix function name for clang IR test
> 
>  tools/include/uapi/drm/i915_drm.h  | 112 +++++++++++++++++++++++++++++++++++--
>  tools/perf/Makefile.perf           |   3 +-
>  tools/perf/ui/browser.c            |   4 +-
>  tools/perf/ui/browsers/annotate.c  |   2 +-
>  tools/perf/ui/browsers/hists.c     |  13 ++---
>  tools/perf/util/annotate.c         |   7 ++-
>  tools/perf/util/auxtrace.c         |  72 +++++++++++-------------
>  tools/perf/util/c++/clang-test.cpp |   2 +-
>  tools/perf/util/c++/clang.cpp      |  11 +++-
>  tools/perf/util/session.c          |   2 +-
>  tools/perf/util/util.h             |   4 +-
>  11 files changed, 169 insertions(+), 63 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
