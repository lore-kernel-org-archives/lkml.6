Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225ZQYDs5iRkzLEFyuioDjRvphbZUyPOL36/sqUjj3rPoVgYwoJko5HFx3tW6HqoVWLdGSUZ
ARC-Seal: i=1; a=rsa-sha256; t=1519379097; cv=none;
        d=google.com; s=arc-20160816;
        b=Xkvf8fAH8DLbxzgI/dNtjCJWR+56JA/ilyPhx/ymqfJ9LK9rJ7IR7XBQ264f71OFBT
         9HX/tgQ+fPvFPx5KEHrhZjasKtn0/6LFJAUWl32NOyhL6qOfHRCfMPy4EH4nUhE8BLI3
         xvq4cng8lXev7dBchG7J+V2kqfbsUmEX+iIFkVBugwwt2FdjcfSpYxzE4I8YVqOr5VSo
         vy2HEaho/FaQTuEF5dqyJaKjTnYDyf6/x0g8sPL9CFOt/Zdo1N8XpD7wP+0IyS08JqTk
         nB8Ivt56QwfMLQVlPzu/scYkXIZjoz4U5AaPSJWMue1wKv62tXN3JCJ+0GgdiAHc8gzM
         UM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=VjbY9Vel8uFo5uYvzcjx/pFtWRPj5VPAsnAYFHvCMmA=;
        b=mBP3k2itKzUXC/MY6Z9dnsJbsuR/lIwE5b2f6qPGlNgH19H1xInZltEhKKwEJdKk1L
         79hqtOT+aoUbN/jUsOzN3KEJiiMOuKrsHBrFRMW0Qq//sldLOy7OS1W/VsMTputtqncv
         YNZo7/GCmJM6p8+sSJYXniI3LzpAqXMpdNcKiqMa1skWsnO3pX/mGSTxT8xXLoXGS6y8
         TVp6j431Z0CzeC01ouwKYMC58VCQYVudETxA1HRaQagwpBvyitr42yKLVct/V7LZXsfY
         fc+O99sZvNIwLmG2AFet4ShmbWrwIdnDGndhSupBwopjV2DhKvuG7ccA7CTzW7YIr67P
         QW7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBWJo4 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 04:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeBWJo4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 04:44:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A05217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 23 Feb 2018 18:44:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [BUGFIX PATCH v2.1] tracing: probeevent: Fix to support minus
 offset from symbol
Message-Id: <20180223184452.283a81391e801f949eeca70d@kernel.org>
In-Reply-To: <20180223001542.GA25299@sejong>
References: <20180221205341.3fd69b35@gandalf.local.home>
        <151928550073.16058.5161938919130863384.stgit@devbox>
        <20180223001542.GA25299@sejong>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593184456155207925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 09:15:42 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Masami,
> 
> On Thu, Feb 22, 2018 at 04:45:01PM +0900, Masami Hiramatsu wrote:
> > In Documentation/trace/kprobetrace.txt, it says
> > 
> >  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > 
> > However, the parser doesn't parse minus offset correctly, since
> > commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
> > unsigned") drops minus ("-") offset support for kprobe probe
> > address usage.
> > 
> > This fixes the traceprobe_split_symbol_offset() to parse minus
> > offset again with checking the offset range, and add a minus
> > offset check in kprobe probe address usage.
> > 
> > Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2.1:
> >   - Fix to ensure the offset value is less than LONG_MAX.
> >   - Fail if the offset is minus when traceprobe_split_symbol_offset()
> >     is used for the probe address.
> >   - Add Fixes tag.
> > ---
> >  kernel/trace/trace_kprobe.c |    4 ++--
> >  kernel/trace/trace_probe.c  |   15 ++++++++++-----
> >  kernel/trace/trace_probe.h  |    2 +-
> >  3 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 5ce9b8cf7be3..b5b1d8aa47d6 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -667,7 +667,7 @@ static int create_trace_kprobe(int argc, char **argv)
> >  	char *symbol = NULL, *event = NULL, *group = NULL;
> >  	int maxactive = 0;
> >  	char *arg;
> > -	unsigned long offset = 0;
> > +	long offset = 0;
> >  	void *addr = NULL;
> >  	char buf[MAX_EVENT_NAME_LEN];
> >  
> > @@ -755,7 +755,7 @@ static int create_trace_kprobe(int argc, char **argv)
> >  		symbol = argv[1];
> >  		/* TODO: support .init module functions */
> >  		ret = traceprobe_split_symbol_offset(symbol, &offset);
> > -		if (ret) {
> > +		if (ret || offset < 0) {
> >  			pr_info("Failed to parse either an address or a symbol.\n");
> >  			return ret;
> >  		}
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index d59357308677..ec3856147fdd 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -320,21 +320,26 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
> >  }
> >  
> >  /* Split symbol and offset. */
> > -int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> > +int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  {
> > +	unsigned long ul;
> >  	char *tmp;
> >  	int ret;
> >  
> >  	if (!offset)
> >  		return -EINVAL;
> >  
> > -	tmp = strchr(symbol, '+');
> > +	tmp = strpbrk(symbol, "+-");
> >  	if (tmp) {
> > -		/* skip sign because kstrtoul doesn't accept '+' */
> > -		ret = kstrtoul(tmp + 1, 0, offset);
> > +		ret = kstrtoul(tmp + 1, 0, &ul);
> 
> Why not just using kstrtol() which handles the sign correctly?

Oops, right!

Thank you!

> 
> Thanks,
> Namhyung
> 
> 
> >  		if (ret)
> >  			return ret;
> > -
> > +		if (ul > LONG_MAX)
> > +			return -E2BIG;
> > +		if (*tmp == '-')
> > +			*offset = -ul;
> > +		else
> > +			*offset = ul;
> >  		*tmp = '\0';
> >  	} else
> >  		*offset = 0;
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 0745f895f780..75daff22ccea 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -365,7 +365,7 @@ extern int traceprobe_conflict_field_name(const char *name,
> >  extern void traceprobe_update_arg(struct probe_arg *arg);
> >  extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >  
> > -extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
> > +extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
> >  
> >  /* Sum up total data length for dynamic arraies (strings) */
> >  static nokprobe_inline int
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
