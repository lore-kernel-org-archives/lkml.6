Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA06C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B11F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8IucuQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfAUOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:05:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbfAUOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:05:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so17656297lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5b6N5TttLACwg1g+D+B1jpyp/MJX3VVfc7fpeKpb1S8=;
        b=B8IucuQwtYIX4oEj8QC+m6MO8aaULSuxvk7TwdA/sGSV/xWuYFA5UUB0OsLvXeZ2W4
         DKwTGq+62W9oVyU9vPM3Ecuh4i/qg3JkXZ//EcSmM+ubScpg1QVIMEfVXV4RgcFTllHt
         nattxyHzgSziDz+zcjRr7jb+cZN/zevP9T500=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5b6N5TttLACwg1g+D+B1jpyp/MJX3VVfc7fpeKpb1S8=;
        b=mfzR503dtGKk0+pCXEgFILa7CUEx4yKdz8IllD96Dtgw12oMcSsXW0fyfKGMbvydP6
         4FgOKyVWIlkTV2LWGBPDZyd8tG51wLdCLnNT7TD5fxrTE1HU0OJQSMWsTNS4RkP2Xa9T
         AtgHFnTgJU4rKPIVjRD6q5j2DwtK4dG+m5ILZH4+c3PoDLQNw4PbIkQNVN7D6naus+rw
         hevC9MQFPqX6GUNs9Tv0muHLMekyzmp4yVeZgehdCS3MEwz1L/y9rjfM0IfoLj7G/5vS
         angOWT81I8bqlSOvbxAliOom0sofvCektRa6rSbUlPWOHiInMXx9oPmTp+lptStOrgH2
         wuwA==
X-Gm-Message-State: AJcUukcPp6f9tf0uNMlEHKj8042T2A+FORoxPPk4I8od28kpIkQMbgHx
        SeS6yNtSlFi9YEi7mq0uymyF7gSWz/JXzIAHNZFfww==
X-Google-Smtp-Source: ALg8bN7q6sTy+2/CGyjdCIo2gr9X3OSRKEJtp6H6qjoB1V59SR04M4lIX8XIwmwQR3BSqoT/G3x+dIvV760LRil4kS4=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr17883188ljk.4.1548079503786;
 Mon, 21 Jan 2019 06:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-5-brgl@bgdev.pl>
In-Reply-To: <20190118134244.22253-5-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 15:04:51 +0100
Message-ID: <CACRpkdYkX2XK2G0WmjjJSdAWGJsBndtYJsdNPS+hWwpqaH8Z1A@mail.gmail.com>
Subject: Re: [PATCH 04/13] dt-bindings: gpio: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:43 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add the DT binding document for the GPIO module of max77650.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Very simple so not much to complain about :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
