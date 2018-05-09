Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965770AbeEIR0l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935202AbeEIR0i (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:26:38 -0400
Date: Wed, 9 May 2018 14:24:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Display multiple events for --stdio
Message-ID: <20180509172429.GL13491@kernel.org>
References: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
 <20180509164251.GH13491@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509164251.GH13491@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 09, 2018 at 01:42:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 09, 2018 at 11:57:15PM +0800, Jin Yao escreveu:
> > When we perform following command lines:
> > 
> > perf record -e "{cycles,branches}" ./div
> > perf annotate main --stdio
> > 
> > Only shows one event "cycles" and the displaying format is not correct.
> > 
> >  Percent         |      Source code & Disassembly of div for cycles (44550 samples)
> > -----------------------------------------------------------------------------------
> 
> Please indent command output (two spaces before all lines) to avoid
> scripts breaking due to mistaking lines starting with --- as the end of
> the patch.
> 
> Applying.

Also you forgot to add this:

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: f681d593d1ce ("perf annotate: Remove disasm__calc_percent() from disasm_line__print()")

Which I've just added, to help with stable@ processing.

- Arnaldo
