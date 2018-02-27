Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224nzEDD/eKWY57SbmObOpwiOj6Uf7I211YGDIgLyEx9sJ+TEsr2fFjSkTpivjvqsL66RzCW
ARC-Seal: i=1; a=rsa-sha256; t=1519709039; cv=none;
        d=google.com; s=arc-20160816;
        b=ZSJseowfIgjaqHCyKZIGl2HCCSPH4nV204cSpRT8fkR86ktmNnOuLogM+vUB3HK29p
         XUG+t6nrSKkeZS89YI1wT8bRDn/I8QS+myeYdUio8rPnfgeaigL1Lkb333LLijVjom94
         e78+Dp6OkHMTviK/LoSAncWx+B057npPsxIe0g3KypGgkTnwsR0JwzeFuvkMarM1yhar
         en7c0JAUrL+gOrL/so3KU/PGlexPVxj4izy6M9pPE35Q1szn4p9/RkN084p7S25sxAxB
         AyuP9Wiyr/KnWzRy6l7YGEaRENXMSFdt/KvY+EAI5KNA02ZFMZmMGG2NTWmdyNP/lraO
         LlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=QnnN2aXzCaQgs7cpytAR4pJbtvzkRjCxPVBIn4n+1ws=;
        b=L1fzB1RXc/e2HBPVEwxNdZp/Tk/9tOQLxdA1UqAKrsf27hg4uTjeNJsrRTEo2D+c0s
         ZUyhwat62DBQ/E25/gvr3nv45b4TTSuQC66NjyexuKHEZZcX/QojkcXw381b6rcGfWDQ
         E8tfpGmOFEEGXFmobP/eJRF/JICtlCzQ1zVxNTbqQOQQQCTwrCpjQ7uXDHi0GU/FxdHT
         pzDtYUYFuM0tyz9ItVUWwkFNM6dKpZOys8EHdh/Ps6PE/UFJ5H7cfLwX3BMZwBLTPsgv
         vdh2mjrL4D8L4oMgIBQ0gzyQgfamIAWPE/FeirtRD7hRSy++mdRm0YuLH+hKgmploTCn
         S9gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeB0FX6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 00:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbeB0FX5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 00:23:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AF02064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 27 Feb 2018 14:23:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 01/18] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-Id: <20180227142351.576f8d8c1964b661dc1dc5a6@kernel.org>
In-Reply-To: <20180226003818.GA1972@sejong>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
        <151945013281.27508.4068021929757474274.stgit@devbox>
        <20180226003818.GA1972@sejong>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593258969628938667?=
X-GMAIL-MSGID: =?utf-8?q?1593530425860131608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Feb 2018 09:38:18 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Masami,
> 
> On Sat, Feb 24, 2018 at 02:28:52PM +0900, Masami Hiramatsu wrote:
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
> >  Changes in v3:
> >   - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
> > ---
> >  kernel/trace/trace_kprobe.c |    4 ++--
> >  kernel/trace/trace_probe.c  |    8 +++-----
> >  kernel/trace/trace_probe.h  |    2 +-
> >  3 files changed, 6 insertions(+), 8 deletions(-)
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
> 
> Hmm.. is minus offset an error?  Then why not removing it from the
> documentation?  And the 'ret' would be 0 in that case.

Yes, since the kprobe.offset is unsigned, it is not possible.
BTW, I found it is "unsigned int", so it should check UINT_MAX too...
(Or make it unsigned long)

> 
> 
> >  			pr_info("Failed to parse either an address or a symbol.\n");
> >  			return ret;
> >  		}
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index d59357308677..d3d1ee820336 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -320,7 +320,7 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
> >  }
> >  
> >  /* Split symbol and offset. */
> > -int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> > +int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  {
> >  	char *tmp;
> >  	int ret;
> > @@ -328,13 +328,11 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> >  	if (!offset)
> >  		return -EINVAL;
> >  
> > -	tmp = strchr(symbol, '+');
> > +	tmp = strpbrk(symbol, "+-");
> >  	if (tmp) {
> > -		/* skip sign because kstrtoul doesn't accept '+' */
> > -		ret = kstrtoul(tmp + 1, 0, offset);
> > +		ret = kstrtol(tmp + 1, 0, offset);
> 
> It should not skip the sign anymore.

Oops, yes. I'll fix it and I should add a test case for it. Thanks!


> 
> Thanks,
> Namhyung
> 
> 
> >  		if (ret)
> >  			return ret;
> > -
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
