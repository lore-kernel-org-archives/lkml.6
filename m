Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A725CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5FD208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="clMH3JDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5FD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeFNOon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:44:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51225 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755355AbeFNOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:44:40 -0400
Received: by mail-it0-f67.google.com with SMTP id n7-v6so8693451itn.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KONYjKXQH1EcNk8VFXEp7jK7//1fns2XVRH27JetNqA=;
        b=clMH3JDdyaCGsz2f3hjZT/ZAg7oN84OaOLpMJa0tHm3r/8a9O0Eg4DZ/RqsG1pHnQR
         Fqf2/PSRFORn/TeJpMydjEJnNKUt6dJiOGAYZ3HEZTucUZ6wqydrRZtaYIrvGgxfSlL8
         c2aryqfcEC/KYI42xczmYOuAI2sGIZ6UV4tGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KONYjKXQH1EcNk8VFXEp7jK7//1fns2XVRH27JetNqA=;
        b=aRuach0fdMuZpEbHxk7d5hDkyhCU7ouwI/6O8znSO6OFkDIE9ngvYKfnMMpaAcYMEC
         gsilMeIfYleJKmxsO4q0puymysLVo7hgN55cB6YgxG0g98hg/q4lh+bctZzVkqYh93C7
         4/kwqVcy2OMTzvfclTJLUzwGglsxyJYO6kr6bzIUmrDWzg7R6TQx6wPNCAqQ/DrwQ47a
         keM7oAkcDiSjX1A0DgtZccQSsBHSLDrH12JnFctxYJWA/IENLKj5D/7ztCUw48/XgDmo
         NTrKkUtkc93EAuyh0u+by4XRrFMwo6lLlJwapSyEb/+apk7B9ITn1WLl1mH+2LGx+/U7
         mKiw==
X-Gm-Message-State: APt69E3+EKV7l/MlAjyLqE/dVEz9XAkzaYQr69Y87li3yG0uiXara/Kx
        fxEDXKhhhrmYbR5PCyX8HTnprc/hg7d4QAX8pos5/g==
X-Google-Smtp-Source: ADUXVKJirMOvGNxDlW5dZZIC7F0NLxf1BDl3cepM01u3akqFAut2xyLUC1pYfU5dJYNck5mdhfQ8SJA7JozIw5QehPk=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr2490994itb.135.1528987479346;
 Thu, 14 Jun 2018 07:44:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:44:38
 -0700 (PDT)
In-Reply-To: <20180530215407.1196429-1-arnd@arndb.de>
References: <20180530215407.1196429-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:44:38 +0200
Message-ID: <CACRpkdb-j4E8JL10i2-AQ4_ZWRu9NrMVaGJBbXwoFxufY60HUQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When CONFIG_GPIOLIB is disabled, this codec fails to build
> because gpio/consumer.h is not included implicitly.
>
> sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
> sound/soc/codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
>   pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>                    ^~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
