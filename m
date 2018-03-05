Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuthkzyBG+iXbPyw+kjrxBQ3VnDJyFQLVmzyDefCxiujW6lqlr6p4rZARwTL0jgpvaRYtl/
ARC-Seal: i=1; a=rsa-sha256; t=1520244342; cv=none;
        d=google.com; s=arc-20160816;
        b=YVrwWi/bGYMkyqJYmKumf8XbdKlgTE15C97tNC1OLX3hJADj8ECGa3sC7lCFK5+YPC
         VFQZV1nD8bBBNAqI9NaCv8BvL3O0r1uJz4i+6t+pJS/3WDS2Udp28P0jJQQ5EEJaxMvn
         hkiao3LnLNMAGasLR4E4XM6oFHfdS0XVfx9LQQU5IZSdiCTLvXHMTyoBJUAAKXtBsBJ6
         i4eXzHKIZkzEvi+EtonnyIuxg8LGJmBUWrPSVUaHshCrXbXxVJ/OVhMaTL2aBD/DHIcd
         RzBIlAoe+Va1ghIgGG6RcB8RmevAPAysMScAcner4y7ymbJVn9LJvTu4tQUlyciJG1y/
         I0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=3LSWAGZlZ0DHPSSMRLQ86TjkPlTNVtAhUVqOpiS1gKM=;
        b=QtzxIb0/7uZLgMqeJiu/Mw2SSOnZx+1esswr0h0Hsgl5V/n5YFh2JAf6g/XW36gLWa
         KmFfk/oNxwa62gYOFmQ17ret/AUogUCoe8isTGHKiSFqJmTfkuTdEZkcMIvqLseUM3/5
         u3Y01UIiX0J65ynwgJ4r0Eqff+5QJ7hULW7rEJN3a5kRhAY6XfUK43S/6cybWQZ9HT3q
         Pot7QUogXH7g+Uh9jvl6Kp/gGuGgGQBp1aDX0Qz0kZfcIAMLcQKmms3OBVSWLI13JJuC
         8FcNnblNJNaV/iQtN6v2Gjq3wpdG7xUxwoiVzNS36in5cjnufjmEc7D+L/eRBPIAzH1B
         cSmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbeCEKFS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 5 Mar 2018 05:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933071AbeCEKFR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Mar 2018 05:05:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9DB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 5 Mar 2018 19:05:12 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 01/19] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-Id: <20180305190512.d4939c53c5288ae0fe9bf2a8@kernel.org>
In-Reply-To: <20180305022814.GA8824@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
        <151978799370.2577.9456049827647614166.stgit@devbox>
        <20180302044951.GA31540@sejong>
        <20180302153229.dbc4dc9be90a0132b7010010@kernel.org>
        <20180305022814.GA8824@sejong>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613247827918493?=
X-GMAIL-MSGID: =?utf-8?q?1594091731739076653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 5 Mar 2018 11:28:14 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Masami,
> 
> On Fri, Mar 02, 2018 at 03:32:29PM +0900, Masami Hiramatsu wrote:
> > On Fri, 2 Mar 2018 13:49:51 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > Hi Masami,
> > > 
> > > On Wed, Feb 28, 2018 at 12:19:53PM +0900, Masami Hiramatsu wrote:
> > > > In Documentation/trace/kprobetrace.txt, it says
> > > > 
> > > >  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > > > 
> > > > However, the parser doesn't parse minus offset correctly, since
> > > > commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
> > > > unsigned") drops minus ("-") offset support for kprobe probe
> > > > address usage.
> > > > 
> > > > This fixes the traceprobe_split_symbol_offset() to parse minus
> > > > offset again with checking the offset range, and add a minus
> > > > offset check in kprobe probe address usage.
> > > 
> > > It now parses a minus offset but doesn't allow it, right?
> > 
> > No, split_symbol_offset() is used for 2 cases
> >  - kprobe-event probe point
> >  - kporbe-event symbol-based argument
> > 
> > Former one doesn't accept a minus offset, but latter accepts it.
> 
> Ah, ok then.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks!!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
