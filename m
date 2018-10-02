Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B55C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C644420652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C644420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeJCEM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:12:28 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:40491 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeJCEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:12:27 -0400
Received: by mail-qt1-f181.google.com with SMTP id e9-v6so3697136qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cMdrEzYPUDnpNH+jjkeP89IUE/O0wULRuokAvvDMdw8=;
        b=uQNbumBaWebnjb/kwOb+LAu9gAupFpcU3nNJhqnDHziByq3cjKA4aW9vYHY5uqlC3J
         I1qWfqmk/zXuui9dGCRe+p+sntw5qgIh8va8AT9gtV0qsMAJ3taK9femSEeI3jmKCI7G
         eIV4R1MsSeK6+HAkr7cc/4lt1RR8icj5FQCSWT40v8glEXK99DaXogGLKZMXN8JFNA5J
         uEe/2w0KypIhoB2dJXqRwebwWfOIcUqcKgUAFRaUJgqDZn601OIp3SVzpZCZa9E4b9X8
         p5nqiZg1EcBk5PjZwXaXGhxqrM/OgQmipdkQULPrwZsgPE15N+fAOL/0nHIHJ/XTLZ74
         pxkw==
X-Gm-Message-State: ABuFfojGxWS7XqE6Dr84GetJCaxw/gPpJfzCQLKlG5bn/g6DQqJuiQ39
        lCCi76+jV9Gr5aj6LDVaLBU9ltJv5E7NVBD9y90=
X-Google-Smtp-Source: ACcGV61RVmHQO1Od9Xl9rWkgp4Md6BQgiVuDLJebn8O3U2c/voPVnQDbtCl5b3H9i2uyEcgsjshrPoY8MJvJXruboIk=
X-Received: by 2002:a0c:9e59:: with SMTP id z25-v6mr12462101qve.180.1538515625242;
 Tue, 02 Oct 2018 14:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211016.2638186-1-arnd@arndb.de> <CAMRc=MfOMp5qpZLBBLKHTrziBBV2kD1ZMv7OD4E3M85G=G++bQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfOMp5qpZLBBLKHTrziBBV2kD1ZMv7OD4E3M85G=G++bQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 23:26:48 +0200
Message-ID: <CAK8P3a1pyWGBX-gOufS196Bbgbvy7eAGN0SKe4edaiSuFVvgdA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: lpc18xx_eeprom: remove an unused variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 11:22 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> wt., 2 paź 2018 o 23:10 Arnd Bergmann <arnd@arndb.de> napisał(a):

> Hi Arnd,
>
> I had already sent a fix for that with you in Cc:
> https://lkml.org/lkml/2018/10/2/439

Ah, good. I had some vague memory of that, but couldn't find it in
my mailbox when I sent out the other fixes for today's
linux-next build regressions, so I included this as well.

Please ignore my patch.

      Arnd
