Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48uplA/gGRkgxMMoPW714v/86XOuXwLPu/hjmjwtRrnmRDbM3i+q8Btg76O7F7kceghx1Ot
ARC-Seal: i=1; a=rsa-sha256; t=1522037869; cv=none;
        d=google.com; s=arc-20160816;
        b=R2HJIFI2GvTnWT18QiDIdl6TO3kngoYX99oTu8C+AfrGURBWyN50E4SFHoh/2z267j
         XJqqj9mw57XL+Lq1SUIkRa4C5z54jV+IDV9ZZvJ3Cz1pEjszLgBFGYXv7I4RZRB5hh1l
         yxut+aHsftTv0XQAHk58wiRlgZAlH/iu4ARj6KlI4QWnySltOovqRSIonHIUsAZIYb7s
         yAW8t95a4BnxE46JURbrrejyoIo1NrWA6YmcqHenX5mfaA+8udKqIn1K+X0zokjZr9El
         EChInLBgtKVDaS9MDl4ArCvDgugrfUmWVowqT5eluFjiafy+VhzisEFZMk4jXLNK7yrC
         n9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=yvXcjAiW4gZeyJC+9R6t5KDpqtlqoIp6ycOJ3V8RbiI=;
        b=Cm23p6cHlHBD+XQ4qE2mc+758XqdSXbYpEQCi8IAyIUlHfWGjRoKRfU2sEwyiClAqB
         qu8bBo9KIhwUJNTKDVLihJeVFKWTjHHMoZo3T30CaP/y10AjIy1w/OPpXbPkYxzt/AJz
         AfgVlTEu4ck1tvIzCM4ppQVm2lQ5FxrUFWYpGhczX/KfrkDYEOyC+ABpJMmcoHiK6O4x
         ao5kRCsbtVYq3TrPM3EYoNG6/0mkJtAqV9g+p7Ekx4tOGqa+QfMA74HZ9AFBGCqr7shp
         E+V5XvdVyOM3NU4ncvNC6t6umcsNP5PzptVH6RouWonqMckpXh1kMPAVreSXpXOCEdQH
         QN8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeCZERh (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 00:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750755AbeCZERg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 00:17:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03CB21749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 26 Mar 2018 13:17:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/21] tracing: probeevent: Cleanup print argument
 functions
Message-Id: <20180326131733.ac156981d82c4a38dae307f4@kernel.org>
In-Reply-To: <20180323123647.4398ae48@gandalf.local.home>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129047203.31874.3188700720826213215.stgit@devbox>
        <20180323123647.4398ae48@gandalf.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188722013958666?=
X-GMAIL-MSGID: =?utf-8?q?1595972381175118273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 12:36:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 17 Mar 2018 21:41:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Current print argument functions prints the argument
> > name too. It is not good for printing out multiple
> > values for one argument. This change it to just print
> > out the value.
> 
> Hi Masami,
> 
> This is a confusing change log, as I have no idea what this patch does.
> Can you add a "before" and "after" of what you mean. Some examples of
> what it currently does to show why it looks bad, and then an example of
> what it looks like after the patch.

OK, this is actually just a cleanup patch. No functional difference between 
"before" and "after". For more flexible argument, like array type, we need
to decouple with argument name and its value printing. Is below more clear
to you?


Cleanup argument-printing functions to decouple it into name-printing and
value-printing, so that it can support more flexible argument expression,
like array type.

Thanks,



> 
> Thanks!
> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
