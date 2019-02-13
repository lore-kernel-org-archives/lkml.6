Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B9C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7D5222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kxqN8lti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbfBMB2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:28:15 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37946 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfBMB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:28:14 -0500
Received: by mail-vk1-f195.google.com with SMTP id x140so168040vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu+svnKxVKYT8wC4ZGj9pPlfWTxgQM5sbKPgFtoLatQ=;
        b=kxqN8ltijlZ4ooIJgzCFqgoQ2S/lcxTW9mvoDUpxWXNN1O53y3JJMjnKnRz77y3F06
         u56J4COldp54Qn/wnIC7BQNt1/Vs1UEAk+0j17abPGaAKmncuopBreDSLqFm2zCCdeIS
         H3HVeig19u7ixPHhipxv2dNMk9HzUOo79Aagk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu+svnKxVKYT8wC4ZGj9pPlfWTxgQM5sbKPgFtoLatQ=;
        b=YoDRtMxV+2y2pTEI63bbFX9qOJc8U8iCXWJTuGRxX2beszBuK9Ui0v5zNqVH1Vj34r
         Vt515XOjgOyXa+xCB3GGkvpenG2sIoYMwrctlc5c62tmgLiBwa2SnNIwzrgrEaXnKS2b
         1W+fWqqwhAiZqKcneD72fmCyX3+9KniBD+ARWYH2ZjSKu/D7Y7eLU/OqrksRt25h4r61
         ArKLMxwRBczUpRfG0/Nw9HoeOEv+7tzJB3SAOTavRqHbxmia+02j27x2gZNxUPYoXrej
         cw+P5SPAUms/Q2xRkkdVKBb1mQUw16Czvya5/8bEqk7dMtbrIoumtcZ607ilNh10k+w8
         YUdA==
X-Gm-Message-State: AHQUAuYEsic8jzgcO63WWDVf5c2h4jEgZgzo1H1fBJckjBzSDJ093iKx
        VdgMHClV4Lj3kZZIe8pSBsOS006Rf70=
X-Google-Smtp-Source: AHgI3IbNI61KTe8/XmzFpvwVlX8aQFvdNlRTJ5EsyvtbDeyHdS/LaEDLs6uBRkHl1gMrgSMlihL81w==
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr2788684vke.73.1550021291559;
        Tue, 12 Feb 2019 17:28:11 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id l197sm16233583vke.18.2019.02.12.17.28.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 17:28:10 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id z24so231959ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 17:28:09 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr2778563uan.114.1550021289318;
 Tue, 12 Feb 2019 17:28:09 -0800 (PST)
MIME-Version: 1.0
References: <001a1140589435c9b60563c76e3f@google.com> <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
In-Reply-To: <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 17:27:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ-+P+p_SsO1X-LJ43RbEG2cYbiV_EYubWoh3mUVRBK9A@mail.gmail.com>
Message-ID: <CAGXu5jJ-+P+p_SsO1X-LJ43RbEG2cYbiV_EYubWoh3mUVRBK9A@mail.gmail.com>
Subject: Re: WARNING in event_function_local
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 10:18 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Jan 27, 2018 at 8:58 PM, syzbot
> <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot hit the following crash on bpf-next commit
> > 8223967fe0b8eb2448cca5cfe3c64a0838e6f60d (Sat Jan 27 01:06:23 2018 +0000)
> > Merge branch 'fix-lpm-map'
> >
> > So far this crash happened 2 times on bpf-next.
> > C reproducer is attached.
> > syzkaller reproducer is attached.
> > Raw console output is attached.
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
>
>
> This was bisected to:
>
> commit 4ee7c60de83ac01fa4c33c55937357601631e8ad
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Fri Mar 23 10:18:03 2018 -0400
>
>     init, tracing: Add initcall trace events
>
>
>
> > WARNING: CPU: 1 PID: 5105 at kernel/events/core.c:331
> > event_function_local.constprop.102+0x494/0x560 kernel/events/core.c:331
> > Kernel panic - not syncing: panic_on_warn set ...
> >
> > CPU: 1 PID: 5105 Comm: syzkaller318382 Not tainted 4.15.0-rc8+ #8
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:17 [inline]
> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >  panic+0x1e4/0x41c kernel/panic.c:183
> >  __warn+0x1dc/0x200 kernel/panic.c:547
> >  report_bug+0x211/0x2d0 lib/bug.c:184
> >  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
> >  fixup_bug arch/x86/kernel/traps.c:247 [inline]
> >  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
> >  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1096
> > RIP: 0010:event_function_local.constprop.102+0x494/0x560
> > kernel/events/core.c:331
> > RSP: 0018:ffff8801db307d00 EFLAGS: 00010006
> > RAX: ffff8801d902a180 RBX: ffff8801d60beac0 RCX: ffffffff81862a54
> > RDX: 0000000000010000 RSI: ffff8801db3079f0 RDI: ffff8801d60bebc8
> > RBP: ffff8801db307da0 R08: 1ffff1003b660edf R09: 000000000000000c
> > R10: ffff8801db307bb8 R11: 0000000000000044 R12: ffff8801db330e00
> > R13: 1ffff1003b660fa3 R14: ffff8801d90841c0 R15: ffff8801d979ce40
> >  perf_event_disable_local kernel/events/core.c:1979 [inline]
> >  perf_pending_event+0x1e5/0x240 kernel/events/core.c:5446
> >  irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
> >  irq_work_run+0x1d/0x50 kernel/irq_work.c:170
> >  smp_irq_work_interrupt+0x103/0x640 arch/x86/kernel/irq_work.c:21
> >  irq_work_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:968
> >  </IRQ>

I got curious why this report went silent, and bisected the "fix" to:

214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")

This contains new tracepoints, and reverting them re-exposes the bug:

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 89d20ed1d2e8..462fab402bfa 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1468,15 +1468,21 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu
*current_vcpu, u64 ingpa, u64 outgpa,
                all_cpus = false;
                valid_bank_mask = BIT_ULL(0);

+               panic("how am I using hyperV?!");
+               /*
                trace_kvm_hv_send_ipi(vector, sparse_banks[0]);
+               */
        } else {
                if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
                                            sizeof(send_ipi_ex))))
                        return HV_STATUS_INVALID_HYPERCALL_INPUT;

+               panic("how am I using hyperV?! (ex)");
+               /*
                trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
                                         send_ipi_ex.vp_set.format,
                                         send_ipi_ex.vp_set.valid_bank_mask);
+               */

                vector = send_ipi_ex.vector;
                valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 6432d08c7de7..895bd184feea 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1424,6 +1424,7 @@ TRACE_EVENT(kvm_hv_flush_tlb_ex,
 /*
  * Tracepoints for kvm_hv_send_ipi.
  */
+#if 0
 TRACE_EVENT(kvm_hv_send_ipi,
        TP_PROTO(u32 vector, u64 processor_mask),
        TP_ARGS(vector, processor_mask),
@@ -1462,6 +1463,7 @@ TRACE_EVENT(kvm_hv_send_ipi_ex,
                  __entry->vector, __entry->format,
                  __entry->valid_bank_mask)
 );
+#endif
 #endif /* _TRACE_KVM_H */

 #undef TRACE_INCLUDE_PATH

Steve, what could possibly be happening here? Just adding more
tracepoints causes some kind of race where the task vs current test
trips in event_function_local():

                        if (WARN_ON_ONCE(task != current))
                                goto unlock;

Is this maybe just an unlucky condition with the event loop running in
an IRQ? Should the WARN be expected, or is running under an IRQ
unexpected?

It'd be nice to find the source of this, since it seems to have gotten
papered over instead of actually fixed. (Especially since the original
"introduction" bisect shows similar "just adding new trace events.)

-- 
Kees
