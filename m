Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E0120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="oAcDEXv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfAONgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:36:54 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:41986 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbfAONgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:36:54 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43fBFv0grcz20Z0;
        Tue, 15 Jan 2019 14:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547559411; bh=LG8RFlYbgiWIWcKsRftI6QPCwOmSRTLGeka7yx5t5bo=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From:To:CC:
         Subject;
        b=oAcDEXv6CpHeQz4KOf/0SGQUqkxaVQvz1PSurDL0JoyFMpTQQkrtByIVdlRdwD2Y1
         YPpCIOhw7mNeCW5MYOFL440rslLXiFZx0G/uBDexG7C3IWUhmSB+fgBzWXpHHRjDgX
         4Up9LM2z56MN+RybDUk5SuTgxm44sYYZH1HmyYeqCgvH4JIHSHUk+Xv65K68Fbafhn
         mPszGKqdDItaKK9nNdOCpGNcG+DJpKkyp7T1m5NmVLDe2hgYZydnwVW7EVqRtd9btN
         TSf10W5x1xpzqN6BaVK+NU28I3Z2kMvG0IY9+tQ9wxCvrqqdK5ks02eaU/Oq+dXdpk
         Q9Y9vkSgeCbuQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19b8MqHwY0b3VyRw6H+YwdnHfTyHulchw4=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43fBFr5rTMz20Wv;
        Tue, 15 Jan 2019 14:36:48 +0100 (CET)
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Subject: Re: uprobes: bug in comm/string output?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
Message-ID: <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
Date:   Tue, 15 Jan 2019 14:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 1/14/19 1:38 PM, Andreas Ziegler wrote:
> Hi,
> 
> I've been playing around with uprobes today and found the following weird behaviour/output when using more than one string argument (or using the $comm argument). This was run on a v4.20 mainline build on Ubuntu 18.04.
> 
> root@ubuntu1810:~# uname -a
> Linux ubuntu1810 4.20.0-042000-generic #201812232030 SMP Mon Dec 24 01:32:58 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> I'm trying to track calls to dlopen so I'm looking up the correct offset in libdl.so:
> 
> root@ubuntu1810:/sys/kernel/debug/tracing# readelf -s /lib/x86_64-linux-gnu/libdl-2.28.so | grep dlopen
>     34: 00000000000012a0   133 FUNC    GLOBAL DEFAULT   14 dlopen@@GLIBC_2.2.5
> 
> Then I'm creating a uprobe with two prints of $comm and two prints of the first argument to dlopen, and enable that probe. The '/root/test' program only does a dlopen("libc.so.6", RTLD_LAZY) in main().
> 
> root@ubuntu1810:/sys/kernel/debug/tracing# echo 'p:dlopen /lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm +0(%di):string +0(%di):string' > uprobe_events
> root@ubuntu1810:/sys/kernel/debug/tracing# echo 1 > events/uprobes/dlopen/enable
> root@ubuntu1810:/sys/kernel/debug/tracing# /root/test
> 
> The trace output looks like this:
> 
> root@ubuntu1810:/sys/kernel/debug/tracing# cat trace
> # tracer: nop
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             test-1617  [000] d...  1237.959168: dlopen: (0x7fbd5272e2a0) arg1=(fault) arg2=(fault) arg3="libc.so.6libc.so.6" arg4="libc.so.6" 
> 
> That's very weird for two reasons:
> - fetching $comm seems to fail with an invalid pointer
> - arg3 contains the text twice (if I add another print of the argument, arg3 will contain the wanted string three times, arg4 two times and the last argument will contain it once). 

at least for the second problem I think I found the answer, and for the 
first problem I have a suspicion (see last paragraph for that).

For this, I installed a uprobe for libdl.so/dlopen once again, the 
command would be

'p:dlopen /lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm'

so it should print the process name twice (using a kernel v4.18 on 
Ubuntu 18.10).

The code which prints the collected data (print_type_string, defined by 
PRINT_TYPE_FUNC_NAME(string) in kernel/trace/trace_probe.c) is the 
following, it simply passes the respective data to trace_seq_printf with 
a "%s" format string:

int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
{
         int len = *(u32 *)data >> 16;

         if (!len)
                 trace_seq_puts(s, "(fault)");
         else
                 trace_seq_printf(s, "\"%s\"",
                                  (const char *)get_loc_data(data, ent));
         return !trace_seq_has_overflowed(s);
}

I dug into that function with KGDB and found the following: 'data' holds 
the size and offset for the member in question, which is 0xf and 0x18, 
respectively. 'ent' holds the base address for event. When we print the 
string at ent + 0x18, we can see that the output for 'arg1' will be 
"update-notifierupdate-notifier"

Thread 511 hit Breakpoint 6, print_type_string (s=0xffff880078fd1090, 
name=0xffff880078fe4458 "arg1", data=0xffff88007d01f05c, 
ent=0xffff88007d01f04c) at 
/build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
gdb$ p *(uint32_t *) data
$46 = 0xf0018
gdb$ p ent
$47 = (void *) 0xffff88007d01f04c
gdb$ p ((char *)ent + 0x18)
$48 = 0xffff88007d01f064 "update-notifierupdate-notifier"

Moving on printing 'arg2' (e.g., the other $comm string). Here we see 
that the string in question is at offset 0x27, and if we print that, we 
see the correct "update-notifier".

Thread 511 hit Breakpoint 6, print_type_string (s=0xffff880078fd1090, 
name=0xffff880078fe4d70 "arg2", data=0xffff88007d01f060, 
ent=0xffff88007d01f04c) at 
/build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
gdb$ p *(uint32_t *) data
$49 = 0xf0027
gdb$ p ((char *)ent + 0x27)
$50 = 0xffff88007d01f073 "update-notifier"

Looking at the bytes in memory and the offsets it becomes clear that 
there is no \0 byte at the end of the first entry (which would need to 
be at address 0xffff88007d01f064 + 0xf = 0xffff88007d01f073 but instead 
that's the start address of the second entry which simply gets consumed 
by the (first) "%s" as well.

gdb$ x/32x ent
0xffff88007d01f04c:	0x00010592	0x00002143	0xe83522a0	0x00007f7f
0xffff88007d01f05c:	0x000f0018	0x000f0027	0x61647075	0x6e2d6574
0xffff88007d01f06c:	0x6669746f	0x75726569	0x74616470	0x6f6e2d65
0xffff88007d01f07c:	0x69666974	0x00007265	0x0045feee	0x00010592
0xffff88007d01f08c:	0x00002143	0xe83522a0	0x00007f7f	0x000f0018
0xffff88007d01f09c:	0x000f0027	0x61647075	0x6e2d6574	0x6669746f
0xffff88007d01f0ac:	0x75726569	0x74616470	0x6f6e2d65	0x69666974
0xffff88007d01f0bc:	0x00007265	0x0038806e	0x00010592	0x00002143

Should we simply also store the terminating \0 at the end of the string? 
The $comm string is saved by fetch_comm_string (in v4.18) which uses 
'strlcpy' and its return value as the size of the respective data... 
that value however does NOT include the terminating \0 byte (as it's 
simply the return value of a call to strlen). The same holds for 
"regular" string arguments where the code uses 'strncpy_from_user' which 
has the same return value semantics. Or should we use the information in 
'len' to only print that many characters?

As fetch_store_string has changed between v4.18 and v4.20, I could try 
to reproduce this with a v4.20 kernel but from looking at the code I 
suspect this should be the problem in v4.20 as well.

As for $comm only printing "(fault)" I suspect this has to do with 
commit 533059281ee5 ("tracing: probeevent: Introduce new argument 
fetching code") as we lost the 'fetch_comm_string' function in that 
commit and (I think, didn't have the newer kernel running yet) go 
through 'fetch_store_string' now. This calls 'strncpy_from_user' instead 
of accessing current->comm directly (and thus does not succeed in 
fetching it). I'm adding Masami to Cc: as the author of said patch.

> 
> On the "standard" kernel shipped with Ubuntu 18.04 (4.18) printing $comm works but also "accumulates" (in lack of a better word) the later string arguments in the earlier output arguments, so for the probe above arg1 would be "testtestlibc.so.6libc.so.6", arg2 would be "testlibc.so.6libc.so.6" and arg3/arg4 will be the same as in the output above.
> 
> Is there anything in the documentation why multiple string outputs might not work with uprobes? Am I installing the uprobe wrong? Or is this a bug?
> 
> I found that the kprobe selftest at tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc contains a similar situation for kprobes (it prints the parameter two times) which works fine on the same system.
> 
> Regards,
> 
> Andreas 


Regards,

Andreas
