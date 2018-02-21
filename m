Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBUHwn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:52:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46478 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBUHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:52:42 -0500
X-Google-Smtp-Source: AH8x226wzfMC7FGAJItHi78xETFmir7agHvvENGegngHhMub17hFyfdOZFHsVVqAhZvWCIrDdFRqzg==
Date: Wed, 21 Feb 2018 08:52:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/5] perf/core improvements and fixes
Message-ID: <20180221075237.yveila4ehiabon37@gmail.com>
References: <20180221013431.11738-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221013431.11738-1-acme@kernel.org>
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
> The following changes since commit 11737ca9e3b9d84448fa405a80980aa9957bcee8:
> 
>   Merge tag 'perf-core-for-mingo-4.17-20180216' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-02-17 11:39:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180220
> 
> for you to fetch changes up to 66dfdff03d196e51322c6a85c0d8db8bb2bdd655:
> 
>   perf tools: Add Python 3 support (2018-02-19 12:28:23 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Initial support for linking with python3, by explicitely setting
>   the PYTHON Makefile variable, python2 remains supported, more work
>   needed to test the shipped python scripts used with 'perf script'
>   (Jaroslav Škarvada)
> 
> - Make twatch.py, an example python script that sets up evlists and
>   evsels to then parse events from mmap, to work with both python2 and
>   python3 (Arnaldo Carvalho de Melo)
> 
> - Fix setting 'perf ftrace' function filter when using a non-existent
>   function, which should result in an error instead of simply not setting
>   the filter and showing all functions (Changbin Du)
> 
> - Fix paranoid check in machine__set_kernel_mmap(), problem introduced
>   in previous perf/core batch (Namhyung Kim)
> 
> - Fix reading cpuid model information in s/390, ditto, also introduced
>   in the previous perf/core batch (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf python: Make twatch.py work with both python2 and python3
> 
> Changbin Du (1):
>       perf ftrace: Append an EOL when write tracing files
> 
> Jaroslav Škarvada (1):
>       perf tools: Add Python 3 support
> 
> Namhyung Kim (1):
>       perf machine: Fix paranoid check in machine__set_kernel_mmap()
> 
> Thomas Richter (1):
>       perf s390: Fix reading cpuid model information
> 
>  tools/perf/Makefile.config                         |  23 +---
>  tools/perf/Makefile.perf                           |   4 +-
>  tools/perf/arch/s390/util/header.c                 |   2 +-
>  tools/perf/builtin-ftrace.c                        |  18 ++-
>  tools/perf/python/twatch.py                        |   8 +-
>  .../perf/scripts/python/Perf-Trace-Util/Context.c  |  34 ++++-
>  tools/perf/util/machine.c                          |   2 +-
>  tools/perf/util/python.c                           |  95 ++++++++++---
>  .../util/scripting-engines/trace-event-python.c    | 147 +++++++++++++++------
>  tools/perf/util/setup.py                           |   6 +-
>  10 files changed, 243 insertions(+), 96 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
