Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CBAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702625E79
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q34OwfO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D702625E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeFYQrV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:47:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38542 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933647AbeFYQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:47:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id a1-v6so2860823pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4Js/y2RDourC42qGYvqe35rJyf6gmgLpW233a/eV/c=;
        b=Q34OwfO5Z9TcdMB+ukJgK/eNwDNfgllRCQfMDgdR1SdGOI+xsfMXjzIQXXSSF9yuNb
         kHekfxlMeTRsw2jTf7/zRCEGpMKDY/D2TdDvXnXmVCoW13iWtXoftNyFrS0J+zBTbTEH
         9Ek0zrrB4OthHw+utAERlUxlLG5RYPg/g4/5z0yOroN/ppzYlzSBKahIoSMGrTS6lhS7
         Tat0WcWvAwbOEUFOX3ZKsO7gYNdsaTMuXujlvU7n/1RNNBTns0Z7zVHClunJyNcIuIVM
         futSdG7bqpEYOcNXXkYqo7Jgs6D7HTRef9TdhCju/Ckn5yaixqPmPvfviq2+kud10v6u
         xmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4Js/y2RDourC42qGYvqe35rJyf6gmgLpW233a/eV/c=;
        b=mnxB/RGauPpNAnezZGvcv0xTmiehwEXHxzdf9VgSaX84mJu58zdVr8/ghI/NQlVs8q
         ieyWVrmD6CPPNKf+gpAYDWSiTt1GT3LgXyDsoKNL5wBXJF1N6yG4aOpMII5toLElqwXT
         106AviEd3eigRBzLhbA98X0J1KO2hQx+myZQMIrDooJfo559iM6k6Ugf0aWp/fNjTb5k
         LX4z9BR9HB3EQEJoD1GIIfecmaLeylYv1Clb9F29i7JXP9aBXmkiohrmaovJf8hFlWR1
         0KUGeWh67l+HqmsCS68I3Mk8XMuexoiDTuLFzPq+MFDcNURKQiM8+haxoOnmObQBR+s9
         4Byg==
X-Gm-Message-State: APt69E044hkJNDNCUhw74cT31zGpOoJPnZkZn403iEjVIOay4EVqPN+8
        tfXA4sFxgiT7hGRG/4569F9H2TGYXmMQJoA29ChCDw==
X-Google-Smtp-Source: ADUXVKJqg5/6bXZRAJEjj86XIiamBCA+9WhVmbsPvnRM6VJ8BMyd4e3SeG0a/ivsNZ9egiCF081my7mAxd9E70PDJf4=
X-Received: by 2002:a65:4841:: with SMTP id i1-v6mr11207948pgs.75.1529945238943;
 Mon, 25 Jun 2018 09:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180619192504.180479-1-mka@chromium.org> <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
In-Reply-To: <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jun 2018 12:47:07 -0400
Message-ID: <CAKwvOdmmv9EtPB-jhwVruLASFve5d4h0+wx-6iY=ve=T9hbNdg@mail.gmail.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     pbonzini@redhat.com
Cc:     Matthias Kaehlcke <mka@chromium.org>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/2018 21:25, Matthias Kaehlcke wrote:
> > update_permission_bitmask() negates u8 bitmask values and assigns them
> > to variables of type u8. Since the MSB is set in the bitmask values the
> > compiler expands the negated values to int, which then is assigned to
> > an u8 variable. Cast the negated value back to u8.
> >
> > This fixes several warnings like this when building with clang:
> >
> > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> >   -Wconstant-conversion]
> >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> >        ~~                               ^~
> >
> > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > doesn't seem to be universally enabled)
> >
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - negate the bitmask at initialization and rename variables to not_X
>
> The patch is not that bad, but I'd like to get confirmation that other
> maintainers are applying fixes like this.  Honestly I'm not really
> impressed by most new clang warnings, these days.

Here's an actual bug this warning caught applied to drivers/input/:

dae1a432ab1f ("Input: mousedev - fix implicit conversion warning"):
https://patchwork.kernel.org/patch/9753771/
