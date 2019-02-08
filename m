Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F6CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BF20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKIGYZGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBHLWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:22:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43742 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHLWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:22:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id j1so2237219lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 03:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzEoJSJEJXBZy8f1Wg8bpBsrehVuXk1vukG5ZjufnMs=;
        b=vKIGYZGLrWGG3Ddru8X0PUsY6nvcElywqJf2WaocebYFSBy+PA0eaHaP4P7AqiKKyu
         OkCgYUNx/Cfp0nmK3GqPYE4QzS+ti0eUhPub1iWcQxhdkUO0N5YO+t2vbv4PegEOwpS+
         EoMmVvPt7jImC4tCWGQeUviXF4OgXk0yxkOAd0i7wYXLz72B7pNqLxjeYL5g7CnEbj5t
         aDmnWItNWGs/RdNo4yQhnwu/ZJ5PZ4yx9eINJT21CGvb3SlzqN8AqKEiuJhNNrUgMBoi
         hgPip31AAsfOmeCiDAsLTTYKLvx+pijHLrGGAE8ndOdt53a6FPZRiVuG7Bpyorq2bYtN
         bEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzEoJSJEJXBZy8f1Wg8bpBsrehVuXk1vukG5ZjufnMs=;
        b=WCpN/8pKxq2liC3F1ei5wvzmhKTWpob1KOgbyAseGcZoxE1iW4r1JkgsuOrYkp98L/
         1a5Wtxq8T5Gv6jHFirCH8/zpUlbI++GhTmknvk8qUQx2NhH52LCSq5PKYL0Z+b/ekRQV
         OZD04cGm/Z8tXKaLlsxaMqh7fiAU1v1p7vJOoOrXe4wmAD+DYHeju2LS2OJExg5fSOvX
         L4PNRJ0QdSgnwVlLFJwdcaVargcVuR12ZkQGD/FMvOiXCQFq8hbKbN2Ai4fuPBTmdgxY
         vtri4czsUJBDnv+FJcd1vEGVrQMTYbmldwTXqkpJMxE7mzOxGx58D2oOLobiqiOhDwJE
         bYvQ==
X-Gm-Message-State: AHQUAub2FWT1OWOQwJlsne/XUb1nSM+Asjj7ooG00E5y4/OdDVNV6NHi
        JSPB6vSHNWbRbGs8XZEdBu1YPGZ6myC4pcVF543bhw==
X-Google-Smtp-Source: AHgI3IZyirNu0MtEuHPP/zzOhmdH+z6MjF+SXLB2GjmBk0yMInW95jahzSzQLqcLk2iTixUgApHokrSSjNc2bvqgB0M=
X-Received: by 2002:a19:9a08:: with SMTP id c8mr13098161lfe.8.1549624942778;
 Fri, 08 Feb 2019 03:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-8-brgl@bgdev.pl>
In-Reply-To: <20190205091237.6448-8-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 12:22:10 +0100
Message-ID: <CACRpkdYKLeKA7CPFvoBPHB-K+X_n80YvFyYS_SHxuTTyGLNZ4g@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] gpio: max77650: add GPIO support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 10:12 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this with the rest of the stuff through MFD!

Thanks,
Linus Walleij
