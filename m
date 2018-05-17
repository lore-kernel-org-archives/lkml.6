Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeEQU1q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:27:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752176AbeEQU1p (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:27:45 -0400
Date: Thu, 17 May 2018 22:27:41 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support multiple events without group
Message-ID: <20180517202741.GD12497@krava>
References: <1525960762-19520-1-git-send-email-yao.jin@linux.intel.com>
 <20180517162750.GB18538@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517162750.GB18538@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:27:50PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 10, 2018 at 09:59:22PM +0800, Jin Yao escreveu:
> > See example,
> > 
> > perf record -e cycles,branches ./div
> > perf annotate main --stdio or
> > perf annotate main --stdio2 or
> > perf annotate main
> > 
> > The "perf annotate" should show both cycles and branches on the
> > left side, but actually it only shows one event cycles.
> > 
> > It works with events group like:
> > perf record -e "{cycles,branches}" ./div
> > 
> > It should work too even without group.
> 
> Humm, I think that this should be done the way it is for perf report,
> i.e. you select the group output by using --group, no?
> 
> Jiri, isn't that how it is done in 'perf report' for non-explicit
> groups?

yep, if there's no event group, the --group will enable the group
output in report.. sounds ok to follow this also in annotate

'perf report' TUI offers list of events to choose from
and the --stdio version prints report for each event
annotate could do the same

jirka
