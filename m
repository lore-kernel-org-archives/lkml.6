Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DBC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D6121927
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G99yMd8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBHMfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:35:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44258 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:35:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id e24so5466994otp.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=akSIvd6WCcF7HY3F6oGHn8ulHVn3lvhcTG9kZsVe9vA=;
        b=G99yMd8XaurWpkZ6qCL2c5XTrfPrfqEca0MfhXjJ84R2LyXk/WlN0KWy7rTk+uMHGP
         X89gZFWtFPF8sAdJkkjXKEjgC5x6KJODdZKfTr/6UvlCatSt+HIeIA//XD3h2REjx6dO
         YUiB0aZJ/CH/JkkTLqIGVJHHsZBxefrm1WqNlMKrOo+WwdjcW8JSocZJVWKjbIYt99Va
         Ga+zIzcI90V4JiOlPWPPK2gCW6GXqxf8WbjRPqyNYlj75tWbXj1YXvvGfExAU/jJJtqz
         SiphsKMDlOMyiyXQRwZT9Duh+c94ES07qXmU9yD1lVLIjqum6SMVtnSqDtwKCiYuUbWH
         qjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=akSIvd6WCcF7HY3F6oGHn8ulHVn3lvhcTG9kZsVe9vA=;
        b=BzCn2T3t/9T33gkKjtgewl+RCUYXPj+/KqZlv0xhyLLKWB7/fxIzJa9FlmNyHLDJH7
         mReRlBlr75oARsLDPU/ZwLVwyZFIDWbekVgzx0j7Q/QrTRYzJQ82AnLFsNiaZ87axQpD
         znu+bemy/Y0Mdwm1BVeAA8M+BK8k6kdDePU0ev41knXaWZnKtLNd7YnoOSmifh/Fq/Be
         LWagUXdshBEznWdjz8Tiafe41mQAGpwUae0LhSSmoIichsNjLPgL5d2pJ7AaJJwhcZiX
         8o69z/jVYN48+iBsCPuTnTUK74Q9FbkwwPt/cQDni5X34fVPfY7en32hNZztOGGVWT8Q
         U0xQ==
X-Gm-Message-State: AHQUAubmn8edRjAtVpHZ5qTPCtJErdjzCscOVIJRIOifeBs62YBB3KSW
        /Z1J1YPhXdBbG/ijRfpaeinuNkNtWTAz+a4jgtBXbw==
X-Google-Smtp-Source: AHgI3IbrmbNlc7e2FCle4ibP6LEu4vFy5LDv5e8hWf9/mVAjU3HkyOWXVv3AKl3LeSu7nDCyeMO63rJUOP+l91XsJx0=
X-Received: by 2002:a9d:7c1:: with SMTP id 59mr13633936oto.191.1549629303596;
 Fri, 08 Feb 2019 04:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl> <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com>
In-Reply-To: <9d423e18-8c85-731b-388a-1843067db242@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 8 Feb 2019 13:34:52 +0100
Message-ID: <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
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

pt., 8 lut 2019 o 13:06 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> > +static const struct davinci_timer_cfg da850_timer_cfg =3D {
> > +     .reg =3D {
> > +             .start          =3D DA8XX_TIMER64P0_BASE,
> > +             .end            =3D DA8XX_TIMER64P0_BASE + SZ_4K,
>
> SZ_4K - 1
>
> This should have prevented watchdog timer from getting registered.
>
> Thanks,
> Sekhar

My clocksource driver doesn't call request_region() so a subsequent
devm_ioremap_resource() in the watchdog driver would still succeed. I
now fixed both the missing call and the value here.

Bart
