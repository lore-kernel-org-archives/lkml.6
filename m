Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524296356; cv=none;
        d=google.com; s=arc-20160816;
        b=hmb5SgltrVIe9HwPHz229M9yKbE9NvPHmgaisOumwiIwJSPxs9I9AZBa9phMejEy9m
         AFpkFjloUJp2MMGr9DiEWUR4QpPlWBXRrVGv4GcTtJbFeefQyyU316uxdmBKXbHNneaB
         rA7Z9hHk9GFet7M6KpGM+BZK6seLhl1tD603TNUbbW0lHEF4WQmdbTixDq3e4D2qw+BL
         ZZgrMLXwe7fBFzHEieDSrCjs2HB88ImmE/JninAxNWE7afozQZCVk+HtesQya34AQb/1
         x7BfiHCeOEvbv/GS1Z1ZX3ivIV6nooTnHJbrkGDIqOb0FQqRdBEM89lLDZfSdLyIyGUm
         p7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=XeCN8j+TDZla46nSV14qlEWdwJkT9ViO0yLTimMcrVQ=;
        b=XThlMJegAj6M01PZxkE8QFWfiKz2cyL3sHmfDc/Mq9UOKjckzxE3/j2AT7quCstSqf
         2UNZU/dBNAmjQq42csFgI8+6jqTkRpiyh9GDO/VeRNc1H6wewoo4DjOxI2VelZCSPWgn
         FEwJEFbPHhk316amU9z/rizLsDeYgeFJZ7mUQ5YQKq4QvYlSNirwRPrDQC8EbxwwgW/A
         AnamkkfDcf1INnYvjW9jb3hBpxJFQqoUQQJErX2ZRJeF+1sv8pyyZazKGwh2WQ0HFf1i
         E3iB3KChq/NCzpwRUx+9G4koD8U/WoegED0C5Z714+gVC+aaW7VU+WN7B10hJIohYJRC
         DK6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oY4K0NIo;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oY4K0NIo;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx4/1zi7gQx9qwG1I6zEWmaeQUXxhIJLqHA8Qu1H4pcf4oyNExUyl1+amIKLr4Q/jXx/C2zpEWQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 21 Apr 2018 09:39:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Brian Robbins <brianrob@microsoft.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Ahern <dsahern@gmail.com>,
	"Dmitriy Vyukov dvyukov @ google . com" <dvyukov@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Kim Phillips <kim.phillips@arm.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Li Zhijian <lizhijian@cn.fujitsu.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Sihyeon Jang <uneedsihyeon@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Takuya Yamamoto <tkydevel@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Wang Nan <wangnan0@huawei.com>, William Cohen <wcohen@redhat.com>,
	x86@kernel.org, Yonghong Song <yhs@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/17] perf/urgent fixes and improvements
Message-ID: <20180421073910.urxorhupps2sjc7h@gmail.com>
References: <20180420143227.16030-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598275995329372109?=
X-GMAIL-MSGID: =?utf-8?q?1598340576025696794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this took longer than I expected
> due to the syscall rename fallout :-\
> 
> - Arnaldo
> 
> The following changes since commit 5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88:
> 
>   trace_kprobe: Remove warning message "Could not insert probe at..." (2018-04-17 07:54:57 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180420
> 
> for you to fetch changes up to 8a9fd8323087e794f1d3cd4850b393ced048bc73:
> 
>   coresight: Move to SPDX identifier (2018-04-19 12:29:41 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes and improvements:
> 
> - Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE].
>   The percentage of preempting and non-preempting context switches help
>   understanding the nature of workloads (CPU or IO bound) that are running
>   on a machine. This adds the kernel facility and userspace changes needed
>   to show this information in 'perf script' and 'perf report -D' (Alexey Budankov)
> 
> - Remove old error messages about things that unlikely to be the root cause
>   in modern systems (Andi Kleen)
> 
> - Synchronize kernel ABI headers, v4.17-rc1 (Ingo Molnar)
> 
> - Support MAP_FIXED_NOREPLACE, noticed when updating the tools/include/
>   copies (Arnaldo Carvalho de Melo)
> 
> - Fixup BPF test using epoll_pwait syscall function probe, to cope with
>   the syscall routines renames performed in this development cycle (Arnaldo Carvalho de Melo)
> 
> - Fix sample_max_stack maximum check and do not proceed when an error
>   has been detect, return them to avoid misidentifying errors (Jiri Olsa)
> 
> - Add '\n' at the end of parse-options error messages (Ravi Bangoria)
> 
> - Add s390 support for detailed/verbose PMU event description (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (3):
>       perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]
>       perf report: Extend raw dump (-D) out with switch out event type
>       perf script: Extend misc field decoding with switch out event type
> 
> Andi Kleen (4):
>       perf mem: Allow all record/report options
>       perf hists browser: Clarify top/report browser help
>       perf record: Remove misleading error suggestion
>       perf record: Remove suggestion to enable APIC
> 
> Arnaldo Carvalho de Melo (3):
>       perf trace: Support MAP_FIXED_NOREPLACE
>       perf tests mmap: Show which tracepoint is failing
>       perf test BPF: Fixup BPF test using epoll_pwait syscall function probe
> 
> Ingo Molnar (1):
>       tools/headers: Synchronize kernel ABI headers, v4.17-rc1
> 
> Jiri Olsa (3):
>       perf: Return proper values for user stack errors
>       perf: Fix sample_max_stack maximum check
>       perf: Remove superfluous allocation error check
> 
> Mathieu Poirier (1):
>       coresight: Move to SPDX identifier
> 
> Ravi Bangoria (1):
>       perf tools: Add '\n' at the end of parse-options error messages
> 
> Thomas Richter (1):
>       perf list: Add s390 support for detailed/verbose PMU event description
> 
>  include/linux/coresight-pmu.h                     |  13 +-
>  include/uapi/linux/perf_event.h                   |  18 +-
>  kernel/events/callchain.c                         |  25 +-
>  kernel/events/core.c                              |   8 +-
>  tools/arch/arm/include/uapi/asm/kvm.h             |   9 +
>  tools/arch/x86/include/asm/required-features.h    |   8 +-
>  tools/arch/x86/include/uapi/asm/kvm.h             |  19 +-
>  tools/include/linux/coresight-pmu.h               |  13 +-
>  tools/include/uapi/asm-generic/mman-common.h      |   3 +
>  tools/include/uapi/linux/bpf.h                    |   1 +
>  tools/include/uapi/linux/if_link.h                |  39 ++
>  tools/include/uapi/linux/kvm.h                    |  21 +-
>  tools/include/uapi/linux/perf_event.h             |  18 +-
>  tools/include/uapi/sound/asound.h                 |   1 +
>  tools/lib/subcmd/parse-options.c                  |   6 +-
>  tools/perf/Documentation/perf-mem.txt             |   3 +
>  tools/perf/Documentation/perf-script.txt          |  17 +-
>  tools/perf/arch/arm/util/auxtrace.c               |  13 +-
>  tools/perf/arch/arm/util/cs-etm.c                 |  13 +-
>  tools/perf/arch/arm/util/cs-etm.h                 |  13 +-
>  tools/perf/arch/arm/util/pmu.c                    |  13 +-
>  tools/perf/arch/x86/Makefile                      |   2 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 712 +++++++++++-----------
>  tools/perf/builtin-mem.c                          |   4 +-
>  tools/perf/builtin-script.c                       |   5 +-
>  tools/perf/tests/bpf-script-example.c             |   2 +-
>  tools/perf/tests/mmap-basic.c                     |   2 +-
>  tools/perf/trace/beauty/mmap.c                    |   3 +
>  tools/perf/ui/browsers/hists.c                    |   2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c   |   3 +-
>  tools/perf/util/cs-etm.c                          |   3 +-
>  tools/perf/util/cs-etm.h                          |  13 +-
>  tools/perf/util/event.c                           |   4 +-
>  tools/perf/util/evsel.c                           |   6 +-
>  tools/perf/util/pmu.c                             |   6 +
>  35 files changed, 545 insertions(+), 496 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
