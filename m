Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4136646-1518011741-2-7405813413048783393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518011741; b=n1EZYw4CS0tXPKNhWq2wE8FgaHbG0n8AWTKYnddnlDJMRB2
    Sp+s2NfOasEhX+s8Y4PjCAguQahfAPMWqPFBQUQJlSd7Zfw2idlK35zph6VyPqEO
    6II814EdNFtNC2cnn5MDNZvsdJ8aGalAOj02waNBaIK34EhLnYLSzpO3LCLbtWtu
    QFilz9+g7vYtxphOHsR992Tuh0fvohECLVFLtuDEGIQokz31hUcIK0mShCPBHuur
    o2AM+XgmiMdpuZ54RDbZSWH3dNOfwWPUqLeh3ptdPYT61dhR0DQqeo6TahAjqwmB
    /iphlJSFBJZM8X9ZUW6Q0e5vwEL9wJC0/BLcSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518011741; bh=vvNIkwsLS8XaG+VJbIIB50TP2yT/U7rueIzNgz
    RNpic=; b=uhxN0LpogBGUdqIoAroQv0G6qyaEFd2dFTpvj14VRRylmLpehSDvtT
    oEAYAZJ1zzNJ7lJDk6w/kjxilGHRsbuNHOkDfY9+XCmTelcHkA0oq1WcdDY0x1ry
    Ocji6V68XMfE6NJH1QFvkY89ZYChqY/WKFsYKwWj9l819F07f/LmyR/3dyqfbyDf
    o95NvdKc5yFMW9W25fveEejXUC/QfYczch13RSObKeV+pg21HCvTf3WxDjHgdNXc
    0T0lijNghF2oXbiY8jvrxcYPAhlTjC/JU8kP4tzPyINB4DRzZtNfJ6AfU84iG/GZ
    da+cFH6x+UH5f/hDXvCdJGJ0d7W+yzZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=XjJmTWNs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tfjPqmSm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=XjJmTWNs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tfjPqmSm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeBGNzh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 08:55:37 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:42970 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753731AbeBGNzg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Feb 2018 08:55:36 -0500
X-Google-Smtp-Source: AH8x227mBVRTUIfpcNw9Cz0xJqYxPdwPBvQ6CxU85Kgd9re97AC+EMoaNVDTiqyK9PeVZAe/6ZIJEJny+cRiC+GUeko=
MIME-Version: 1.0
In-Reply-To: <20180201093432.21919-2-ludovic.desroches@microchip.com>
References: <20180201093432.21919-1-ludovic.desroches@microchip.com> <20180201093432.21919-2-ludovic.desroches@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 14:55:35 +0100
Message-ID: <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: udc: atmel: convert to use GPIO descriptors
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 10:34 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
> Include irq.h header since it is needed and was indirectly
> included through of_gpio.h.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you for doing gpiod conversions. Making the world
a better place!

Yours,
Linus Walleij
