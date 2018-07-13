Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DE1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167C22089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBpQNfQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGNAHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:07:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34051 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbeGNAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:07:01 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so65252248ois.1;
        Fri, 13 Jul 2018 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hUf/o21pbN/wqjp3RMv4x0Lv8IGoryFqN+JLzDari6o=;
        b=gBpQNfQcABvsGp6kvGfY2U3DBgqMhOMSdTTWFRqC4J8mFxkQaTBd0b8Rts8QaV/BcB
         RLnZHrPDoTpkXm6O7pFi3TTB8qR1lpNo+kr2yEQ5TUC8QO2wwzmAKmYJhMlEwKaStoDD
         7sGJKw5Xv3lltEssCNZrNmYaMJgvtDjyNdNgyzUKd+zMJ5K8lbKs6SItxqyj3yfOaSAP
         hQ+u+jJrP+moFpRC7MIbcwBRBARF5QYT4hy74DrgBF73OWuFbRgMumNiCRh6UUhb1JzI
         r3ZSM4P3pUAPHgtqs1EkcDmwAkfiQEjKThAUETdYJ8ZUCzT7xyoYZfzgcD5CC17/ToUH
         lcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hUf/o21pbN/wqjp3RMv4x0Lv8IGoryFqN+JLzDari6o=;
        b=k/2iLKmkHku3qyq6JEWj6jItJp8tmziE14N4KjlCDWmnia2iMn080Rnv1gwjEYsbzX
         jLTHGOjF8HK/yYuAFoYvk+vWiU1EpaFDLoC97x+ZGiPTl6nqzw/J3ix6Nr7kgJ665TMU
         KWKdQJW5M1PvccQjHnuHNktWKzSlPtyYWeSPU9Nivr8ID0cxptxSmnkZS0beYjQ+9fV6
         hJUG+Pb1NNipXhtHwknBeJo4pbizfw0cISCdfiryYiTEL2w7HDr3rlqBSb69Apl3RkpC
         E7W9SZQ34Ld8DSxYVjWAmzBZmZ0iBjMoHA7/LJWh8pgpjX05h03OgEigbXHrawJwBmQi
         td9w==
X-Gm-Message-State: AOUpUlGjrsJU5XfMsG3b+1LMPaQuXyG1b7paNE0/rYOqSxtEfdVLiNpV
        R+AMHmif361LiLQe2Go3Tq/UGCYQaLEXvLmekKE=
X-Google-Smtp-Source: AAOMgpdU6yD87M58cppkdz+YTdqrTgDYBOXEP1ZMdvahKEQwBarrBc47PWvztwOaAeGfgTmysjufXqmV92WDyKRHi6E=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr9503995oih.161.1531525809726;
 Fri, 13 Jul 2018 16:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5e0c:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:50:09
 -0700 (PDT)
In-Reply-To: <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com> <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com> <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com> <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com> <20180712145849.GB15265@redhat.com>
 <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com> <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 13 Jul 2018 16:50:09 -0700
Message-ID: <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:55 AM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
> On 07/13/2018 01:23 AM, Song Liu wrote:
>> I guess I got to the party late. I found this thread after I started developing
>> the same feature...
>>
>> On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 07/11, Ravi Bangoria wrote:
>>>>
>>>>> However, I still think it would be better to avoid uprobe exporting and modifying
>>>>> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>>>>> I'll re-check...
>>>>
>>>> Good that you bring this up. Actually, we can implement same logic
>>>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>>>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>>>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>>>> need to pass arch_uprobe object to uprobe_write_opcode().
>>>
>>> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
>>> arg to uprobe_write_opcode(). OK, this is fine.
>>>
>>>
>>>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>>>> or a consumer property, before posting v6:
>>>>
>>>> If we make it a consumer property, the design becomes flexible for
>>>> user. User will have an option to either depend on kernel to handle
>>>> reference counter or he can create normal uprobe and manipulate
>>>> reference counter on his own. This will not require any changes to
>>>> existing tools. With this approach we need to increment / decrement
>>>> reference counter for each consumer. But, because of the fact that our
>>>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>>>> to keep track of which reference counter have been updated in which
>>>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>>>> {uprobe, consumer, mm}.
>>
>> Is it possible to maintain balanced refcount by modifying callers of
>> install_breakpoint() and remove_breakpoint()? I am actually working
>> toward this direction. And I found some imbalance between
>>      register_for_each_vma(uprobe, uc)
>> and
>>      register_for_each_vma(uprobe, NULL)
>>
>> From reading the thread, I think there are other sources of imbalance.
>> But I think it is still possible to fix it? Please let me know if this is not
>> realistic...
>
>
> I don't think so. It all depends on memory layout of the process, the
> execution sequence of tracer vs target, how binary is loaded or how mmap()s
> are called. To achieve a balance you need to change current uprobe
> implementation. (I haven't explored to change current implementation because
> I personally think there is no need to). Let me show you a simple example on
> my Ubuntu 18.04 (powerpc vm) with upstream kernel:
>
> -------------
>   $ cat loop.c
>     #include <stdio.h>
>     #include <unistd.h>
>
>     void foo(int i)
>     {
>             printf("Hi: %d\n", i);
>             sleep(1);
>     }
>
>     void main()
>     {
>             int i;
>             for (i = 0; i < 100; i++)
>                     foo(i);
>     }
>
>   $ sudo ./perf probe -x ~/loop foo
>   $ sudo ./perf probe install_breakpoint uprobe mm vaddr
>   $ sudo ./perf probe remove_breakpoint uprobe mm vaddr
>
>   term1~$ ./loop
>
>   term2~$ sudo ./perf record -a -e probe:* -o perf.data.kprobe
>
>   term3~$ sudo ./perf record -a -e probe_loop:foo
>           ^C
>
>   term2~$ ...
>           ^C[ perf record: Woken up 1 times to write data ]
>           [ perf record: Captured and wrote 0.217 MB perf.data.probe (10 samples) ]
>
>   term2~$ sudo ./perf script -i perf.data.kprobe
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
> -------------
>
> Here install_breakpoint() for our target (mm: 0xc0000000b5072900) was
> called 2 times where as remove_breakpoint() was called 6 times.
>
> Because, there is an imbalance, and if you make reference counter a
> consumer property, you have two options. Either you have to fix
> current uprobe infrastructure to solve this imbalance. Or maintain
> a list of already updated counter as I've explained(in reply to Oleg).
>
> Now,
>
>   uprobe_register()
>     register_for_each_vma()
>       install_breakpoint()
>
> gets called for each consumer, but
>
>   uprobe_mmap()
>     install_breakpoint()
>
> gets called only once. Now, if you make ref_ctr_offset a consumer
> property, you have to increment reference counter for each consumer
> in case of uprobe_mmap(). Also, you have to make sure you update
> reference counter only once for each consumer because install/
> remove_breakpoint() are not balanced. Now, what if reference
> counter increment fails for any one consumer? You have to rollback
> already updated ones, which brings more complication.

Hmm... what happens when we have multiple uprobes sharing the same
reference counter? It feels equally complicate to me. Or did I miss any
cases here?


>
> Now, other complication is, generally vma holding reference counter
> won't be present when install_breakpoint() gets called from
> uprobe_mmap(). I've introduced delayed_uprobes for this. This is
> anyway needed with any approach.

Yeah, I am aware of this problem. But I haven't started looking into a fix.

>
> The only advantage I was seeing by making reference counter a
> consumer property was a user flexibility to update reference counter
> on his own. But I've already proposed a solution for that.
>
> So, I personally don't suggest to make ref_ctr_offset a consumer
> property because I, again personally, don't think it's a consumer
> property.
>
> Please feel free to say if this all looks crap to you :)
>

These all make sense. Multiple consumer case does make the problem
a lot more complicated

For the example you showed above (~/loop:foo), will the following patch
fixes the imbalance? It worked in my tests.

Thanks,
Song

From 664b087cff0d458c0360a6834140a2a88dff478e Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Thu, 12 Jul 2018 11:16:51 -0700
Subject: [PATCH] perf/core,uprobe: fix imbalanced install_breakpoint and
 remove_breakpoint

When uprobes are used by perf event, it is handle as follows:

Enable path:
1. perf_event_open() => TRACE_REG_PERF_REGISTER => probe_event_enable()
2. PERF_EVENT_IOC_ENABLE => TRACE_REG_PERF_OPEN => uprobe_perf_open()

Disable path:
3. PERF_EVENT_IOC_DISABLE => TRACE_REG_PERF_CLOSE => uprobe_perf_close()
4. close(fd) => TRACE_REG_PERF_UNREGISTER => probe_event_disable()

In this routine, install_breakpoint() is called once at step 2; while
remove_breakpoint is called twice at both step 3 and step 4.

This patch tries to resolve this imbalance by passing extra flag
"restore_insn" to probe_event_disable().

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/uprobes.h     |  6 ++++--
 kernel/events/uprobes.c     | 21 +++++++++++++++------
 kernel/trace/trace_uprobe.c | 14 ++++++++++----
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e950df8..2b7a67b64877 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -124,7 +124,8 @@ extern unsigned long uprobe_get_trap_addr(struct
pt_regs *regs);
 extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long
vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset,
struct uprobe_consumer *uc);
+extern void uprobe_unregister(struct inode *inode, loff_t offset,
+                  struct uprobe_consumer *uc, bool);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long
start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -166,7 +167,8 @@ uprobe_apply(struct inode *inode, loff_t offset,
struct uprobe_consumer *uc, boo
     return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc)
+uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc,
+          bool restore_insn)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..988f5a5acaca 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -846,14 +846,16 @@ static int __uprobe_register(struct uprobe
*uprobe, struct uprobe_consumer *uc)
     return register_for_each_vma(uprobe, uc);
 }

-static void __uprobe_unregister(struct uprobe *uprobe, struct
uprobe_consumer *uc)
+static void __uprobe_unregister(struct uprobe *uprobe, struct
uprobe_consumer *uc,
+                bool restore_insn)
 {
-    int err;
+    int err = 0;

     if (WARN_ON(!consumer_del(uprobe, uc)))
         return;

-    err = register_for_each_vma(uprobe, NULL);
+    if (restore_insn)
+        err = register_for_each_vma(uprobe, NULL);
     /* TODO : cant unregister? schedule a worker thread */
     if (!uprobe->consumers && !err)
         delete_uprobe(uprobe);
@@ -906,7 +908,11 @@ int uprobe_register(struct inode *inode, loff_t
offset, struct uprobe_consumer *
     if (likely(uprobe_is_active(uprobe))) {
         ret = __uprobe_register(uprobe, uc);
         if (ret)
-            __uprobe_unregister(uprobe, uc);
+            /*
+             * only do remove_breakpoint (restore_insn)
+             * when failed in install_breakpoint (ret > 0)
+             */
+            __uprobe_unregister(uprobe, uc, ret > 0);
     }
     up_write(&uprobe->register_rwsem);
     put_uprobe(uprobe);
@@ -951,8 +957,11 @@ int uprobe_apply(struct inode *inode, loff_t offset,
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
+ * @restore_insn: shall we restore original instruction with
+ *                register_for_each_vma(uprobe, NULL)
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc)
+void uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc,
+               bool restore_insn)
 {
     struct uprobe *uprobe;

@@ -961,7 +970,7 @@ void uprobe_unregister(struct inode *inode, loff_t
offset, struct uprobe_consume
         return;

     down_write(&uprobe->register_rwsem);
-    __uprobe_unregister(uprobe, uc);
+    __uprobe_unregister(uprobe, uc, restore_insn);
     up_write(&uprobe->register_rwsem);
     put_uprobe(uprobe);
 }
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51e740d..fb6fb9d00cdc 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -938,7 +938,8 @@ probe_event_enable(struct trace_uprobe *tu, struct
trace_event_file *file,
 }

 static void
-probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
+probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file,
+            bool restore_insn)
 {
     if (!trace_probe_is_enabled(&tu->tp))
         return;
@@ -961,7 +962,8 @@ probe_event_disable(struct trace_uprobe *tu,
struct trace_event_file *file)

     WARN_ON(!uprobe_filter_is_empty(&tu->filter));

-    uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+    uprobe_unregister(tu->inode, tu->offset, &tu->consumer,
+              restore_insn);
     tu->inode = NULL;
     tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;

@@ -1197,7 +1199,7 @@ trace_uprobe_register(struct trace_event_call
*event, enum trace_reg type,
         return probe_event_enable(tu, file, NULL);

     case TRACE_REG_UNREGISTER:
-        probe_event_disable(tu, file);
+        probe_event_disable(tu, file, true);
         return 0;

 #ifdef CONFIG_PERF_EVENTS
@@ -1205,7 +1207,11 @@ trace_uprobe_register(struct trace_event_call
*event, enum trace_reg type,
         return probe_event_enable(tu, NULL, uprobe_perf_filter);

     case TRACE_REG_PERF_UNREGISTER:
-        probe_event_disable(tu, NULL);
+        /*
+         * Don't restore instruction, as TRACE_REG_PERF_CLOSE
+         * already did that.
+         */
+        probe_event_disable(tu, NULL, false /* restore_insn */);
         return 0;

     case TRACE_REG_PERF_OPEN:
-- 
2.17.1
