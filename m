Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F24279D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bjM0dScq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F24279D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965042AbeF1VWl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:22:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41675 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeF1VWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:22:39 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so6576694ioa.8;
        Thu, 28 Jun 2018 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KqTMhO9wk67UjDyc7BMCZLUZ/ESiYpnMwRgq8QjpC4=;
        b=bjM0dScqjgyQzjsCnyR3RBAY6SactJHLi+WxXFAoYRIPgepdFfGY2eOHqyxcNUdrlV
         /+en2oZKLtK+3E3BQ3gOGys1mZnpeGe+7f9lko8SJcr9+Qs/xbQrwGV4nCIwaOk6oyOh
         VQoHoCy7oWsbReJMhX3w39KQTlzpH6IEjqdLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KqTMhO9wk67UjDyc7BMCZLUZ/ESiYpnMwRgq8QjpC4=;
        b=KNJ9cNEXY4Lwe1MCL9C+4FHrLnnqPZ3WXDLAHoE8Bl3Aq0Vy06dntn5aynsmaapcvJ
         C018UjLK1UaECtZoAQGlwBg98E+CwdTsXdroFmXzZvpHZQMAbdDQcYo1ebAIwpf70H0X
         IkhoBrVQ+bDdHyO4u6W9ox2XCfbAY+5da3kChAU+HLZ91WpznYuyJff9Vtkj85FsvZrK
         CQ+L/6T0cA3t2r3Rbp7+L9Xq88uYaFrgvXDLc08ZPDO1l4pn5LcvW+r81FrEzV+tTFSv
         Tyl5/uplFxCxQB0mH1XvZNBVdqW36MtbnXG8iOVZrt9xHMqRcSre6PDJkchcK0f3t/62
         a3aQ==
X-Gm-Message-State: APt69E3mLyEFDjhwWmupiECMQK0pLE33y4/iYWtKEl9tHY3lLH/yiR54
        RqGiuzUejShMkxiWpFci3mF3qYEYKimzEgRDU7Q=
X-Google-Smtp-Source: AAOMgpeLELn0sna72c6voAGpGq88rkIQ3131vXF7BM9PD3E7OsPmhzL+/5v3R2jnjfiUzlDoKdEQ0JH/DkEyBrjPgo4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr10650264iov.203.1530220958881;
 Thu, 28 Jun 2018 14:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
In-Reply-To: <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jun 2018 14:22:27 -0700
Message-ID: <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
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
        Michael Kerrisk <mtk.manpages@gmail.com>, joelaf@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 1:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> This is okay with me for a fix outside the merge window.  Can you do a
> followup for the next merge window that fixes it better, though?  In
> particular, TASK_SIZE is generally garbage.  I think a better fix
> would be something like adding a new arch-overridable helper like:
>
> static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }

We already have that. It's called "user_addr_max()".

It's the limit we use for user accesses.

That said, I don't see why we should even check the IP. It's not like
that's done by signal handling either.

                     Linus
