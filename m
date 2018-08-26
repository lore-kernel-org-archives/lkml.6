Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E04208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="R8DBeRn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E04208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeHZSHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 14:07:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35719 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeHZSHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 14:07:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id z4-v6so6264116pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Br+F6ackvix8jTckjfbh8xxY5EG6ueq5gvpzi79uiBE=;
        b=R8DBeRn0JOCvB6N0OJOmhsG6CGVVREgWGCG4knNlv4/OV/sL/4j/E88iWInl1VRk4r
         sq/YnqPlBX3URlXwtzC4U7f1oLw4d/xtRTNJufHB7mqTnJpLHSJ3yLQ+ocM2HAfu3QI3
         fkG6W54WnWR4pq6IQbhZsBLoS5Ec8tEF+H+DWdZxlQ3AZPj1oZN7HXazjfOYoqGpa7TC
         rwMDlcg0C8ah95YNx4ZxBo9H1Ha/NBsYb1oA4j+WZOCmIMaIXuON+A2Ai7j8440Ton8b
         dIcQEhoW7nvN+04Gn3cJ02rRiS6vjWvS/Pc3U7DW+wroHvLZ66aYcCLecUYxaHGv5MY8
         ev3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Br+F6ackvix8jTckjfbh8xxY5EG6ueq5gvpzi79uiBE=;
        b=W6IXQqO5MyCJXHD2QjU3HQmhz59G7L/ohXEwqai1f53+YG783QEBw3yAMxqYyid7Vi
         A2H6IBW7MJS59D6TtYxqcmBiIQt9yFJAb2vgy3mSySifMPWn6HjjrwnsEcm6vG2gSvah
         rcep4BymULaM8XLfLkWT71q54vw0K9OWHQASCCHP/YyZqhRHfD6TqN/tTK2S2//KH5XQ
         VOdvduDCiz7LsxdK3UvQ9jzqiFZ/hdXhe7cUGDo6f+3B1vW9J1a8Bek0cnd1FT/ASc1J
         z3kcUdNR3BdYKqJxLq0/fdWSxQVmSBVsvQ/lKYLkVDFUIYXqLK2GN+OsCHwGclV9WNQ6
         le1Q==
X-Gm-Message-State: APzg51DCrpMuf9Jur1DUeLMVa6UgHSYJuDXQHAWQzcmyfcKWebDG9/YN
        BJZkOXSUA3XPbtdDDLsx58AKEA==
X-Google-Smtp-Source: ANB0VdaWFjxa7jbUjnltdIOlLqS3iJ9vijVu2Am/O1ia5rQpNQJGF90KX9YbZDVo7dscKK3YPH8GCQ==
X-Received: by 2002:a63:1250:: with SMTP id 16-v6mr186184pgs.299.1535293503400;
        Sun, 26 Aug 2018 07:25:03 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a803:ac38:1531:22f8? ([2601:646:c200:7429:a803:ac38:1531:22f8])
        by smtp.gmail.com with ESMTPSA id t19-v6sm18390696pfk.182.2018.08.26.07.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 07:25:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
Date:   Sun, 26 Aug 2018 07:25:01 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <01BF319B-D6F3-432F-AE1A-1B8B4E3A36A4@amacapital.net>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de> <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Aug 26, 2018, at 7:18 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> On Sun, Aug 26, 2018 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>> Do you mean to say you intend to make kernel_fpu_end() and
>>> kernel_neon_end() only actually do something upon context switch, but
>>> not when it's actually called? So that multiple calls to
>>> kernel_fpu_begin() and kernel_neon_begin() can be made without
>>> penalty?
>>=20
>> On context switch and exit to user. That allows to keep those code pathes=

>> fully preemptible. Still twisting my brain around the details.
>=20
> Just to make sure we're on the same page, the goal is so that this code:
>=20
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> ...
>=20
> has the same performance as this code:
>=20
> kernel_fpu_begin();
> kernel_fpu_end();
>=20
> (Unless of course the process is preempted or the like.)
>=20
> Currently the present situation makes the performance of the above
> wildly different, since kernel_fpu_end() does something immediately.
>=20
> What about something like this:
> - Add a tristate flag connected to task_struct (or in the global fpu
> struct in the case that this happens in irq and there isn't a valid
> current).
> - On kernel_fpu_begin(), if the flag is 0, do the usual expensive
> XSAVE stuff, and set the flag to 1.
> - On kernel_fpu_begin(), if the flag is non-0, just set the flag to 1
> and return.
> - On kernel_fpu_end(), if the flag is non-0, set the flag to 2.
> (Otherwise WARN() or BUG() or something.)
> - On context switch / preemption / etc away from the task, if the flag
> is non-0, XRSTOR and such.

It=E2=80=99s not that simple. First, these states need names, at least for t=
hinking about. 0 is =E2=80=9Cuser state in regs=E2=80=9D. 1 is =E2=80=9Ckern=
el state active=E2=80=9D. 2 is =E2=80=9Cnothing active=E2=80=9D.

The actual encoding will be something like TIF_XSTATE_UNLOADED: user state i=
s not in regs.  TIF_KERNEL_XSTATE: kernel is using FPU. And this fundamental=
ly doubles the size of struct fpu.

Tglx, that doubling-the-size-of-fpu makes me question the idea of letting th=
e kernel use the fpu while preemptible.

> - On context switch / preemption / etc back to the task, if the flag
> is 1, XSAVE and such. If the flag is 2, set it to 0.
>=20



> Jason
