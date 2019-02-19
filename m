Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C37521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BKQ5k3rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfBSAYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:24:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44840 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfBSAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:24:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id g2so13565848lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWtVNlWHc7fMabRJchZACsoQQvMj00mpuBH8OR27Rrs=;
        b=BKQ5k3rx3PKMMa2Z8P74CHG3KZv3WpJQaUKxrWr5339afGy0C4a1nOr2Fvp87bTD2l
         h3zzPJ7Kf71J9HwhI+rsPQEAJE3rWVzUKH4K7K8Gk4FfNwmubeZHzem+zRVFunpaMSG3
         i1muoIcRoYoZ6nHfy2PLOvTpJfoRTlDSYhUUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWtVNlWHc7fMabRJchZACsoQQvMj00mpuBH8OR27Rrs=;
        b=neqcdw1RKuYx9gqnmhxbm4INrcFZtPayyD2gGzJRmvS0mKyVbz8y9Zz+GTclRrv3Vm
         ZR08FiO/dylow1QE2yvayvw99mjFdEO3aeYJ4cT7FZuQiTY6XfW26LD9vx3XICfgpGK2
         9Pyhx1dWEbcxE330oyAAnpDZqgj4ysGSozC9wWAQR9xDv6fTk07gQGc8M78jelS1cC+u
         FpJEQzgqRj3YN8icybQ8BkahkDwYW3f39cn+dRL3i00GjyMOUpCpb+Ph1mnxGBr4lVwK
         bspnKs43h2We3AGw5KkUi1Abc2kcpBEh6HsMSVLfYBf4kC+mqwZMWfOwwIfHHW/rkLNP
         vCpA==
X-Gm-Message-State: AHQUAuY8bvRN3O5fhVBD+Ps9OBBAZaUBAHeNVszW0O1+VdiqSKyDV7xk
        Hzc0dgC9zdCPsfa3UnNyXGog+eRHu80=
X-Google-Smtp-Source: AHgI3IZ+mI1rgUp9d8V/xnTw0PqpibGP+jyLQ62s/EIr++jo4PxU+loJWUqC57wmbWvCoKGcSVSTBg==
X-Received: by 2002:a19:911c:: with SMTP id t28mr15759702lfd.78.1550535887875;
        Mon, 18 Feb 2019 16:24:47 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a22sm2351982lfi.73.2019.02.18.16.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:24:46 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z20so14860545ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:24:46 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr13676200ljg.94.1550535886008;
 Mon, 18 Feb 2019 16:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net> <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
In-Reply-To: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 16:24:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Message-ID: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> The question is what "fix it" means. I'm really concerned about AC escapes,
> and everyone else should be, too.

I do think that it might be the right thing to do to add some kind of
WARN_ON_ONCE() for AC being set in various can-reschedule situations.

We'd just have to abstract it sanely. I'm sure arm64 has the exact
same issue with PAN - maybe it saves properly, but the same "we
wouldn't want to go through the scheduler with PAN clear".

On x86, we might as well check DF at the same time as AC.

              Linus
