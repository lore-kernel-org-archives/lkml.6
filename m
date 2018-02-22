Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeBVRKF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:10:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeBVRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:10:02 -0500
Date: Thu, 22 Feb 2018 18:09:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180222170947.GW25235@hirez.programming.kicks-ass.net>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 06:04:27PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:37:15PM +0100, Oleg Nesterov wrote:

> > This all makes me think that we should change (fix) kernel/events/core.c...
> 
> That's going to be mighty dodgy though, holding a reference on the task
> will avoid the task from dying which will avoid the events from being
> destroyed which will avoid the task from dying which will... if you get
> my drift :-)

Hmm, it might not be all that bad.. I need to re-read some of that code.
