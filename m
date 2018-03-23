Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsynwwxLkp6dF0eRf9X1oyvBklVt01ZS0g2iFbySpjR4cmpuy4ZB5uQu0OIchATZ5LbBd3S
ARC-Seal: i=1; a=rsa-sha256; t=1521823012; cv=none;
        d=google.com; s=arc-20160816;
        b=C42Bhh4ebAGGAFMKMTEmKGTWCp85JF8C/zMbV1oM0QDTcUVd7HJhr4xv9k3Z5gkUvv
         UFPwzNZ6tAVt9+3pxgYpXb2M19Omf/Nm0VZASLZ1TSQNII6XlWpuEUo6/SrweNc3RQ2B
         X4dkIeEr37I22O4hjQS2f+P6DrBwA6Uv/xsqLnu1aEN+hFbNjWHXwiFIxSB3chpIy7CE
         wd5HitC+Rm01mpq3sPDRRZAwkEIn+dX2I/tN3AT62E9EK9XMxTdsPWkAjSWW+LisRxg5
         xdTghZu7TFH0HFO7HTRNl2wGzY7v+UZR6Q/6T2AND//JpTJV+kNnioCLODN3i4andYrX
         m6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=NXITcK1RiZ60I2U/zQmWzBp3jGUpeVUhZSb5B5cH55o=;
        b=qkRwC5/EeYYrJWokQIVvrKw7TeUMu8aTKXmGZc86TwDSmPFCnFAy4NRh1KaDY5mGG2
         x6Ai8XHxWApziGp7/v3slaUlxRwqh3gVQn+zyivo0StGE3BKNKWmZupQu0GurdsB5nIO
         Od4ncIO+ggjuZwiZwtUqC7+b7UqMM5O0T4D451STmXLCsIU5KuSwtoKsaLUP4qHR0xoo
         qwns6kv0nEIV2c81b2a09dag28L3vK9sZ5inbuyGGutZ8f7GhXHfo52MfLeSrJ04VX1l
         Ycmhlw/SzwRZU5iXn5is0FLhV1ujT7Bz4Jexi8TrW3ocKWAiyje9ffXS0yzf2++vy+do
         RstQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCWQgv (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Mar 2018 12:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbeCWQgu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Mar 2018 12:36:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A80D21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 12:36:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/21] tracing: probeevent: Cleanup print argument
 functions
Message-ID: <20180323123647.4398ae48@gandalf.local.home>
In-Reply-To: <152129047203.31874.3188700720826213215.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129047203.31874.3188700720826213215.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188722013958666?=
X-GMAIL-MSGID: =?utf-8?q?1595747087519215387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 21:41:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Current print argument functions prints the argument
> name too. It is not good for printing out multiple
> values for one argument. This change it to just print
> out the value.

Hi Masami,

This is a confusing change log, as I have no idea what this patch does.
Can you add a "before" and "after" of what you mean. Some examples of
what it currently does to show why it looks bad, and then an example of
what it looks like after the patch.

Thanks!

-- Steve


> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
