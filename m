Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A6925026
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKFeO2Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A6925026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGBUNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752728AbeGBUNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:13:14 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F24925011
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530562394;
        bh=GL6sljJ+sc2/09UHtzjReksrt2mF39MV4+AyIF1RMtM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CKFeO2JjAGTQo+iIxC/TWPyYTqy0FIVzpUzVP037RKgw7qF9T0Raixo2acu/OtpCP
         LJePLluJ3nOkiZzh/CnuALxcrm/3puj/8RfiPtHN9/z2ZdQkvrUasxvcLUbP1+QWaX
         0WZ+Rc3uUJvuuyxLn+nP6xAUJITb1wP28fIq3BnM=
Received: by mail-wm0-f46.google.com with SMTP id w16-v6so30179wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:13:13 -0700 (PDT)
X-Gm-Message-State: APt69E3v8fTQ1UxyvCNXRL4iFHjxIixi4i6QMEXHChmZ8QaNE5N0zFm2
        BZRlM1k4Y5h7F3DbDN0kPkmBNFp7xKtuOn/lfaZXYg==
X-Google-Smtp-Source: AAOMgpe4ri2oTYTiGqz8B7cBvrAvq6tGLhxd4+7rRnyrcKjnmpAbB/V60T5Bf78pNaHPj6Wukey6emPyHTnejK2kUSQ=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr9553382wma.21.1530562392517;
 Mon, 02 Jul 2018 13:13:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 13:12:51 -0700 (PDT)
In-Reply-To: <CA+55aFy2rxnLhbqGtz0wxW_u=x_A1zHZBNP8ZC5P12_AHyb3PA@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
 <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
 <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
 <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
 <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com>
 <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
 <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com>
 <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com>
 <CALCETrVMhU8SrZBXOXxJerrZpQ71A_f_cRBCU=Lmj_KPV0+rRA@mail.gmail.com> <CA+55aFy2rxnLhbqGtz0wxW_u=x_A1zHZBNP8ZC5P12_AHyb3PA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 2 Jul 2018 13:12:51 -0700
X-Gmail-Original-Message-ID: <CALCETrWps4Bvd_hGviEZ+60nQFr5ovp2A0+afDWg-QOHB9x7cA@mail.gmail.com>
Message-ID: <CALCETrWps4Bvd_hGviEZ+60nQFr5ovp2A0+afDWg-QOHB9x7cA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:31 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jul 2, 2018 at 12:02 PM Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> Works for me.  Linus, any objection?
>
> I think the 4.19 stage may be overkill, but I don't hate it, so no
> real objections.
>
> If the main reason for this is that we silently clear the upper bits
> when returning to compat mode, I actually think that a better fix
> would be to just fix that. We shouldn't silently ignore bogus data in
> the return path.
>
> But I don't care enough, I think.

Like this:

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b81918..ec40223c8856 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -170,6 +170,26 @@ static void exit_to_usermode_loop(struct pt_regs
*regs, u32 cached_flags)
         if (cached_flags & _TIF_USER_RETURN_NOTIFY)
             fire_user_return_notifiers();

+        if (unlikely(!user_64bit_mode(regs) &&
+                 (regs->ip & 0xffffffff00000000ull))) {
+            siginfo_t info;
+            struct task_struct *tsk = current;
+
+            /* I haven't thought about this *that* hard. */
+            clear_siginfo(&info);
+            tsk->thread.cr2    = regs->ip;
+            tsk->thread.trap_nr = X86_TRAP_PF;
+            tsk->thread.error_code = X86_PF_USER | X86_PF_INSTR;
+            info.si_signo = SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = SEGV_MAPERR;
+            info.si_addr = (void __user *)regs->ip;
+            /* si_addr_lsb? */
+            force_sig_info(SIGSEGV, &info, tsk);
+
+            /* And we'll go through the loop again. */
+        }
+
         /* Disable IRQs and retry */
         local_irq_disable();

It's whitespace damaged and barely tested, but it seems to at least
not be completely busted.  I don't really love doing this, though.
