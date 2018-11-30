Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20419C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D434E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D434E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLAHUM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAHUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:20:12 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E7E20863;
        Fri, 30 Nov 2018 20:09:45 +0000 (UTC)
Date:   Fri, 30 Nov 2018 15:09:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 7/9] tools/lib/traceevent: traceevent API cleanup
Message-ID: <20181130150944.65a61974@gandalf.local.home>
In-Reply-To: <20181130191856.GC19230@kernel.org>
References: <20181130154403.150474900@goodmis.org>
        <20181130154647.891651290@goodmis.org>
        <20181130191856.GC19230@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 16:18:56 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Nov 30, 2018 at 10:44:10AM -0500, Steven Rostedt escreveu:
> > From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> > 
> > In order to make libtraceevent into a proper library, its API
> > should be straightforward. This patch hides few API functions,
> > intended for internal usage only:
> > tep_free_event(), tep_free_format_field(), __tep_data2host2(),
> > __tep_data2host4() and __tep_data2host8().
> > The patch also alignes the libtraceevent summary man page with
> > these API changes.  
> 
> I applied the previous patches, stopped here as it this one fails with
> the error bellow.
> 
> Please resend from this patch onwards.
> 
> BTW, this is what I have right now:
> 
> [acme@quaco perf]$ git log --oneline - 6
> 9db9efe53c72 (HEAD -> perf/core) tools lib traceevent: Rename tep_free_format() to tep_free_event()
> e58c351e8383 tools lib traceevent, perf tools: Rename 'struct tep_event_format' to 'struct tep_event'
> 4237fd0b60d8 tools lib traceevent: Install trace-seq.h API header file
> bb837f2581dc tools lib traceevent: Added support for pkg-config
> a2c167ad70b6 tools lib traceevent: Implement new API tep_get_ref()
> 51d0337d0198 (acme.korg/perf/core) tools lib traceevent: Add sanity check to is_timestamp_in_us()
> 
> - Arnaldo
> 
> [acme@quaco perf]$ m
> make: Entering directory '/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j8' parallel build
>   CC       /tmp/build/perf/util/trace-event-read.o
>   CC       /tmp/build/perf/util/trace-event-scripting.o
>   CC       /tmp/build/perf/util/trace-event.o
>   CC       /tmp/build/perf/util/sort.o
>   CC       /tmp/build/perf/util/hist.o
>   INSTALL  trace_plugins
>   CC       /tmp/build/perf/util/cgroup.o
>   CC       /tmp/build/perf/util/stat.o
>   CC       /tmp/build/perf/util/stat-shadow.o
>   CC       /tmp/build/perf/util/stat-display.o
>   CC       /tmp/build/perf/util/record.o
> util/trace-event-read.c: In function ‘read4’:
> util/trace-event-read.c:105:9: error: implicit declaration of function ‘__tep_data2host4’; did you mean ‘tep_data_flags’? [-Werror=implicit-function-declaration]
>   return __tep_data2host4(pevent, data);
>          ^~~~~~~~~~~~~~~~
>          tep_data_flags

This should have been changed with patch 6 in the series.

-- Steve

> util/trace-event-read.c:105:9: error: nested extern declaration of ‘__tep_data2host4’ [-Werror=nested-externs]
> util/trace-event-read.c: In function ‘read8’:
> util/trace-event-read.c:114:9: error: implicit declaration of function ‘__tep_data2host8’; did you mean ‘tep_data_flags’? [-Werror=implicit-function-declaration]
>   return __tep_data2host8(pevent, data);
>          ^~~~~~~~~~~~~~~~
>          tep_data_flags
> util/trace-event-read.c:114:9: error: nested extern declaration of ‘__tep_data2host8’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/.trace-event-read.o.tmp': No such file or directory
> make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/trace-event-read.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:658: /tmp/build/perf/libperf-in.o] Error 2
> make[1]: *** [Makefile.perf:215: sub-make] Error 2
> make: *** [Makefile:110: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k O=/tmp/build/perf -C tools/perf install-bin':
> 
>     20,606,463,070      cycles:u
>     24,937,056,161      instructions:u            #    1.21  insn per cycle
> 
>        2.192507189 seconds time elapsed
> 
>        5.571323000 seconds user
>        0.994057000 seconds sys
> 
> 
> [acme@quaco perf]$

