Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B01C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E9208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhpTGqwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67E9208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbeFOSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:04:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37649 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFOSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:04:56 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so5737887plc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtcFBC2X8edmJrN69B9bQ1ccwSnRH5LWc74OZcaotyo=;
        b=RhpTGqwFpOhi+1OlBBa+JvYcI/PqXd6lN2Okt9w4644tei3jMeQGNXi1g91vP5h/fE
         lehRyn6Fu7giZe5QFx70cFxGOISSDPmt7/BCmOCrxv3pvF6O6T9+gtKlORHRYsPt4ksb
         3QMfqEWwCXSbbha+tPN6Jii1zsbAQbQElah6j2qaLdko8DDtiRuplRQbAGf1I6HyXBj+
         0YAy8hn6ThC/sshEm0vIrpkvf1H4HaQexuwrBNXYT6UEuCJfJfIY6sVFksIkYYuFflT9
         wKVaEdeod3DY5f6F2kan05KkyO4bP9TFCsqbN3bFUoGWVZsJtjEyxHHi3pXuH4S0wAmG
         Nwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtcFBC2X8edmJrN69B9bQ1ccwSnRH5LWc74OZcaotyo=;
        b=m5SqJA/oOEcm/SXGT0D6oM4wIhaZr03EbVbsfdxmsaRFRg98zw0k2PcG0Bt7LB5TcU
         37PYnf7u1YAfgn2YHnLL4lCCLp4rYAnHa/fVx9I2WrLs2/cJ3r7iKz/pCEnTpmsx968e
         2Wrs+PzPAlUyJ2wjZDmaoqrWb+i5YZiz9n3geMOdOmEWWuZc4wqe2NnBWaKKPyAm8+wA
         m+q6bNcUlDP7+svLejYWPqd/BkttD9hH+pzOz6+Ay4d85Ur3JKT5UNhulvFLOZ51EjU8
         kKTdzYL+pk5fTr63P6FIxIKEWDAYD8m6wjgtpmg6N9AayPkafin+zeYUy3Ld+A1limT1
         xopg==
X-Gm-Message-State: APt69E1/M5TBxRtZZrdMvZPYPnQBg53079HxPBtuG4/AI5tNNYnEGJcc
        zq55khs8VvjalbfP2Z/aMetnf9ptD6yRgG97F6G0Og==
X-Google-Smtp-Source: ADUXVKJ71VWYYx5wEyKrDwYIiUIYbUWbwpIHR0gv05GMzf06b6nwZxTohv4QnEclNM/fV7Sz2RtMQetCxptodY9ZqRQ=
X-Received: by 2002:a17:902:778e:: with SMTP id o14-v6mr3151936pll.214.1529085895262;
 Fri, 15 Jun 2018 11:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174731.47588-1-mka@chromium.org>
In-Reply-To: <20180615174731.47588-1-mka@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jun 2018 11:04:43 -0700
Message-ID: <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> update_permission_bitmask() negates u8 bitmask values and assigns them
> to variables of type u8. Since the MSB is set in the bitmask values the
> compiler expands the negated values to int, which then are assigned to
> u8 variables. Cast the negated values back to u8.
>
> This fixes several warnings like this when building with clang:
>
> arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
>   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
>   -Wconstant-conversion]
>     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
>        ~~                               ^~
>
> (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> doesn't seem to be universally enabled)
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/x86/kvm/mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index d634f0332c0f..a83817fdbd87 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4275,11 +4275,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
>                  */
>
>                 /* Faults from writes to non-writable pages */
> -               u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> +               u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
>                 /* Faults from user mode accesses to supervisor pages */
> -               u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
> +               u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
>                 /* Faults from fetches of non-executable pages*/
> -               u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
> +               u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
>                 /* Faults from kernel mode fetches of user pages */
>                 u8 smepf = 0;
>                 /* Faults from kernel mode accesses of user pages */
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>

This fixes -Woverflow warnings in gcc and -Wconstant-conversion
warnings in clang, without changing the disassembly.  Further
modification to mka's test case (to show no change in codegen):
https://godbolt.org/g/ynAoeJ

See also: https://wiki.sei.cmu.edu/confluence/display/c/EXP14-C.+Beware+of+integer+promotion+when+performing+bitwise+operations+on+integer+types+smaller+than+int

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
--
Thanks,
~Nick Desaulniers
