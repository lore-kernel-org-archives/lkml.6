Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtEX9LHqBbNYBmzjIo7tVSs76Mcedh9qmHHj72bT9GFxYZ0RheOtPP3hO8IQgnLOr40G2Ol
ARC-Seal: i=1; a=rsa-sha256; t=1521488374; cv=none;
        d=google.com; s=arc-20160816;
        b=nn2Lt0VDn3jBldDWBbRoKcXRJb1jpasIj8e9onBYTHafx8m2D+aC5Gvks2yxpmd5NT
         Z1bZKKiOEgx4GgPb/rIB32dcKNx1dpkYAcHETbJt96/6iaqWZd1mSpu9vWODsbNhG/bV
         P8wFliqIXRdiOvxZwVimpVnyDfhn8cJsBHxtjh9Lv41L/j7Nqi568JHKpbHJw7acvENw
         kw9Kjjg764ollWHyPte/tZ4zrgh49Ii6TnJzhnFNRGLMC+If4loeD8iE8amD7olcpFhk
         NU88KEU2TeReUN2bgf7Bl1GOsEH4HlK+493BlrU6QA4wILSw/ZPae2S9Snbh3GXX5saZ
         Vdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PRT9KnVJyaegl4dJVrpCXmVEpvAKoHCJe9YIfKmJmLk=;
        b=xVLvowBjtMZrZilEOjGAIxM4IolrCsIr2+vu6pdzdbXfClDkq0U/jYub8YTpK/z2Iy
         nouLwiPlI4xVAzRP41QI90DCwFpFKc4PCzCul8YdACZi5KHkyTbd3oXqymcUwGWtiNFw
         /P+Tw/dRiMo+Nhp3yMm1IMuufzOW1s5abGs4gdvwpM6E5QwhNVRCyjZI/MRGTYvOZsC4
         enX4Y2b9n4B03klEXSXT4bnUHVINb+mgAlLHN2ayUnudn5FLoXr5w2lBPH+eImY+ua0H
         y/MdS44VS7OQrm1jn/3yM6+Y0ouyzKySAKcvFjjinptp2/C83C3Ehcu2s/6JI5i5kLOs
         dVFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ifFWVzOd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=ifFWVzOd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965605AbeCSTjc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 19 Mar 2018 15:39:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36497 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936131AbeCSTjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Mar 2018 15:39:06 -0400
Date: Mon, 19 Mar 2018 20:39:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        kernel-janitors@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Wang Nan <wangnan0@huawei.com>, Willy Tarreau <w@1wt.eu>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/14] perf/core improvements and fixes
Message-ID: <20180319193900.27fk6paow6fy4gkk@gmail.com>
References: <20180319190136.7441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595394069238457878?=
X-GMAIL-MSGID: =?utf-8?q?1595396193867706751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this has those 31 patches that were
> blocked due to some problems (author not being the fist S-o-B, build
> broken on ppc), those issues should all be fixed and then we have 14
> patches more, described in the signed tag.
> 
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd:
> 
>   perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-16 13:56:31 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180319
> 
> for you to fetch changes up to 1cd618838b9703eabe4a75badf433382b12f6bef:
> 
>   perf tests bp_account: Fix build with clang-6 (2018-03-19 13:51:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Fixes for problems experienced with new gcc 8 warnings, that treated
>   as errors, broke the build, related to snprintf and casting issues.
>   (Arnaldo Carvalho de Melo, Jiri Olsa, Josh Poinboeuf)
> 
> - Fix build of new breakpoint 'perf test' entry with clang < 6, noticed
>   on fedora 25, 26 and 27 (Arnaldo Carvalho de Melo)
> 
> - Workaround problem with symbol resolution in 'perf annotate', using
>   the symbol name already present in the objdump output (Arnaldo Carvalho de Melo)
> 
> - Document 'perf top --ignore-vmlinux' (Arnaldo Carvalho de Melo)
> 
> - Fix out of bounds access on array fd when cnt is 100 in one of the
>   'perf test' entries, detected using 'cpptest' (Colin Ian King)
> 
> - Add support for the forced leader feature, i.e. 'perf report --group'
>   for a group of events not really grouped when scheduled (without using
>   {} to enclose the list of events in the command line) in pipe mode,
>   e.g.:
> 
>   $ perf record -e cycles,instructions -o - kill | perf report --group -i -
> 
> - Use right type to access array elements in 'perf probe' (Masami Hiramatsu)
> 
> - Update POWER9 vendor events (those described in JSON format) (Sukadev Bhattiprolu)
> 
> - Discard head in overwrite_rb_find_range() (Yisheng Xie)
> 
> - Avoid setting 'quiet' to 'true' unnecessarily (Yisheng Xie)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf annotate: Use asprintf when formatting objdump command line
>       perf top: Document --ignore-vmlinux
>       perf annotate: Use ops->target.name when available for unresolved call targets
>       perf tests bp_account: Fix build with clang-6
> 
> Colin Ian King (1):
>       perf tests: Fix out of bounds access on array fd when cnt is 100
> 
> Jiri Olsa (4):
>       perf record: Synthesize features before events in pipe mode
>       perf report: Support forced leader feature in pipe mode
>       perf tools: Fix snprint warnings for gcc 8
>       perf tools: Fix python extension build for gcc 8
> 
> Josh Poimboeuf (1):
>       objtool, perf: Fix GCC 8 -Wrestrict error
> 
> Masami Hiramatsu (1):
>       perf probe: Use right type to access array elements
> 
> Sukadev Bhattiprolu (1):
>       perf vendor events: Update POWER9 events
> 
> Yisheng Xie (2):
>       perf mmap: Discard head in overwrite_rb_find_range()
>       perf debug: Avoid setting 'quiet' to 'true' unnecessarily
> 
>  tools/lib/str_error_r.c                            |   2 +-
>  tools/perf/Documentation/perf-top.txt              |   3 +
>  tools/perf/builtin-record.c                        |  18 +-
>  tools/perf/builtin-report.c                        |  57 +++--
>  tools/perf/builtin-script.c                        |  22 +-
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
>  .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
>  .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
>  .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
>  .../arch/powerpc/power9/translation.json           |  10 +-
>  tools/perf/tests/attr.c                            |   4 +-
>  tools/perf/tests/bp_account.c                      |  10 +-
>  tools/perf/tests/mem.c                             |   2 +-
>  tools/perf/tests/pmu.c                             |   2 +-
>  tools/perf/util/annotate.c                         |  20 +-
>  tools/perf/util/cgroup.c                           |   2 +-
>  tools/perf/util/debug.c                            |   1 -
>  tools/perf/util/header.c                           |  11 +-
>  tools/perf/util/mmap.c                             |  15 +-
>  tools/perf/util/parse-events.c                     |   4 +-
>  tools/perf/util/pmu.c                              |   2 +-
>  tools/perf/util/probe-finder.c                     |  13 +-
>  tools/perf/util/setup.py                           |   2 +
>  26 files changed, 298 insertions(+), 243 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
