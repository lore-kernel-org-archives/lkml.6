Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227HhtUMQHsntYHKNbYnLG0S2DapJCZViGYvEMBTAmoiI13J3QEEcx827HcGHtMJKc0A0uq/
ARC-Seal: i=1; a=rsa-sha256; t=1519640225; cv=none;
        d=google.com; s=arc-20160816;
        b=PgoAD70Lc8XNToHlNuLB62e3m8KT5Csdr++See9GU8d6lDr3J3sCmIGNTfAydYaCiR
         +D2z1LRdCJMiZz9YV1PTaVYy+yC5wKZ5xbmE0j9Zz78ES3VEdIgFOu7v1MMtUo15jPGk
         2x41q9ZLPTwHCRVYtC5NxEFRMaYOytsmjVtUPuWvuLrJXLzDWzijgbB7sF6U0YyrOqFA
         tGQSSnycCxeYqRUzJIGIeX5rrD6RLT+Ud5ZFd4rVAUJVI/cgrbgmWpEvSOS0i8zByd9S
         4cx9TgN1/a/47/lPLGHuJx9CuClN0sYwHphgLpdSwfpJ0JBvzuKSaDNijrCdnSu7riuG
         Rmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=cJUz4yfu7VpLfXsnJeK3Nz2OQp8bQsYygVSxBiRtezA=;
        b=f71+SlRfcVJVixKxneURYVoLVUwlN7bC2NzaVy6begyxrOroqKmTcD5O8v9smJk8OS
         W3Bko7Ecgbeo7mHJkfFJWF8Up68YWyZc2RpNQVY/4PVfsvZg3objQzlVArlYnr4UapeT
         HP0WE2DvLCIH9hZCBN6nnp4ntk6FrxDZefxl7cUWKiJPVDjJkaSBt0PIxFmmFDp1TLHU
         GGibSOvdlebpG+ZkDENLXHZk4XU70mfPI+BrlRW59Xs21bvWlVEA5awC22mL5xfZHIE1
         x7A343bplXiBtV01EAxW82Fin31ZUTDxfc4zM2GSztp1+5p2+4+LVCYaXMBqpTzatbnL
         ZHmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBZKQz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Feb 2018 05:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbeBZKQu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Feb 2018 05:16:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB54206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 26 Feb 2018 19:16:45 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 15/18] tracing: probeevent: Add array type support
Message-Id: <20180226191645.3b1f5b529b6c876dd279cb37@kernel.org>
In-Reply-To: <20180226014532.GB1972@sejong>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
        <151945054003.27508.54078842635361756.stgit@devbox>
        <20180226014532.GB1972@sejong>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593259396862036062?=
X-GMAIL-MSGID: =?utf-8?q?1593458269086591541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Feb 2018 10:45:32 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Sat, Feb 24, 2018 at 02:35:40PM +0900, Masami Hiramatsu wrote:
> > Add array type support for probe events.
> > This allows user to get arraied types from memory address.
> > The array type syntax is
> > 
> > 	TYPE[N]
> > 
> > Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
> > x8/16/32/64, symbol, string) and N is a fixed value less
> > than 64.
> > 
> > The string array type is a bit different from other types. For
> > other base types, <base-type>[1] is equal to <base-type>
> > (e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
> > equal to string. The string type itself represents "char array",
> > but string array type represents "char * array". So, for example,
> > +0(%di):string[1] is equal to +0(+0(%di)):string.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Add array description in README file
> >   - Fix to init s3 code out of loop.
> >   - Fix to proceed code when the last code is OP_ARRAY.
> >   - Add string array type and bitfield array type.
> > ---
> 
> [SNIP]
> > @@ -546,11 +610,16 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
> >  	/* Set argument names as fields */
> >  	for (i = 0; i < tp->nr_args; i++) {
> >  		struct probe_arg *parg = &tp->args[i];
> > -
> > -		ret = trace_define_field(event_call, parg->type->fmttype,
> > -					 parg->name,
> > +		const char *fmt = parg->type->fmttype;
> > +		int size = parg->type->size;
> > +
> > +		if (parg->fmt)
> > +			fmt = parg->fmt;
> > +		if (parg->count)
> > +			size *= parg->count;
> > +		ret = trace_define_field(event_call, fmt, parg->name,
> >  					 offset + parg->offset,
> > -					 parg->type->size,
> > +					 parg->type->size * parg->count,
> 
> It should use the 'size' variable, otherwise scalar types will have 0 size.

Oops, good catch! I forgot to use it at the main point...
 
Thank you so much!

> 
> Thanks,
> Namhyung
> 
> 
> >  					 parg->type->is_signed,
> >  					 FILTER_OTHER);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
