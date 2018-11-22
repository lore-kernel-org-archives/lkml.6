Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC4FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E820820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPosrY4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1E820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405878AbeKWC12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:27:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33723 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeKWC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:27:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so6834089lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ty6xzGtClUOXO0cCX1e1VMQ/MHg88JzkJ6fl3Fiw8JI=;
        b=NPosrY4Gc9FpZiaaXPGluswgQCo7Wh+JncB7rbjhPkmN3WOlO54uFW6bE7+o9z4qPl
         0KivetmRjdWD4fJRq4uCGaukrzkvL2qUdlIL2YxzW9SxI9lJrGZOeN41lWL0XsYP/JpF
         r5GTRjbMrF8/ug+LxklPbetn10m2UUvnfaFRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ty6xzGtClUOXO0cCX1e1VMQ/MHg88JzkJ6fl3Fiw8JI=;
        b=jXndIalPn4m7fzd0Kx0fBMBvvFwJglD09jfym3DnR/6FTxkPpuup7foCa2D8VvaC0Y
         8dKd9FbmJ6wd8IZRHt7fWyuTmz+Dj4kP/Lnk7+iHMsUlpL+OmBN3hLd+qWPBKYtUkSRS
         KI5dE3+LZ6oU+Hq7k/oGRAOgSeeof4TB9NkjydpRIBPPZegEGc/fvAC7lo8nhlWerSVs
         WWe4ekv13/0njGXu84uiSa/lvSnteDRHiqIV6AzQZCrOaiV2Cl13vMNwfuOXotWoTEfT
         BF4jnIKqQFZQqg36zAtbgd+Jl+W8ZnlLK7Db1GKr4SXr3NhlRkw/PZbQS9FA/KEl7KqK
         VMfQ==
X-Gm-Message-State: AGRZ1gKyFKFFbvfaY5G4Pv1IxbCtpKzIFJuCTevDMEnNvBN4y/gucVwN
        GaLO3c7+b9S+joxAr8xkJ4/EDa4u1ibcpUGmn3zmUw==
X-Google-Smtp-Source: AJdET5cbhOGw2OSlgGUY1kPQxrDwXGnNiRRM/IVSPQeWU8xilfrZ4pUPK1BTCuzEnL7NnRIH16cQm1ccSlJukseNx8A=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7293403lfb.96.1542901652035;
 Thu, 22 Nov 2018 07:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20181121101316.32194-1-ckeepax@opensource.cirrus.com> <CACRpkdb3HSQ_h1+9RvBUEDRDSCih7bv7kcf+=cc3-c0Hn6A0bg@mail.gmail.com>
In-Reply-To: <CACRpkdb3HSQ_h1+9RvBUEDRDSCih7bv7kcf+=cc3-c0Hn6A0bg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 16:47:20 +0100
Message-ID: <CACRpkdb9KStEkMigDX2kA4Q-tr6DuuWqqTuF6jXZK67Zp+DxmA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:19 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 21, 2018 at 11:13 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
>
> > The regulator core takes over managing the lifetime of the enable GPIO
> > once the regulator is registered. As such we shouldn't register the
> > enable GPIO using devm, or it will be freed twice.
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Oh no this is not the right solution I think.

All drivers passing a descriptor (config->ena_gpiod) do their
own refcounting, including some using a function that has no
non-devm* counterpart.

It is better if we teach the core to not gpiod_put() those.

The other patch series I am floating to get rid of the legacy
GPIO handling from the core will do away with all the
legacy GPIO handling anyway, so let me introduce a bit
of ugliness (that can be backported) and then delete that
ugliness with an updated series v8 of my legacy GPIO
cleanup.

Sorry for the inconvenience.

Will send a patch soon.

Yours,
Linus Walleij
