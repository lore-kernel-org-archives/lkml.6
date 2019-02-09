Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76386C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4F320863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549714514;
	bh=NiLTuR52RBATDeeDBDLsF0wXzqiMl18L4dMSAdFhl6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SfHedHjQVoPBLgnJuwnCqvmQvJzEiM7OCjW09ZCCHyEb6Er0TNLKygtZNLHtpWa+X
	 CnyO9utfx83DjrcRsOgr8dnD7tInBI/cCjumyQs90rTxCgcPdYXqrMCoJ60J4qZ59S
	 EdVYnnynSY7iMAoPwUWC3fRN/OepVrLSgcj96oxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfBIMPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:15:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52460 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:15:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so8168417wml.2;
        Sat, 09 Feb 2019 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtxqEsoJCpiKjW9Rqa+dq0M+WU9b6jHV75J2VWj2D5s=;
        b=OXhocG13dz73OiWA5wCB25ZyBQeWIWoaPI9W1MtxTK0HBwpFJfdyUIlmCbhNfszOdh
         3XdN0y8SmJHUzRTT8OzGTSLIVybr5L2FKNZ5GL2mDnu7eDVkCT7DcrarfVH5lsEyX8xM
         83NsXDfC0jI5XRNgKDAQu/pm/fBet7Ji1vckKvEYcA17AN0nn7S3HncXjIC5LmdO3BJQ
         DWB5q23AtLfqzqa0C9d8CvpJIk74sTCQ5/FNljrBZ248oXu/Unb/WAZuuM+VPrwbzf2s
         Zcw6yNfmOAVmUddbJ8WNIDGmjkrDFat4p6jk9jbxi/8Jx+c99XdtRetjnyeTzZYmX5d2
         P4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtxqEsoJCpiKjW9Rqa+dq0M+WU9b6jHV75J2VWj2D5s=;
        b=OMleYScKCFA8lG6fYV5JkapbqWwnhoThzjmSLl1rnhV2jE3O4hsE4riivPZCnPyYwo
         zo40/8LwNh6YyiRLq5wuDdnAURni73bD0kPZi123nrmthAMW3cbiLLY/rTcJXHCwTlZA
         oBCNmOfdIkpcLD0TKURW7GKrvmEKZnEZlbvax4PFfjypjltYlXZNQH8+hh9PtW5MR5gb
         P6oS7vSXPM1gRrfa81gqE5TpGwIqv8pTOokiCHDBavL5EJkcXm+wJBL5g+GRUkoTG/+u
         j2jj+AagX8x7kp3oj+e6xgrgLMmbBeaFyx49NVIzrdkff/OQm75f77Zdfs4b1s3VUZqx
         /g0g==
X-Gm-Message-State: AHQUAuZdC5RAvd8hs0HmIMWzSmAI7HkLY2JweFgYTWMAlbvYSt2J566z
        6edHoElRd9hNqDu/RKN9pDw=
X-Google-Smtp-Source: AHgI3IaGOvTrM05Jfr/bNmw9wpiWShEnk9RLok1W8e26zHZSIRH2Evdsdq3WrL6qyfYj8U/ha4PLSA==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr2579934wma.103.1549714509247;
        Sat, 09 Feb 2019 04:15:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e4sm5061622wrt.53.2019.02.09.04.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 04:15:08 -0800 (PST)
Date:   Sat, 9 Feb 2019 13:15:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Message-ID: <20190209121505.GA54650@gmail.com>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
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
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9dff0aa95a324e262ffb03f425d00e4751f3294e:
> 
>   perf/core: Don't WARN() for impossible ring-buffer sizes (2019-02-04 08:45:25 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.0-20190205
> 
> for you to fetch changes up to 8f2f350cbdb2c2fbff654cb778139144b48a59ba:
> 
>   perf script python: Add Python3 support to tests/attr.py (2019-02-05 10:31:08 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>     Fix handling of probe:vfs_getname when the probed routine is
>     inlined in multiple places, fixing the collection of the 'filename'
>     parameter in open syscalls.
> 
> perf test:
> 
>   Gustavo A. R. Silva:
> 
>     Fix bitwise operator usage in evsel-tp-sched test, which made tat
>     test always detect fields as signed.
> 
>   Jiri Olsa:
> 
>     Filter out hidden symbols from labels, added in systems where the
>     annobin plugin is used, such as RHEL8, which, if left in place make
>     the DWARF unwind 'perf test' to fail on PPC.
> 
>   Tony Jones:
> 
>     Fix 'perf_event_attr' tests when building with python3.
> 
> perf mem/c2c:
> 
>   Ravi Bangoria:
> 
>     Fix perf_mem_events on PowerPC.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>     Sync linux/in.h copy from the kernel sources, silencing a perf build warning.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf clang: Do not use 'return std::move(something)'
>       tools headers uapi: Sync linux/in.h copy from the kernel sources
>       perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
>       perf trace: Support multiple "vfs_getname" probes
> 
> Gustavo A. R. Silva (1):
>       perf tests evsel-tp-sched: Fix bitwise operator
> 
> Jiri Olsa (1):
>       perf symbols: Filter out hidden symbols from labels
> 
> Ravi Bangoria (1):
>       perf mem/c2c: Fix perf_mem_events to support powerpc
> 
> Tony Jones (1):
>       perf script python: Add Python3 support to tests/attr.py
> 
>  tools/include/uapi/linux/in.h             |  2 +-
>  tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
>  tools/perf/Documentation/perf-mem.txt     |  2 +-
>  tools/perf/arch/powerpc/util/Build        |  1 +
>  tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
>  tools/perf/builtin-trace.c                | 25 +++++++++++++++++-------
>  tools/perf/tests/attr.py                  | 32 ++++++++++++++++++-------------
>  tools/perf/tests/evsel-tp-sched.c         |  2 +-
>  tools/perf/util/c++/clang.cpp             |  2 +-
>  tools/perf/util/mem-events.c              |  2 +-
>  tools/perf/util/symbol-elf.c              | 23 +++++++++++++++++++++-
>  11 files changed, 88 insertions(+), 30 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

Pulled, thanks a lot Arnaldo!

	Ingo
