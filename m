Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsOSMhzaOhilab3koLgiDJPDMNCoaDD+4tSpZj+kL48BaxIYEJckoapC477OY8ApXOPUTbd
ARC-Seal: i=1; a=rsa-sha256; t=1521098337; cv=none;
        d=google.com; s=arc-20160816;
        b=Dztrj4jy0YDjmbsCkUco/WJtwmRNeJmPxbyCvqOdgCgcv+F1GulQAMmpeDof4RrvnT
         U7acQ1W00dy84zVh5GROSVgw/mZAOPQ9/ogcfOITruAL/g03sKRngd4shpP599Smp4Dc
         ElkQMME8Cre6n0ldPPd+gRmgH3+BWO+5wqsrdmpQNuOdDAxU/z4xQZ1z1ivMZTn7Uq2K
         AQxDEmih3oAZawTj1CTOv7Ea6/pM14pqg/NgHDPRiJOOcOaIz4ZWW7pq+Yo4NrVibbKq
         qu7UE8vWOMbuiIcSckejxF7l19GVuSj3jkCuFRWs73PI5llAin0Fq9Mqayff9szEH8Tn
         hXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=ZXcvfZy85ByPyTzlOeMWPoJA80x0tja/8acn7AcAANM=;
        b=Z1i3XU6axOd8WSJ1j4mMFNbWRGoMEUK2B453YwwU4thY7NcD8wpv9FT11CzQffqpae
         u3YptGez5+DgSBGLRJbvbssD+3g/0MtNcGfYBV+mjlRm64pFwBHo5uM4HUSD0TYf6emj
         LzcSHolGaMoEfd8OTE65Cht2aUCcZ3ogjIqQOf2ba+2y9ZgpLslyavC5uVdJdhpENtFb
         46HD/dx1LCeA+CGZg0nR6UoMJyZtU4A0VxbjpPCXR9PyUB+VCqIOlRArEigjMTG28KMI
         zpeVGNM0MAB4oTYGfguTKyj+4avghXO9uFmTy9Y7V8J0wdqiDiWPnUEF6g5VpBII+MdY
         daog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCOHSp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 03:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeCOHSo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 03:18:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 15 Mar 2018 16:18:40 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v5 16/19] tracing: probeevent: Add array type support
Message-Id: <20180315161840.71d524a73307881febfe34c2@kernel.org>
In-Reply-To: <72be81a4-710a-b942-277d-9156c3debc5d@linux.vnet.ibm.com>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
        <152049905133.7289.17516121776689315422.stgit@devbox>
        <72be81a4-710a-b942-277d-9156c3debc5d@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1594987211185344746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 11:18:19 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Hi Masami,
> 
> On 03/08/2018 02:20 PM, Masami Hiramatsu wrote:
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
> 
> I was trying to test this patch. But I'm not getting proper data.
> Here is what I'm doing...
> 
> $ cat hello.c
> #include <stdio.h>
> 
> void foo1(int a[])
> {
>     printf("%d\n", a[2]);
> }
> 
> void foo(int a[])
> {
>     printf("%d\n", a[1]);
>     foo1(a);
> }
> 
> void main()
> {
>     int a[3] = {4, 5, 6};
>     printf("%d\n", a[0]);
>     foo(a);
> }
> 
> $ gcc -g hello.c -o hello
> $ sudo ./perf probe -x ~/hello foo1 'a=a:x32[3]'
> $ sudo cat /sys/kernel/debug/tracing/uprobe_events
> p:probe_hello/foo1 /home/ravi/hello:0x00000000000005fc a=+96(%gpr31):x32[3]
> 
> $ sudo ./perf record -e probe_hello:foo1 ~/hello
> $ sudo ./perf script
> hello  6913 [038]  2857.704470: probe_hello:foo1: (100005fc) a={0xd69e4400,0x7fff,0x0}
> 
> 
> I don't see proper values of the 'a'? Anything wrong with my perf commands :) ?

Ah, I guess since it is a pointer. in main() function, "a" is an array,
but in foo1(), "a" is a pointer to the array.
>From the viewpoint of C source code, both pointer and array is same
expression, but actually it is not same from memory point of view.
perf probe has to be updated to enable it too.

Could you please try to do as below?

$ echo "p:probe_hello/foo1 /home/ravi/hello:0x00000000000005fc a=+0(+96(%gpr31)):x32[3]" | sudo tee /sys/kernel/debug/tracing/uprobe_events

and trace it again.

-- 
Masami Hiramatsu <mhiramat@kernel.org>
