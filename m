Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D61C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA272070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546520835;
	bh=kOwhYziO9v4j3Uc5hXcjbhfhA536r/ua2oDdYrdk4YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZhMizzXXnSK1ylaad31rhCGquCLVPi7kBa2f2nnYpodKsSGoNMW50QXkb2dQKPnB
	 u+x4xQhn1FqUu7AYct8ItgFscNXGSy1vVLaSq6ebQ8FWe/NiJHO1ZSmuR4KTCFRYPS
	 7vhXlxr4Abs/SCehckmNNp4y8Gdhci5q6yDOs+0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfACNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:07:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35538 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:07:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so18315895wmt.0;
        Thu, 03 Jan 2019 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAHNSNWjLoD8yti3azFXMDurulXmWfDCBixgsHp0mUc=;
        b=n50DeGv/YUL25tZ1egjwNH7y1MQCubOTEN+brMbQVGLM2eYEsFj6CJlu4VJfJKhSeu
         fvwkTF96eBHzyKLn3bO5GmSLV7v4UxfA/69k7+qSzysec/vX15N3B71dqcH/+eo/+13Y
         lOSmF3wfgXi0rCiiK4kFCKrt9llHxQOBhi7H11sMe5k8W0poxLcvC5/KVC6J5WV6WW8m
         qYKJVU10XQ92have+Rl9tDxxSkZO3nrrHCzLsgRSJuYdvAg4txiJ7BUvgR7fdNrB8YqX
         7JEIYZLsh2wwqnPTjaQYVCc1RazdICt+minMnzy+hxgyeq/jfCBrBvepS6XkkLx459vM
         5KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAHNSNWjLoD8yti3azFXMDurulXmWfDCBixgsHp0mUc=;
        b=r19k8v2NKHgCJIOCgFSgwcoDXHV5TD43H6sLYSAfLiHXZJaaJDJZZ6W8fA6k4Od+Z9
         HNLlkdcJld3uAHQ7znTZ/s+KHA3g7lqSoQc8IRRGWr1LPKphcWsmmymVP3KBn5BzkDWw
         zFER2xtvU7+Hc4zJIlEo9q5Hrd7RDAtOH05Rtm2adoPiHVjzpuxRm4SFm1aj4B7kXNfg
         iFm6Gw4aoW+4i+89bJyyGBWrYa3YuCPpLTDj6bXU2+hQOmpMt1IgWhU4/az04ZcZ+4Vn
         2hpGK5MjPnEOpEvUQmsud4/p3AGA+aYVjTu9+fqgoTnsNwwtFB1zJB9hG4ZWyusHLFQO
         pKpA==
X-Gm-Message-State: AJcUuke3SP9Dh0MN+3jQ/PgK1QGgOHTwnl1Ni811eUes+AnVi5LnnvOl
        zWvR9OpEOLdLc2v45FoFjVI=
X-Google-Smtp-Source: ALg8bN6qAxYavLPvvKC3dvqINJsUY2vz92BKqJ0DivvoZ+nSfvS4lM+w2SIZgMD7BtPywGS6hW35OA==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr39812141wmh.40.1546520830383;
        Thu, 03 Jan 2019 05:07:10 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b129sm28855778wmd.24.2019.01.03.05.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 05:07:09 -0800 (PST)
Date:   Thu, 3 Jan 2019 14:07:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/29] perf/core improvements and fixes
Message-ID: <20190103130707.GA47648@gmail.com>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
> The following changes since commit 883f4def8b77e6870ce42be279564cca0256c611:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20181218' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-12-20 18:51:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20190103
> 
> for you to fetch changes up to b25756df5b28cd7b6e91200fc5012e7c76e8ec69:
> 
>   perf session: Add comment for perf_session__register_idle_thread() (2019-01-02 11:05:06 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf c2c:
> 
>   Jiri Olsa:
> 
>   - Change the default coalesce setup to from '--coalesce pid,iaddr' to just '--coalesce iaddr'.
> 
>   - Increase the HITM ratio limit for displayed cachelines.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix LBR skid dump problems in brstackinsn.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter.
> 
>   - Do not hardcode the size of the tracepoint common_ fields.
> 
>   - Beautify USBDEFFS_ ioctl commands.
> 
>   Colin Ian King:
> 
>   - Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*".
> 
> perf python:
> 
>   Jiri Olsa:
> 
>   - Do not force closing original perf descriptor in evlist.get_pollfd().
> 
> tools misc:
> 
>   Jiri Olsa:
> 
>   - Allow overriding CFLAGS and LDFLAGS.
> 
> perf build:
> 
>   Stanislav Fomichev:
> 
>   - Don't unconditionally link the libbfd feature test to -liberty and -lz
> 
> thread-stack:
> 
>   Adrian Hunter:
> 
>   - Fix processing for the idle task, having a stack per cpu.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (8):
>       perf thread-stack: Simplify some code in thread_stack__process()
>       perf thread-stack: Tidy thread_stack__bottom() usage
>       perf thread-stack: Avoid direct reference to the thread's stack
>       perf thread-stack: Allow for a thread stack array
>       perf thread-stack: Factor out thread_stack__init()
>       perf thread-stack: Allocate an array of thread stacks
>       perf thread-stack: Fix thread stack processing for the idle task
>       perf session: Add comment for perf_session__register_idle_thread()
> 
> Andi Kleen (1):
>       perf script: Fix LBR skid dump problems in brstackinsn
> 
> Arnaldo Carvalho de Melo (11):
>       perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter
>       perf beauty mmap: PROT_WRITE should come before PROT_EXEC
>       perf trace: Do not hardcode the size of the tracepoint common_ fields
>       perf trace: Rename thread_thread->paths to thread_trace->files
>       perf trace: Move the files table resizing to outside set_pathname()
>       perf trace: Store the major number for a file when storing its pathname
>       tools headers uapi: Grab a copy of usbdevice_fs.h
>       perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands
>       perf trace: Wire up ioctl's USBDEBFS_ cmd table generator
>       perf trace beauty: Export function to get the files for a thread
>       perf trace beauty ioctl: Beautify USBDEVFS_ commands
> 
> Colin Ian King (1):
>       perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"
> 
> Jiri Olsa (7):
>       perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
>       perf c2c: Change the default coalesce setup
>       perf c2c: Increase the HITM ratio limit for displayed cachelines
>       tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
>       tools thermal tmon: Allow overriding CFLAGS assignments
>       tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
>       tools gpio: Allow overriding CFLAGS
> 
> Stanislav Fomichev (1):
>       perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz
> 
>  tools/build/Makefile.feature                       |   4 +-
>  tools/build/feature/Makefile                       |  10 +-
>  tools/gpio/Makefile                                |   2 +-
>  tools/include/uapi/linux/usbdevice_fs.h            | 201 ++++++++++++++++++
>  tools/perf/Makefile.config                         |  44 ++--
>  tools/perf/Makefile.perf                           |   8 +
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-script.c                        |  21 +-
>  tools/perf/builtin-trace.c                         | 142 +++++++++----
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   7 +
>  tools/perf/trace/beauty/ioctl.c                    |  22 ++
>  tools/perf/trace/beauty/mmap.c                     |   2 +-
>  tools/perf/trace/beauty/seccomp.c                  |   4 +-
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh          |  19 ++
>  tools/perf/util/dump-insn.c                        |   8 +
>  tools/perf/util/dump-insn.h                        |   2 +
>  tools/perf/util/intel-bts.c                        |   4 +-
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   8 +
>  tools/perf/util/intel-pt.c                         |   6 +-
>  tools/perf/util/python.c                           |   3 +-
>  tools/perf/util/session.c                          |   7 +
>  tools/perf/util/thread-stack.c                     | 227 +++++++++++++++------
>  tools/perf/util/thread-stack.h                     |   8 +-
>  tools/power/x86/turbostat/Makefile                 |   8 +-
>  tools/power/x86/x86_energy_perf_policy/Makefile    |   6 +-
>  tools/thermal/tmon/Makefile                        |   8 +-
>  27 files changed, 620 insertions(+), 166 deletions(-)
>  create mode 100644 tools/include/uapi/linux/usbdevice_fs.h
>  create mode 100755 tools/perf/trace/beauty/usbdevfs_ioctl.sh

Pulled, thanks a lot Arnaldo!

	Ingo
