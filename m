Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C02086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cw8pJN/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9C02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeH2M1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:27:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50926 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeH2M1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:27:06 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so6528234ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqO/CGMPZTQeOOUIuSB2NKwkLlZzEyY+TggBfaeaYhg=;
        b=Cw8pJN/B/v1bnkGcrnLrThKSrRpsIIwxFET5OnL1ZL09kTaHoJJ2ThmRBj0cuFPP1f
         T5eKDDfcrXb73JH/X8hOzMtLX6svH5jC66yGTOIZnhVRzSsKL1oectvrmEIrPvaHJUlo
         PEbi8ljuLiLex0vh8wd7mowPt0nyRQek+3Zuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqO/CGMPZTQeOOUIuSB2NKwkLlZzEyY+TggBfaeaYhg=;
        b=osQJOHu5lgm1g9gJ6LS3sfb09e9+wYLE5Djw7R6d2S2C4WEZFj+tooNsMl7z72bNZK
         T0V7VA345SwrEhgpdcdlqvsS9htZt8tTAD8HoiBnSbJp/nwBhm64wMdHwtmQuV7ijFJl
         nQL7aalO+dIjqPKZGFucUQrTT1aYiLl0XHHeOS4lsc7ZlisLxE3JUEQATQsWW50ki57+
         gFgI+YrEMEZNiX0NNOtDritF3R6JMF68ycU+puziBdyltqFum3IQpdbyC882rdvFW1HI
         IvqhDQcz8dsjYpJrk2c18ER0AfTR7ftc4kDp1JnOsU4NOoXbPYOSou9a9IvVPsD5HK8D
         cPpQ==
X-Gm-Message-State: APzg51CB2YdxsVBrie8ZLX7z74RNuZm5l9OeqdBQieDDuMlCfbFWi7J0
        V0tFBbM3ilk4CO2tUk/AEY/ty7OeXovy3ypgnyXOtQ==
X-Google-Smtp-Source: ANB0Vda7jRKrZneo+P9cwI6Jgp+40xFOrsuPp3iQkwCVR22tEdOZ1eoPDNIxeUARBigOgDJS2YVpoAUaBsH0qQWThSc=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4526803jab.87.1535531480157;
 Wed, 29 Aug 2018 01:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180808092526.87405-1-tmaimon77@gmail.com> <20180808092526.87405-3-tmaimon77@gmail.com>
In-Reply-To: <20180808092526.87405-3-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:31:08 +0200
Message-ID: <CACRpkdb5PSx52xqeqiCO-dcQXT0uuUZGstvKP2YKUFnCnoWOpw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:26 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Add Nuvoton BMC NPCM750/730/715/705 Pinmux and
> GPIO controller driver.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Patch applied! It's a very nice driver.

I had to add back select GPIO_GENERIC as the driver
uses bgpio_init() exactly as I wanted.

Yours,
Linus Walleij
