Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5F62081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8g7CfFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5F62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeLEOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:32:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41450 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:32:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so1052837ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmYxr9IatdTdyk1fQg9DYdQxDubDRuKPD/DCUsG+khg=;
        b=I8g7CfFoFxLDgMHh1B3GUvQ5mWE+VzT7PXFbQ2fa5svDV1A9Tya6ccvNmHuhE221pq
         XvFNkGRRduhV0GbOheT0yfV8tUM9I026x3iH6lKEVB6XmM8hSdyfzY9B/MZ5r0Hhgi67
         vLuLC3AKYFbMsLRx1/JMDIGHbkTWjAlHY9QmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmYxr9IatdTdyk1fQg9DYdQxDubDRuKPD/DCUsG+khg=;
        b=BSIB1D7qej4svQcmDv4lRW0yeYe0mn9SKu0fxo4EWDvEqH5laprR/QY7ExnjMZINxS
         LDtiAqGNxCGrmOkk+tU2VvHNzDMCz951cn9Qy4Kas2BE4MOSaeqdXMovtOm+un1NUY8f
         vIyWMMAHC54dDU243kUUOMJg6JiYfQF0t5VRb6jbGdEeYmXxckziBp1LlG8HaxeevUmk
         7bzcaDieBLInIxbKXhXyCAGMG/gcQ4io65Vt7K641ozX1IuLmxmQXtGfAizkgq26NbXe
         FWmZDB9JJZZm1KRRjeroc1GHrMV+Ofq2iqyE4oiWcpqyvICX7A4SszZ7Ai930eOcVL1w
         q4VA==
X-Gm-Message-State: AA+aEWZZdiPFASGN3kJGB0BXskIIIjSWH1plB+03INie1B62QOcNQBYd
        IV9cXOiLoAmp/v4D+IZPtPspQD3Z+lYfV2R8BR2UDw==
X-Google-Smtp-Source: AFSGD/VvJKsPAnYPsm7wdR8GYevSo/M0RkPvfle2KCH/1NUh2yHQ32zIbMjg0fSeLC/7dmAY2oGZ+93df4Gw3YXvo7M=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr15789580ljj.9.1544020351242;
 Wed, 05 Dec 2018 06:32:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187@epcas4p3.samsung.com>
 <20181201154151.14890-1-linus.walleij@linaro.org> <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
 <CACRpkdYQ5cy1-8wu--deF0kdzrRGVJ_teNh2LRF7tr9vyh+oHw@mail.gmail.com>
 <455ced52-e444-66f2-7dec-9d37bdd5116c@samsung.com> <CACRpkdbVSEYJpSb6Uzji158gL7WHu_Bfpw2gK-qo2s66dWjY7Q@mail.gmail.com>
 <b1ecf322-92bd-79e9-9c8c-b87a534afc11@samsung.com>
In-Reply-To: <b1ecf322-92bd-79e9-9c8c-b87a534afc11@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 15:32:19 +0100
Message-ID: <CACRpkdbJEYBQYF2T+UT-t0OYGs1Dj5M7AMEXJWdE282njXfcFw@mail.gmail.com>
Subject: Re: [PATCH 00/13 v2] Regulator ena_gpiod fixups
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:30 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> > I just sent a fix for that, subject:
> > "gpio: devres: Handle nonexclusive GPIOs"
> > you could perhaps try it on top of this
> > series? I intend to merge that separately as a fix for current,
> > as it is a bug.
>
> Those 2 warnings were worrying me and I finally found! devres_*
> functions require to pass a pointer to the pointer as match_data, so
> desc must be passed as &desc to devres_find() and devres_destroy()
> functions, otherwise they always return -ENOENT. I will comment
> respective lines in your patches then.

Ah thanks so much Marek!

I will follow up with a v4 patch set immediately once I have it nailed
down. Devres is tricky, and I'm not the smartest...

Yours,
Linus Walleij
