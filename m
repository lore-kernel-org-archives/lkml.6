Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE8C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D849B20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYS9vE20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D849B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeIJAa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:30:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51979 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeIJAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:30:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so19362418wma.1;
        Sun, 09 Sep 2018 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Olh6rEV31+h5/O1QNMEB7YUAIxZ1I/xIU8oQ2Iq5ztM=;
        b=XYS9vE20Y5hKzi1BxrCeSfctXYF+9yURIuU9vNvhveiiKu4YU+S2Wqcr42EuzDLklo
         IL+8PMSLWAPWAlCinu/dcYF3TEcGsrYtiPaM/E/ud3myQ6K3mrPneemEW4JjneRV4Re9
         70HPDDLmuhId3YhMT2KE3wJtMInQBrCeBkGX80nXa5v3eMqRYLMU+8y5zGek+vK9VneD
         0p72nhIJA/VntyEo0B20iII/Yzuc665yZqtXNWufCIhjaD+6wbzcvAD6dxuHsDWF0pY2
         oVKqYnmojF/7cWlx8ty9ypz9ny6HO8OPBl9zcGVCNvzqP6QdhXY7cEQYotsrm5SQvWBW
         77mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Olh6rEV31+h5/O1QNMEB7YUAIxZ1I/xIU8oQ2Iq5ztM=;
        b=UIIwmxlcN3Lq654uTVxvHNRxo5LBkFtL46cfTyyN1A05+UmP3QVYYOqoMorEunADqQ
         ucFVKyho3No1ez0HzwxKXzZoegFSnGzLKhL2L5M1/vC+TL1butnacjgcgUW9cLkVo3s3
         SNRV0bHR2XhX0aXHirE0E7BEpKz0D6nvAg/aGJ68/MxsFa0QiX7YA9fqezCqIA3Yr/vp
         bDzs2L1TE5OJvjnvEyDsKdGkK5LQQ5YxL96EUnLXJ5jBhes3awo7BMVg+y1y/djPzJi5
         32RHjCNAT7JYbcmmLI41hgLOCPiRl0un8SRy75qx9f7u+d89gOYvMKK3LjSSxcRoXlaj
         ltkA==
X-Gm-Message-State: APzg51BYQ8g/pQzOmqYBe7TPwc3dZCuJ0zoC2Cqa/3LWTWoSONYi/QV9
        38x87WiQ4xFf7bkMe6hVMMU=
X-Google-Smtp-Source: ANB0VdZboPgE4WLi7Cg7ENVmkYVThjkjx/Br7Xd+UGSZ0T0v+wMNKy5qKfoY3A8JZTqT8IUvoArJcA==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr10837922wmb.19.1536521982211;
        Sun, 09 Sep 2018 12:39:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 184-v6sm26052981wmv.6.2018.09.09.12.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 12:39:41 -0700 (PDT)
Date:   Sun, 9 Sep 2018 21:39:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anton Blanchard <anton@samba.org>,
        Chris Phlipot <cphlipot0@gmail.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Hisao Tanabe <xtanabe@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/13] perf/urgent fixes
Message-ID: <20180909193938.GA14324@gmail.com>
References: <20180903145224.12318-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
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
> The following changes since commit 66e5db4a1ccc64f278653bc69dc406d184dc750a:
> 
>   Merge tag 'perf-core-for-mingo-4.19-20180820' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-08-23 10:29:19 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180903
> 
> for you to fetch changes up to 4e67b2a5df5d3f341776d12ee575e00ca3ef92de:
> 
>   perf annotate: Fix parsing aarch64 branch instructions after objdump update (2018-08-30 15:51:54 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> Kernel:
> 
> - Modify breakpoint fixes (Jiri Olsa)
> 
> perf annotate:
> 
> - Fix parsing aarch64 branch instructions after objdump update (Kim Phillips)
> 
> - Fix parsing indirect calls in 'perf annotate' (Martin Liška)
> 
> perf probe:
> 
> - Ignore SyS symbols irrespective of endianness on PowerPC (Sandipan Das)
> 
> perf trace:
> 
> - Fix include path for asm-generic/unistd.h on arm64 (Kim Phillips)
> 
> Core libraries:
> 
> - Fix potential null pointer dereference in perf_evsel__new_idx() (Hisao Tanabe)
> 
> - Use fixed size string for comms instead of scanf("%m"), that is
>   not present in the bionic libc and leads to a crash (Chris Phlipot)
> 
> - Fix bad memory access in trace info on 32-bit systems, we were reading
>   8 bytes from a 4-byte long variable when saving the command line in the
>   perf.data file.  (Chris Phlipot)
> 
> Build system:
> 
> - Streamline bpf examples and headers installation, clarifying
>   some install messages. (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf tools: Streamline bpf examples and headers installation
> 
> Chris Phlipot (2):
>       perf util: Fix bad memory access in trace info.
>       perf event-parse: Use fixed size string for comms
> 
> Hisao Tanabe (1):
>       perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()
> 
> Jiri Olsa (5):
>       perf tests: Add breakpoint modify tests
>       perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
>       perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0
>       perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
>       perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint
> 
> Kim Phillips (2):
>       perf arm64: Fix include path for asm-generic/unistd.h
>       perf annotate: Fix parsing aarch64 branch instructions after objdump update
> 
> Martin Liška (1):
>       perf annotate: Properly interpret indirect call
> 
> Sandipan Das (1):
>       perf probe powerpc: Ignore SyS symbols irrespective of endianness
> 
>  kernel/events/core.c                              |  11 +-
>  kernel/events/hw_breakpoint.c                     |  13 +-
>  tools/perf/Makefile.perf                          |  14 +-
>  tools/perf/arch/arm64/Makefile                    |   5 +-
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   6 +-
>  tools/perf/arch/powerpc/util/sym-handling.c       |   4 +-
>  tools/perf/arch/x86/include/arch-tests.h          |   1 +
>  tools/perf/arch/x86/tests/Build                   |   1 +
>  tools/perf/arch/x86/tests/arch-tests.c            |   6 +
>  tools/perf/arch/x86/tests/bp-modify.c             | 213 ++++++++++++++++++++++
>  tools/perf/util/annotate.c                        |  32 +++-
>  tools/perf/util/annotate.h                        |   1 +
>  tools/perf/util/evsel.c                           |   5 +-
>  tools/perf/util/trace-event-info.c                |   2 +-
>  tools/perf/util/trace-event-parse.c               |   7 +-
>  15 files changed, 282 insertions(+), 39 deletions(-)
>  create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
