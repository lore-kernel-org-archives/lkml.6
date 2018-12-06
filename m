Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32D620868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z9CaXbx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32D620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLFUYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:24:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45496 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:24:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so1561059ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Pn3nYNOWgA2vXqZK4nu66QPs+PB21QR2Ap68HqFHX8=;
        b=Z9CaXbx7QAxEUGtrMzNXA6cNU7T3nFalFngJTv4WwWOsQ3yg21PsOO7FZDRJJ/xfD6
         eNq43ngSidoH7zo1xrYTvp6IfHQLsbGKBQnJSJtWjKs4dr4o5fkeQtXzKT07DTQ+tdlC
         z2sBAb67zq3UxS6g2LlJdeET4rXBh1NcTCdz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Pn3nYNOWgA2vXqZK4nu66QPs+PB21QR2Ap68HqFHX8=;
        b=Os+wXT0AzPN8MThS8oJLEoLdjfmdTgMZHoKX6g5hyf/HN1qxdOIV7U8j0UEenVoAlx
         LHeNShc0cUD1cQqa/d84+dbnSDcO+qcC5jwNef/y1iT1D6pAs+aj5vi4FFsSXk2uTQur
         iTyu1qVO9yKRzln8YZuP2OT64Oh9uBI90ivyd8pz7nDzTiTHNJ7Vh4/NqALeskAOy8Ac
         pJv16SzeJ19npvhp3+GM+Uq0c/QGlMckVs0EvpxUbpAegPov0AL/oIgik7JzaMmoJGt6
         crorP4n7BSOYaiExeS+r2mWT5oCvp0V3LVgWen4l1yyUMuE7KOvo6ivsNfo/up5JQD0l
         Sa7g==
X-Gm-Message-State: AA+aEWZrGpPypMuzbzzValBrhm+raf5B27FMxTeeCL7WHluCsCkSCj5P
        +47UsJ/iOsYHpl2g3uTGlsiUMPLIMZo=
X-Google-Smtp-Source: AFSGD/USGDGbfn6nrt7C7VjCnrKAbyZ5KmGV76HBa2eUxLSfJ4+CuJguEfgVelk/hiMN/exVh2WizA==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr18725238ljh.59.1544127858862;
        Thu, 06 Dec 2018 12:24:18 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f29sm237466lfa.46.2018.12.06.12.24.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:24:17 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id k15-v6so1582682ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:24:17 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr17101613ljj.120.1544127857077;
 Thu, 06 Dec 2018 12:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com> <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
 <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com>
In-Reply-To: <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 12:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOT0DW8a+VNgmrVybY1RJCajjJKskktzfNd1iJfhuV5Q@mail.gmail.com>
Message-ID: <CAHk-=wgOT0DW8a+VNgmrVybY1RJCajjJKskktzfNd1iJfhuV5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, sean.j.christopherson@intel.com,
        dave.hansen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:07 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> How do you like the attached patch?

I agree with whoever thought it's odd that "read" is in lower case
when everything else is in upper case.

And honestly, I'd just siggest making the err_text simply have the
real user/kernel difference in it too, using something like

        pr_alert("#PF error: 0x%04lx%s from %s mode\n", error_code, err_txt,
                user_mode(regs) ? "user" : "kernel" );

The "oh, PF_USER and user_mode differs, so let's point that out
explicitly" thing is a good thing regardless.

             Linus
