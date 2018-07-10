Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B32208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyTmU+UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B32208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeGJNZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:25:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42063 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933245AbeGJNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:25:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id 1-v6so16686874ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fDUNZt6moHDVFwy47h8TPjhab73S5yiOBZT7Z2pUoLY=;
        b=HyTmU+UHQLytmqNh61Ve/oyDo8aUqxTsIJhV7ROltL0wo85dWHdHK+qhbDG6SfcbBw
         66QBaL9E1NJjY2rGNcO7zRvLdPHFyJC9cUOsBWo3mrm2ZeX0KUM9n/xDfKudQf8mOmf9
         NwNVlVMEkD/NMpWNO6NoSgcWLGeaPuXxQVmLBRgCjC7DvvL+xkQfhtISXgZYQV2L8efR
         cOqWsDoeNzjARCxMrqL0SVojFhdvQEZEDMXK1ekB+khy7A5Iy413Fn65YHHyqOs5DoWW
         qyhKTEk5jedrY6yXGcd4d4WQCWhUgA1gmUNhdvKgoPbG1JUZRAQrtggE1sXUXBbtdgoe
         0SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fDUNZt6moHDVFwy47h8TPjhab73S5yiOBZT7Z2pUoLY=;
        b=aBTMediIpvVTWdEEyDQMQvbAwWAIa57KtcLcvy6xvA1m8NgxViVFHZqzDVe5xH2/rf
         FRi28BwUSMthx7lh80lTmlPvL0c8auL8WXQFZs8P4KChJ+OVX5LguNt4Rwe7bWqCmJht
         nbiQ2Xj1pPmmeuqQ53qqrjEL0CCtlnmoaYGqg9jHaIqFwLC3Gz9UEojATg/4eIRbQizf
         pKFVHsl5qtNZ5UDUbYW1FyjRS1LLPoIMoSPllNC64aKB4gXTcckHWXSAUNQLfNBNV1Cd
         GoKxYj+/vwCDWmn7I9OKBUrFmJqKIjLpxy+WKS4ZSgPx0DTQSGgJoKnfiymUJr9Tre3v
         ULTA==
X-Gm-Message-State: APt69E2OWfnva/KBco0vyjtgI7U5oPmajxH7cxnKcKZeKmc+G8xEdGon
        bku8juSYHUWGtNh2P0f0DhQOMRk9pcJsckuNheY=
X-Google-Smtp-Source: AAOMgpe41Msw7GwlX3Uif4n99Nj34gjZzMLdvdm/ZGN5+tPA9VCB7RcCBftpGeN5xvfz3ig3WPeq/oVbC+c05XDL8ZQ=
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr14770071ljc.71.1531229114859;
 Tue, 10 Jul 2018 06:25:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 06:25:14
 -0700 (PDT)
In-Reply-To: <20180710130650.GD31318@arm.com>
References: <20180706174724.44594-1-nkela@cisco.com> <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
 <20180710130650.GD31318@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 15:25:14 +0200
X-Google-Sender-Auth: TuYo2GLIhpz0I9X8WK5o8ygwybk
Message-ID: <CAK8P3a2ss5tYve6xL7eE50ev3zVPOHzN5QtroWYmTih0F3sQYQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: add ARM64-specific support for flatmem
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nikunj Kela <nkela@cisco.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        xe-kernel@external.cisco.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Arnd,
>
> On Tue, Jul 10, 2018 at 02:55:41PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 6, 2018 at 7:47 PM, Nikunj Kela <nkela@cisco.com> wrote:
>> > Flatmem is useful in reducing kernel memory usage.
>> > One usecase is in kdump kernel. We are able to save
>> > ~14M by moving to flatmem scheme.
>> >
>> > Cc: xe-kernel@external.cisco.com
>> > Cc: Nikunj Kela <nkela@cisco.com>
>> > Signed-off-by: Nikunj Kela <nkela@cisco.com>
>> > ---
>> >  arch/arm64/Kconfig | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> > index 42c090c..f5b4c49 100644
>> > --- a/arch/arm64/Kconfig
>> > +++ b/arch/arm64/Kconfig
>> > @@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
>> >  config ARCH_SELECT_MEMORY_MODEL
>> >         def_bool ARCH_SPARSEMEM_ENABLE
>> >
>> > +config ARCH_FLATMEM_ENABLE
>> > +       def_bool y
>> > +
>> >  config HAVE_ARCH_PFN_VALID
>> >         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>> >
>>
>> I'm getting hundreds of errors in randconfig builds with this:
>
> Damn, I was worried something like this might happen. Sorry!
>
> Does randconfig also fuzz CONFIG_EXPERT? We only added ARCH_FLATMEM_ENABLE
> so that people can hand-configure crashkernels to make them small; there will
> be plenty of situations where it's just going to cause more problems than it
> solves, so I'd be happy hiding it behind EXPERT if it helps.

Yes, randconfig also tests EXPERT and COMPILE_TEST configurations, though I
don't test the !COMPILE_TEST ones myself, so you can also hide options from
me by making them 'depends on !COMPILE_TEST'.

> Otherwise we can probably through a 'def_bool !NUMA' at it.

Yes, I was going to send a patch with that next after testing it some more.
So far it's holding up. This is also what some other architectures have, so
it's probably safe.

     Arnd
