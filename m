Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0533216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNMNFA+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0533216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeI1UQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:16:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55737 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeI1UQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:16:02 -0400
Received: by mail-it1-f193.google.com with SMTP id c23-v6so2528509itd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I8vXbrqB5BF4OtvkNXYZLxzdp/koegsaDLHAuHoixQk=;
        b=RNMNFA+gK3oYxwcvXZ1rNhZZNTyT2usHOaui/A4uzkNinQl9SvuMe57Ia5EkWLkKV+
         3HKVLv883xMf3I6Kmh6TDnewNusqAle9sa4EWYgLo51cNMJ4KQd6oMu6fzzNX4Omn/km
         07RF4VhXYKZc3oQb84JenLw2XpzIUMIBOt30g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I8vXbrqB5BF4OtvkNXYZLxzdp/koegsaDLHAuHoixQk=;
        b=QmTrudbKBqtZOPdb+vddPMUtGRmj/fA9DKepHJqP1qbZP/WZ8in/3bxrx+5j7M9l0k
         37xhMqnWiEdkuEIPm2FAjbFcPdaHOdguiFjsCwVlQ3rP7pjqVcW+p3UbPjnu/yPwsS7M
         a7pwDfxMSpKUHWbj8eQbWEcTvgcdFBYgqNf8pxLgCiZqYesonb2Uvyrp8uMazfATNLSb
         JKfBVBn9YTsrgHLK1t78R9hsJvZXsAmIVxhhPJ3lbOtA7Q7gliBxXBV/t27YJ8b4WTzl
         sVN/M9wD7n6DnInhDTzKNOfektf7CvD8F8uecBPyDOynJYTD5ijdzfyoURAy6RuDoehV
         wzMg==
X-Gm-Message-State: ABuFfoi6LO+vS+Tt6pfzXLrsj07qQRF+Y6bxrsqlXeoX3kQypN1JN0sz
        RQHbMk+1jVurxGnU+C0YxfSv6QVxWV6GTi5YPXJL6w==
X-Google-Smtp-Source: ACcGV60BKnfCTY9ye8djKdljaSHfRgelzXD0dj7nBQIrB4d1+xpgd9pHDhS68+et2nB24AWYQUygE6sCSgku6NOT2pc=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr1605523ita.148.1538142728281;
 Fri, 28 Sep 2018 06:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 06:52:07
 -0700 (PDT)
In-Reply-To: <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
 <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com> <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 15:52:07 +0200
Message-ID: <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 at 15:47, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> >> +typedef enum {
>> >> +       HAVE_NO_SIMD = 1 << 0,
>> >> +       HAVE_FULL_SIMD = 1 << 1,
>> >> +       HAVE_SIMD_IN_USE = 1 << 31
>> >> +} simd_context_t;
>> >> +
>>
>> Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
>> about it): the use of typedef in new code is strongly discouraged.
>> This policy predates my involvement, so perhaps Joe can elaborate on
>> the rationale?
>
> In case it matters, the motivation for making this a typedef is I
> could imagine this at some point turning into a more complicated
> struct on certain platforms and that would make refactoring easier. I
> could just make it `struct simd_context` now with 1 member though...

Yes that makes sense
