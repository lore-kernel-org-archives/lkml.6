Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeDWSsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeDWSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:48:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A64C2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 15:48:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/9] perf tools: Assorted fixes
Message-ID: <20180423184811.GA3788@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 23, 2018 at 11:08:14AM +0200, Jiri Olsa escreveu:
> hi,
> sending assorted general fixes that queued
> up in my other branches.
> 
> Arnaldo,
> I added wait4 call in the last patch and am wondering
> if it will pass your all-distros-docker test ;-)
> If not I'll need to put some build detection code.

That wasn't a problem, but centos:5, centos:6 didn't like this:

  CC       /tmp/build/perf/util/evsel.o
cc1: warnings being treated as errors
builtin-stat.c: In function 'print_footer':
builtin-stat.c:1800: warning: declaration of 'stime' shadows a global declaration
/usr/include/time.h:297: warning: shadowed declaration is here
mv: cannot stat `/tmp/build/perf/.builtin-stat.o.tmp': No such file or directory
make[3]: *** [/tmp/build/perf/builtin-stat.o] Error 1
make[3]: *** Waiting for unfinished jobs....

debian:7 didn't like something else, unrelated to your patches:

  CC       /tmp/build/perf/util/ctype.o
builtin-buildid-cache.c: In function 'cmd_buildid_cache':
builtin-buildid-cache.c:267:2: error: 'err' may be used uninitialized in this function [-Werror=uninitialized]
builtin-buildid-cache.c:247:6: note: 'err' was declared here
  MKDIR    /tmp/build/perf/util/

I'm hunting down the patch that introduced this last one...

- Arnaldo
