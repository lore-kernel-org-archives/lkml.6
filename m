Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7025BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YO9SFjPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLRMvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:51:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36241 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:51:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so1843986oix.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q2PNKSAhpSgYUq64TB11w1Y0vKi5UwhbWSsBx1rp4JE=;
        b=YO9SFjPZhU7rN9QO0SO0Nrg20L4UkWq/Fi2soR1uJ1u7tQjLRhCXDQi990TqAB4yIA
         oQ5JDe3Bq47AP0xzzkYZfa1/jnWe61HHrT3Bm/hNUUquZcyOJA4UZ2q+jfdr18vn5NaU
         6UwAUQbBnSiv+Su7iMC7sLpSjSE5c3Liv0fpf3QjlZ8AtB6DAPx/UkemGmqMdfuL7mI2
         haSet+Bz9fTNw/bvVEZPDHLba1GdWQVelP+YppsE/5FJj07U+NyEkLLtY0z0QwphpeDi
         AM3rsirgUNBmly0o7OxkRyS5vQU7hprsu1mjY4XkxnZsAbSrm7YzjRX2i7BQzErX4xWZ
         PWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q2PNKSAhpSgYUq64TB11w1Y0vKi5UwhbWSsBx1rp4JE=;
        b=Vrt4QsJ4dpFzDrcKupFzMVfKt78cBFNFM1ggmjVmSXDPOlD00xqAVKKXdw4WozpMtt
         LDDhY3kyo9R9FYtKRf3wpeE4tCJJAtxXIKRQ2/jAjXQKUrtsi7FWoM4w4U19hRJOXK+z
         fdNIwataw7uuGTFsDXOnv2akTZ9/lYldYZLiQRZM+6S8YVfFtMpyiOfswlqXL9PCyEt/
         1PV2/oLFhrAVZM77hK2jFZlPR8occ7k18JesCjrs0y/jVeV+Ps7pdlUnJLg+kvTCnKBN
         /I9Izl5IwVqDQF7mGf/0vUy0Vn7x5RayBFjhnZyPsfdSt6RvIQlHu7GDq749foHeYRAa
         vFfw==
X-Gm-Message-State: AA+aEWZrzWQrdCE/BarPcOR3lP1QyeCwRXkM/+Eyys1MyBGj55VqUoe+
        mAHnGspg+v3EcQpYgesZHb5Sf5Ch7DrEZvi45k09ew==
X-Google-Smtp-Source: AFSGD/VgImYHxk3h3dHSgKdv9EbyMi8RrGnZ5U6+4r0Rya6QGiakTE4wAPGwU2pQ3RERjJi8uFQPZwbMnnbYUyzVCBk=
X-Received: by 2002:aca:1e17:: with SMTP id m23mr8031817oic.332.1545137459636;
 Tue, 18 Dec 2018 04:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
 <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com> <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
In-Reply-To: <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Dec 2018 13:50:48 +0100
Message-ID: <CAMpxmJUnfnHmopyOfHRZrN1KoqZx_Bsra1BTiGud6UVmzz1ryA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jan Kotas <jank@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 gru 2018 o 23:22 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Mon, Dec 17, 2018 at 4:51 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>
> > The driver looks good but is there any particular reason not to use
> > regmap for register IO?
>
> I thought we only use regmap for MMIO when the register range is
> shared (as in a system controller) so that some registers are for this,
> some register or even bits in a register for some other driver, so they
> need the spinlock in the regmap to protect the register range.
>

This is what syscon is for. Regmap simply abstracts any register IO.
For instance: there's no locking in this driver. Are we sure it's not
needed? Regmap provides internal locking for you in the form of a
mutex or spinlock.

Also: it looks like the interrupts here are quite simple with a single
bit per interrupt in the status register and the same layout in the
mask register - it could probably profit from using the
regmap_irq_chip and not bother with reimplementing irq_chip callbacks.

> It is also nice for shadowing/caching of register contents I guess,
> wat does this driver get from regmap MMIO?
>

Code shrinkage IMO.

Note that I'm not blocking this from being merged - I just think that
using modern frameworks is always a good idea.

Best regards,
Bartosz Golaszewski

> Yours,
> Linus Walleij
