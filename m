Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs0WFcAFVoROGmF1lIhPWSY/BnGI2lWFCiBjbez3c//OvevaAB4C8/5wvtR+Nj3kjKk0EWO
ARC-Seal: i=1; a=rsa-sha256; t=1520216899; cv=none;
        d=google.com; s=arc-20160816;
        b=NWghUvJtc8IYIYDK+lvYZWyJooJyNKgPMts02MfXexoIfVkw2mi2WrceAQXuqjkPUN
         G7bTH5uJJHqOY10hq4Dnu2NGlrt/xhX8N7xzzjrvscg4NPfr+AWrE6WFQzYyraKj8CgS
         PVGaMwQXJdHsUV1F8PLMNLVzozuycZsXW9OjIXqpU4++Apj0aejIg8xhKAQY+aoF5vKc
         Eh6I17Wp6V8SeznWeY33Fu8vxIVtmIWIa7EjT0B+N94SW5zSluFnzE1aWRaGmOkqAh/3
         TPEIhCvYP2xjIZh0U9bBi0nCun4xKZHMabMSIqFUnLvTClx0TCicWL0ya8X1AZTm0VBL
         EqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=+0a+cktZsXSILbQFZ8u15I54FLrfyodPpskAOI9w9QU=;
        b=IarBWY/siK9/oC1jRiqHg13I5LSxrSw/baTA914TPGsaR2gUtobYqHpBCzdk86FcCR
         Db72WehS5SAPQ9oGNAc0nh+JfW/AaqDEjf9k1+3PAyEsV622LlKqlqh/SIJyZUkL2wTL
         Nh+PL0JN5xG0t0G/KxaZjhwfkHQQQrBJcZNZIOb6aB8ReN2VsYfBkw/zR0tqNk52PRDW
         ZqkzejOu8xqrIuZd/todfID3w4N5BE8a2qU9ydMYlkHgqw5w6shwsx7qONBq/9bP02ZP
         zkQdXwrwt/fc8Im0LLWDXfmpoGtXeY0adrvg42OoLsdaT6l2pyUwKKcxoORqMCpfwNPX
         zKQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeCEC2S (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 4 Mar 2018 21:28:18 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:37295 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeCEC2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Mar 2018 21:28:17 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 5 Mar 2018 11:28:14 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 01/19] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-ID: <20180305022814.GA8824@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
 <151978799370.2577.9456049827647614166.stgit@devbox>
 <20180302044951.GA31540@sejong>
 <20180302153229.dbc4dc9be90a0132b7010010@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302153229.dbc4dc9be90a0132b7010010@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613247827918493?=
X-GMAIL-MSGID: =?utf-8?q?1594062955587870599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On Fri, Mar 02, 2018 at 03:32:29PM +0900, Masami Hiramatsu wrote:
> On Fri, 2 Mar 2018 13:49:51 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > On Wed, Feb 28, 2018 at 12:19:53PM +0900, Masami Hiramatsu wrote:
> > > In Documentation/trace/kprobetrace.txt, it says
> > > 
> > >  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > > 
> > > However, the parser doesn't parse minus offset correctly, since
> > > commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
> > > unsigned") drops minus ("-") offset support for kprobe probe
> > > address usage.
> > > 
> > > This fixes the traceprobe_split_symbol_offset() to parse minus
> > > offset again with checking the offset range, and add a minus
> > > offset check in kprobe probe address usage.
> > 
> > It now parses a minus offset but doesn't allow it, right?
> 
> No, split_symbol_offset() is used for 2 cases
>  - kprobe-event probe point
>  - kporbe-event symbol-based argument
> 
> Former one doesn't accept a minus offset, but latter accepts it.

Ah, ok then.

Acked-by: Namhyung Kim <namhyung@kernel.org>


> 
> (Frankly to say, I guess no one care about supporting minus offset :P)

:)

Thanks,
Namhyung
