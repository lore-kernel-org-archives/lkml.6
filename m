Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D1C21528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiF1v2wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D1C21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeI1UYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:24:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45344 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeI1UYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:24:44 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so4197333iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V1YUbtd6aFkUt0FR+y+/NkKwWjXB81Dzm7EN1IuEOTI=;
        b=CiF1v2wrKW0n7Eg7L1ZBJru3KvAEvaqXx01nDeXKMkrteOWJCms6c5zm8G+GVKpk78
         eLbuJY6jSGI+5Oh38A5gQe4SKeR3s/KJG/3IB5QqbZ/6pt5z0SA/LnP9F4cWag2lpgwj
         089qlMPO5Ko2g3MPXiSD0DlpVtK9W54yV1Ir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V1YUbtd6aFkUt0FR+y+/NkKwWjXB81Dzm7EN1IuEOTI=;
        b=MNPywPl3eq9h3AxEsKeJcx1SwLpJDamTjLGzvP0mKrqsC6tg1QiyLa+LxPhILz1r8u
         Jxv2yfOQjYa/OkPO5Zzyr/pQd5hZqXnnEISKNy8n+UR5ae/ddvN5fYpVOje6FmiCl2EX
         taRgPrn4FzOiEtYajJXQO9oY36RVBeDrjd31IiuQQXvyA/wed6UsKFvGm1W7I5mkZMkb
         l+Xc9FyrDnvi1VQFeZT5k6jW8o899hoBkiSURChMbXLqErLSqJmy0+9fff131iIRYW4T
         COK/lwx1gfbHoax/RBsfg4rssPTjV/NQj8GRLV8YirFLZ1gbQhEqDSyir5/pXWfiLAjx
         RMYA==
X-Gm-Message-State: ABuFfojdRS3ObB55dUbtENd+5omPMCcoa1y08StJxdxbySYD0j9W5zJy
        rOHia76vhH1XRq+dqOogh5wKUF6nAL3EmfDjh01e2A==
X-Google-Smtp-Source: ACcGV62fzNYMaylOTr5XuIo2zEb6yxOOqqldKGY6JOeowfpVVVdSjF2g+H10o7nVRPEXAYtzsAAqMjF/q/vbGppjuGs=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr11856981iof.173.1538143248302;
 Fri, 28 Sep 2018 07:00:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 07:00:47
 -0700 (PDT)
In-Reply-To: <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
 <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
 <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
 <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com> <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 16:00:47 +0200
Message-ID: <CAKv+Gu9FAVVOiYyGovYZ19-107_6sK9Ya6LnK=AQkTgctMmu5A@mail.gmail.com>
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

On 28 September 2018 at 15:59, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Sep 28, 2018 at 3:58 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On 28 September 2018 at 15:47, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
>> > <ard.biesheuvel@linaro.org> wrote:
>> >> >> +typedef enum {
>> >> >> +       HAVE_NO_SIMD = 1 << 0,
>> >> >> +       HAVE_FULL_SIMD = 1 << 1,
>> >> >> +       HAVE_SIMD_IN_USE = 1 << 31
>> >> >> +} simd_context_t;
>> >> >> +
>> >>
>> >> Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
>> >> about it): the use of typedef in new code is strongly discouraged.
>> >> This policy predates my involvement, so perhaps Joe can elaborate on
>> >> the rationale?
>> >
>> > In case it matters, the motivation for making this a typedef is I
>> > could imagine this at some point turning into a more complicated
>> > struct on certain platforms and that would make refactoring easier. I
>> > could just make it `struct simd_context` now with 1 member though...
>>
>> Yes that makes sense
>
> The rationale for it being a typedef or moving to a struct now?

Yes just switch to a struct.
