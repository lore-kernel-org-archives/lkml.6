Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3949127-1520580595-2-8138551738240176691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520580594; b=IUYOAigi8+LrXAN6C6waXMNE/u5c/49XDudLKaDqHUNahyw
    N/R7QW5i8hP03xK0pEzHXxR8KTgOV+pKTjclHqW8nAyyG0hh/2ftsqAbP8DUYw7R
    JrRBCwZ+whhIB3mGkJQPZikgGOUu4YvNIJEfjpWOJViKNY7J3Z25kpXh/PGXlMwp
    Ds69NZrRk2tpAt1/qbIdmBF319n8V5XRjJ992HsxPUCOIPaErWLS2GnVh4lNlSZG
    gA1oPdMmbuSxivErgoGmClBlVVm6Vqjk7G1N6Bh13zZV8lD6nZr49XqYXUewqpSz
    d7aemQlX+tWixVQrlh9nYZN2IakoTdk7Sv5xEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520580594; bh=x4v9xWd4f+ggqs1M2+N72AOx1H
    kntVGra9z+kCcW5E0=; b=Al7GLBwfqAsN+hta9gn0zqECc9aeIhoqF6E7RDSvMB
    QsNOnDa6vjLb9RH+Hokr3XNOcvpqVSflBAEH07bMzQQa80OeSEsQMnq1eC4Qe697
    VjcCI9PSrjyLEuQQn0MjOQYwPrg4+lXNJ+1dyPzPTni9x6oUzAQiD+p7EMA6c8ZJ
    JXNaM89Hxl+IPEsDu1w3kPOIg1oovLCL+2+Tonb+xtVMF8Qkmusum9lbHy1najMa
    6gLUjOc0tLlXwrNuboj1xaz7URZLwwaZfl3Fly/n2r84LJIB2NUUWmXI55VR/PDO
    /Ec2o+ZjhrCRVu2MEfH7uxcwce9PoRD8nBEYQx1w84iQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RMfVJt+u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q1cKuBHy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RMfVJt+u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q1cKuBHy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeCIH3j (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 02:29:39 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35912 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIH3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 02:29:38 -0500
X-Google-Smtp-Source: AG47ELtmYdwIB3HWl13AqDzeJDV/amgSptUPMZoMaOSGwjP5rx+KIYrhZ0udC/QV1PMfV9CZYdJN9w==
Date: Fri, 9 Mar 2018 08:29:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lakshman Annadorai <lakshmana@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Timur Tabi <timur@codeaurora.org>,
        Wang Nan <wangnan0@huawei.com>,
        Wang YanQing <udknight@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/54] perf/core improvements and fixes
Message-ID: <20180309072932.nphzr4smyxzupzbt@gmail.com>
References: <20180308195029.14991-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 3f986eefc89c528bf2d398a6dc3637b743a7139e:
> 
>   Merge branch 'perf/urgent' into perf/core, to resolve conflict (2018-03-07 09:23:12 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180308
> 
> for you to fetch changes up to 2427b432e63b4b911100f717c48289195b7a7d62:
> 
>   perf tools: Update quipper information (2018-03-08 11:30:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Support to display the IPC/Cycle in 'annotate' TUI, for systems
>   where this info can be obtained, like Intel's >= Skylake (Jin Yao)
> 
> - Support wildcards on PMU name in dynamic PMU events (Agustin Vega-Frias)
> 
> - Display pmu name when printing unmerged events in stat (Agustin Vega-Frias)
> 
> - Auto-merge PMU events created by prefix or glob match (Agustin Vega-Frias)
> 
> - Fix s390 'call' operations target function annotation (Thomas Richter)
> 
> - Handle s390 PC relative load and store instruction in the augmented
>   'annotate', code, used so far in the TUI modes of 'perf report' and
>   'perf annotate' (Thomas Richter)
> 
> - Provide libtraceevent with a kernel symbol resolver, so that
>   symbols in tracepoint fields can be resolved when showing them in
>   tools such as 'perf report' (Wang YanQing)
> 
> - Refactor the cgroups code to look more like other code in tools/perf,
>   using cgroup__{put,get} for refcount operations instead of its
>   open-coded equivalent, breaking larger functions, etc (Arnaldo Carvalho de Melo)
> 
> - Implement support for the -G/--cgroup target in 'perf trace', allowing
>   strace like tracing (plus other events, backtraces, etc) for cgroups
>   (Arnaldo Carvalho de Melo)
> 
> - Update thread shortname in 'perf sched map' when the thread's COMM
>   changes (Changbin Du)
> 
> - refcount 'struct mem_info', for better sharing it over several
>   users, avoid duplicating structs and fixing crashes related to
>   use after free (Jiri Olsa)
> 
> - Display perf.data version, offsets in 'perf report --header' (Jiri Olsa)
> 
> - Record the machine's memory topology information in a perf.data
>   feature section, to be used by tools such as 'perf c2c' (Jiri Olsa)
> 
> - Fix output of forced groups in the header for 'perf report' --stdio
>   and --tui (Jiri Olsa)
> 
> - Better support llvm, clang, cxx make tests in the build process (Jiri Olsa)
> 
> - Streamline the 'struct perf_mmap' methods, storing some info in the
>   struct instead of passing it via various methods, shortening its
>   signatures (Kan Liang)
> 
> - Update the quipper perf.data parser library site information (Stephane Eranian)
> 
> - Correct perf's man pages title markers for asciidoctor (Takashi Iwai)
> 
> - Intel PT fixes and refactorings paving the way for implementing
>   support for AUX area sampling (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (13):
>       perf record: Combine some auxtrace initialization into a single function
>       perf auxtrace: Add missing parameters from kernel-doc comments
>       perf auxtrace: Rename some buffer-queuing functions
>       perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
>       perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
>       perf intel-pt: Fix sync_switch
>       perf intel-pt: Fix error recovery from missing TIP packet
>       perf intel-pt: Fix timestamp following overflow
>       perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
>       perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
>       perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
>       perf intel-pt: Remove a check for sampling mode
>       perf intel-pt: Adjust overlap-checking to support sampling mode
> 
> Agustin Vega-Frias (3):
>       perf pmu: Support wildcards on pmu name in dynamic pmu events
>       perf pmu: Display pmu name when printing unmerged events in stat
>       perf pmu: Auto-merge PMU events created by prefix or glob match
> 
> Arnaldo Carvalho de Melo (11):
>       perf cgroup: Remove misplaced __maybe_unused
>       perf cgroup: Rename 'struct cgroup_sel' to 'struct cgroup'
>       perf cgroup: Introduce cgroup__delete()
>       perf cgroup: Rename close_cgroup() to cgroup__put()
>       perf cgroup: Introduce cgroup__get()
>       perf cgroup: Introduce find_cgroup() method
>       perf cgroup: Introduce cgroup__new() out of open coded equivalent
>       perf cgroup: Add evlist__findnew_cgroup()
>       perf cgroup: Add evlist__add_default_cgroup()
>       perf cgroup: Make the cgroup name be const char *
>       perf trace: Support setting cgroups as targets
> 
> Changbin Du (2):
>       perf sched: Move thread::shortname to thread_runtime
>       perf sched map: Re-annotate shortname if thread comm changed
> 
> Jin Yao (1):
>       perf annotate: Support to display the IPC/Cycle in TUI mode
> 
> Jiri Olsa (11):
>       perf report: Fix the output for stdio events list
>       perf report: Display perf.data header info
>       perf record: Move machine variable down the function
>       perf record: Remove progname from struct record
>       perf tools: Add refcnt into struct mem_info
>       perf c2c: Use mem_info refcnt logic
>       perf tools: Add MEM_TOPOLOGY feature to perf data file
>       perf tools: Update tags with .cpp files
>       perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
>       perf build: Add llvm/clang make targets to FILES
>       perf build: Force llvm/clang test compile output to .make.output
> 
> Kan Liang (8):
>       perf evlist: Store 'overwrite' in struct perf_mmap
>       perf mmap: Store mmap scope in struct perf_mmap()
>       perf mmap: Use the stored scope data in perf_mmap__push()
>       perf mmap: Use the stored data in perf_mmap__read_event()
>       perf mmap: Use stored 'overwrite' in perf_mmap__consume()
>       perf mmap: Simplify perf_mmap__consume()
>       perf mmap: Simplify perf_mmap__read_event()
>       perf mmap: Simplify perf_mmap__read_init()
> 
> Stephane Eranian (1):
>       perf tools: Update quipper information
> 
> Takashi Iwai (1):
>       perf tools: Correct title markers for asciidoctor
> 
> Thomas Richter (2):
>       perf annotate: Fix s390 target function disassembly
>       perf annotate: Handle s390 PC relative load and store instruction.
> 
> Wang YanQing (1):
>       perf report: Provide libtraceevent with a kernel symbol resolver
> 
>  tools/build/Makefile.feature                       |   6 +-
>  tools/build/feature/Makefile                       |  14 +-
>  tools/include/linux/bitmap.h                       |   2 +-
>  tools/perf/Documentation/perf-data.txt             |   2 +-
>  tools/perf/Documentation/perf-ftrace.txt           |   2 +-
>  tools/perf/Documentation/perf-kallsyms.txt         |   2 +-
>  tools/perf/Documentation/perf-list.txt             |   8 +-
>  tools/perf/Documentation/perf-sched.txt            |   2 +-
>  tools/perf/Documentation/perf-script-perl.txt      |   2 +-
>  tools/perf/Documentation/perf-stat.txt             |  17 ++
>  tools/perf/Documentation/perf-trace.txt            |  25 ++
>  tools/perf/Documentation/perf.data-file-format.txt |   7 +-
>  tools/perf/Makefile.perf                           |   6 +-
>  tools/perf/arch/s390/annotate/instructions.c       | 116 +++++++-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   7 +-
>  tools/perf/arch/x86/util/auxtrace.c                |  14 +-
>  tools/perf/builtin-annotate.c                      |  88 +++++-
>  tools/perf/builtin-c2c.c                           |  24 +-
>  tools/perf/builtin-kvm.c                           |   9 +-
>  tools/perf/builtin-record.c                        |  45 +--
>  tools/perf/builtin-report.c                        |  26 +-
>  tools/perf/builtin-sched.c                         | 133 ++++++---
>  tools/perf/builtin-stat.c                          |  29 +-
>  tools/perf/builtin-top.c                           |   7 +-
>  tools/perf/builtin-trace.c                         |  57 +++-
>  tools/perf/tests/backward-ring-buffer.c            |   5 +-
>  tools/perf/tests/bpf.c                             |   5 +-
>  tools/perf/tests/code-reading.c                    |   7 +-
>  tools/perf/tests/keep-tracking.c                   |   7 +-
>  tools/perf/tests/mmap-basic.c                      |   7 +-
>  tools/perf/tests/openat-syscall-tp-fields.c        |   7 +-
>  tools/perf/tests/perf-record.c                     |   7 +-
>  tools/perf/tests/sw-clock.c                        |   7 +-
>  tools/perf/tests/switch-tracking.c                 |   7 +-
>  tools/perf/tests/task-exit.c                       |   7 +-
>  tools/perf/ui/browsers/hists.c                     |   5 +-
>  tools/perf/util/annotate.c                         |   2 +-
>  tools/perf/util/auxtrace.c                         |  37 ++-
>  tools/perf/util/auxtrace.h                         |   2 +
>  tools/perf/util/cgroup.c                           | 111 +++++---
>  tools/perf/util/cgroup.h                           |  13 +-
>  tools/perf/util/env.h                              |   9 +
>  tools/perf/util/evlist.c                           |   8 +-
>  tools/perf/util/evsel.c                            |  23 +-
>  tools/perf/util/evsel.h                            |   6 +-
>  tools/perf/util/header.c                           | 312 ++++++++++++++++++++-
>  tools/perf/util/header.h                           |   1 +
>  tools/perf/util/hist.c                             |   4 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 ++---
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
>  tools/perf/util/intel-pt.c                         | 110 ++++----
>  tools/perf/util/machine.c                          |   2 +-
>  tools/perf/util/mmap.c                             |  63 ++---
>  tools/perf/util/mmap.h                             |  16 +-
>  tools/perf/util/parse-events.c                     |  21 +-
>  tools/perf/util/parse-events.h                     |   2 +-
>  tools/perf/util/parse-events.l                     |   2 +-
>  tools/perf/util/parse-events.y                     |  18 +-
>  tools/perf/util/python.c                           |   7 +-
>  tools/perf/util/symbol.c                           |  22 ++
>  tools/perf/util/symbol.h                           |  19 +-
>  tools/perf/util/thread.h                           |   1 -
>  62 files changed, 1197 insertions(+), 401 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
