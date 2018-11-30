Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B24C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E04B20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsb1y5qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E04B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLAIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAIKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:10:24 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1CC821479
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543611590;
        bh=dklhLqSh/R3eawAshrdGCTAzouty0hE7j0furIEfWGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hsb1y5qKkN4Q39SDlL0Ot+tNE3SGupkh0uvX/i4BHmbq/iUg5dHQ5IdYTHnwvX9p1
         wPyu++1o4NKRoGRxlVoc6mmup5vHLwXttrvgvprfD7lTwn7Qn99mu7nELLkeepbF9x
         7Fv/ZvPo93q4uEmK4CSu1Pp+r5rB7DeHUfrfHjRo=
Received: by mail-wm1-f54.google.com with SMTP id n133so248572wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:59:50 -0800 (PST)
X-Gm-Message-State: AA+aEWZJHUnzFcAN86tXF/ZzMj8h7DD/xV2bOOWqURVqDC8fAZlHbza1
        7DH6ZivcTloMthZWppwg96UZp9daDH7X0PmSmhGc0A==
X-Google-Smtp-Source: AFSGD/U+PSBW/L7TjC0EmDoLwX5Ze/kiSCujzK9KU3HVLgQgBnAMbm19mauAvcb+lDCik/iMFLMijMwC9qNFn8d0AEE=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr284175wmf.32.1543611589060;
 Fri, 30 Nov 2018 12:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble> <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
 <20181130183917.hxmti5josgq4clti@treble> <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
 <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com> <20181130152852.456ce379@gandalf.local.home>
In-Reply-To: <20181130152852.456ce379@gandalf.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 12:59:36 -0800
X-Gmail-Original-Message-ID: <CALCETrUtaXU+5hTNrPKZgU_w1piyZ7O+5Kpk99RJMv9jry-OdQ@mail.gmail.com>
Message-ID: <CALCETrUtaXU+5hTNrPKZgU_w1piyZ7O+5Kpk99RJMv9jry-OdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 30 Nov 2018 12:18:33 -0800
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > Or we could replace that IPI with x86's bona fide serialize-all-cpus
> > primitive and then we can just retry instead of emulating.  It's a
> > piece of cake -- we just trigger an SMI :)  /me runs away.
>
> I must have fallen on my head one too many times, because I really like
> the idea of synchronizing all the CPUs with an SMI! (If that's even
> possible). The IPI's that are sent are only to force smp_mb() on all
> CPUs. Which should be something an SMI could do.
>
> /me runs after Andy

According to the SDM, you can program the APIC ICR to request an SMI.
It's not remotely clear to me what will happen if we do this.  For all
I know, the SMI handler will explode and the computer will catch fire.
PeterZ?
