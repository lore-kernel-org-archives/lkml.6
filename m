Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBEV2Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:28:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36253 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeBEV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:28:07 -0500
X-Google-Smtp-Source: AH8x2273WFE3dHebBAXnmD3jbzwos72Im5e/+A5YbZ2MrZaOuZiALR0aZr/ZTFyz76n/DCdOdUrpdw==
Date: Mon, 5 Feb 2018 22:28:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Juri Lelli <juri.lelli@gmail.com>,
        Kan Liang <kan.liang@intel.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>, Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [GIT PULL 00/10] perf/urgent fixes
Message-ID: <20180205212801.p5iqjeglg2vowng2@gmail.com>
References: <20180205195620.9010-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 72906f38934a49faf4d2d38ea9ae32adcf7d5d0c:
> 
>   Merge branch 'x86-hyperv-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2018-01-30 13:04:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180205
> 
> for you to fetch changes up to 2fe2230d4183d2c311bbb7b426491ac486216a16:
> 
>   perf tools: Add trace/beauty/generated/ into .gitignore (2018-02-05 13:58:02 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - 'period' and 'freq' handling fixes for 'perf record', also
>   related: add Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS
>   in the x86 perf kernel driver (Jiri Olsa)
> 
> - Fix 'perf trace -i perf.data' callgraph handling (Ravi Bangoria)
> 
> - Synchronize tooling headers for asound, s390 and powerpc KVM,
>   sched and x86 features (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools headers: Synchronize sound/asound.h
>       tooling headers: Synchronize updated s390 kvm UAPI headers
>       tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h
>       tools headers: Synchronize uapi/linux/sched.h
>       tools headers: Synchoronize x86 features UAPI headers
> 
> Jiri Olsa (3):
>       perf evsel: Fix period/freq terms setup
>       perf record: Fix period option handling
>       x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS
> 
> Ravi Bangoria (2):
>       perf trace: Fix call-graph output
>       perf tools: Add trace/beauty/generated/ into .gitignore
> 
>  arch/x86/events/perf_event.h                   |  3 ++-
>  tools/arch/powerpc/include/uapi/asm/kvm.h      | 25 +++++++++++++++++++++++++
>  tools/arch/s390/include/uapi/asm/kvm.h         |  5 ++++-
>  tools/arch/x86/include/asm/cpufeatures.h       | 24 ++++++++++++++++++++----
>  tools/arch/x86/include/asm/disabled-features.h |  3 ++-
>  tools/arch/x86/include/asm/required-features.h |  3 ++-
>  tools/include/uapi/linux/kvm.h                 |  4 ++++
>  tools/include/uapi/linux/sched.h               |  5 +++++
>  tools/include/uapi/sound/asound.h              |  9 +++++++++
>  tools/perf/.gitignore                          |  1 +
>  tools/perf/builtin-record.c                    |  3 ++-
>  tools/perf/builtin-trace.c                     |  5 ++++-
>  tools/perf/perf.h                              |  1 +
>  tools/perf/util/evsel.c                        | 13 ++++++++++---
>  14 files changed, 91 insertions(+), 13 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
