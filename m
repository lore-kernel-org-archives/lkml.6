Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934282AbeE2Ncb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933444AbeE2Nc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:32:28 -0400
Date: Tue, 29 May 2018 10:32:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Walker <Robert.Walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>, Kim Phillips <kim.phillips@arm.co>,
        Tor Jeremiassen <tor@ti.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Subject: Re: [RFT v3 0/4] Perf script: Add python script for CoreSight trace
 disassembler
Message-ID: <20180529133224.GA20886@kernel.org>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
 <20180528200326.GJ25467@kernel.org>
 <CANLsYkzn5qyzjxMiCPQ1GxyNjhHJp-2H6Lds11HP9rG5xug0FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzn5qyzjxMiCPQ1GxyNjhHJp-2H6Lds11HP9rG5xug0FA@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 28, 2018 at 03:53:42PM -0600, Mathieu Poirier escreveu:
> On 28 May 2018 at 14:03, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Mon, May 28, 2018 at 04:44:59PM +0800, Leo Yan escreveu:
> >> This patch series is to support for using 'perf script' for CoreSight
> >> trace disassembler, for this purpose this patch series adds a new
> >> python script to parse CoreSight tracing event and use command 'objdump'
> >> for disassembled lines, finally this can generate readable program
> >> execution flow for reviewing tracing data.
> >>
> >> Patch 0001 is one fixing patch to generate samples for the start packet
> >> and exception packets.
> >>
> >> Patch 0002 is the prerequisite to add addr into sample dict, so this
> >> value can be used by python script to analyze instruction range.
> >>
> >> Patch 0003 is to add python script for trace disassembler.
> >>
> >> Patch 0004 is to add doc to explain python script usage and give
> >> example for it.
> >>
> >> This patch series has been rebased on acme git tree [1] with the commit
> >> 19422a9f2a3b ("perf tools: Fix kernel_start for PTI on x86") and tested
> >> on Hikey (ARM64 octa CA53 cores).
> >
> > Thanks, applied to perf/core.
> 
> Please hold off on that Arnaldo - I'm currently reviewing the set and
> I think some things can be improved.

Ok, I dropped all but the one adding sample->addr to the python
dictionary, that is ok to cherry pick.

- Arnaldo
