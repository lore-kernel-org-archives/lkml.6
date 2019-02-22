Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB962075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM1FitHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBVMQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:16:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46225 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:16:06 -0500
Received: by mail-io1-f66.google.com with SMTP id k21so1513156ior.13;
        Fri, 22 Feb 2019 04:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSDXeQtwrVw22ntSVHFiO7PWYxPzF9EBjM/hlsDz/Rw=;
        b=iM1FitHfcrLmn9bStAvtW7HxnSeec5Wx/GxwiGNQ/R8xS8B/l7tn7Nzszw6KlZSR0s
         rpWJpikgVyLZb6jli3V6gQ/ohK9pASTC7BsQMXxBAjk+vvaJqc1sTl+InwZGqx0cZE10
         YByycpl6IrD3K7TUJ/uxYrpDBJGkZhCWDkR1//I6VENKMDYk/abgZQv6lP5Fj0osiuI9
         Zj0XP6z0QodXZ4bwtBVvcdistsabQXcfHOO82hdmHYsTJhYxDWf4A+TSRXsP84rYst8M
         gC3vLliBBdPtrNnIXPhhgaXH4T88EZYUqQT6G/xJJuInhpm+hckaKFPIt6N05sMFDjP5
         RAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSDXeQtwrVw22ntSVHFiO7PWYxPzF9EBjM/hlsDz/Rw=;
        b=Qx8rcbVN+61xEaJaMSi7s72NJhZ9z/ZtIFYmP5NogwV2+KFLwCYySqlo8yvLpHJFNv
         fSjujuJ+ae4do0+GzgGCOlVNDCha7l8P27aIGXVd6KsA7X2vQcE3izT0DiqLJ3OWI2xR
         cIA7O9mgEECo4xfcMr9dGeHH/wHGm59ShKqlcgIL5OavMa9/2Yas+d1BNwO9+Zi5MyNa
         54L97hBbiYsCMTjZJHuJmgOOTQFq6V40Gnwuk6aNTYosKVDvPUCWiSgiCZlUfue5PTN+
         6fqkIJN7IwUVL1c3m2HhaFrrpe3vyZLjBI/qG+TN/hB5CfFZcIPGUnv8gd5TpcrN6I7q
         bCzg==
X-Gm-Message-State: AHQUAub5RS7IQkzGJdq/zhMBqJjw9q2tUaF3pXuNAOZEa0FnZTtUiDUz
        AqdmiBwhZ18ak0eSlIW+uSzySAEnCxshHhc5otI=
X-Google-Smtp-Source: AHgI3IahQ52jB4z4hPgGVGQE61GKdSAUUpKRHLRpB1j0p753PEFLBuenfsek3T4DsAAGyD/qmGllHrTgTeEjoq6pqIs=
X-Received: by 2002:a5d:9750:: with SMTP id c16mr2072673ioo.300.1550837765071;
 Fri, 22 Feb 2019 04:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20190219095808.12059-1-m.othacehe@gmail.com> <20190219095808.12059-3-m.othacehe@gmail.com>
 <20190221195641.hqvjxixhj7fi4gff@pengutronix.de>
In-Reply-To: <20190221195641.hqvjxixhj7fi4gff@pengutronix.de>
From:   Mathieu Othacehe <m.othacehe@gmail.com>
Date:   Fri, 22 Feb 2019 13:15:53 +0100
Message-ID: <CANVeeZyQU_NAKYaqKQStWzCOAmidTqLAph0SupfmD7zrH5K_9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pwm: hibvt: Add hi3559v100 support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> The patch looks fine now. (If you have to do another round:
> s/again/twice/ in the commit log and s/once more/twice/ in the comment
> below.)

Ok.

>
> I wonder if this behaviour is a bug or a feature of the hardware. Is
> this additional enable needed to apply changes to both period and
> duty_cycle atomically? Is the 2nd enable needed independent of the PWM
> already running? Can you share the relevant part of the documentation
> without violating an NDA?

The same goes for the period, so I'll precise it in v4. This behaviour
is not documented in the SoC manual.
I discovered it by hitting the problem. Hisilicon support confirmed it
was needed without any
further details. It looks like this behaviour is "by design" because
there are 2 registers for duty cycle and period
and 2 state registers for duty cycle and period. When the first two
registers are edited, the state registers are
only updated on sending a new "1" in pwm enable.

I don't know if the two boards already supported by hibvt driver have
the same design but it seems quite likely.
Maybe this enable thing could be done for all boards and not
considered as a quirk.

Thanks,

Mathieu
