Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B41C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497DE2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLPCRkCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497DE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLAH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLAH3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:29:13 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB472148E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543609127;
        bh=Cs7BDISB1ieiLt7d4jp2Ven9syRA+nggJ3jKZ0LD1UI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vLPCRkCJkMYS20CuLF4O9fD4Fh3MwXOgfombV2e1c8HcM6JNTd+MfWVx3wChPbda6
         JdOmsVGlJ0gRcp/La9M8jXnAfR48rAO6dX/q1TAgLiTSbMaw2rBspUIGemOUMy7MZj
         j9lXoLoEhlE9M1r0PfKwlaoYqFG7tNT1DCYTUofs=
Received: by mail-wr1-f41.google.com with SMTP id c14so6469358wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:18:46 -0800 (PST)
X-Gm-Message-State: AA+aEWbePzVdFNUOgFtbWGSJksgxBH/FAlN8eAKkPOsNhjvJuFQso9As
        w2KW0pzj6tz7ah8Q1YohVRWNzX9Cpe78yYTqmz2aOg==
X-Google-Smtp-Source: AFSGD/WI9k75Fi9ma2umv8keGTs6KdPjBXGnEdcuHCm5Q6ebozEfwoC26AWzDh1WZGf4qCnvXcmBMo5Q4akO64cIWt8=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr5887210wro.77.1543609125274;
 Fri, 30 Nov 2018 12:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble> <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
 <20181130183917.hxmti5josgq4clti@treble> <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
In-Reply-To: <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 12:18:33 -0800
X-Gmail-Original-Message-ID: <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
Message-ID: <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Fri, Nov 30, 2018 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 30, 2018 at 10:39 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > AFAICT, all the other proposed options seem to have major issues.
>
> I still absolutely detest this patch, and in fact it got worse from
> the test of the config variable.
>
> Honestly, the entry code being legible and simple is more important
> than the extra cycle from branching to a trampoline for static calls.
>
> Just don't do the inline case if it causes this much confusion.

With my entry maintainer hat on, I don't mind it so much, although the
implementation needs some work.  The #ifdef should just go away, and
there should be another sanity check in the sanity check section.

Or we could replace that IPI with x86's bona fide serialize-all-cpus
primitive and then we can just retry instead of emulating.  It's a
piece of cake -- we just trigger an SMI :)  /me runs away.

--Andy
