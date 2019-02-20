Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C7220880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nfhSet5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBTVVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:21:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46676 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:21:14 -0500
Received: by mail-vk1-f195.google.com with SMTP id j68so5836259vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWAc5FCO+cMMQk/gs4xgFG+Nej5qqLnHefYCW6Hd11c=;
        b=nfhSet5dATw1pr2sDEUbC8LfTm1if2M8Fwaep0FCBW17kBnKlxQrQM1Lji6TiLfFDe
         XhfNaq97xwAIubmWTeHlVbCSmzNu2jBO7oQ1JCe69c5RJTbXc+aUJMzekcMqPZ+5qLTR
         Xsu7fFZkQk9Vb91lwB0H1UJvp8TY6ji+Q+QKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWAc5FCO+cMMQk/gs4xgFG+Nej5qqLnHefYCW6Hd11c=;
        b=e0quLSbzKlN+22pa7tXoRDTgO5wTcV5XjVqsRYcRbYxAHOdzuMnKgUFtXeFiGqACMF
         NDNjO3+55Q+JxBRVhW3BS3im8c7ZAV/CaTxUYiEvhLJGKqvE2dgwE0eHQwcwyO4dzTnA
         Pbc96Kzs6Vs0RYRkNNz0/b1greV7DPvxJHWgl/M+N67ECXvtfdmXg6OuocnEmr+OANmU
         48OgsLqbUeff9Ac+A/yJT4fflqxldXmw8YjvT62nbqj9FVjKMX7HeB5st+pLa4H7sfDX
         EPVqxF7UXb3mhnT9qGjvpUAfXVWVVAktcE8m1xFtgeyIAjJerGg1IcciZBVP29BL4xQF
         2YVw==
X-Gm-Message-State: AHQUAuaFQKLRXianPYMrl3f7cVzcvIJIMAaAYl5AZ/10ZxrTNwKKMpJK
        Fnfr/ASK5PsuQfxRr6Z9mPUI8S3ijUY=
X-Google-Smtp-Source: AHgI3IZrcidWRe/g2etNW7I/X255oU91BQTSyMPSun6eUIuVCM7cuPh/naMeIXGWHJxkdRalRLXnGw==
X-Received: by 2002:a1f:210f:: with SMTP id h15mr20273016vkh.6.1550697672722;
        Wed, 20 Feb 2019 13:21:12 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j4sm13788106vke.0.2019.02.20.13.21.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 13:21:11 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id u64so14864035vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:21:11 -0800 (PST)
X-Received: by 2002:a05:6102:d2:: with SMTP id u18mr11361090vsp.172.1550697670719;
 Wed, 20 Feb 2019 13:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20190220180934.GA46255@beast> <20190220184859.GA6429@openwall.com>
In-Reply-To: <20190220184859.GA6429@openwall.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 13:20:58 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLB=so4r169pq1KF3Kyfh2Kw_t6ZXGavpzVO2sg3=D1tw@mail.gmail.com>
Message-ID: <CAGXu5jLB=so4r169pq1KF3Kyfh2Kw_t6ZXGavpzVO2sg3=D1tw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Pin sensitive CR4 bits
To:     Solar Designer <solar@openwall.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:49 AM Solar Designer <solar@openwall.com> wrote:
>
> On Wed, Feb 20, 2019 at 10:09:34AM -0800, Kees Cook wrote:
> > +     if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
> > +             goto again;
>
> I think "goto again" is too mild a response given that it occurs after a
> successful write of a non-pinned value to CR4.  I think it'd allow some
> exploits to eventually win the race: make their desired use of whatever
> functionality SMEP, etc. would have prevented - which may be just a few
> instructions they need to run - before the CR4 value is reverted after
> "goto again".  I think it's one of those cases where a kernel panic
> would be more appropriate.

It will not land upstream with a BUG() or panic(). Linus has
explicitly stated that none of this work can do that until it has
"baked" in the kernel for a couple years.

In his defense, anyone sufficiently paranoid can already raise the
priority of a WARN() into a panic via sysctl kernel.panic_on_warn (and
kernel.panic_on_oops).

> Also, WARN_ONCE possibly introduces a delay sufficient to realistically
> win this race on the first try.  If we choose to warn, we should do it
> after having reverted the CR4 value, not before.

Isn't cr4 CPU-local though? Couldn't we turn off interrupts to stop the race?

-- 
Kees Cook
