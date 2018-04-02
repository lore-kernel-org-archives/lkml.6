Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDBP0e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbeDBP0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:26:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60745206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 2 Apr 2018 11:26:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: A few inter-event bugfixes
Message-ID: <20180402112628.3cc00f62@gandalf.local.home>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 15:10:52 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steven,
> 
> Here are a few bugfixes that should be applied on top of the
> 'Inter-event (e.g. latency) support v9' patchset.

Thanks, I pulled them in and will send them out to git after testing
has succeeded.

-- Steve

> 
> The first two are things introduced by the refactoring of the last
> version, the third I noticed when adding further actions for a future
> add-on, and the last was prompted by a patch for a similar problem
> posted this morning by Arnd Bergmann.
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit 80765597bc587feae8dbc8ce97a0f32e12a6e625:
> 
>   tracing: Rewrite filter logic to be simpler and faster (2018-03-14 12:35:39 -0400)
> 
> are available in the git repository at:
> 
>   https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-update1
>   https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update1
> 
> Tom Zanussi (4):
>   tracing: Fix display of hist trigger expressions containing timestamps
>   tracing: Don't add flag strings when displaying variable references
>   tracing: Add action comparisons when testing matching hist triggers
>   tracing: Make sure variable string fields are NULL-terminated
> 
>  kernel/trace/trace_events_hist.c | 75 +++++++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 17 deletions(-)
> 
