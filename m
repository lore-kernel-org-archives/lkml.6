Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967235AbeBOKou (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:44:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755304AbeBOKos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:44:48 -0500
Date: Thu, 15 Feb 2018 11:44:42 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>, Kan.liang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH v4 0/2] perf stat: Add interval-count and time support
Message-ID: <20180215104442.GA12714@krava>
References: <1517217923-8302-1-git-send-email-ufo19890607@gmail.com>
 <20180129102558.GA14925@krava>
 <CAHCio2iVBoEXEv3mXzq34FsDZXJT9Oig+SfDwv3vneYfZQ089g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2iVBoEXEv3mXzq34FsDZXJT9Oig+SfDwv3vneYfZQ089g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 05:33:07PM +0800, 禹舟键 wrote:
> PING
> 
> 2018-01-29 18:25 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:

Arnaldo, could you pelase check on this?

thanks,
jirka

> 
> > On Mon, Jan 29, 2018 at 10:25:21AM +0100, ufo19890607 wrote:
> > > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > >
> > > Introduce two new options for perf stat and update perf-stat
> > documentation
> > > accordingly.
> > >
> > > The interval-count option can be used to print counts for fixed number of
> > > times, and it should be used specifically with "-I" option.
> > >
> > > Show below is the output of the interval-count option for perf stat.
> > >
> > >         $ perf stat -I 1000 --interval-count 2 -e cycles -a
> > >         #           time             counts unit events
> > >              1.002827089         93,884,870      cycles
> > >              2.004231506         56,573,446      cycles
> > >
> > > The time option can be used to print counts after a period of time, and
> > it
> > > should not be used with "-I" option.
> > >
> > > Show below is the output of the time option for perf stat.
> > >
> > >         $ perf stat --time 2000 -e cycles -a
> > >         Performance counter stats for 'system wide':
> > >
> > >                 157,260,423      cycles
> > >
> > >                 2.003060766 seconds time elapsed
> > >
> > > yuzhoujian (2):
> > >   perf stat: Add support to print counts for fixed times
> > >   perf stat: Add support to print counts after a period of time
> > >
> > > Changes since v3:
> > > - merge interval_count check and times check to one line.
> > > - fix the wrong indent in stat.h
> > > - use stat_config.times instead of 'times' in cmd_stat function.
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > thanks,
> > jirka
> >
> > >
> > > Changes since v2:
> > > - modify the time check in __run_perf_stat func to keep some consistency
> > >   with the workload case.
> > > - add the warning when the time is set between 10ms to 100ms.
> > > - add the pr_err when the time is set below 10ms.
> > >
> > > Changes since v1:
> > > - change the name of the new option "times-print" to "interval-count".
> > > - keep the interval-count option interval specifically.
> > >
> > >
> > >  tools/perf/Documentation/perf-stat.txt | 10 +++++++
> > >  tools/perf/builtin-stat.c              | 53
> > ++++++++++++++++++++++++++++++++--
> > >  tools/perf/util/stat.h                 |  2 ++
> > >  3 files changed, 62 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.14.1
> > >
> >
