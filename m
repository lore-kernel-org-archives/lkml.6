Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83250C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0F52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uiu2Kvm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0F52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLAG3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeLAG3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:29:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AED42082F;
        Fri, 30 Nov 2018 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543605539;
        bh=98vzZta8KuyWOVxUsIuezQoGNy4OQ4NQiajJUIICRws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uiu2Kvm47X02eX7wX3lvW2ZrOGA10cyyQ+6JOfu3R6LQnDfQhODX0lXwD1e/qrRBY
         DEGSLwKB6+s8Ws36KCgi+A326odqGRgb1/yFLPgZbRNAq3NIg8GaHQVGE/elS06ODT
         SvBXLiDqmma2yXBVXPVe3uzfFYnH3UTwCl9npHhY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1684340BF1; Fri, 30 Nov 2018 16:18:56 -0300 (-03)
Date:   Fri, 30 Nov 2018 16:18:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 7/9] tools/lib/traceevent: traceevent API cleanup
Message-ID: <20181130191856.GC19230@kernel.org>
References: <20181130154403.150474900@goodmis.org>
 <20181130154647.891651290@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130154647.891651290@goodmis.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 30, 2018 at 10:44:10AM -0500, Steven Rostedt escreveu:
> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> In order to make libtraceevent into a proper library, its API
> should be straightforward. This patch hides few API functions,
> intended for internal usage only:
> tep_free_event(), tep_free_format_field(), __tep_data2host2(),
> __tep_data2host4() and __tep_data2host8().
> The patch also alignes the libtraceevent summary man page with
> these API changes.

I applied the previous patches, stopped here as it this one fails with
the error bellow.

Please resend from this patch onwards.

BTW, this is what I have right now:

[acme@quaco perf]$ git log --oneline - 6
9db9efe53c72 (HEAD -> perf/core) tools lib traceevent: Rename tep_free_format() to tep_free_event()
e58c351e8383 tools lib traceevent, perf tools: Rename 'struct tep_event_format' to 'struct tep_event'
4237fd0b60d8 tools lib traceevent: Install trace-seq.h API header file
bb837f2581dc tools lib traceevent: Added support for pkg-config
a2c167ad70b6 tools lib traceevent: Implement new API tep_get_ref()
51d0337d0198 (acme.korg/perf/core) tools lib traceevent: Add sanity check to is_timestamp_in_us()

- Arnaldo

[acme@quaco perf]$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  INSTALL  trace_plugins
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/util/record.o
util/trace-event-read.c: In function ‘read4’:
util/trace-event-read.c:105:9: error: implicit declaration of function ‘__tep_data2host4’; did you mean ‘tep_data_flags’? [-Werror=implicit-function-declaration]
  return __tep_data2host4(pevent, data);
         ^~~~~~~~~~~~~~~~
         tep_data_flags
util/trace-event-read.c:105:9: error: nested extern declaration of ‘__tep_data2host4’ [-Werror=nested-externs]
util/trace-event-read.c: In function ‘read8’:
util/trace-event-read.c:114:9: error: implicit declaration of function ‘__tep_data2host8’; did you mean ‘tep_data_flags’? [-Werror=implicit-function-declaration]
  return __tep_data2host8(pevent, data);
         ^~~~~~~~~~~~~~~~
         tep_data_flags
util/trace-event-read.c:114:9: error: nested extern declaration of ‘__tep_data2host8’ [-Werror=nested-externs]
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.trace-event-read.o.tmp': No such file or directory
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/trace-event-read.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:658: /tmp/build/perf/libperf-in.o] Error 2
make[1]: *** [Makefile.perf:215: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k O=/tmp/build/perf -C tools/perf install-bin':

    20,606,463,070      cycles:u
    24,937,056,161      instructions:u            #    1.21  insn per cycle

       2.192507189 seconds time elapsed

       5.571323000 seconds user
       0.994057000 seconds sys


[acme@quaco perf]$
