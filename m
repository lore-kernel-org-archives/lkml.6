Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54885C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1835221852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551207795;
	bh=qraLWL7x6cgBw0sq0xSMwbtGX/JgjmzM/vLSsjdQMIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u+NGffQzu9erSpGofvz0XQdVpoO/zVRXxrx4BUQlEYtmInI6KmnM2mG0IC+cc8Lgm
	 jprboaXgGi76O9I4PzQjQLITeAcIeDhbL4XMbZPjvhw4solzEzkfIEI6FGbicirrvg
	 M2jOcSa4aZugmjjf+qmp7caZHiFSCPkpEeNJE47E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfBZTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:03:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46046 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:03:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id d24so11479583ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QwtqDKw1phhWGxijFondHZun3RsglOMlqDBhuBPytk=;
        b=QE6cxKXBqNh8pzJQMGBWdbBf5Hlt0R/hJYq/w8b90acdrSSMDZcB5ujemNHzkNTM2J
         mrrIzLWhk2Gp+4GEuCcK7ZdY8kT84TP/5VJVi1R+ZUj2gKSJZn+hMq53Ev/tzIZfGp/n
         7mLJksYmQu4JPCJpyLsYRzQ1CtiGjZ3R/9vqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QwtqDKw1phhWGxijFondHZun3RsglOMlqDBhuBPytk=;
        b=F9GpDQSxUBnWyn3LCcRrPLx32ochgvsST/9XJhSosNgWLQz5uFjMOGnT43k92HlRle
         c+lpn3VHaFAif8PvPIlPHMXS9Wi6RLNe34R18HF729hwzSykGjivFsF/2jOa+qIgnJBG
         fzGrftU5fo5goHHu+zcJ0vK5vACDJ/l7T6t+waaz1PlYT6HaFmArHTvLq7nXMsjzkUgf
         L4gV+QgLt7yulgy2nYI+LJ1a8mmuT0E0KAMYQ5RsHof3XoohA92nPCDQeefaYcBABhth
         /H5wOTlW/Ct9NL1sF9GLXcyzhC2yZ4Zwy6yBlWmyBPiDyE9GBXdSqUvMcHK75eJyEmo7
         cNDQ==
X-Gm-Message-State: AHQUAuZvO3LVyXhIxA7NGILAEh/5qosAQF+9fJbGKtptE9rHCZmAdBOA
        d+9I2lFvTudoNAPTHk65emeJ4dFMGME=
X-Google-Smtp-Source: AHgI3IYyTiTeFtbtuQF2QhNZl2QnqnScju6hudMjwogPN0haqNWQCc94ayQn9XBlVH57UWhRyRN3Xw==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr15165280ljk.64.1551207790390;
        Tue, 26 Feb 2019 11:03:10 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y2sm3061876lji.46.2019.02.26.11.03.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:03:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id l5so11774312lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:03:07 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr14170493lji.2.1551207786929;
 Tue, 26 Feb 2019 11:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com> <20190226183335.GN2861@worktop.programming.kicks-ass.net>
In-Reply-To: <20190226183335.GN2861@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Feb 2019 11:02:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
Message-ID: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.

Yeah, I guess x86 _should_ really do __this_cpu_xchg() as just a
read-write pair.

In general, a read-write pair is probably always the right thing to
do, and the only reason we can't just do it in an
architecture-independent way is that we'd want to avoid doing the
address generation twice (for architectures where that is an issue).

                  Linus
