Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB049C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BC420881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OvcAGoAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbeLBVMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:12:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35192 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:12:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so9197863oif.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNC6UybqQt8UI6xiJE2xLki3zzn88E5tXcT+MtLKe68=;
        b=OvcAGoArXMu1YS4lVnY9aw1AMOyip7+gv37XNXPayMniRpD22xvLImQy8R2ojzU409
         DfZD4aWYzEn3z4Zmx2nKBYIknhbJe160FgTVOS2UDSBNkDp2mp25VXr0uheUcSH5KGik
         jv46htjH2kgB27JniIAvwHEM0YFg00fBOpgHpDBam5JWbU4ZYBg3hUBFbuISZOOj5GCQ
         Gp53cAiZLgYsfYUufBmw4Pd4TAuUqb6z8SH+7/FvMR/3oFEVXricX2ksJcrVPGqK3IsX
         K3EAzkPDooI8Xrp71nqr4Zh0IeO1DbTCsPaP+Sh/jPV3xC4K+SPfPvMpJW8AuVfIOaMy
         Nq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNC6UybqQt8UI6xiJE2xLki3zzn88E5tXcT+MtLKe68=;
        b=qlawioyrxZfFtXaUR7zNblzHOivUuKiK0wPas851kTwuzecJVivkvAJfer5dYaqu9l
         tp1jRc0DJuXK1Yg1EzKBpI0Chh1U2fuBVGMtLVtoeII+4R3Jl113RSC9liEGnKijDVZD
         SDeJ/V5484o3Akdk6uENWB66x2lDZM4e82HeJ4jW7L5lAs24dD8DHM6OlrMkuQRDcVZ9
         7jUTnfU0qXlwWbpLOjj+q3Y2+VxrwnhuBNLuQWh0eUY6h8df7PA9izPwdB9cm0vO9CqH
         HRsphhi7q4Ogj5tYIRkcU/IY09IJ74krcancq+IDQBHU/yF3FrjtM0E4Nn9D+6GK/MoL
         Rn2Q==
X-Gm-Message-State: AA+aEWapCIGMEHTvz/OCS1pTGvUGkzJpeuDDI6J6ZFx5s5n6tehCqbJw
        1d/4j003KjeiS5qsWcKuCzM64qkbquyL27dlBqc=
X-Google-Smtp-Source: AFSGD/Vl3zKkeQK3n/q92OMoPK0sdOEfpj9yvzmrF/gMXAir7g7yGiQNM4aM2dY/hAyCy3yvaTVmLp4zmp796DecV1Y=
X-Received: by 2002:aca:f0f:: with SMTP id 15mr8898641oip.47.1543785152265;
 Sun, 02 Dec 2018 13:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 2 Dec 2018 22:12:21 +0100
Message-ID: <CAFBinCDg2tbaJMYusLyH-q1=n1Mb8ng4BhGOa8=vc0QoAFMzFA@mail.gmail.com>
Subject: Re: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
To:     khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, carlo@caione.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, Nov 23, 2018 at 8:53 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The 32-bit Meson SoCs use Cortex-A9 or Cortex-A5 cores. These come
> with the ARM TWD ("Timer Watchdog") which contains a timer and a
> watchdog as well as the ARM Global Timer.
>
> This enables the corresponding configs for the 32-bit Meson target.
> Additionally this adds and enables the ARM TWD timer. The Global
> Timer is added but currently disabled because it's clock input is
> the PERIPH clock which is derived from the CPU clock. Thus the rate
> of the PERIPH clock will change when changing the CPU frequency.
> Unfortunately the Global Timer driver doesn't handle clocks with
> changing rates yet (unlike the TWD timer), thus we keep it disabled
> for now.
>
> The whole series is inspired by an almost 3 year old patch from
> Carlo: [0]
>
>
> Dependencies:
> - I build this on top of my other series "ARM: dts: meson: add the
>   timer interrupts and clocks" from [1]
this is already merged into your v4.21/dt branch

> - CLKID_PERIPH requires updated clock driver headers. Neil provided
>   a tag which includes the updated headers: [2]
this is still a dependency which you could easily pull in

> - There is no runtime dependency on the PERIPH clock as we don't
>   have CPU frequency scaling support enabled yet. In case the TWD
>   timer driver can't find the clock it falls back to auto-detecting
>   the clock rate at boot time. This is safe as long as we don't have
>   .dts patches in place which allow changing the CPU clock rate. Once
>   we enable CPU frequency scaling support for the PERIPH clock becomes
>   mandatory so the TWD timer driver knows about changes to the PERIPH
>   clock (which is derived from the CPU clock).
and there's still not a hard runtime dependency until you apply [3]
"ARM: dts: enable CPU frequency scaling on Meson8/Meson8b"

> Martin Blumenstingl (6):
>   ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
>   ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
>   ARM: dts: meson8: add the ARM TWD timer
>   ARM: dts: meson8: add the Cortex-A9 global timer
>   ARM: dts: meson8b: add the ARM TWD timer
>   ARM: dts: meson8b: add the Cortex-A5 global timer
>
>  arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
>  arch/arm/boot/dts/meson8.dtsi  | 32 +++++++++++++++++++++++++++-----
>  arch/arm/boot/dts/meson8b.dtsi | 32 +++++++++++++++++++++++++++-----
>  arch/arm/mach-meson/Kconfig    |  2 ++
>  4 files changed, 72 insertions(+), 18 deletions(-)
if you plan to send another pull-request to the arm-soc tree then
please consider including this series.
it fixes some harmless (but still noisy) warnings during boot which
also also seen by Odroid-C1 in your KernelCI lab:
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Could not switch to high resolution mode on CPU 3
  Could not switch to high resolution mode on CPU 2
  Could not switch to high resolution mode on CPU 0
  Could not switch to high resolution mode on CPU 1


Regards
Martin


[0] https://patchwork.kernel.org/patch/7797581/
[1] https://patchwork.kernel.org/cover/10687005/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html
[3] https://patchwork.kernel.org/cover/10705475/
