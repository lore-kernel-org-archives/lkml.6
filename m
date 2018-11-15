Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EA321582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UKPTcj9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EA321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeKOQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:30:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46924 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:29:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so4442355oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYTgiDGTrq1OyCCVYQAp6/x/Oodgbs77pkYGB4OgZ00=;
        b=UKPTcj9k0YLe3tZ3GapSbzleA5HltwspUYUmR1gCFJ3Hl5JaY5rIlzzVSNHCTAf8Eu
         IuGe8tPhTBnuDixK/YuK3P/eaKFqmKceBjppccPRdv00eshXF46GC1i7rbwZUIWF58DY
         juQvXBx49dZn9H3cVjcls8AEddWsZ1xR5ltig9S9qYC4DdZdhOzTH5cJ+QAlsVglngTt
         4Y+XF25jYpQd103CYxK7Orq9aUS+RDzjkOrmu4mhW5J4xRzUpw/DDrA/mY+Jemd+koK+
         /aWLetJUbYbNpPJgf7ufiYHu94GuNdFnjEHtDr34MpMw+rEjrU9gPUQtMK7cLvwpKLrc
         gNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYTgiDGTrq1OyCCVYQAp6/x/Oodgbs77pkYGB4OgZ00=;
        b=nIcJR4Sr6Fk9VU+AyYSQHZOtIX7PbXe/w8i9m184P2HrN276OhpHU/GLU9V3Rg+kDn
         1kZdnPXM8V5G2Is7bSrOyYt3HXScwFq403w1WrDY6PIE5DVtWaQk/tGBMToAE5KGkGOJ
         Wf0qbRJzNbkl1aIdtPX7/X8+FGFEsDAOMvgxKmiifcmGxomS8K5FrmDwqhK/8dwMy+M7
         OFnDhRFc17YQ4a+ushZeXyOzgxkCX19Rb8KOvYrg4kaNptcs9J/ebW6f3HbUMWCZL/dR
         BGb8rxvi2emkg9wPXq5uYpVzAVIRo3mrng1QNrQ4fKYUSPGo8BkrEMouSRLUs50lPQwV
         CpcQ==
X-Gm-Message-State: AGRZ1gK4bNVXz0DARks7AcQ0vNIwD/xLfiWPv7DRJZvXzfsE97jEvu9h
        kykS4ytFlqLLyUDzp1z1LERbS8OyfbUtuNWligSM5Q==
X-Google-Smtp-Source: AJdET5e/O1kcqSkcJ88PafqEPXz+2hodMmxVKFTlQy4o2lD2leiqU99fcq41EHhluU68Ba6pjo5PqwDt5Sb5DwJMJr4=
X-Received: by 2002:aca:bdc1:: with SMTP id n184-v6mr2986314oif.321.1542263008795;
 Wed, 14 Nov 2018 22:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
 <20181028125501.17336-2-martin.blumenstingl@googlemail.com> <6793aba9-87fc-6cf8-cada-f1fa6a1e0040@linaro.org>
In-Reply-To: <6793aba9-87fc-6cf8-cada-f1fa6a1e0040@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 15 Nov 2018 07:23:17 +0100
Message-ID: <CAFBinCBueqknBzV6PJnuSzd09=dd06gkjZG+ykr5qKLf=uRT2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: meson6_timer: use register names from
 the datasheet
To:     daniel.lezcano@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, carlo@caione.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

thanks for your feedback!

On Thu, Nov 15, 2018 at 2:35 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/10/2018 13:55, Martin Blumenstingl wrote:
> > This makes the driver use the names from S805 datasheet for the
> > preprocessor #defines. This makes it easier to spot that the driver
> > currently only supports Timer A (as clockevent with interrupt support)
> > and Timer E (as clocksource without interrupts). Timer B, C and D (which
> > are similar to Timer A) are currently not supported by the driver.
> >
> > While here, this also removes the internal "CED_ID" and "CSD_ID" defines
> > which are used to identify the timer. These IDs are not described in the
> > datasheet and thus make it harder to compare the code to what's written
> > in the datasheet.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/clocksource/meson6_timer.c | 110 ++++++++++++++++++-----------
> >  1 file changed, 68 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
> > index 92f20991a937..c622135bee9d 100644
> > --- a/drivers/clocksource/meson6_timer.c
> > +++ b/drivers/clocksource/meson6_timer.c
> > @@ -10,6 +10,8 @@
> >   * warranty of any kind, whether express or implied.
> >   */
> >
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/interrupt.h>
> > @@ -20,80 +22,102 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >
> > -#define CED_ID                       0
> > -#define CSD_ID                       4
> > -
> > -#define TIMER_ISA_MUX                0
> > -#define TIMER_ISA_VAL(t)     (((t) + 1) << 2)
> > -
> > -#define TIMER_INPUT_BIT(t)   (2 * (t))
> > -#define TIMER_ENABLE_BIT(t)  (16 + (t))
> > -#define TIMER_PERIODIC_BIT(t)        (12 + (t))
> > +enum meson6_timera_input_clock {
> > +     MESON_TIMERA_CLOCK_1US = 0x0,
> > +     MESON_TIMERA_CLOCK_10US = 0x1,
> > +     MESON_TIMERA_CLOCK_100US = 0x2,
> > +     MESON_TIMERA_CLOCK_1MS = 0x3,
> > +};
> >
> > -#define TIMER_CED_INPUT_MASK (3UL << TIMER_INPUT_BIT(CED_ID))
> > -#define TIMER_CSD_INPUT_MASK (7UL << TIMER_INPUT_BIT(CSD_ID))
> > +enum meson6_timere_input_clock {
> > +     MESON_TIMERE_CLOCK_SYSTEM_CLOCK = 0x0,
> > +     MESON_TIMERE_CLOCK_1US = 0x1,
> > +     MESON_TIMERE_CLOCK_10US = 0x2,
> > +     MESON_TIMERE_CLOCK_100US = 0x3,
> > +     MESON_TIMERE_CLOCK_1MS = 0x4,
> > +};
>
> It is not required to specify the values. The standard defines the
> default first value is zero, and each enum has the value which is +1 of
> the previous one.
the idea behind this is: these are values from the datasheet so I
wanted to make them easy to find when comparing the datasheet with the
driver.
I will replace the enums with simple #defines if there are no
objections (that also makes it consistent with the other register
values in the driver).


Regards
Martin
