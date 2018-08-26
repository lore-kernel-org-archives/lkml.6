Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8122C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0DF208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="j1sN18Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0DF208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHZSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 14:01:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45483 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeHZSBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 14:01:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so3000051pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iXpDF+Y2S/NVGFxjm4bAz/bx05FH/VsP3mYUGAk4+CQ=;
        b=j1sN18ZqP8t9NfLj+Bo+cUXp5usNRiVdGUlQDbngxctcrW4ksPKYVJscXRfPvJqpA4
         kjwm2FjUCe+Vl0ibMYQbg0DfJnPCYhNEvkz8YJZkD6FkDAHkvJc7CZNAm0ssbuVbNmIn
         DWCXQX94fmzL0HUJH/zpiMDVQrnVI7VYPir9T0cZkPJIyC08IvlamE51EoByoGy4gK/T
         F8N274j0UcmYVfhhcCnIqmD5yCD318CIdjj+KHCWFUicpCkEA1cIO+9ZBQfqtEYYPRdK
         ftQySEjrb/GiSXaH8HJix+Qi5ChNjNt/m7dA6LmlhJgxZcnOq9tj2ANwERlETASZO/QH
         vNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iXpDF+Y2S/NVGFxjm4bAz/bx05FH/VsP3mYUGAk4+CQ=;
        b=WdEpSlNsMd4/YB8jdh8Bl8t6+bltWMJ40KyePtxOUltl0Fku64CNpuNSKH2d7luRJB
         AO8pzmOkhCRMlGqO7bzeRXOsIIveId7Yw7dVCmuSTOKJLot/j1xgJyZoVFIwqdWSHXBW
         AyvIueZyFMutMZD6fUIQwMC5OrDd9UBk6V4wiklznw9wCRB8HkcPFBpWl6Zv73hHtC3c
         FS2gSSk26lrcaFaGRgKzJO19RsDb2p3grmBzd4iSFXtkvK4WRteEVETc2rUeorYxqee9
         aGkOZRb0zkOMkEIWs3imYiCo5uSfy4UIL0tknztY5xI/+VJ4tZqyHoTkhAR0huA0lMuN
         0BAA==
X-Gm-Message-State: APzg51DfXW8MywetTFWaSJU50gecqiphq+f9ItBiWCsU6h2mAP8/sNs9
        BXaWzOrnkdXqGhV6Ac7mHLoRiUVYFpA=
X-Google-Smtp-Source: ANB0VdbdrkaTqX2/uhgBqGTmIwlpix7pa5sCk+pm3b/uZVsPUNY1tYcxUwd3R5579JaSjRQtdjetPA==
X-Received: by 2002:a17:902:28aa:: with SMTP id f39-v6mr9474535plb.150.1535293133950;
        Sun, 26 Aug 2018 07:18:53 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a803:ac38:1531:22f8? ([2601:646:c200:7429:a803:ac38:1531:22f8])
        by smtp.gmail.com with ESMTPSA id j191-v6sm21876889pfc.136.2018.08.26.07.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 07:18:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
Date:   Sun, 26 Aug 2018 07:18:52 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2532E417-DDD2-4E2C-9F21-3B8D9B96370D@amacapital.net>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2018, at 7:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Jason,
>=20
>> On Sun, 26 Aug 2018, Jason A. Donenfeld wrote:
>>> On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>> I'm not too fond of this simply because it requires that relax() step in=

>>> all code pathes. I'd rather make that completely transparent by just
>>> marking the task as FPU using and let the context switch code deal with i=
t
>>> in case that it gets preempted. I'll let one of my engineers look into
>>> that next week.
>>=20
>> Do you mean to say you intend to make kernel_fpu_end() and
>> kernel_neon_end() only actually do something upon context switch, but
>> not when it's actually called? So that multiple calls to
>> kernel_fpu_begin() and kernel_neon_begin() can be made without
>> penalty?
>=20
> On context switch and exit to user. That allows to keep those code pathes
> fully preemptible. Still twisting my brain around the details.

I think you=E2=80=99ll have to treat exit to user and context switch as diff=
erent things. For exit to user, we want to restore the *user* state, but, fo=
r context switch, we=E2=80=99ll need to restore *kernel* state.

Do user first as its own patch set. It=E2=80=99ll be less painful that way.

And someone needs to rework PKRU for this to make sense. See previous thread=
s.
