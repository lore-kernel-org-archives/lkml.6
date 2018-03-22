Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvg2RBS5Hal9+2Csh5Oorm68WU0E23Ikk23D5mo3peSnRZJkhqWjTDENRXIH2LuPxQ7LPB5
ARC-Seal: i=1; a=rsa-sha256; t=1521714240; cv=none;
        d=google.com; s=arc-20160816;
        b=KYW+oAqIm0QjeNkH66NUgp6MHzTDTkYW4blhnMv8mw4GzOH6nVzaI6SI6m4A5Rj8b8
         A/6quzmPJOOYJg9wDb5ckb+Fl40YN20ZTkMpDFLXD+XRUlmevgVnhDyN09537M/oH/oj
         Zb3kpJ1zg3xJVpZz4DRXuuX2ffD3caB0IFHOf3EVfQdeci+bDFtY755CZhDNz+NeVPAH
         3aEG9VFEcLNYUNCreKQxij27l8IV8xNkwNgdXbsuSjtMuJxKzHGFLDDUKV47FV2pxA/e
         j4EP1yyFTnSVvldgQmX+2CdCu7/H+S60dyAEOz6nv1lFr0O4MOYZz49BzWiUUkN1xOeZ
         ZJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=Pq1ufAJnI1m1oWABdveITM+PjEcJQJlMaO/7KhCs0es=;
        b=zLh2QEPL33LEW2xtHiDZXy/SDqi//ciMV7BXqDabbPbVFjJIbfw6mpQBnhnme9/dGd
         jZ4Fw84PSlafA6Xo/P/ytMjePyCfbXMCkvfzi+7AGm+9jOovdvMOWtv+Il5PyUiBlBKG
         0DPGE8XSTfCLhNWNuoNoGNwaqGdb9KKP305Ai9kBBrilirzXm6bejAt8rxQex9P23JaU
         ib2Nbahiq++qrdcQV3YIxJ0hOarLaXJDEUaexMG8DVEoKIJlo9WrDkBIaqpCNVJMxKND
         24Pnc0i8FQCgNGShNPy7UexP6bxhjQpfwPHQv5tVV3ENrgyrzQhWXEztp9Q29w4NerpQ
         XCsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeCVKX6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Mar 2018 06:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753342AbeCVKXx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Mar 2018 06:23:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E869B217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 22 Mar 2018 18:23:47 +0800
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v6 21/21] perf-probe: Add array argument support
Message-Id: <20180322182347.ca1aab9b77ab4c351100646b@kernel.org>
In-Reply-To: <8c02c538-4934-59c2-7795-9058ce57e625@linux.vnet.ibm.com>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129118998.31874.16273532808298489908.stgit@devbox>
        <8c02c538-4934-59c2-7795-9058ce57e625@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189477266437642?=
X-GMAIL-MSGID: =?utf-8?q?1595633031485120008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Mar 2018 13:29:59 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Hi Masami,
> 
> On 03/17/2018 06:23 PM, Masami Hiramatsu wrote:
> > Since kprobes events support an array argument, perf-probe
> > can also support dumping array now.
> > The syntax are
> >
> >  <array-var>[<range>]
> > or
> >  <pointer-var>[<range>]
> >
> > where the <range> is <start>..<end>. e.g. array[0..5].
> > This can also be available with string type. In this
> > case, the string array should be "char *array[]" or
> > "char **array_ptr".
> >
> > Note that this feature is only available on the kernel which
> > supports array type.
> 
> User can still do,
> 
> # perf probe -x ~/hello main:3 'a=a:x32[3]'
> 
> which will successfully be installed in uprobe_events. But for a
> perf tool, x32[3] is not a valid type. And it seems perf tool don't
> validate the 'type' field:
> 
>     static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
>     {
>         ....
>         tmp = strchr(str, ':');
>         if (tmp) {      /* Type setting */
>                 *tmp = '\0';
>                 arg->type = strdup(tmp + 1);
>                 if (arg->type == NULL)
>                         return -ENOMEM;
>                 pr_debug("type:%s ", arg->type);
>         }
> 
> Is it okay to allow user to specify array size with type field?

Fro this patch, yes. The availability of type is checked only when
it is automatically generated.
IMO, it should be done in another patch, something like
"Validate user specified type casting" patch. Would you need it?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
