Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09492082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLDi27HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09492082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJYSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:48:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35508 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:48:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so6354674lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBDsJGi0QVriKe8XetCb0sKJlxX1Yq3CxfATigksOKQ=;
        b=FLDi27HQYpQ0FfuyBtfePspDlataeHTfoVfN4q74XqNfAC0H3NC6Cbq8C8wjmXIBu1
         skfQME+3Jy+8OHIu6QbdE/L5Ptr9IG864EuU5IrirywvjgaLhtj6uBrufsrT/qnxHWD7
         eixnO7h9Nzjqd5+/Du5Ww85QNGRkboqGpHi1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBDsJGi0QVriKe8XetCb0sKJlxX1Yq3CxfATigksOKQ=;
        b=i2PtxG71l20EiXjCHb8nzKMSZsNL+fN+pn21Z/8UP4//rzRxbuBFYLRVO8n6UTH9JF
         v7fo3Uv6verkpHgX3VVR8awWh+ryA6MKMdJR2B68/gvP9Gq9dtboqrLMVmJLXo1Tqcd8
         /VRopEQJEOMfAQFy7rCe4nl6jN/Pw/j3UgAi7DI+mFuS+onZVwX55OsM3RnOyI6tXZxL
         5OQnRpeWn5OhNRzJJhhXXqX7bk9fDha8IKG2ajMQZC5IvcbL+ss3DZoYtRqXuoXjG58U
         7zYq5SvONfNX2XJNF/AFWjlV82VtK4DvIPSVDUM+NatSOEVaztkO2BW4dWK3Qw7yR4A0
         uwAQ==
X-Gm-Message-State: AGRZ1gJIUezB7LqkddcgrX/JIUasu0bbmWnNcuYKomWxd4jShbWOQgjU
        AXsUtSxTGLF1bsxnzM5+T38BX6XkGbWT+ygGvPVy5A==
X-Google-Smtp-Source: AJdET5eMczNYOopPQV8n5onsUQMPEtIbrANsZlejti+OrQEgVgELwVNqWYm/+c+z5jhsR82C5lzgCVR2jJYwdvn6QTE=
X-Received: by 2002:a19:1549:: with SMTP id l70mr730195lfi.53.1540462604508;
 Thu, 25 Oct 2018 03:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181024142456.10084-1-svendev@arcx.com> <20181024142456.10084-3-svendev@arcx.com>
In-Reply-To: <20181024142456.10084-3-svendev@arcx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Oct 2018 12:16:32 +0200
Message-ID: <CACRpkdbXPWH4FS5205ML0UmuATuZf087Y6ueVUdp_Lfc5Nu8Hw@mail.gmail.com>
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
To:     svendev@arcx.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>, yuanzhichang@hisilicon.com,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        bogdan.purcareata@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

thanks for your patch!

On Wed, Oct 24, 2018 at 4:25 PM Sven Van Asbroeck <svendev@arcx.com> wrote:

> +  - pwms : the pwm connected to the bridge's 'pwm input'.

That is really unintuitive and needs a detailed explanation. What
is a bridge doing with a PWM? Is it 100% certain this is a PWM,
it's not just a .... clock? A pwm is a pule WIDTH modulator and
I can't for my life understand why a bus bridge needs a signal
with variable pulse width, but surprise me! :D

> +               fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> +                               0x00000000 0xa0000240 0x00000000>;

Is it just a copy/paste from
Documentation/devicetree/bindings/bus/imx-weim.txt
leftover?

It was mentioned as undocumented but it is also pretty terse
with these opaque hex numbers. I would never let the
Freescale binding pass if I was reviewing it.

Look at my bindings for Qualcomm EBI in
Documentation/devicetree/bindings/bus/qcom,ebi2.txt
for example.

But maybe it's not even supposed to be there.

Yours,
Linus Walleij
