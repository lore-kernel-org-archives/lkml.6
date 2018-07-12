Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBCEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C734208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY0QNs2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C734208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeGLOEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:04:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50741 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeGLOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:04:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so5774679wmc.0;
        Thu, 12 Jul 2018 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dClUg8Az4+NuIH/YQmzvi4ucSoobRoqGdp/zBqKtSZA=;
        b=kY0QNs2uFZqtl6e15SPBpmooV9HLA4amcKn0/AYtYwINs8gQLdVuie+SXOXDM1oEa+
         EFmRkGHGPxhxj/l1bAghBY/MzyRdWMp+UuUK+d0zwwyHg2gek34ETSJLUYUHRgGi4VYD
         3gVNFgf7+yku9mjgvJdAwQsspN4YSj7AGFYDIHJwz4n4zaLyfdKo3CMx46Vegwg1kvBu
         nmCGr71cTHJEvh1uIhZCc3PikR8Xj55O29HfPRrKoa8FZs1ZfZb4kRk5GKnFv8NEO4Su
         KUq+JNkQ6H6awWkWgtoCKE2E3gd8gqPzjYLo46MwmirvbC4FsbgM6LyyqLXzmQ7dpWAO
         6l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dClUg8Az4+NuIH/YQmzvi4ucSoobRoqGdp/zBqKtSZA=;
        b=UoJjpmh2ScwX7WOoaqDbp9ppZ3ZdKesn0T/rTHtvYEIv930Q0A1DKTBip1OvRQDmOc
         UrUovUL1qddaCZNLwnAOgbouIB86Mc/TZy9KBXNdmcPbscxcn5kLEzOXwtCzACI3KUPu
         eL0f+0ZXp0KVAM6m0dS8V/80yOoDTZ/zjHNAXvEW/disWIHc7b7Kjf/lzrlRTPsAMPT/
         0ZTpoq24Khg6irdkfEwq7Q0thESBIGhuCarq5vIvw4aT/4ipz6tX5B8IblIiuvL+HOO+
         sg2j/+kHmBAIFz8Sv7clsXmItBbddPv5nR01ZnDHv+eGiMCaAUvoEjWNX9JbKixa0OD/
         VJrg==
X-Gm-Message-State: AOUpUlE+qBxO0ZrIvVjVHzfdy16c5NnFRHcwRm1vUXmO4GrbwlOhxrYi
        lFl5zLLKqVmyXeoHXwT/wqA=
X-Google-Smtp-Source: AAOMgpdnzHRUcU9eq0Nr47/ya/utDG5/jsjJn7OJGttU/nwehOgquELvnMmCRwSms5M0tk0xH9lKaA==
X-Received: by 2002:a1c:c40a:: with SMTP id u10-v6mr1401023wmf.10.1531403658875;
        Thu, 12 Jul 2018 06:54:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r140-v6sm7048367wmd.27.2018.07.12.06.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 06:54:17 -0700 (PDT)
Date:   Thu, 12 Jul 2018 15:54:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Herton Krzesinski <herton@redhat.com>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/14] perf/urgent fixes
Message-ID: <20180712135415.GA6199@gmail.com>
References: <20180711204305.12924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
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
> The following changes since commit 092150a25cb7bd6a79aa00bb1ad131063f58073d:
> 
>   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid (2018-07-09 17:16:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180711
> 
> for you to fetch changes up to 32aa928a7b817140c84987b726d5014911808fa4:
> 
>   perf tools: Use python-config --includes rather than --cflags (2018-07-11 09:48:31 -0400)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> python interface:
> 
> - Make 'perf script -g python' generate scripts that are compatible
>   with both python 2 and 3 (Jeremy Cline)
> 
> - Fix python dictionary reference counting (Janne Huttunen)
> 
> - Add python3 support for various python scripts (Jeremy Cline)
> 
> - Use python-config --includes rather than --cflags, fixing the build
>   on Fedora, where the python 3.7 started adding -flto to what
> 
> perf stat:
> 
>   - Remove needless extra header line in --interval_clear (Jiri Olsa)
>   python-config --cflags generate, breaking the perf build (Jeremy Cline)
> 
> Build:
> 
> - Fix compilation errors on gcc8 (Jiri Olsa)
> 
> perf llvm-utils:
> 
> - Remove bashism from kernel include fetch script (Kim Phillips)
> 
> perf test: (Kim Phillips)
> 
> - Replace '|&' with '2>&1 |' to work with more shells
> 
> - Make perf's inet_pton test more portable
> 
> - Prevent temporary editor files from being considered test scripts
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Janne Huttunen (1):
>       perf script python: Fix dict reference counting
> 
> Jeremy Cline (7):
>       perf tools: Generate a Python script compatible with Python 2 and 3
>       perf scripts python: Add Python 3 support to Core.py
>       perf scripts python: Add Python 3 support to SchedGui.py
>       perf scripts python: Add Python 3 support to Util.py
>       perf scripts python: Add Python 3 support to sched-migration.py
>       perf scripts python: Add Python 3 support to EventClass.py
>       perf tools: Use python-config --includes rather than --cflags
> 
> Jiri Olsa (2):
>       perf tools: Fix compilation errors on gcc8
>       perf stat: Fix --interval_clear option
> 
> Kim Phillips (4):
>       perf test shell: Replace '|&' with '2>&1 |' to work with more shells
>       perf test shell: Make perf's inet_pton test more portable
>       perf llvm-utils: Remove bashism from kernel include fetch script
>       perf test shell: Prevent temporary editor files from being considered test scripts
> 
>  tools/perf/Makefile.config                         |  3 +-
>  tools/perf/arch/x86/util/perf_regs.c               |  2 +-
>  tools/perf/builtin-stat.c                          |  2 +-
>  tools/perf/jvmti/jvmti_agent.c                     |  3 +-
>  .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
>  .../Perf-Trace-Util/lib/Perf/Trace/EventClass.py   |  4 ++-
>  .../Perf-Trace-Util/lib/Perf/Trace/SchedGui.py     |  2 +-
>  .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  | 11 +++---
>  tools/perf/scripts/python/sched-migration.py       | 14 +++++---
>  tools/perf/tests/builtin-test.c                    |  2 +-
>  .../tests/shell/record+probe_libc_inet_pton.sh     | 37 +++++++++++---------
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |  2 +-
>  tools/perf/util/llvm-utils.c                       |  6 ++--
>  .../util/scripting-engines/trace-event-python.c    | 37 +++++++++-----------
>  14 files changed, 84 insertions(+), 81 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
