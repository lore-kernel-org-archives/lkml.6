Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeELR1h (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 13:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeELR1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 13:27:36 -0400
Date: Sat, 12 May 2018 13:27:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Message-ID: <20180512132732.792468da@gandalf.local.home>
In-Reply-To: <20180512214029.8610c88ecc3de94a95822189@kernel.org>
References: <20180511194927.190877137@goodmis.org>
        <20180511195341.034688188@goodmis.org>
        <20180512214029.8610c88ecc3de94a95822189@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 21:40:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> >  static int regex_match_full(char *str, struct regex *r, int len)
> >  {
> > -	if (strncmp(str, r->pattern, len) == 0)
> > -		return 1;
> > -	return 0;
> > +	/* len means str is dynamic and ends with '\0' */  
>            ^^^
>           !len (or len == 0)?
> 
> Thank you,
> 

Yes, agreed. Thanks for the review!

-- Steve
