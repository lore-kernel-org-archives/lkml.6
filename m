Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BEC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miVzJyKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972B92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJPBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:09:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37167 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeJPBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:09:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so15712180oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFIKRAWJ16+TpQPKqu1yB08222QfG8MR8RlKCAAding=;
        b=miVzJyKUVDvwKHnHG7A6X6tYCtpy38v8Gecp258m0UKs5x4OR9RHkkeqjr0YwvLhkZ
         5mDLu75claoV/orwOQGFNnGYWyZS/i7gzTXEu907u/IPwTK6C8WnDNiEqxRA6nmeMFd2
         G+Z7vLn0XjWaLLqTPf0ZaeUvRD+vVohddMyUUQQktnokdHEyHfQuSnQZj/7ny8fMq4tV
         XWy+CEfXHG9pfVW9SHyqG7GaJ1LMGcFP2Xab19QpSeU4rgr1v5crTCjFstE9Dbb/m1r5
         TiZqak07dmcyM9Yth7bizJTxdZI7TwLfg0y1zqlAafwDCoXYSx07dZceCgBdyiaLIaxD
         qWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFIKRAWJ16+TpQPKqu1yB08222QfG8MR8RlKCAAding=;
        b=UJnGdSBUhyb+ufM+u8dbm8aKvYqJW8aKdP3Jj5JH0LYeXrnC8Kb/w5ttNg7QafykbP
         BWWyXKQKdJvnyZ6qxE7DhYsJaT2a6692Y/wCQRTOvfUEjyNr+IdqDXbx/1/HipDD1Skf
         +9DLAW/vEkwBnxoj3EzBVeF/HS7EY3SwNOh+7yI4X/D+VgVYPpxdu9A7o33vwCXtuoOp
         7pY913L7YQ2oeo5Lo+uDFam2JnylT3O0csE1aeLNCS7nrBNwYpMprtvH3UxrNMwPJh15
         5GgkHrdxuiyxxmVCm7cMSZxpkIcQVEZVxGAzSu7qM2C+i6w8cYfWs3LYON9s483S86Yp
         tTXQ==
X-Gm-Message-State: ABuFfohPc6DUNZ8V065+ryoIyL1Kk/ScnC+o9XQSU5gvvphHg5LWiEv1
        nf1GrKYyFk07laz+tz56lVwUcwaGv3RqKX3TvfM=
X-Google-Smtp-Source: ACcGV60BdARqF9d6DDYysxKTf1eUB1QSR3JKoN1la78G6tfKt/c3tnVbxdyWpK96Wextzjk6+oMKWde002UD3yIfmBE=
X-Received: by 2002:aca:6b45:: with SMTP id g66-v6mr10164011oic.273.1539624195650;
 Mon, 15 Oct 2018 10:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox> <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox> <20181015153144.buuow3yof2njjzjm@treble>
 <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com> <CAH7mPvhgVgt+N=5pi-tGNWbitzcteSp5JOvNuMYoKFgxyrqRTQ@mail.gmail.com>
In-Reply-To: <CAH7mPvhgVgt+N=5pi-tGNWbitzcteSp5JOvNuMYoKFgxyrqRTQ@mail.gmail.com>
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
Date:   Mon, 15 Oct 2018 10:23:04 -0700
Message-ID: <CAH7mPvhxULvsw=4rSkq14nPk2e4Kirh4O3bxw61RDrqXiB2WvQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
To:     luto@amacapital.net
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>, luto@kernel.org,
        dave.hansen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 9:57 AM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> I broke this myself in commit 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> Thanks for the suggestion, will verify then send a patch with your
> suggested by tag.  Thanks everyone for helping us sort this out!

https://lkml.org/lkml/2018/10/15/626
