Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4142147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqCUDt0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4142147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeINLd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:33:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52344 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeINLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:33:59 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so1179256ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bsaNGShqKwnDmcxYHCBBuGqkfRN2UcewSbRQtNuwMd4=;
        b=DqCUDt0IMsX20P+haK+JDUw7F8UoMswquaFjPylvBlOMLxIQoBSSg34aUWVhCkLGqt
         SqZN+Y6cmZ2dof8zFAywvi1F56279DiO6VzcbV/r+Clt0O9ojgDy2g4uwuusHFdeHZCt
         mKwjHyulag7bMQR4VmEDeGecMC3EMehkJBxXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bsaNGShqKwnDmcxYHCBBuGqkfRN2UcewSbRQtNuwMd4=;
        b=oHUXyRfnAtrFv2BNgNDEMIkBkJH7eJl40RpbSQT1xTuEfx4114ooKZD/vGrRI3tyLm
         85MH4BM9nQisLpaP6MPZv92DJ4Mp8iieqcms6cXZ6uY1hNHm138p6LyRxy324WjTRXfG
         em5+GIYYBn0jr7tMox/tq1iGRwX78jRvDe9gMr1XrzfbbhPobQJ6feblrpk9xduXSMQo
         X34Pxpc3oLpzT1MabVAhUtC8i7TUmhEYP3clokK4Zv2e+KfM1ROK3Jl/MVL54+eXM1OQ
         sOKjcXIQ4UGu3PZwFfm9yJ0lElpUcz3yhGh+RVc6F4hPBLSGRCLJZyoM9GJkJRQUsxkE
         A+nA==
X-Gm-Message-State: APzg51AVR/g0ui2EM9iTgyAXrdSWxG5htmXWrxbrXQ9sMx58oJv9Nxc/
        q7xC9eepzQFYi0RbCVzPLMyqAcCNwC2ZScXYgEdtFw==
X-Google-Smtp-Source: ANB0VdbY1JbUpu1WWFiOBjli9cvnDrp9nExZDCQkLoLGzOAnZvwpIOXOv9awauBb6e96427zo7A1PtRR/YdKAFl1KSU=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr1105211ite.123.1536906062043;
 Thu, 13 Sep 2018 23:21:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 23:21:00
 -0700 (PDT)
In-Reply-To: <20180912183444.GB222557@gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911220849.GC81235@gmail.com> <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
 <CAKv+Gu9ZjX3A4bHHgRAkJtr+SKwti+d3dwE0fhGtmeQB_refqw@mail.gmail.com> <20180912183444.GB222557@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Sep 2018 08:21:00 +0200
Message-ID: <CAKv+Gu8qtt5n2r=ro1m3U+q311fims=N+jtacV-767oz-92C9g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2018 at 20:34, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Sep 12, 2018 at 08:19:21PM +0200, Ard Biesheuvel wrote:
>> On 12 September 2018 at 20:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > Hi Eric,
>> >
>> > On Wed, Sep 12, 2018 at 12:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
>> >> I'd strongly prefer the assembly to be readable too.  Jason, I'm not sure if
>> >> you've actually read through the asm from the OpenSSL implementations, but the
>> >> generated .S files actually do lose a lot of semantic information that was in
>> >> the original .pl scripts.
>> >
>> > The thing to keep in mind is that the .S was not directly and blindly
>> > generated from the .pl. We started with the output of the .pl, and
>> > then, particularly in the case of x86_64, worked with it a lot, and
>> > now it's something a bit different. We've definitely spent a lot of
>> > time reading that assembly.
>> >
>>
>> Can we please have those changes as a separate patch? Preferably to
>> the .pl file rather than the .S file, so we can easily distinguish the
>> code from upstream from the code that you modified.
>>
>> > I'll see if I can improve the readability with some register name
>> > remapping on ARM. No guarantees, but I'll play a bit and see if I can
>> > make it a bit better.
>> >
>> > Jason
>
> FWIW, yesterday I made a modified version of poly1305-armv4.pl that generates an
> asm file that works in kernel mode.  The changes are actually pretty small, and
> I think we can get them upstream into OpenSSL like they were for sha256-armv4.pl
> and sha512-armv4.pl.  I'll start a thread with Andy Polyakov and you two.
>
> But I don't have time to help with all the many OpenSSL asm files Jason is
> proposing, just maybe poly1305-armv4 and chacha-armv4 for now.
>

Thanks Eric. I reached out to Andy Polyakov off line, and he is happy
to work with us again on this, although he did point out that our
experiences on ARM may not extrapolate to x86_64, given the fact that
the perl sources there also contain parameterization for the calling
convention differences between Windows and SysV.
