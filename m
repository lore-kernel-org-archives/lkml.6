Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD62ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF820989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDF820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeIXAy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeIXAy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:54:56 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5816949020;
        Sun, 23 Sep 2018 18:56:29 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 313732010D97;
        Sun, 23 Sep 2018 18:56:26 +0000 (UTC)
Date:   Sun, 23 Sep 2018 20:56:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH 00/15] tools/lib/traceevent: Namespace updates to make
 traceevent into a library
Message-ID: <20180923185626.GC30923@krava>
References: <20180919185643.358126338@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919185643.358126338@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 23 Sep 2018 18:56:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:56:43PM -0400, Steven Rostedt wrote:
> 
> Jiri,
> 
> This is another series to fix the namespace of libtraceevent.
> 
> Please pull in these patches or if you choose, pull in the branch.
> The code is based off of the latest tip/perf/core.
> 
> These changes can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> tip/perf/core
> 
> Head SHA1: bb730b5833b5bddf5cb226865e5f4496770d00b0
> 9bc7aeba01678955c3724052966ab8ad61053c89

nice, looks good to me:

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Arnaldo,
could you please pull this in?

Steven,
is there still something left to rename, or we can start moving it into public rpm?

thanks,
jirka

> 
> 
> Tzvetomir Stoyanov (VMware) (15):
>       tools/lib/traceevent, tools/perf: Rename struct event_format to struct tep_event_format
>       tools/lib/traceevent, tools/perf: Rename struct format{_field} to struct tep_format{_field}
>       tools/lib/traceevent, tools/perf: Rename enum format_flags to enum tep_format_flags
>       tools/lib/traceevent: Rename enum event_{sort_}type to enum tep_event_{sort_}type
>       tools/lib/traceevent: Add prefix TEP_ to all EVENT_FL_* flags
>       tools/lib/traceevent, tools/perf: Add prefix tep_ to all print_* structures
>       tools/lib/traceevent, tools/perf: Rename enum print_arg_type to enum tep_print_arg_type
>       tools/lib/traceevent: Add prefix tep_ to enums filter_{boolean,op,cmp}_type
>       tools/lib/traceevent: Add prefix tep_ to enums filter_{exp,arg}_type
>       tools/lib/traceevent: Add prefix tep_ to struct filter_{arg,value_type}
>       tools/lib/traceevent: Add prefix tep_ to various structs filter_arg_*.
>       tools/lib/traceevent: Add prefix tep_ to structs filter_type and event_filter
>       tools/lib/traceevent: Rename struct plugin_list to struct tep_plugin_list
>       tools/lib/traceevent: Rename data2host*() APIs
>       tools/lib/traceevent: Add prefix tep_ to enum filter_trivial_type
> 
> ----
>  tools/lib/traceevent/event-parse.c                 | 1184 ++++++++++----------
>  tools/lib/traceevent/event-parse.h                 |  532 ++++-----
>  tools/lib/traceevent/event-plugin.c                |   18 +-
>  tools/lib/traceevent/parse-filter.c                |  646 +++++------
>  tools/lib/traceevent/plugin_function.c             |    2 +-
>  tools/lib/traceevent/plugin_hrtimer.c              |    4 +-
>  tools/lib/traceevent/plugin_kmem.c                 |    4 +-
>  tools/lib/traceevent/plugin_kvm.c                  |   14 +-
>  tools/lib/traceevent/plugin_mac80211.c             |    6 +-
>  tools/lib/traceevent/plugin_sched_switch.c         |   10 +-
>  tools/perf/builtin-trace.c                         |   18 +-
>  tools/perf/tests/evsel-tp-sched.c                  |    4 +-
>  tools/perf/util/data-convert-bt.c                  |   56 +-
>  tools/perf/util/evsel.c                            |   10 +-
>  tools/perf/util/evsel.h                            |   10 +-
>  tools/perf/util/evsel_fprintf.c                    |    2 +-
>  tools/perf/util/header.c                           |    2 +-
>  tools/perf/util/python.c                           |   20 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   66 +-
>  .../util/scripting-engines/trace-event-python.c    |  100 +-
>  tools/perf/util/sort.c                             |   22 +-
>  tools/perf/util/trace-event-parse.c                |   18 +-
>  tools/perf/util/trace-event-read.c                 |    4 +-
>  tools/perf/util/trace-event.c                      |    8 +-
>  tools/perf/util/trace-event.h                      |   20 +-
>  25 files changed, 1390 insertions(+), 1390 deletions(-)
