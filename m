Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C36C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49C0206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrziQseN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49C0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJBTxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:53:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54738 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeJBTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:53:35 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so3267148ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LAfoa/PIVKJRoX/u2DCLazOTNxvjW4Tp+kM3Du6B9t4=;
        b=JrziQseNEdLRtoB6G8zfdF8IZfoh6n8mZEOmM9JJuHxGCcxqG7cmZxonQFvu21hL/1
         qLoPDDeE/PmM+s51CIeSCVxfLRm9/RYsazPMaECVb+pMpy+UKR/lSKeG80afvqqfJQZZ
         rVd3W4aZDdlqzj3sp2biTCjkkX6igxnEaj4fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LAfoa/PIVKJRoX/u2DCLazOTNxvjW4Tp+kM3Du6B9t4=;
        b=aHo4NJ1gy6sXx25OpY2XT4ehla6aeVcGWDKrcaJ9iVK6+daQc0F1yWngcHA6hXuXkq
         OD0ql5arI2LPrbS8itNZNYBXHJz6eVghpeCjVR9CXw6y0Fnw2h6UDfvxhe6H6cBwEk4g
         W1Xs63DdGTODjWCdH3ML7iZ/VMKjzO1mzZ73BcjhLvO41spMu55EJWQownhKMNRbUB1q
         5VbiyekI6oJrzGYFz7adNpEnRlob/Tt04SFuwjJVahuIFpk6QfvuwOPrFjDp4mAT6Zut
         0JqE+emoe6/oNXv1Gl6JOyKKoFa91nJCZbDiv6KpsUzDekwBCz+1Avroax9+W1ct1o1W
         7glA==
X-Gm-Message-State: ABuFfoh2f+VyG0STZEjL09YQHbAnMhcrGAAnMgnoJU5kJs97s74eEOzy
        JkjdqDdUaqmmKBOYC57q0ZMyrnm55tvMA359outgSA==
X-Google-Smtp-Source: ACcGV620QBn1y1ULWRQBW7Jcc2X6jhvGy2kDDOnMfrMmeh2Kc8NQYS84BRM5BI+aYjF3qZYUFzedMieRI5G+z/Vi4aM=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr1785586itc.123.1538485818253;
 Tue, 02 Oct 2018 06:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 06:10:17 -0700 (PDT)
In-Reply-To: <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
 <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com> <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 15:10:17 +0200
Message-ID: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 14:30, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Arnd,
>
> On Tue, Oct 2, 2018 at 9:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > I think we're going to wind up playing whack-a-mole in silly ways. The
>> > fact of the matter is that the ARM assembly I'm adding to the tree is
>> > for ARMv4 and up, and not for ARMv3.
>>
>> I don't see what issues remain. The 'reteq lr' that Ard mentioned
>> is definitely the correct way to return from assembly (you also need
>> that for plain armv4, as 'bx' was added in armv4t), and Russell
>> confirmed that using -march=armv3m is something we want
>> anyway for mach-rpc.
>
> I'll do that. I can confirm that after changing it to `reteq lr`,
> everything works well with armv3m.
>
>> > I think there are three options to work around this issue:
>> >
>> > 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
>> > 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
>> > -march=armv4.
>> > 3) This patch.
>> >
>> > My initial plan was (1). ArdB recommended I do (2) instead. I thought
>> > that was a bit too nuanced and submitted (3).
>>
>> I suspect all three of the above fail to work for armv4.
>
> Armv4 does actually work in this configuration, in fact.

It builds but it doesn't run, at least not when built into the kernel
proper (which will be the case after random.c moves to this library)

Your toolchain is implicitly passing --fix-v4bx to the assembler,
which causes it to permit bx instructions in ARMv4 object code, but
tag them with special R_ARM_V4BX ELF relocations. The ARM module
loader does take these into account, so built as a module, it works.
However, when built into the core kernel, we have to rely on the
linker to patch this instruction into the ARMv4 equivalent, and a
quick check reveals that that is currently not the case.

Bottom line: let's not go there.

> But anyway,
> I'll go with your primary suggestion and we therefore can move ahead
> with changing the global cflag to march=armv3m. Would you like me to
> submit the patch for this, or would yo like to handle it?
>

Yes please go ahead.
