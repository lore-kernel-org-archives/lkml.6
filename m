Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6B320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546961562;
	bh=XJVUsoiAUftxAqnpDDce8O8F4eJ/Mv55iE7KEvPPPP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RJUnjjyigLuHp0bC7yjq15P5y+GVEqXnGsAYFqUrm58gVGQUkXswgtfZnPCJmHgJZ
	 KRiidG+kSeU1G4i356qWBaiLuCsOeAJtXi6+h72aONqkkKdxIWD+t1W2sX0RYY8oqO
	 0HssFpRY3HQr5writDjTe/nFLkOl89UY57FxsUtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfAHPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:32:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38165 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:32:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so4852248wml.3;
        Tue, 08 Jan 2019 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlZj+1vl140tuv4UQo6ufgiXsmp3sBvZIhSFmX3iQY8=;
        b=DYM5Y2n6K6si5jhFpEdIuiy+kkDJeQ47GsDZP7gDYz9hNGW9l8678Oum9NK5sJvKDx
         f/WcIfpFInMQLfMDLbeHmGJF6eP9ZQyPn68eszfJJ6yuyWZFxoceAj3jvv2rXCHpE2du
         newxQXi7M26Fw0lzXT7tXSdBGHe0jp1nKiZrjbwCMVt5U0qXMYvK6of12y1eeH7lOqDD
         UQX7SK0V+OtnEYo6llq6YzJBO545KBolkX/c6lIpYmSvLO0Xn1TwAPRLSeERy6Bxyev4
         ldzhEUNNswDNSIUWlDGqEqrEiE9Py0d81ErYqqXt8jCAyj/kMnvC8PXr8QlI0rVpN2Cm
         7AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlZj+1vl140tuv4UQo6ufgiXsmp3sBvZIhSFmX3iQY8=;
        b=LQOMp1WIB3Na9cqe/BSAwdCIumbB5tqVuzcj/D327eUx1ATgrFPH8dKrZRRz5lqpcy
         puydyIe9IA6Ov2yVbz0uzPKUQPhwuW1nfjEIbSULJitIqd9JKRGOhxsnNtg+CBsJ1aN6
         dcFGYTtR2tdVRQQEUOSTR0qjCvjBLR8nqY8IXAwCtXabndrkMMsSTEujPiJnU6M9AbBV
         3KToGHkavGEyb/mUwOQzrgFazL3TSrldZPoKU38hSkc/LAVcz4/A7ut9t21Ogunl9kR4
         XJBZ/8Js82OJMbvWZPnKsOuTpNHQjV2fYqHg9Pbtk2HPQPdL8uDPuFvl+fKYHtgRyL65
         jjvg==
X-Gm-Message-State: AJcUukd7YB5CRPWIuQ/rh/KoQYLTnM9E1X225RwZbWzCbsqZX7O2ovJ/
        frHxRVAIirhwVRG4mEQ0E8E=
X-Google-Smtp-Source: ALg8bN7x+8qqp81kc4/EQWglNyqnb+1fJM0G4Z2Gua5zsrO7xQ4CU6lWEU7hFZyRuwtGdpzEDmT8aA==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr2028919wmk.47.1546961557311;
        Tue, 08 Jan 2019 07:32:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b18sm51986929wrw.83.2019.01.08.07.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:32:36 -0800 (PST)
Date:   Tue, 8 Jan 2019 16:32:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ivan Krylov <krylov.r00t@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mattias Jacobsson <2pi@mok.nu>
Subject: Re: [GIT PULL 00/16] perf/core improvements and fixes
Message-ID: <20190108153234.GA110207@gmail.com>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
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
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2573be22e5b6f24a0cabc97715c808c47e29eaaf:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20190103' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-03 14:05:16 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20190104
> 
> for you to fetch changes up to 03fa483821c0b4db7c2b1453d3332f397d82313f:
> 
>   perf test shell: Use a fallback to get the pathname in vfs_getname (2019-01-04 15:12:29 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf annotate:
> 
>   Ivan Krylov:
> 
>   - Pass filename to objdump via execl, fixing usage with filenames
>     with special characters.
> 
> perf report:
> 
>   Jin Yao:
> 
>      Fix wrong iteration count in --branch-history
> 
> perf stat:
> 
>   Jin Yao:
> 
>   - Fix endless wait for child process
> 
> perf test:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use a fallback to get the pathname in vfs_getname in
> 
> tools build:
> 
>   Jiri Olsa:
> 
>   - Allow overriding CFLAGS assignments.
> 
> Misc:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Syncronize UAPI headers
> 
>   Mattias Jacobsson:
> 
>   - Remove redundant va_end() in strbuf_addv()
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (10):
>       tools headers x86: Sync disabled-features.h
>       tools headers uapi: Sync prctl.h with the kernel sources
>       tools beauty: Make the prctl option table generator catch all PR_ options
>       tools headers uapi: Update i915_drm.h
>       tools headers uapi: Sync linux/in.h copy from the kernel sources
>       tools headers uapi: Sync linux/kvm.h with the kernel sources
>       tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
>       tools headers x86: Sync asm/cpufeatures.h copy with the kernel sources
>       perf python: Make sure the python binding output directory is in place
>       perf test shell: Use a fallback to get the pathname in vfs_getname
> 
> Ivan Krylov (1):
>       perf annotate: Pass filename to objdump via execl
> 
> Jin Yao (2):
>       perf stat: Fix endless wait for child process
>       perf report: Fix wrong iteration count in --branch-history
> 
> Jiri Olsa (2):
>       tools thermal tmon: Use -O3 instead of -O1 if available
>       tools iio: Override CFLAGS assignments
> 
> Mattias Jacobsson (1):
>       perf strbuf: Remove redundant va_end() in strbuf_addv()
> 
>  tools/arch/x86/include/asm/cpufeatures.h        |  2 ++
>  tools/arch/x86/include/asm/disabled-features.h  |  8 ++++++-
>  tools/iio/Makefile                              |  2 +-
>  tools/include/uapi/asm-generic/unistd.h         |  4 +++-
>  tools/include/uapi/drm/i915_drm.h               |  8 +++++++
>  tools/include/uapi/linux/in.h                   | 10 +++++---
>  tools/include/uapi/linux/kvm.h                  | 19 +++++++++++++++
>  tools/include/uapi/linux/prctl.h                |  8 +++++++
>  tools/perf/Makefile.perf                        |  4 +++-
>  tools/perf/builtin-stat.c                       |  3 ++-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh |  3 ++-
>  tools/perf/trace/beauty/prctl_option.sh         |  2 +-
>  tools/perf/util/annotate.c                      |  8 +++----
>  tools/perf/util/callchain.c                     | 32 +++++++++++++++----------
>  tools/perf/util/callchain.h                     |  1 +
>  tools/perf/util/machine.c                       |  2 +-
>  tools/perf/util/strbuf.c                        |  1 -
>  tools/thermal/tmon/Makefile                     |  2 +-
>  18 files changed, 90 insertions(+), 29 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
