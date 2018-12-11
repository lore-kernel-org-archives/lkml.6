Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240DAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECC620672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="choPK2ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECC620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLKBoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:44:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38245 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeLKBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:44:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so11478049lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TK/uH3yL47ofdiSN2tIcOY+WcrX9SIB/VKpoBaYj0IM=;
        b=choPK2ET1s5hAtrSQgGQ3QQjsup0DORlGEZz9CLXI3x/EJk2+Q/ml7ZitkwvaJLU9n
         b+FR1U83VvG9BJmxsDAPbGbDPckIz1YVYfW1wSJhsh3UR1qRYz631RzfGMgXgcsCKWVH
         52iSxVaNEyIerwxeqVfBcWkjrvvShadH0SWgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TK/uH3yL47ofdiSN2tIcOY+WcrX9SIB/VKpoBaYj0IM=;
        b=dYaOxQgNI0lOVHY26krqga7OTeN7XaINauERPrUJH4w8cc/i8F3CHLr9SBmuOCd9Ec
         zNfmK/Cqenq9aNfm9PTOROwIvRDLweEl60nZ4BvAOiqW5y51ZT0ZMISPXD1WHLmUJbFX
         6Yk0HtUyM+flCDZberMZnKk/UWSiJj4qHnX/MWLyWRy2d2dlDTn+wjITeovM6Y8e0Hxp
         k9C1FI4oxA7B+YUsSyhQefiLQl27P3KpwFDZQLCxJpa/NGArskyQoUWoce/Za4Bi+owN
         2PVH4cn+lANdcxB8cSz9Ai4feewSjcAorZVaWxdSKYQcrXHoFtKCNWbjw0niU4qpW89J
         ockw==
X-Gm-Message-State: AA+aEWbPIpSj48p21Q37gRTSyoP2kRRUaTC8nulj4HgVEioikEfW0I51
        VKNEtGTvVjPBAzj+RxADEXtQHfzIkmE=
X-Google-Smtp-Source: AFSGD/W21ziXKdMmwlVJipRtaBee7/2qgzyVIc95y83YIf5NzwENUMkTRD0BGCQ03jmAiWw5hsJ9RA==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr9333008ljj.18.1544492644200;
        Mon, 10 Dec 2018 17:44:04 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id o25sm2314655lfd.29.2018.12.10.17.44.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 17:44:01 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t9-v6so11471972ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:44:01 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr8326297ljh.59.1544492641152;
 Mon, 10 Dec 2018 17:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20181129121307.12393c57@gandalf.local.home> <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CAHk-=whxtKjkDbvA4EK0aU+FpqALyW+p79_nuPy99PjYFnkbvQ@mail.gmail.com> <20181210235809.GB22352@amd>
In-Reply-To: <20181210235809.GB22352@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Dec 2018 17:43:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjo3v2fMOHseL5gxbzZKdLztER1+mk2-zUcUtHGusgM7A@mail.gmail.com>
Message-ID: <CAHk-=wjo3v2fMOHseL5gxbzZKdLztER1+mk2-zUcUtHGusgM7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     pavel@ucw.cz
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:58 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2018-11-29 11:11:50, Linus Torvalds wrote:
> >
> > It might be better to use an empty REX prefix on x86-64 or something like that.
>
> It might be easiest to use plain old NOP, no? :-).

No. The whole point would be that the instruction rewriting is atomic wrt fetch.

If it's a "nop" + "second instruction", and the "nop" is overwritten
by "int3", then the second instruction could still be executed after
the "int3" has been written (because the other CPU just finished the
"nop".

So an empty rex prefix is very different from a one-byte nop, exactly
because it's executed atomically with the instruction itself.

              Linus
