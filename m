Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2217520844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ/gBzIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfBHNc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:32:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfBHNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:32:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id l142so2562713lfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOKN2RtkqD3NhMxXTntaG9/up/T7KSnJjjnbyy1R1eQ=;
        b=hJ/gBzIBCLQhm2rPw3nICW4FI+YX9FDpAGBDmZblsvklPtVgQkqbeK+W9uXIsO6m1Y
         fOoPPn/tB5+fCM1fYzT2+zm1VK69ijYIk0FBrMzQy7MGGNwSU8yTQgDA6lccGuPnB3h5
         Y4MEDVCpU+vdENq/lAbTxaXZwU5i2Ah8cfcwkW61MouNQOkDNpBSr+Z7+laM+HSOl9HH
         yj0iDQ0qQM6Cbw4q2qFnRO27zhYYZ6zh707rHEVmeDSYWHUglGnd24Y0SYtNmu6I5A+o
         rDr/mfWB+NRWnaijrBNLaJYGaRaAkfbvRKzwODHfWUnak9R3hP9oIEuoMOQ4hiU+3xZ2
         X25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOKN2RtkqD3NhMxXTntaG9/up/T7KSnJjjnbyy1R1eQ=;
        b=WY8N0q14vnpbTLygkWZ5nSsqqRj3JpSNsAAwMM37UMUhO68EoxIl6cr4fWa65gKvGI
         zzZ4Ga7aKBPkjKr/1SaEwAzuE8iwZjP8/zAcmy3gHSaBjpnpRWruv7CFjfeFqi6kSSK5
         HiIPDW1CnnAhBfc/UDtJxudw1KKOPuOgUzeypaIEt/fHNae0PUUARwc1+WASTCYo7rbh
         V1WxouFCIBfGTiYnDtttZz/rfFjnPCKElpzcNeZtaMOl4pfwwUrv/dl5qJ/zlXzL0v52
         e/2cCsu274esPPa1BK+zz+vIgkt8scFU5IPWWkg32UmSZgKnYv8puL3bW+/uuKEVxl4y
         DXyQ==
X-Gm-Message-State: AHQUAuYZ/5eFtKn+BPvUrczt07wIpKPiL0sG73xn5t/CJ5FArXRMsBMk
        IoKCy/r5wJRCRSWPvc+n21IOfBajCAVksYh92NLLQA==
X-Google-Smtp-Source: AHgI3Iaun5UChBVpgraPMeJiOXrr7LLPt7LegZUyY1EAUG1cB5RCgqZ5w6gktc+8ahXVjI1Rp1m/H6r2Vgq39tr+324=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13201900lfe.168.1549632775616;
 Fri, 08 Feb 2019 05:32:55 -0800 (PST)
MIME-Version: 1.0
References: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:32:44 +0100
Message-ID: <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut
 M10V pinctrl description
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sugaya,

thanks for your patch!

On Fri, Feb 8, 2019 at 1:32 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> Add DT bindings document for Milbeaut M10V pinctrl.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>

(...)
> +- interrupts: three interrupts specifer.
> +- interrupt-names: corresponds "interrupts" factor.
(...)
> +               interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +                               <0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +                               <0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +                               <0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +               interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +                               "pin-52", "pin-53", "pin-54", "pin-55",
> +                               "pin-56", "pin-57", "pin-58", "pin-59",
> +                               "pin-60", "pin-61", "pin-62", "pin-63";

As mentioned in the review of the driver, don't do this.

This is a hierarchical interrupt controller, so these
GIC-offset-to-GPIO-interrupt-offests should be hardcoded in
the driver.

If these interrupt offsets differ between difference instances of
this pin controller, they should have different compatible strings.

Yours,
Linus Walleij
