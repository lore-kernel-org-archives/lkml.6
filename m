Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1F0C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30802147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbyQ/KpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30802147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeHWMAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:00:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53534 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeHWMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:00:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so4358682wmh.3;
        Thu, 23 Aug 2018 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCJI8DA4K4j6ysCaImIJwiAeJMCZFxYD1LCFrFcxMpc=;
        b=bbyQ/KpLEs1ET8RZaMcEW7Aj6fodYUuTGEAEkRxNnUpsbG3xpOoZxhVR1HE7/3Uh8y
         Lozu4Rz+GP/CWKqnlGd/aS6PB853bEVhFNfco+6VszM/0bjRcZVgQzEKe0UpHkGO52XF
         tHsWgI8HFqe4u3zaxm7HoOjYxCt3HHlHmI96IR+s9GRkvpY16a17YCFMcxPUygTUWJxE
         2J8797Mb/UiEvWZNFBY8dT6/qgYjt3/94KNhDEa09LJLp4KP6DF58cVJEznO8BlXoxzT
         BKBvVk0QUvVWZ2YW/6oSWEZdsX9NK3ZIM1FIGbfwl6kAD/zDnElVg7WYn9HYPWGGedL7
         +dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCJI8DA4K4j6ysCaImIJwiAeJMCZFxYD1LCFrFcxMpc=;
        b=cDQnG4eRpLPjZMqHIphkx3xC6T9V55ZsO/xe0FWUOWuOZrFiUI61CTCam898dJO/aL
         n4uQXoUTfBhyYQ7DN5bwn4f+nk41iEiMdWnVKPQuB6xK2qftPzomSWd78O1+oFG1E3vj
         rg+ugfvy4PDRUXVbWNV2OsOfStfqAo8yj5tAkurtJxUo0HpAN4YcSnwVg2QbIwy6pwSI
         SHAaN2glC79kqriKVBRN9OfuuF/GGOZBcmBiE+JR4vHzympBZrLZ6+KxkIZqErmCD/xl
         q4y04Y2oVln7kAg2czgDe8SFxKZSJ8EuQMpPSRHwZUae/qPfbzlAcZLtD1/QGU6lxiJK
         +uEw==
X-Gm-Message-State: APzg51CEjEK03HuDGWK1p4wG/Nho/kBDuS7GYyZ9aFTabwQeA9Ly9ypD
        7uyiVBXoDsfeGX3QgbWju/s=
X-Google-Smtp-Source: ANB0VdbMxMyMYT9idCOgS3lcK3puK2S+pXNmu39qfeYfz5a4i0QD2J0UVCaQmvxSUF5SmBOBMdJmqw==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr4825307wmw.13.1535013088712;
        Thu, 23 Aug 2018 01:31:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 204-v6sm5606633wmh.25.2018.08.23.01.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:31:27 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:31:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Jack Henschel <jackdev@mailbox.org>,
        Jan Beulich <JBeulich@suse.com>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>,
        linux-trace-devel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Feiner <pfeiner@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/21] perf/core improvements and fixes
Message-ID: <20180823083124.GA10800@gmail.com>
References: <20180820161602.6830-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pullimg,
> 
> - Arnaldo
> 
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5804b11034a21e4287daaf017c5ad60ad7af8d67:
> 
>   Merge tag 'perf-core-for-mingo-4.19-20180815' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-08-18 13:11:51 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180820
> 
> for you to fetch changes up to 78303650e4cd873c6c4276c6fe3e768ff0b46d22:
> 
>   tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy' (2018-08-20 10:17:14 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> LLVM/clang/eBPF: (Arnaldo Carvalho de Melo)
> 
> - Allow passing options to llc in addition to to clang.
> 
> Hardware tracing: (Jack Henschel)
> 
> - Improve error message for PMU address filters, clarifying availability of
>   that feature in hardware having hardware tracing such as Intel PT.
> 
> Python interface: (Jiri Olsa)
> 
> - Fix read_on_cpu() interface.
> 
> ELF/DWARF libraries: (Jiri Olsa)
> 
> - Fix handling of the combo compressed module file + decompressed associated
>   debuginfo file.
> 
> Build (Rasmus Villemoes)
> 
> - Disable parallelism for 'make clean', avoiding multiple submakes deleting
>   the same files and causing the build to fail on systems such as Yocto.
> 
> Kernel ABI copies: (Arnaldo Carvalho de Melo)
> 
> - Update tools's copy of x86's cpufeatures.h.
> 
> - Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'.
> 
> Miscellaneous: (Steven Rostedt)
> 
> - Change libtraceevent to SPDX License format.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (3):
>       perf llvm: Allow passing options to llc in addition to clang
>       tools arch x86: Update tools's copy of cpufeatures.h
>       tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
> 
> Jack Henschel (1):
>       perf parser: Improve error message for PMU address filters
> 
> Jiri Olsa (15):
>       perf tools: Get rid of dso__needs_decompress() call in read_object_code()
>       perf tools: Get rid of dso__needs_decompress() call in symbol__disassemble()
>       perf tools: Get rid of dso__needs_decompress() call in __open_dso()
>       perf tools: Make decompress_to_file() function static
>       perf tools: Make is_supported_compression() static
>       perf tools: Add compression id into 'struct kmod_path'
>       perf tools: Store compression id into struct dso
>       perf tools: Use compression id in decompress_kmodule()
>       perf tools: Move the temp file processing into decompress_kmodule
>       perf tools: Add is_compressed callback to compressions array
>       perf tools: Add lzma_is_compressed function
>       perf tools: Add gzip_is_compressed function
>       perf tools: Remove ext from struct kmod_path
>       perf mmap: Store real cpu number in 'struct perf_mmap'
>       perf python: Fix pyrf_evlist__read_on_cpu() interface
> 
> Rasmus Villemoes (1):
>       perf tools: Disable parallelism for 'make clean'
> 
> Steven Rostedt (VMware) (1):
>       tools lib traceevent: Change to SPDX License format
> 
>  tools/arch/x86/include/asm/cpufeatures.h |   3 +-
>  tools/arch/x86/lib/memcpy_64.S           |   2 +-
>  tools/lib/traceevent/event-parse.c       |  16 +---
>  tools/lib/traceevent/event-plugin.c      |  16 +---
>  tools/lib/traceevent/event-utils.h       |  16 +---
>  tools/lib/traceevent/kbuffer-parse.c     |  17 +---
>  tools/lib/traceevent/parse-filter.c      |  16 +---
>  tools/lib/traceevent/parse-utils.c       |  16 +---
>  tools/lib/traceevent/trace-seq.c         |  16 +---
>  tools/perf/Makefile                      |   4 +-
>  tools/perf/tests/code-reading.c          |   4 +-
>  tools/perf/tests/kmod-path.c             | 136 +++++++++++++++----------------
>  tools/perf/util/annotate.c               |   4 +-
>  tools/perf/util/compress.h               |   2 +
>  tools/perf/util/dso.c                    | 111 ++++++++++++-------------
>  tools/perf/util/dso.h                    |  13 ++-
>  tools/perf/util/evlist.c                 |   2 +-
>  tools/perf/util/llvm-utils.c             |  31 ++++++-
>  tools/perf/util/llvm-utils.h             |   9 ++
>  tools/perf/util/lzma.c                   |  20 +++++
>  tools/perf/util/machine.c                |   4 +-
>  tools/perf/util/mmap.c                   |   3 +-
>  tools/perf/util/mmap.h                   |   3 +-
>  tools/perf/util/parse-events.c           |  20 ++---
>  tools/perf/util/python.c                 |  20 ++++-
>  tools/perf/util/zlib.c                   |  18 ++++
>  26 files changed, 256 insertions(+), 266 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
