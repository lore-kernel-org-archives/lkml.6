Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1728C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CE62177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpE43GoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBHMIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:08:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33301 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:08:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id q12so2381295lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MZVCPmiFoZOeY6Zi2sALAnt/UkJv5RFzHY10fRT4mI=;
        b=OpE43GoUJYMqV2jgCBvlmhI2KoIScG4kI9bUBTnc01KvDFy+ZgiH8UtfjavtxkYzR6
         mXcvxjONbF+enJ24VKebl2DbbZo5wA3dRBK/oWxpJMm7kvAsgzBNPLOL3JdGUv892MBg
         u7so9XNQ9ZMpwps4OAbefgxVnZOCOD0r4XuL0e8r6nfY7H6EyA2ViNOlikmgane+Hx9O
         pzkiucyCRnYfc9yxzMknbPy6OeQhVby2j7SNmhyxT+LW0sL9262lxa96gGON0+9ZBMa0
         kL4kk5rxHc66RTtSQsbi9mObG4Am2NTjM+Jt4qhm3scPA35mLx62/frTl8X5fvV/MtSK
         YmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MZVCPmiFoZOeY6Zi2sALAnt/UkJv5RFzHY10fRT4mI=;
        b=P5/9n/GZYpG+wayARVqJTEXrsTgmhuyG0eHR9Lo5bPkfpLlT4pJPH1DpsJACBoh8ss
         piQDBsA3yjp0l72Y6vwGL6eU6bSS7wDFn2CyUIs4jMwGeMxK+2xM64QjH72EZ7caI9xz
         IIvqzQpODQ8wtVbbmsEetPGQ/jUhxXTvJvN70u0Y+vHNlPI5x+Xy3pPocwrJlB0fb/Mr
         FgWn/eYx1LgLf3L2OUPilgyqMG7hYez11XyS4osF0qYnKq+c5bi9lwtEkt//V4f0a3Ks
         PwMjVN4kqhFAKm/Wqo+5z53yfiv8FVLElHqhQb4SHOmqrt4fl+XTiglmKoHwOp30u0J2
         X76g==
X-Gm-Message-State: AHQUAuZIKwJ56zDINFj48E056NJEy6pa5oWl7RwUuYUh8C+VqxI7n7Q/
        EbzTjdaIumooZcy89uy7dzZn7gxiBLGlS4S9U8RVAw==
X-Google-Smtp-Source: AHgI3IaPPJmXbMUXRxatMm83Ibuspywjjx9pmn4aBEeEXTgtFqQqNYb4fqm7fvevB4/5Kcs/FH9N86RwxeERxtmbpIQ=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr13882950lfc.27.1549627687819;
 Fri, 08 Feb 2019 04:08:07 -0800 (PST)
MIME-Version: 1.0
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 13:07:56 +0100
Message-ID: <CACRpkdasSzX8gxW1dDjkeTyT6RAYFhrwSPGdwmrKEaabEFgG4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] add support for SAM9X60 pin controller
To:     Claudiu.Beznea@microchip.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:24 AM <Claudiu.Beznea@microchip.com> wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> This series adds drive strenght and slew rate support for SAMX60's pin
> controller. For drive strenght we could have 2 values: low, high.
> For slew rate we could have 2 values: enable, disabled.
>
> Besides this I took the chance and adapt the documentation for at91 pinctrl
> driver.
>
> Changes in v3:
> - fix checkpatch.pl warning on DBG_SHOW_FLAG_MASKED() macro in patch 1/7
> - add Ack-by tag

All 7 patches applied for kernel v5.1.

Yours,
Linus Walleij
