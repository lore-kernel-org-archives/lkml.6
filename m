Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695BBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C9208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrXPfAHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6C9208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:19:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43462 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:19:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so24530554qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6LoBoRFgCvRapU0Kj82C/RUkpCby0NviBiWvvnysNs=;
        b=LrXPfAHg0o1fGbmANLMAUcfMt4LYa6LnLR5dYZjU3frWFkNTp6AD9F8cXfOZ2iYU//
         5Ou3DVDdujHeWzUfPFoCMByvxaL58FUlismZZHWeMBRMYiza2G6aYfUSsxNzV+KPue06
         eIxzFbsmRNGKoG7EXX0Y623cQG+elkA4zhIOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6LoBoRFgCvRapU0Kj82C/RUkpCby0NviBiWvvnysNs=;
        b=ti+gtFUjIpnUh+dHCgaz4/PeoluNmbguSzAmISybRHUAb2ZKN0pDCPfAlBk+jKmZjT
         kEHJVqrXWngTafyOG8pHEat/+Lt5Ovv9bkG4eeHB80aLS5MHcOjOYFWu4/pKZDvjCz95
         SDWgomxXRP7+wPaIXMxeY29HMzIA5C7o1ChPGZXbSh6fcfjtDZEo/jCQ2z8sTPpzQlR1
         /7CsovHRTLEmbyAMA2wkCdTPy+f6JK6BV27i/hUTh3x5SMre/+/6Wy9Jh2dmjHrvIFr2
         sYJ9tspY1q9eNaowWVd0f5EL3EheDnKF6QsH3foj1t3BSzloOXomLUtjTkbCseApI+Pn
         vcCw==
X-Gm-Message-State: ABuFfoh05rjIU0T6GVon0D0RSfU1HvZ2rTtttuoq1fqsw5aaSwEvKNdH
        B1pl07neSwxAmtdhxCjxE9jL31bv90c7/LOAh4xBIA==
X-Google-Smtp-Source: ACcGV62myHepaN86cRaHeXlJpdJyP4/ZE5o8ljMA+Qri1RVyoXARNqAb6yu62RV1b7eqdhxrbBZ8xTJGKIsf+gcVGN0=
X-Received: by 2002:a0c:9689:: with SMTP id a9mr418331qvd.103.1539675011119;
 Tue, 16 Oct 2018 00:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181008163216.97436-1-swboyd@chromium.org> <20181008163216.97436-4-swboyd@chromium.org>
In-Reply-To: <20181008163216.97436-4-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 09:29:59 +0200
Message-ID: <CACRpkdYmzRHcF=Bap=zjMoFRuEobqBibChQVCNiD0XrE+Kc_nw@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: Remove unused 'irqchip' argument to gpiochip_set_cascaded_irqchip()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        evgreen@chromium.org, Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:32 PM Stephen Boyd <swboyd@chromium.org> wrote:

> This argument hasn't ever been used since it was introduced in commit
> 1425052097b5 ("gpio: add IRQ chip helpers in gpiolib"). Let's drop it to
> reduce reading confusion.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied. Good catch.

Yours,
Linus Walleij
