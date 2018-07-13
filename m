Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313F82089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kn0Q5RS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313F82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbeGMHTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:19:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39555 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGMHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:19:16 -0400
Received: by mail-it0-f65.google.com with SMTP id 198-v6so1960278ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc2ySPGABPXzXZzHUAF+q7BooeWDvdtcJXP7+GgU7gI=;
        b=Kn0Q5RS53H3RfLxRZ+Nc7vIIJ7NW67C2IfIctt2FjNwI/0MUz37mMcvEwkUSoPDVyt
         b0NZr+hQneFElgBy2PZ0ZSfcdYaSouF312ejNUMZ25xEDRVbbz6SO9KPhNwvdu2UjvtF
         /nIMd1hoeoUGGj9f3UR6a/UBKhn+BLOc8isB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc2ySPGABPXzXZzHUAF+q7BooeWDvdtcJXP7+GgU7gI=;
        b=KNgqEo0rNo3dr+ty7KUoiDSbsAKHYHhqbB7FN35Eo+xWB7ENyFPEFF0qOUfoNKIidM
         hl5LSxmdIxhCfy1zoMzBDMhQbe+KNO03tlqbU6SJ2iEH5caKiJdikIiursGlaSS35nrY
         VMtjBPcSq8fYrYKIfHMSvAtOBvhnN+nZS/j2Efi9pznsWmpBq4HE+5wf1OkAQQt0aXu4
         5RMoFFspotAmmg1a+eEdc8fWqgPLxHCTYN6/z82e97NKSbbLljciP7QaX+0motyWl635
         qWgvcHWxplOiCpoeZrJ7tAcjbzw7byXuHygph/HGplI7k6M4b+zM0ju4sVW8cO8ZmNY8
         /+Pg==
X-Gm-Message-State: AOUpUlG02gIXJmxHl2l1ITYzX2OGgI1i1N4hmMjb+MmDPJA0u8f5I8oV
        MOhcue3hh38LWEAx54SDuqNTqMeDKdHIZVDG+gtm0g==
X-Google-Smtp-Source: AAOMgpeGT+MmEsg8AOPij3qtPgQeVGhGtnQJr30apPdFsu7HwekHEMmWEpOKQuCWRlSErDi95gtje7mvXSjKaNnBW28=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr3796675itf.70.1531465560101;
 Fri, 13 Jul 2018 00:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180709145612.4166409-1-arnd@arndb.de>
In-Reply-To: <20180709145612.4166409-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:05:48 +0200
Message-ID: <CACRpkdaMdcAnA9GWx2vJtfGtDEUzpE64g6v+tJM8NVtY=Bc_Mg@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: fix compile testing warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Gcc cannot always see that BUG_ON(1) is guaranteed to not
> return, so we get a warning message in some configurations:
>
> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
>
> Using a plain BUG() is easier here and avoids the problem.
>
> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Benjamin's ACK.

Yours,
Linus Walleij
