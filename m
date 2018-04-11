Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeDKXY1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeDKXY0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:24:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFC921722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 11 Apr 2018 20:24:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/3] perf version: some follow-up updates
Message-ID: <20180411232423.GC24386@kernel.org>
References: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 09, 2018 at 06:26:46PM +0800, Jin Yao escreveu:
> 1. Remove -DNO_LIBPERL and use -DHAVE_LIBPERL_SUPPORT in C code.
> 
> 2. Remove -DNO_LIBPYTHON and use -DHAVE_LIBPYTHON_SUPPORT in C code.
> 
> 3. Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT.
> 
> 4. Don't print "libaudit" line if HAVE_SYSCALL_TABLE_SUPPORT is available
>    and add a line for HAVE_SYSCALL_TABLE_SUPPORT.

Applied after adding the Suggested-by tags for the three patches,

Thanks,

- Arnaldo
 
> Jin Yao (3):
>   perf script: Use HAVE_LIBXXX_SUPPORT to replace NO_LIBXXX
>   perf: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
>   perf version: Print status for syscall_table
> 
>  tools/perf/Makefile.config              | 2 +-
>  tools/perf/builtin-help.c               | 2 +-
>  tools/perf/builtin-script.c             | 4 ++--
>  tools/perf/builtin-version.c            | 3 +++
>  tools/perf/perf.c                       | 4 ++--
>  tools/perf/util/generate-cmdlist.sh     | 2 +-
>  tools/perf/util/syscalltbl.c            | 6 +++---
>  tools/perf/util/trace-event-scripting.c | 4 ++--
>  8 files changed, 15 insertions(+), 12 deletions(-)
> 
> -- 
> 2.7.4
