Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B422222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a4rSZM8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392216AbfBPAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:22:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40968 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbfBPAWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:22:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so1996792ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZu9yKf7/y1PhxZ/QIrEDwuJyhP/izVcuc3XltvUjmQ=;
        b=a4rSZM8vUfxX3uByi7RoJOEoa6DxrIjJRc2yfnndHKn6V212rZYOuPHWhH4kyRMrG2
         BisntrNaR1SEXoRrhAdRMhxsZaQnrY4RN21oq1TADbYda+q7ZPaW3MkyfV3T+QRnF6nP
         2yMAGCpEucf5N0GKlPW2BDpJYUlSNqCDuX1oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZu9yKf7/y1PhxZ/QIrEDwuJyhP/izVcuc3XltvUjmQ=;
        b=BUUVbtfe5/CH3VhI9aNMM0tbWKQ5CTUmRQ0hI7/CBrljYNtHHdlaCdxGlx+J6jzzUf
         DGX31u5Dh0cReBfsxZ4K0oQLLFGj7hl1dgYhIPuJvJdyel61jnjtq7FvXaWX10CI8rG5
         MngK2VMll47Iou8+aPUHlbv/MNhU6wdbVQ1LNtf5NWCOLp9QlW7jn7/anb3+5VH+XAlR
         PUANsNSA64a3DCxXDCR4pmJ/5mr8AOjMSZH6rgCTc1aCUiTU24GZrKKPM95ffc043IN3
         sIGPmXDNWD8V4lTHzXmhHcck1lZ3+dw3wWHJZavVULIFI3uZ+EaFguUg9MPfBIsnBzUQ
         XJLw==
X-Gm-Message-State: AHQUAuZMJIZSa+Ur+ADtwBtvNvXenyErgTsqiHdVPXxg+zUpqGid0aKM
        qVts2NP26YTHoYiQEDBW22Dix9hGSSo=
X-Google-Smtp-Source: AHgI3IaB5CTH5CAnG4O/OQCbwOe0R+wpge+K2Zr21lsfRFvj/0qTmi9bKWVgn+zLGYWqzMqwiR7hZA==
X-Received: by 2002:a2e:9a8b:: with SMTP id p11mr7155427lji.66.1550276525180;
        Fri, 15 Feb 2019 16:22:05 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y1sm1614744ljy.58.2019.02.15.16.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 16:22:04 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id v7so8468337lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:22:03 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr6928685lfe.149.1550276523131;
 Fri, 15 Feb 2019 16:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net> <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net> <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net> <20190215233414.GS32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190215233414.GS32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 16:21:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
Message-ID: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Now, EFLAGS bit 1 is supposedly always 1, but it really doesn't seem to
> matter for POPF.

Correct, it's "read as 1", you can try to write it and it doesn't matter.

> I went through the other flags, and aside from VIP/VIF (I've no clue),
> they looks like 0 should be just fine.

So 0 is a perfectly valid initializer in the sense that it _works_, I
just want it to be something that was thought about, not just a random
"initialize to zero" without thinking.

Even just a comment about it would be fine. But it might also be good
to show that it's an explicit eflags value and just use
X86_EFLAGS_FIXED as the initializer.

            Linus
