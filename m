Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A7EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2938F20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB8jXxfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2938F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbeGVUkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 16:40:04 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43053 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbeGVUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 16:40:03 -0400
Received: by mail-ua0-f196.google.com with SMTP id x24-v6so10470488ual.10;
        Sun, 22 Jul 2018 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fvSz8a+iC74T/ULFnZ/RGfb3K8bTOTCF9DHYsAbs8to=;
        b=GB8jXxfM/6UVePAaplX6FK4hM0O1XZGW26+2jMsrz85AEKplMnJneiRlc1WwyR8erO
         Mfaz5+Kyyp+anft6H1uWF7zO3PAY1dyVFS6IvjcDpjqpO3DX+ybHrYQA1pVMlAiRYl44
         rtmbTUmOkAIKCQpnDRxJGhkjGeAN5zfmjD/+SfMWTvXgVvzkNr9PlodbuSsvYuWD5djl
         n5+fjdGz5x8sk8Yq448Tr398FmGx9ZmrYS8SKRseUPe4XhBU/gcVIUiFVA0puiIhrEJM
         /VFjhDhT3yVEgZl8UlkZH4fFn4weiu1EdsQz3YVn0/QajDYHueNA93wSJEOyQznM9FvW
         hoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fvSz8a+iC74T/ULFnZ/RGfb3K8bTOTCF9DHYsAbs8to=;
        b=VZOFOuLPMNXfUbi4L1UGWXXVlICn8hsTVwHKnTnOQebgGutPy9q4O7bBj2Y7dU7AVU
         sT0Q6nlnqh9/uEdsxJC3h2B2troUfzmo/8HlxV6wffQkmR+lra8cum1U25f/ejqe4Cie
         Vku2l+WCjuoMS0SZ9QFvp0U8ma5nATslNXPTXp1+/MAQfJsTAX4WHHwXqAb/NVL+asC6
         4WUltFPKYhF+1aMZ5Oq9ope8WcpJ6vKSJ+oeNWBEftFVqv62syL3ZJKzhMBfvwdVnTEZ
         2OHRbCf2KTdCO3cCZhAaHhOYeouixEjrEXwDWTPRCTOmW9xPZYIwbsH12k72ZvcemhcL
         7epg==
X-Gm-Message-State: AOUpUlE22WIOLvOHDzL7UYEcP86oE/igJgEZjq/pI94MEXi0vCQrjNde
        b5u/HIw3r9KWgZYRUMcITMuzrSM2bv5jYP5/lxA=
X-Google-Smtp-Source: AAOMgpebJ5iQ0KW/3jyOFN3YRNZ97E4sFLmCdQmuu7Cja5qHYXOt4Q11sFVwO+5tnc8Uukjw+xL8drcTTFeQzolE/ik=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr6896379uad.12.1532288537378;
 Sun, 22 Jul 2018 12:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 12:42:16
 -0700 (PDT)
In-Reply-To: <20180721223630.24559-1-lkundrak@v3.sk>
References: <20180721223630.24559-1-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Jul 2018 22:42:16 +0300
Message-ID: <CAHp75Vf0vzOxSawqLgvAOJLL2SP5brckzF+jeMhVxeo2U+cqmw@mail.gmail.com>
Subject: Re: [PATCH] x86: czc-tablet: add driver that fixes the buttons on CZC
 P10T tablet
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 1:36 AM, Lubomir Rintel <lkundrak@v3.sk> wrote:
> This driver switches the P10T tablet to "Android" mode, where the Home
> button sends a single sancode instead of a Windows-specific key
> combination and the other button doesn't disable the Wi-Fi.
>
> The driver also supports the ViewSonic ViewPad 10 which is almost identical
> to P10T.
>
> Complementary hwdb patch with the scan code mapping:
> https://github.com/systemd/systemd/commit/40a3078b.patch

First of all, thanks for the driver.

While I have several comments against style, the main one is about
necessity to have this driver in the first place.

> +/*
> + * The device boots up in "Windows 7" mode, when the home button sends a
> + * Windows specific key sequence (Left Meta + D) and the second button
> + * sends an unknown one while also toggling the Radio Kill Switch.
> + * This is a surprising behavior when the second button is labeled "Back".

I'm not sure switching to Android mode is what we want. Most of the
laptops are trying to be kept compatible with Windows as much as
possible (thus, for example, we utilize Windows Management
Instrumentation for many of laptops and tablets).

> + * The vendor-supplied Android-x86 build switches the device to a "Android"
> + * mode by writing value 0x63 to the I/O port 0x68. This just seems to just
> + * set bit 6 on address 0x96 in the EC region; switching the bit directly
> + * seems to achieve the same result. It uses a "p10t_switcher" to do the
> + * job. It doesn't seem to be able to do anything else, and no other use
> + * of the port 0x68 is known.

Does it have it in ACPI as a method? How exectly it does this?

> + * In the Android mode, the home button sends just a single scancode,
> + * which can be handled in Linux userspace more reasonably and the back
> + * button only sends a scancode without toggling the kill switch.
> + * The scancode can then be mapped either to Back or RF Kill functionality
> + * in userspace, depending on how the button is labeled on that particular
> + * model.
> + */

> +       outb(CZC_EC_ANDROID_KEYS, CZC_EC_EXTRA_PORT);

This is basically "the driver". The question here, what prevents
userspace to have few liner C-code to perform the same. IOW, why this
is necessary to have in kernel space?

-- 
With Best Regards,
Andy Shevchenko
