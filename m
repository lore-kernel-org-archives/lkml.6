Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvdis2pqptMSuj+yTks9BvwyUW+cfOHjWAGFlc9Ej8DRCszgZ2DHrJE8Jt/Gw6vXW5cWcAM
ARC-Seal: i=1; a=rsa-sha256; t=1521098603; cv=none;
        d=google.com; s=arc-20160816;
        b=AZGDfgf/OIaN3sPe3vWnDsxYhmnu2wZEV4nqbyPInly/XaWU03nM/l5EElHSpdB4Le
         QtxZo/T2+kM6erzajDWBkTUYILIEtcNu9HtS6NJb+H3lCZadxPc6CAnmAmjXf2HeGctU
         mNnvP4Hjpkm3xJ/eIyCosAKnqZ+CKHRopnQbPTvGgKgWRDv5tgqYLVfPFSpmnjRUGCg0
         EH4MwAHHBBjthX9XRgNfNljI4oYkdLrzOmM6gq776Su7gRsvMJa+V4Ajtw9rC+QKSCsq
         T5h0OmWXraHENa2GQrRkCWYVh0NL+OIrOmw3+Rya18NJvIDJ80WUZO58rMDVcbvIB7tN
         iIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=L7MiktSjfEs6kpMm4CdMIDdVzwnthgMEwoCJhes1xrU=;
        b=xedNP1rRi9r7H3H9iQEfyMpKklwE9G2enhBGf0zeo9mRB0hewf3IGAXUvbZjGtc4zV
         O9BifeADNjzt0SZ9NbY69pj+13WT9DQQuFC7bKzwGSEyHqDpvfdO8F2SXKV6hcznJr6D
         q3KRwb9mM/AvLgmEWMEib1LdFq7tVbD5MwR+phSVkrI5KsoDGyjbWSQyF0+/paJOw6zF
         ty8E5EdCgcLyJ+1YtI4NjPjBK/mwiV8tkMpxE5bV+B53yf+JUxcQQJT3/W9uX6Bxx3An
         7IdvZGzpIZhc07zKr0W9cwIyDoRp2xNWUHNlvSvliUxNqmKGzCRGOj204usya8KMyxqD
         +Dtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeCOHXJ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 03:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeCOHXH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 03:23:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE3620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 15 Mar 2018 16:23:03 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v5 16/19] tracing: probeevent: Add array type support
Message-Id: <20180315162303.1250dea1500aea420ecd85c6@kernel.org>
In-Reply-To: <20180315161840.71d524a73307881febfe34c2@kernel.org>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
        <152049905133.7289.17516121776689315422.stgit@devbox>
        <72be81a4-710a-b942-277d-9156c3debc5d@linux.vnet.ibm.com>
        <20180315161840.71d524a73307881febfe34c2@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1594987489069655970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ravi,

On Thu, 15 Mar 2018 16:18:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 15 Mar 2018 11:18:19 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> 
> > Hi Masami,
> > 
> > On 03/08/2018 02:20 PM, Masami Hiramatsu wrote:
> > > Add array type support for probe events.
> > > This allows user to get arraied types from memory address.
> > > The array type syntax is
> > >
> > > 	TYPE[N]
> > >
> > > Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
> > > x8/16/32/64, symbol, string) and N is a fixed value less
> > > than 64.
> > >
> > > The string array type is a bit different from other types. For
> > > other base types, <base-type>[1] is equal to <base-type>
> > > (e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
> > > equal to string. The string type itself represents "char array",
> > > but string array type represents "char * array". So, for example,
> > > +0(%di):string[1] is equal to +0(+0(%di)):string.
> > 
> > I was trying to test this patch. But I'm not getting proper data.
> > Here is what I'm doing...
> > 
> > $ cat hello.c
> > #include <stdio.h>
> > 
> > void foo1(int a[])
> > {
> >     printf("%d\n", a[2]);
> > }
> > 
> > void foo(int a[])
> > {
> >     printf("%d\n", a[1]);
> >     foo1(a);
> > }
> > 
> > void main()
> > {
> >     int a[3] = {4, 5, 6};
> >     printf("%d\n", a[0]);
> >     foo(a);
> > }
> > 
> > $ gcc -g hello.c -o hello
> > $ sudo ./perf probe -x ~/hello foo1 'a=a:x32[3]'
> > $ sudo cat /sys/kernel/debug/tracing/uprobe_events
> > p:probe_hello/foo1 /home/ravi/hello:0x00000000000005fc a=+96(%gpr31):x32[3]
> > 
> > $ sudo ./perf record -e probe_hello:foo1 ~/hello
> > $ sudo ./perf script
> > hello  6913 [038]  2857.704470: probe_hello:foo1: (100005fc) a={0xd69e4400,0x7fff,0x0}
> > 
> > 
> > I don't see proper values of the 'a'? Anything wrong with my perf commands :) ?
> 
> Ah, I guess since it is a pointer. in main() function, "a" is an array,
> but in foo1(), "a" is a pointer to the array.
> From the viewpoint of C source code, both pointer and array is same
> expression, but actually it is not same from memory point of view.
> perf probe has to be updated to enable it too.
> 
> Could you please try to do as below?
> 
> $ echo "p:probe_hello/foo1 /home/ravi/hello:0x00000000000005fc a=+0(+96(%gpr31)):x32[3]" | sudo tee /sys/kernel/debug/tracing/uprobe_events

Sorry, that is too complicated than enough. you should try to specify a[0] instead of a.

 $ sudo ./perf probe -x ~/hello foo1 'a=a[0]:x32[3]'

:)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
