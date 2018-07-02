Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4CB25A60
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KzjV7nkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4CB25A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeGBUXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:23:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45594 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGBUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:23:01 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so15794547ioh.12;
        Mon, 02 Jul 2018 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QF5l3yU2aMDNxSqAlUSxWtCE9gKfVxcgj2EprIdGy8=;
        b=KzjV7nkOpoylKEVuDgEWoHdX2pAaquTUHU228ie3kbhD56MOAuiOXBl3ABlu0ssVOr
         fxHClaQodcjIc2bRA4pp9d8ZmCqmGPL4wYyKnEqxkffKQr0Mo7ZB8rnCBeowGJyLhvwC
         96m7rgj2OVIq5B5sIozmgdpPtKslDgePOuz18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QF5l3yU2aMDNxSqAlUSxWtCE9gKfVxcgj2EprIdGy8=;
        b=AXuf2ZZ+jHNP+Wm+q+koO0V4Cgxr9WJB673p6Ld7iK+8mr4cLF+upCPDKtjTpAEtSC
         1EA015IYyTjifZ2piv7Z4Sc5NrplmZgA/1wivCEvWmfo84KbVv+1oq/gTIb6UwYYi64C
         NIJ0PcieeXzHED6vKg8vy/E04ui0G0TB4gadNsheyiYPMBFHRwmcR6U+uEwtPMC9dMi/
         EIYZJPCygHmScbqq45FZptkXnIZM+NYP2O69hvLdQ1ppGtyEhehypkgUCYxnoQ+wc6Da
         ZHHbzfrg9y07rlpeX/Gv6r8cf7f6QEUx05Ni0AgLa34tKntRGDOE4hflzthiFIhxsQTs
         fV3A==
X-Gm-Message-State: APt69E1a8RLdPng79Ia4r6W8kIFLbH46jXitj2SplS+5JY2YmknSiiM6
        3BMdG+O14+wtmK0t1ph2DHNzhW7YzGzIL2h0xyA=
X-Google-Smtp-Source: AAOMgpcsWGs6vnUNAGcmFF+yDPdRv0SRzJRdQ2HvvLDpY4wWhic+nlcXFw288kkTwqIIbtsEMrlMpYvL7WwkfNI0iw0=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr23230886ion.259.1530562980936;
 Mon, 02 Jul 2018 13:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
 <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
 <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
 <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
 <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com>
 <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
 <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com>
 <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com>
 <CALCETrVMhU8SrZBXOXxJerrZpQ71A_f_cRBCU=Lmj_KPV0+rRA@mail.gmail.com>
 <CA+55aFy2rxnLhbqGtz0wxW_u=x_A1zHZBNP8ZC5P12_AHyb3PA@mail.gmail.com> <CALCETrWps4Bvd_hGviEZ+60nQFr5ovp2A0+afDWg-QOHB9x7cA@mail.gmail.com>
In-Reply-To: <CALCETrWps4Bvd_hGviEZ+60nQFr5ovp2A0+afDWg-QOHB9x7cA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 13:22:49 -0700
Message-ID: <CA+55aFwvsNY7eLm3OevWQvijPN_HQA4KgfZ5k-RTVPjD8MKppg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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

On Mon, Jul 2, 2018 at 1:13 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Like this:
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 3b2490b81918..ec40223c8856 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -170,6 +170,26 @@ static void exit_to_usermode_loop(struct pt_regs
> *regs, u32 cached_flags)
>          if (cached_flags & _TIF_USER_RETURN_NOTIFY)
>              fire_user_return_notifiers();
>
> +        if (unlikely(!user_64bit_mode(regs) &&
> +                 (regs->ip & 0xffffffff00000000ull))) {

I'd be afraid that code generation is atrocious. So more something like this:

    static noinline send_sigsegv(..) { }

    ...
    if (unlikely(!user_64bit_mode(regs)) {
        if (unlikely(*(1+(u32 *)&regs->ip)))
            send_sigsegv(tsk);

to make sure it doesn't do crazy big constants in the normal path, and
doesn't allocate silly stack frames.

But as mentioned, I'm not entirely convinced this is worth it. But I
wasn't sure it's worth it for rseq.

So basically, *if* we do these kinds of checks, I'd personally rather
do a *generic* "we don't return to garbage 64-bit values in compat
mode" than have special case code that is only for rseq and is truly
irrelevant to all normal cases.

The generic case might even be worth a test-case. And if we do that,
we should probably check that we don't do something odd like
sign-extending the %rip value we load from stack for signal return
etc, that just happens to work because nobody cared about the upper
bits.

So there's a lot of these kinds of small details that are of
questionable importance, but might in theory be worth it.

                  Linus
