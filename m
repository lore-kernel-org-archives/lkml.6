Return-Path: <acme@kernel.org>
X-Google-Smtp-Source: AIpwx4++5zwyx4ol0ETJJ4SQC7vZMem3yoIo/DcR9kOjoX2/UP4JYbpKN6jCRrxw6fD40+5+X2Il
ARC-Seal: i=1; a=rsa-sha256; t=1524234767; cv=none;
        d=google.com; s=arc-20160816;
        b=MBBiu+JAeZq0c41zhrI203aMJ5x+mAmaAoNhvldtu27vCO/jAWdrD6gtVSyOtJgYGL
         a3/bkuH976QoDRqObafaPzFTqvvyg1OtePJOwidX7tVgrYRe2xmAO/2HqvNw5z1gmN/I
         ZJe1u/jU2VPgVI6rNxctx7eT/2kLj4a13a6K2uSLp/B8v0WdhMSIf07cx4V1jYLRLorQ
         Zps90qL5rTJ8o06pGZgUG3LbB/vK2qwpOPd86u8BdmBMRyXN1xjWJIP9H0a73n07iweQ
         wV1c3iN7nlGahv/W/p1dthhy9GozsSsjIMOGt3N130+hb2WmUO3v/HEWgsdnPfmikBBq
         pXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:arc-authentication-results;
        bh=BvTx0lGGd02irs8b/4xhZ9kpCf4kLQclcaF0/faFbzk=;
        b=fYIH8TV5NjFFIAij/+oaJS4rBjzvJxJ2OATEAP3GSCMMh1ON8IIhzsLsXGvxFsBn3D
         5rKRmGDEPLeXrY/YqtLTX3PXwG6f6ye55mwPboTThH3kehqrB9Y447cE/nx0/Bx4qcyp
         D0Mtxx7GFAAStelGAHA6A34gRu9d2MFGwe9zI1yxYJLDL6AAY0ZiAqXnOPug50MlJYt5
         Id3Ut2GR4Hwj1E2iRIXqZfxzdnGnGb/PXrb6Ln0gjCuBzzXXtPYNJJSYsy47QttwGgff
         BPosEe+JvWLrkNVuJRfUoa6uk0+oZNK3PPEufo2hbw4XwfCzfh+vB7z9b0FPaNuPDr/2
         GTRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9B2217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
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
	Jin Yao <yao.jin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Kim Phillips <kim.phillips@arm.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Li Zhijian <lizhijian@cn.fujitsu.com>,
	Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
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
	Wang Nan <wangnan0@huawei.com>,
	William Cohen <wcohen@redhat.com>,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/17] perf/urgent fixes and improvements
Date: Fri, 20 Apr 2018 11:32:10 -0300
Message-Id: <20180420143227.16030-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598275995329372109?=
X-GMAIL-MSGID: =?utf-8?q?1598275995329372109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo,

	Please consider pulling, this took longer than I expected
due to the syscall rename fallout :-\

- Arnaldo

The following changes since commit 5c8dad48e4f53d6fd0a7e4f95d7c1c983374de88:

  trace_kprobe: Remove warning message "Could not insert probe at..." (2018-04-17 07:54:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180420

for you to fetch changes up to 8a9fd8323087e794f1d3cd4850b393ced048bc73:

  coresight: Move to SPDX identifier (2018-04-19 12:29:41 -0300)

----------------------------------------------------------------
perf/urgent fixes and improvements:

- Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE].
  The percentage of preempting and non-preempting context switches help
  understanding the nature of workloads (CPU or IO bound) that are running
  on a machine. This adds the kernel facility and userspace changes needed
  to show this information in 'perf script' and 'perf report -D' (Alexey Budankov)

- Remove old error messages about things that unlikely to be the root cause
  in modern systems (Andi Kleen)

- Synchronize kernel ABI headers, v4.17-rc1 (Ingo Molnar)

- Support MAP_FIXED_NOREPLACE, noticed when updating the tools/include/
  copies (Arnaldo Carvalho de Melo)

- Fixup BPF test using epoll_pwait syscall function probe, to cope with
  the syscall routines renames performed in this development cycle (Arnaldo Carvalho de Melo)

- Fix sample_max_stack maximum check and do not proceed when an error
  has been detect, return them to avoid misidentifying errors (Jiri Olsa)

- Add '\n' at the end of parse-options error messages (Ravi Bangoria)

- Add s390 support for detailed/verbose PMU event description (Thomas Richter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexey Budankov (3):
      perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]
      perf report: Extend raw dump (-D) out with switch out event type
      perf script: Extend misc field decoding with switch out event type

Andi Kleen (4):
      perf mem: Allow all record/report options
      perf hists browser: Clarify top/report browser help
      perf record: Remove misleading error suggestion
      perf record: Remove suggestion to enable APIC

Arnaldo Carvalho de Melo (3):
      perf trace: Support MAP_FIXED_NOREPLACE
      perf tests mmap: Show which tracepoint is failing
      perf test BPF: Fixup BPF test using epoll_pwait syscall function probe

Ingo Molnar (1):
      tools/headers: Synchronize kernel ABI headers, v4.17-rc1

Jiri Olsa (3):
      perf: Return proper values for user stack errors
      perf: Fix sample_max_stack maximum check
      perf: Remove superfluous allocation error check

Mathieu Poirier (1):
      coresight: Move to SPDX identifier

Ravi Bangoria (1):
      perf tools: Add '\n' at the end of parse-options error messages

Thomas Richter (1):
      perf list: Add s390 support for detailed/verbose PMU event description

 include/linux/coresight-pmu.h                     |  13 +-
 include/uapi/linux/perf_event.h                   |  18 +-
 kernel/events/callchain.c                         |  25 +-
 kernel/events/core.c                              |   8 +-
 tools/arch/arm/include/uapi/asm/kvm.h             |   9 +
 tools/arch/x86/include/asm/required-features.h    |   8 +-
 tools/arch/x86/include/uapi/asm/kvm.h             |  19 +-
 tools/include/linux/coresight-pmu.h               |  13 +-
 tools/include/uapi/asm-generic/mman-common.h      |   3 +
 tools/include/uapi/linux/bpf.h                    |   1 +
 tools/include/uapi/linux/if_link.h                |  39 ++
 tools/include/uapi/linux/kvm.h                    |  21 +-
 tools/include/uapi/linux/perf_event.h             |  18 +-
 tools/include/uapi/sound/asound.h                 |   1 +
 tools/lib/subcmd/parse-options.c                  |   6 +-
 tools/perf/Documentation/perf-mem.txt             |   3 +
 tools/perf/Documentation/perf-script.txt          |  17 +-
 tools/perf/arch/arm/util/auxtrace.c               |  13 +-
 tools/perf/arch/arm/util/cs-etm.c                 |  13 +-
 tools/perf/arch/arm/util/cs-etm.h                 |  13 +-
 tools/perf/arch/arm/util/pmu.c                    |  13 +-
 tools/perf/arch/x86/Makefile                      |   2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 712 +++++++++++-----------
 tools/perf/builtin-mem.c                          |   4 +-
 tools/perf/builtin-script.c                       |   5 +-
 tools/perf/tests/bpf-script-example.c             |   2 +-
 tools/perf/tests/mmap-basic.c                     |   2 +-
 tools/perf/trace/beauty/mmap.c                    |   3 +
 tools/perf/ui/browsers/hists.c                    |   2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c   |   3 +-
 tools/perf/util/cs-etm.c                          |   3 +-
 tools/perf/util/cs-etm.h                          |  13 +-
 tools/perf/util/event.c                           |   4 +-
 tools/perf/util/evsel.c                           |   6 +-
 tools/perf/util/pmu.c                             |   6 +
 35 files changed, 545 insertions(+), 496 deletions(-)
