Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAACC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5232086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd8q4LgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeH2Mqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:46:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34562 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Mqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:46:42 -0400
Received: by mail-it0-f66.google.com with SMTP id x79-v6so4498898ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtQRJCyRCjZxNgqqWwfTKn0jQ65JPR4vuIluTXMwTn4=;
        b=Rd8q4LgD1k1QHD8tmfqa21a5zRhHK6LhyiYBArNpr7QvTa73aJMh/LOn8+T5eXlzZP
         GEO3baLPOLquUwe1/hqXp8l618XW2C0feZGOnOCPaj/Q1KwmLak0lMJc/IFSaN4Us9hd
         8jcElTQJzcGfIweO0Bjclx+eBPAZ1MrQbFq8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtQRJCyRCjZxNgqqWwfTKn0jQ65JPR4vuIluTXMwTn4=;
        b=EMcTz1vvStUM/TmMSOh+0RS0zDRmZDuYczk9PfBoSnfti3Jztff6y+VvPV35/rPdph
         9U8OPNzHQXJglrOcbFB8ZUCVHacMY+bCRNrQ9u+TO7EAUasDc9fXs1czRYyqWIWY6aXL
         v+5qe4HlL7GjIlJ5uHOlgjYrg5cyOYOloxESP+NOq1Swcvw2QC1UZ7Arx+KY3DAMdA+0
         jFkZQY2KAd/9c4GAToIein4bOX2uMDGbaDrfGjc6i12Tz3C500I+PvBCkKToQnKayV+G
         OvK52/a0e3KNGOqr8FOOkrXQsIvVUfZ49JbRobgJQLV/cpA6V34YUDYK1TvhSALqJqiH
         nSkw==
X-Gm-Message-State: APzg51B2PYblMLaadaAPEIOxnoQESaUZtFycfVMDgINZbsvkN7BVluzK
        Gqt2ZEGXiZXTosNZCJ3cblLRVtGzHlH6hoheBIvFgg==
X-Google-Smtp-Source: ANB0VdaziVI1hxHmziLvNnp5SGMEjhrgiOUNqrBULaduJ2w/U1YdQrZyLvS3v/j+5iTMo6XFhkwkwivp6fXpDAI3j08=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4223809itk.62.1535532650147;
 Wed, 29 Aug 2018 01:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:50:38 +0200
Message-ID: <CACRpkdZJHYda-TRJ9QB00Cs7Kna-Dq9Qhyugbv8wz0rxNwK2bQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: uniphier: drop meaningless pin from SD1
 pin-mux of Pro4
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 4:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The pin 327 was supposed to be used as a voltage control line for the
> SD card regulator, but the SD card port1 does not support UHS-I.  It
> only supports 3.3V signaling, hence this pin is pointless.
>
> Just a note about the background.  At first, hardware engineers tried
> to implement the UHS for this port.  Then, they needed to shrink the
> silicon die size, and gave up the UHS, but forgot to remove the pin
> assignment.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
