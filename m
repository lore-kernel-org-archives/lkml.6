Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9DC20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvxZgqvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBUVnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:43:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37275 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:43:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id w66so113688oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O/HK3mLFtv1ji70aNzHI0DDfU7TZ/B+m+LX2qxsSsjo=;
        b=ZvxZgqvKG7wqca4a4L8RX9ONLuio4rGzVeKj0VEfCAT0brPw91GaCXMI/pbyb9apQE
         wGSwOgwfIDsFtLbYbLOFBaoK217nSNFqIbJqTisnok7wYxrWXOqKngiSGZuoEdPzqGz7
         BBUOolGOnKjZFVZvYu+TNqH0aj2A7nk5NaoAbsEB9kYNcBBfMV4B5SlNAqIsMAll49NO
         GNvRAIrFNd+9wRdI0Iiys94kKxfNH3sLN10UNNfzxTOFSlp+d83pkVlBL7e6nMz5ObZf
         S0CQnFCC3FKALGLKmXm3Fy0YuBQKvYlKdkTGV8IJDl8hf1+iyptrx0aG18JCnuUWpG75
         38Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O/HK3mLFtv1ji70aNzHI0DDfU7TZ/B+m+LX2qxsSsjo=;
        b=MyM1fWyRFNCI3uMq481AdeJ4uzn4Q1+m/mfxG8zm0aN2sYhr1ZWIIbJWQ6GXeQZBIa
         CDq5TwwbIRgMS9d2bLu0StmMb5kcSDHQtCxxKNrbTx+8A5wJx45yWgN1CvF8rVqEHrgl
         jOV5G06E0UKGrfJzpEQXA3He6DgjpnEQ5jO3GQ6nJUB7Bn7N9cxu/0evQx2JqvERmaqX
         lAp5duPmYF+oiEPPlrh0ay04mGY+ZVFBQPwpGRxMOaLnNeEZhPDZ0QOdRQbuEkpmZcOQ
         ppOGmDWGL0QYsjfte7HcEIdoTN3q4it8h04bl0dIhKoZ01fRafa8VLgoMABEjfK5su62
         VG/Q==
X-Gm-Message-State: AHQUAuZcf8wS6ofZPF7mJe0IF6swfFH7ecmwckV5iIBpuNBNbOKthE3n
        4nDKU+lTNo26UV13xASaShu+66tnCbCqmUv9OIw=
X-Google-Smtp-Source: AHgI3IaxR7oowo9aHVrXDcfNQLtwBucLAP8tWR+1S0CGhsTx4RrV55SyrzIEEREEzmeJWSSecYHdV42cNIIZnLCsyVw=
X-Received: by 2002:aca:b8d5:: with SMTP id i204mr429603oif.169.1550785424627;
 Thu, 21 Feb 2019 13:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20190221160648.29785-1-david.abdurachmanov@gmail.com> <cf0a7334-c347-b254-f80d-93640f201b20@linaro.org>
In-Reply-To: <cf0a7334-c347-b254-f80d-93640f201b20@linaro.org>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 21 Feb 2019 22:43:33 +0100
Message-ID: <CAEn-LTqUcp+xtGHLL6E1BL-GFUeDwJ95RDH=NLegZZwBxixe1Q@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Make ARM_TIMER_SP804 depend on (ARM || ARM64)
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 9:48 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/02/2019 17:06, David Abdurachmanov wrote:
> > Resending to incl. a proper mailing list and maintainers (not suggested
> > by scripts/get_maintainer.pl)
> >
> > This is only used on arm and arm64 platforms. Other timers also seem
> > to depend on (ARM || ARM64).
> >
> > After I moved Fedora/RISCV kernel to 5.0.0-0.rc2 it keeps asking me to
> > add CONFIG_ARM_TIMER_SP804=3Dn to my config. This patch resolved the is=
sue.
> >
> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> > ---
> >  drivers/clocksource/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index a9e26f6a81a1..7593d80e1c88 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -369,7 +369,7 @@ config ARM_GLOBAL_TIMER
> >
> >  config ARM_TIMER_SP804
> >       bool "Support for Dual Timer SP804 module"
> > -     depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
> > +     depends on (ARM || ARM64) && GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
>
> What about adding the COMPILE_TEST option:
>
> bool "Support for Dual Timer SP804 module" if COMPILE_TEST
>
> but not add the ARM || ARM64 dependency ?
>

That would work, but is that consistent with other timers?

Looks like a number of them have depends on + COMPILE_TEST.

Some examples:

config ROCKCHIP_TIMER
bool "Rockchip timer driver" if COMPILE_TEST
depends on ARM || ARM64

config ARMADA_370_XP_TIMER
bool "Armada 370 and XP timer driver" if COMPILE_TEST
depends on ARM

config ORION_TIMER
bool "Orion timer driver" if COMPILE_TEST
depends on ARM

config ARM_GLOBAL_TIMER
bool "Support for the ARM global timer" if COMPILE_TEST
select TIMER_OF if OF
depends on ARM

config CLKSRC_EXYNOS_MCT
bool "Exynos multi core timer driver" if COMPILE_TEST
depends on ARM || ARM64

david

> >       select CLKSRC_MMIO
> >       select TIMER_OF if OF
> >
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
