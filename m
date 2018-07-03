Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770B421A36
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IFgY5Sm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770B421A36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934446AbeGCR77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:59:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35239 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbeGCR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:59:57 -0400
Received: by mail-it0-f67.google.com with SMTP id l16-v6so4426815ita.0;
        Tue, 03 Jul 2018 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTLur/l3gfciEikX6eGS5zyUwbJoC4xUFEYCGZ3X4hg=;
        b=IFgY5Sm8i7qwFCLczmLQqV81O1cIS6fe0Ya3ko9CJAwXlllXq+prrZAJKwDl73U7iB
         SmPcyqJg1h1eIgINOoduYR/WiQ1BX0iLnVAkVPLqev4TwMraUxraaSjIwZvkqpkhKyRI
         0cBkboVAm5YwGkXk9SEwpkni39Twn2iYSOkss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTLur/l3gfciEikX6eGS5zyUwbJoC4xUFEYCGZ3X4hg=;
        b=Ri5tW6fOpE+wRyGv8SJX8RML8D4XvS2pYVnT3/KXO6WwsCOV0+BGXY6wLitygsCqfu
         RCEoNbLpqSQslD642k3lg8n500eZcduwAHifyImGHe7bY7pZg8ILYzsBICiyc8cqkaBV
         fc7NAquWYuAwBl956uBnu4Yx6uN5uJKnOxG+Fir2ZlRJ2WMeTojd4FnOJrN4zBNwt22g
         8D9d5DDSQzQ69Av+lmazt85T+OC8ZLjoVs277e3juYFvwQvX3BDBiQ5SdyT746uiTTGW
         PfdXOoji2Aan8wfaDoVaZ9LJguGRZLx1Pw1zgXwGIemaNk9SXsPYeJTgqz56AFVsPuYO
         3bAg==
X-Gm-Message-State: APt69E0u2h2U0DuFnNeUANk+CmHxo7+IkRpRrvaMRruovfeJtN489Cs1
        tHQISLqDfHWZ60/do4467ynOmx6upxy93yzPU+s=
X-Google-Smtp-Source: AAOMgpcAxDlfGgIywrQX+oJl4jIhc2Rj27OLbHTEGr8jMdX6SpIhc9SBLyG0jqJCpXaykYsRaVDtrgrWVQjikk80dFk=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr25793644jaf.70.1530640796985;
 Tue, 03 Jul 2018 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <20180703082955.GH3704@osiris> <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris> <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net> <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
 <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jul 2018 10:59:45 -0700
Message-ID: <CA+55aFxcVbG2DMmmrW-HLTXZE+rcBWc5F48UYoL2heEsEpyO=g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andi Kleen <andi@firstfloor.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 10:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > I can simply document that loads/stores from/to all struct rseq fields
> > should be thread-local then ?
>
> I'm not sure that covers things sufficiently. You really want the
> userspace load/stores to be single instructions.

Actually, I think we should try very hard to limit even that to _just_
the rseq pointer itself.

Everything else can be filled in ahead of time with non-atomic stores,
and then the last thing that happens - and the only thing that wants
that final "one last atomic write" is the rseq pointer write.

No?

So I'd suggest that the only part we aim to have any "atomic" behavior
at all is for the individual fields in "struct rseq" itself. So the
cpu id and the base pointer and the flags. And even they are
thread-local, so the atomicity is not about the kernel, but about user
space needing to read and update them in word-sized chunks.

End result: absolutely nothing is atomic for the kernel.

                 Linus
