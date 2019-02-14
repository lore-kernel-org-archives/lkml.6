Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F54C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3396221927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZPnbWkIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405301AbfBNSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:16:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40542 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfBNSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:16:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id t14so5261160lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
        b=ZPnbWkIaLF1fPpbhVu5fqt9VoWAh7zq9mqH5LmbreMaS/dFp/ga9ADBd1bUPfLNZVt
         9cmIVEyoT/T8O5y3yiREHXO6gcW+3HJveD69ZJigOCRdO+OvsnNK66RwV3oR7F6BHY0m
         nx+fInfaHOtcGNGfeA3vdOANp4vbwtRzlSmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
        b=nYcy1lHBQ1TJMrppfTJBFnECJ9j7nQ30wK1/qAdcD1mzW/5iz7BnWTAbjhCb93KkHg
         01ukeE+gEpQZTjJWv0JHkSNq01eGGTCdZttdBDEF0MrK4mrMDNAohrGBKkrnSLmzZooH
         n4Fibjfn2XH3TMT27w2yZWaVs+7mf/DIzrz/bXfK7RqpKewElkOsC8ZyVa+EFhY3YbhK
         ys9+UPyYTLa7bGn0SmUjVYd42xMdOiLTop9//NY1Sw7DAad8GK3viyJl4WKNLlNZoIdD
         4CPxSG1mpCNM6blDPpcwMc/aTUizPM6vKm8mF10WKdeEO9N7HFvvrDW3MxIFcnmSC2JE
         dsPQ==
X-Gm-Message-State: AHQUAuYYhnLyP2u8q+0hiWYjxw3UMfdbLUBbwYOjLwQAjEo8x6bIFkrR
        CCaKnqWO8awmX/V0l59/KtrjH1Wkz24=
X-Google-Smtp-Source: AHgI3Ib9e8GzOGd3K93YeTi9sZFURrkVQksoLDWl/l9RwIC8HpHg5SNmVe0un/PTPkIFbvEnx2Jj+w==
X-Received: by 2002:a19:f607:: with SMTP id x7mr3149224lfe.47.1550168159679;
        Thu, 14 Feb 2019 10:15:59 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q1sm621564lfk.15.2019.02.14.10.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:15:59 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id v16so6062279ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:15:59 -0800 (PST)
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr2287389ljg.185.1550167800344;
 Thu, 14 Feb 2019 10:10:00 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com> <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com> <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
In-Reply-To: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Feb 2019 10:09:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The arm64 numbers scaled horribly even before, and that's because
> there is too much ping-pong, and it's probably because there is no
> "stickiness" to the cacheline to the core, and thus adding the extra
> loop can make the ping-pong issue even worse because now there is more
> of it.

Actually, if it's using the ll/sc, then I don't see why arm64 should
even change. It doesn't really even change the pattern: the initial
load of the value is just replaced with a "ll" that gets a non-zero
value, and then we re-try without even doing the "sc" part.

End result: exact same "load once, then do ll/sc to update". Just
using a slightly different instruction pattern.

But maybe "ll" does something different to the cacheline than a regular "ld"?

Alternatively, the machine you used is using LSE, and the "swp" thing
has some horrid behavior when it fails.

So I take it back. I'm actually surprised that arm64 performs worse. I
don't think it should. But numbers walk, bullshit talks, and it
clearly does make for worse numbers on arm64.

               Linus
