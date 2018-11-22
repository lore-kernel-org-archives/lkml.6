Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33561C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AE020824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="akW00vXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AE020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbeKWEGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKWEGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:06:49 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EE920866
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542907590;
        bh=tXMMSXtp5EiyAZinJKdwu3CDS7qx0Kd3PYZEVgF31YM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=akW00vXtbGBBU9rQFOeiq2ktvnbFXiewtatrdMg1p3BLfJyMcYVa7IY/j02qoMZD6
         q/qjjUTbaJCn89nu0HskcghhVJ2aUbxq4KmldFBbjCEZgWNAi+O4a0YSJ8UgCxzcqk
         mE5zY+d6LN4Xbi/F8b9hhv5fdsCYEN8/lyY4pW9A=
Received: by mail-wr1-f45.google.com with SMTP id p4so9979545wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:26:29 -0800 (PST)
X-Gm-Message-State: AA+aEWa8dzqiXLhXJLwpe3O5P6iyi6vgOFXvCQx6F8LOIhYSI5CVW+u3
        GM+usdAvzpXs8lPBHkgpEEMjZDjl1qOpthRwoArd6g==
X-Google-Smtp-Source: AFSGD/X+oc0eNz0+9kE+c2XYvOtzEBqcNGa72aImw86GGdSUAzgyrgH/smy/6WcVdCLG7UYfWwkRH4Vtq81gP/zZ7Ow=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr10901295wrw.330.1542907588434;
 Thu, 22 Nov 2018 09:26:28 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
 <20181122103231.GA102790@gmail.com> <CAHk-=wjG=hvKnsRByogG_7Pwwi+7UQ1AK52m5bTp9dUHhAOzfw@mail.gmail.com>
In-Reply-To: <CAHk-=wjG=hvKnsRByogG_7Pwwi+7UQ1AK52m5bTp9dUHhAOzfw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 09:26:16 -0800
X-Gmail-Original-Message-ID: <CALCETrXtXfD9=H_jqz2DowmEdeUBXOxA5zk4xVNmiK0RzJVZxw@mail.gmail.com>
Message-ID: <CALCETrXtXfD9=H_jqz2DowmEdeUBXOxA5zk4xVNmiK0RzJVZxw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, pabeni@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 8:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 22, 2018 at 2:32 AM Ingo Molnar <mingo@kernel.org> wrote:
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > Random patch (with my "asm goto" hack included) attached, in case
> > > people want to play with it.
> >
> > Doesn't even look all that hacky to me. Any hack in it that I didn't
> > notice? :-)
>
> The code to use asm goto sadly doesn't have any fallback at all for
> the "no asm goto available".
>
> I guess we're getting close to "we require asm goto support", but I
> don't think we're there yet.

commit e501ce957a786ecd076ea0cfb10b114e6e4d0f40
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jan 17 11:42:07 2018 +0100

    x86: Force asm-goto

    We want to start using asm-goto to guarantee the absence of dynamic
    branches (and thus speculation).

    A primary prerequisite for this is of course that the compiler
    supports asm-goto. This effecively lifts the minimum GCC version to
    build an x86 kernel to gcc-4.5.

This is basically the only good outcome from the speculation crap as
far as I'm concerned :)

So I think your patch is viable.  Also, with that patch applied,
put_user_ex() should become worse than worthless -- if gcc is any
good, plain old:

if (unsafe_put_user(...) != 0)
  goto err;
if (unsafe_put_user(...) != 0)
  goto err;
etc.

will generate *better* code than a series of put_user_ex() calls.
