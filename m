Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B31C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AAF28064
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnIwXnn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AAF28064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755080AbeF2P3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:29:50 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39292 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeF2P3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:29:47 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so6030075uad.6;
        Fri, 29 Jun 2018 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8e/Muxu2bM1J7wbHcemIqjtQgEF7PRSFdLTKlWt/la4=;
        b=LnIwXnn9v3AxZIW1xXAHHxshNTIUuz4wMzZzl37Y2tbPcOcyCgsa7zJ3rp33ToC1Ml
         W+CVEZkCA4TAvX+cMPcyES8muGyqFMB/GtZR5loJrtFH+fxB022XuswTd2V8x/bQcdp5
         HtpRzfd2v4KuaW2M5S1PIecfETGqlPtBlxFEc+cS2FSYLs/5cBgFMctzrQpn7qQVCMdT
         nFFjHMza1lTqtX9DqqZ5UpqRaBJDi+ZqUMPkKYAmAtyoTzXnmnZxUHwzgxH9bcGI320A
         +hChYpgXvkkO0cqq2nmYZB1NiHzUZ8BWOG8aidtBUzxrhH59Siuy4G5GlaDPHVeAkHqJ
         PeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8e/Muxu2bM1J7wbHcemIqjtQgEF7PRSFdLTKlWt/la4=;
        b=gNY/pNx4jYPVFySjw/JQiVj/8eyLanuJIDvz/ufJwsGCgERdOZ/H0/j1UgBx+bn+9s
         SajDfl+AZzcSRoRdQ6g/UMVeVueX+dVRZMW19PV5h22wvkHTCKsMS7flMuvciubfOSQX
         oGBInR7XMeffikM8M8LcSibJYmADR//tlzt4cLPGI7dKpw1Vhc4YcmTNEQijO0BOixbn
         I6IJmADhJOJBFHsNr/ZM980QQwcO1ut3es/6CSR66IR07ygRf2h9Bk+O8SYZRKQq2+WY
         2yvrZV2/kLd7IRSeHzUQVg+jv9raYgZoAcos2dOcSg70cpvQA9LUAe2y8YQWwM7YG4OF
         ceLA==
X-Gm-Message-State: APt69E2ACuJpw4QJTn6w+miqtGGSzlzY7nhk4wRvbRN5H51U7dGAHPME
        n/YtfpR7pFllt9LgHX4WYtlpgDZa2w6RELGcHYY=
X-Google-Smtp-Source: AAOMgpcBcwHwH0m5SxBSQ61k76WjcxnwaKUGGMtmqrtYEygy3+oryCdmYKdGQGxMkVhpCQ+Al/E3lB9XKkTOjGCRwXY=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr9844727uad.49.1530286186155;
 Fri, 29 Jun 2018 08:29:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 08:29:45
 -0700 (PDT)
In-Reply-To: <1530213066.3755.0@smtp.crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net> <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
 <1530213066.3755.0@smtp.crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 18:29:45 +0300
Message-ID: <CAHp75VfPVB6BwkL1+bGRsi03g6io0A0Cty+ykSDkYevOvq=VGA@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:11 PM, Paul Cercueil <paul@crapouillou.net> wrot=
e:
> Le mer. 27 juin 2018 =C3=A0 19:18, Andy Shevchenko <andy.shevchenko@gmail=
.com> a
> =C3=A9crit :
>> On Wed, Jun 27, 2018 at 2:48 PM, Paul Cercueil <paul@crapouillou.net>
>> wrote:

>> I dunno what Linus would going to say about this, but I would like to
>> see a schematics for this piece of IP.

> ftp://ftp.ingenic.com/SOC/JZ4780/JZ4780_pm.pdf

I'm not sure you referred to a proper document "Mobile Application
Processor. Programming Manual"

I didn't find quickly what I'm looking for. Care to point me out to
the page number?
Thanks!

>> Even if GPIO and pin muxing has only one set of buffers to indicate
>> input or output (same registers in use) it's a GPIO driver business to
>> get direction from GPIO part of IP.
>
>
> If I follow that logic it's also a GPIO driver business to set the direct=
ion
> of a GPIO, right? Truth is the pinctrl subsystem takes care of that. So w=
hy
> have "set direction" and no "get direction"?

Because it's a pin muxing business depending on the function chosen.

It solely depends on a schematic. For the example, everyone knows that
MOSI is out always, otherwise SPI function would not work.
.get_direction() has useful meaning only for GPIO function. (This is
my understanding from electrical configuration of buffers).

>> Looking into the existing code I would rather say that
>> pinctrl-ingenic.c should incorporate gpio-ingenic.c as they are
>> (partially) sharing same registers.
>> To ->get_direction() implementation it's pretty straight forward, just
>> read necessary registers in the gpio-ingenic.c directly. No need to
>> have pin control or pin muxing to be involved.

> Sure, it'd be pretty straightforward to do it from the GPIO driver, but I=
'd
> still like to hear Linus' point of view about this.

Sure.

> As for merging pinctrl-ingenic.c and gpio-ingenic.c... I wouldn't disagre=
e
> more,
> even if they share registers, they belong to different subsystems. Beside=
s,
> your platform might need the pinctrl driver but not the GPIO one, or you
> might
> want to provide the GPIO driver as a loadable module, etc.

It was just my observation, I'm not a maintainer of that code  nor
author, so, up to you how to proceed.

--=20
With Best Regards,
Andy Shevchenko
