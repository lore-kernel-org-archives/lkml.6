Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeDILks (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:40:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeDILkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:40:47 -0400
Date: Mon, 9 Apr 2018 13:40:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <20180409114034.GW4082@hirez.programming.kicks-ass.net>
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
 <20180222170947.GW25235@hirez.programming.kicks-ass.net>
 <20180222174041.GA2802@redhat.com>
 <35f890f7-1194-4509-a1e4-d63d1c7d22ab@lab.ntt.co.jp>
 <20180409073827.GS4082@hirez.programming.kicks-ass.net>
 <20180409104010.GA22993@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409104010.GA22993@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:40:10PM +0200, Oleg Nesterov wrote:
> But I still think that we should (try to) remove put_task_struct() from put_ctx().
> 
> Quite possibly I missed something, but I think it only adds some confusion. Once
> again, even if ctx can't go away you can't use ctx->task without TASK_TOMBSTONE
> check, exactly because this task can exit. So why perf_event_context should add
> another reference?

Ah, I see what you mean. Yes that might be possible.
