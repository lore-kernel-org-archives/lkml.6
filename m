Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74820857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ieGfk5dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBHMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:48:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43527 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBHMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:48:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so5546175otr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JWzV0M0DRGDSHP1/88xQPKP0xbprssAo28cl+Ap6wNM=;
        b=ieGfk5dQ4O40tNc6NnZ4JeBT1H0kM6WLPymOjxvvkInUU1szdAv052OyksGLlVaeTj
         hDJFRn+9OHbhXfIWpx0q//LKyMAn1B7TkEBe7lZh1I42nOf8ToYTxr9a3YQ4jVMoJEM6
         6ZUa+yc8DStA524HuJ6zwZu93BWXvXetlgqMdANDJtnUdZScdvGbIN+lPUWfeyEVjAEk
         RHLFA+S4CPkJpsHrmRYGvYjeT7v4CQKJfxHLwCLiV8oMPL/FR2ABQ+2JVmM2nEB3KGdJ
         NjhyC8Cq3Fq+Q91eVmAb8jJen/YhWtJHpR0q5OrqHF+X5cIgnzHuU7NrrJ45mYDe98MM
         qBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JWzV0M0DRGDSHP1/88xQPKP0xbprssAo28cl+Ap6wNM=;
        b=jw7/3Al246Aam5kcJZ3tBgYE3i1VV4Tz+L1vEOLoKvd8yBEcAE7dP8rsf7ojFOxrMU
         KRcsLP65Q7hxS05ZOE0AHUz6TQFPh/u2fW3I8w0ph2X1BjovmBob+nEp9mNrgEGqiTJv
         PDbaStmhtc1bNW8kX17vdAxbtHsIfvnQSc5SDzP3CdYKP1ioZ78Q1QIXdiAlxMu1nXWZ
         53mLUK1hZouj/viE+Ws4aOmXiLhHw3IDJdQHto7BKa/cMaat2fN/LhCMA5tPwcANksRg
         ycTCAfq5+I2cMLw2AzRSsnCbBv3r2v/cHkp1CIqPRPnDhET6NXJXw3TYs7iKc6Fr5U8J
         xx3w==
X-Gm-Message-State: AHQUAuZ2QyC2dYM1ps2kI+rO9LAZqP0DMCzecpuP6QB8mPd+wEFh3XmS
        R6c8zEUEYxBuSyxu/CaLRHaZl4WtF9DimsRIJjMseQ==
X-Google-Smtp-Source: AHgI3Ial+h5E9Y271MzSd0t0lZHzB/vXzwxcYRl1ZDWcV0xgScVWDgDusw+8T2RGaYgTewepPiemzptpCz2QRltdDe0=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr4070807ote.234.1549630087103;
 Fri, 08 Feb 2019 04:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl> <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com> <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
 <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
In-Reply-To: <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 8 Feb 2019 13:47:56 +0100
Message-ID: <CAMpxmJUXuxEp+424Z_YtAq02XvBzcDAj73LgOBnXE-T0fhmCTQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lut 2019 o 13:37 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 08/02/19 6:04 PM, Bartosz Golaszewski wrote:
> > pt., 8 lut 2019 o 13:06 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
> >>
> >> On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> >>> +static const struct davinci_timer_cfg da850_timer_cfg =3D {
> >>> +     .reg =3D {
> >>> +             .start          =3D DA8XX_TIMER64P0_BASE,
> >>> +             .end            =3D DA8XX_TIMER64P0_BASE + SZ_4K,
> >>
> >> SZ_4K - 1
> >>
> >> This should have prevented watchdog timer from getting registered.
> >>
> >> Thanks,
> >> Sekhar
> >
> > My clocksource driver doesn't call request_region() so a subsequent
> > devm_ioremap_resource() in the watchdog driver would still succeed. I
> > now fixed both the missing call and the value here.
>
> Ah, got it. Perhaps a call to request_region() should be added to catch
> issues?
>

Yes, that's what I meant by "fixing the missing call". It will be
there in v3. Actually the kernel seems to be missing a non-managed
ioremap_resource() helper. Maybe I should add it as well.

Bart
