Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F423DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA23B217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwBPylfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLRKBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:01:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46046 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:01:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so9091883qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WeptxUz1NFu8vRQHSJh0qy1cQKeFCQwjmhRPJqUMho=;
        b=DwBPylfzkxVVSwPnKdVPpmECNL0XIcRYwq9UgJEvoj93SQMmX0j3LvKp2bSUu5kndm
         +SJn4qK4mW+NfuiBRLGALLsdTqIUCYlxveDNwviSpEuO+YO6X+SBJLLvgF8j+/2SUpXV
         JpLsZYJsbkHjtcDYCFLCw0bNLnSqAn/sAkIpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WeptxUz1NFu8vRQHSJh0qy1cQKeFCQwjmhRPJqUMho=;
        b=BQldw2b2tAk6nmaiiIJVKO+IYwnR+StpsJukSfUjRaXwuCHgpeZOUzl1uV65mxCxrU
         VatAZqxYJ8GhYtwPcrle2Dn03J7s62C+zCaHQjJTKa7cVaSuNTMt39em08SirvdbyAOJ
         KWbKD+nwyMrDD+bfyS7Sk2D7kS4+01H2SFTXjj3uiHFFoBQofjH/B/JPaspj8il2EIUw
         kqymyg7goY9nYdStT7xbf0DnBJqGozgHiKKtjy2Jp4FGZUfJeHwzP6vQexWevtRcrbfX
         4E4CQels1vIH3z4+OZMkZdhVn4URLtpKwmp9DzNytgqpqshVipaFFzlHEMYLxBd1XGo/
         51pQ==
X-Gm-Message-State: AA+aEWbAIpMmf+L4f/lj3OdUwvQLQjUjWbvwRlWfXYYK9+ykiOoLM7Gu
        FdayPNM2pIqPm7Qh8v0utjDCgB+xSPH59zJ4aTKLGg==
X-Google-Smtp-Source: AFSGD/Wk2JEhQWCyJ0pWM/30N0ELC0cPx2wlkW6Ksu9z23FwbZh+J6ohi/oUkcaE/IgLfNhJJACMS2rwj2ObywCoAWs=
X-Received: by 2002:a37:d947:: with SMTP id u68mr15152906qki.296.1545127274193;
 Tue, 18 Dec 2018 02:01:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545063166.git.amit.kucheria@linaro.org>
 <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
 <87r2ef701w.fsf@purkki.adurom.net>
In-Reply-To: <87r2ef701w.fsf@purkki.adurom.net>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Dec 2018 15:31:02 +0530
Message-ID: <CAP245DXP4FiQSSKCqdGVOL+Fz=w0rAqvUcsBaL_j9AfCfp7TQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
To:     kvalo@adurom.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>, marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 1:12 PM Kalle Valo <kvalo@adurom.com> wrote:
>
> Amit Kucheria <amit.kucheria@linaro.org> writes:
>
> > Several drivers didn't have a specific maintainer (other than the
> > subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
> > patterns to capture all of them and add exceptions to the couple of
> > drivers that contain 'msm' but are not related to qcom hardware.
> >
> > Thanks to Marc for the idea to use the N regex.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  MAINTAINERS | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3318f30903b2..c9376030f77a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1929,20 +1929,14 @@ M:    Andy Gross <andy.gross@linaro.org>
> >  M:   David Brown <david.brown@linaro.org>
> >  L:   linux-arm-msm@vger.kernel.org
> >  S:   Maintained
> > -F:   Documentation/devicetree/bindings/soc/qcom/
> > -F:   arch/arm/boot/dts/qcom-*.dts
> > -F:   arch/arm/boot/dts/qcom-*.dtsi
> > -F:   arch/arm/mach-qcom/
> > -F:   arch/arm64/boot/dts/qcom/*
> > +N:   qcom
> > +N:   msm
>
> IMHO this is pretty fragile in the long term. For example only due to
> historical reasons qualcomm wireless drivers currently under ath
> directory but who knows if at some point we switch using qcom (or
> qualcomm) directory. Also the wireless drivers might easily have
> filenames containing strings like "msm" or "qcom" (which I assume would
> match with "N" rules above).

I've now sent a v2 of the patch that tries to list all the drivers
explicitly. Let's see which one is better liked. :)

Regards,
Amit
