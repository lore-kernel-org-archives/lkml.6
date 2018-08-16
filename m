Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43B0208B1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEk9TK1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43B0208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeHPLIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:08:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41986 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389825AbeHPLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:08:36 -0400
Received: by mail-io0-f196.google.com with SMTP id n18-v6so3181851ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFKp7xwWFVpolO3tGZrLzPUt23wDqlZDPpe3eGLPC1I=;
        b=gEk9TK1Zijeju4uI8337fkR0p1kKrVVkCknwqksVUoDqSBFq+/mnaFRiOap2KAlPnz
         D7z1Z4tTh970gmXtHTA937cWjJD7/rxueNQ3V7TqhXq83C24o1gyYZyRkakpRJr3hwxV
         aSSNQCBBjBSvMb11i6no4CfeR5fDcQ1liqGJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFKp7xwWFVpolO3tGZrLzPUt23wDqlZDPpe3eGLPC1I=;
        b=FcIu4V5sWav7C5ta18Fkykadqa1vtBn0fOMXd05EaFExEmVGTlDZT/ETtMAclwOUry
         x6PjYbyjHEuD8cpqRUij+SZOsxdlmdPGzwHmBM6SLMm0h8yHtJoZRRLlA1cCoNwKheDN
         Vg34JseFaiE647/boAN0Of8Q2qvOOptcKJUWfvTd8pPW/hCA8ji+FedORHsOPmo3X5z5
         X0GhPm2rmwnOIz0TAwF9xIUyQlAPcjKEop02l5M1HWi0Faa9xNHlVrfJNuTTzeTrgvBs
         iPy8QHne3Jq/iIlsMAbgU3NgJRYUNpc3XL/l1QVgptYIrYI5dTBN4D1UL/kiL1iJPM4D
         /Hsg==
X-Gm-Message-State: AOUpUlGla9dsQDAgQ4ml4m+QBWSCKiCrJmHxGzwuwiOlkPv47uIg6xd6
        t9AuLDjT6bGCx6W9vPMXRXB03ppQT7yXhzOalcJy2A==
X-Google-Smtp-Source: AA+uWPxYAwrG7X6w+g9Mt0g4as4QnRh3jJ6VZi6UMilTku1YRv6k0xhuwbAQO2gcWhJIqUMP1i/2pyER9sCjQa4a6HE=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr23460879ioa.277.1534407110775;
 Thu, 16 Aug 2018 01:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180815201855.29738-1-mail@david-bauer.net>
In-Reply-To: <20180815201855.29738-1-mail@david-bauer.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Aug 2018 10:11:38 +0200
Message-ID: <CACRpkdYTxvWjLizTr8Qg-FmSPjnnU+kj2+VrUUcz5F0nkhrUrg@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74x164: add lines-initial-states property
To:     mail@david-bauer.net
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Aug 15, 2018 at 10:19 PM David Bauer <mail@david-bauer.net> wrote:

> This adds the ability to define the initial state of each output line on
> device probe.
>
> Signed-off-by: David Bauer <mail@david-bauer.net>

(...)
>  Optional properties:
>  - enable-gpios: GPIO connected to the OE (Output Enable) pin.
> +- lines-initial-states: Bitmask that specifies the initial state of
> +  each line. When a bit is set to zero, the corresponding output line
> +  is initialized LOW. When a bit is set to one, the corresponding
> +  output line is initialized HIGH. In case this property is not
> +  defined, all lines will be initialized as LOW.

This sounds like something that should be generic, and not use
a bitmask, but offsets. It should work even if the number of
GPIOs from the chip is > 32.

Is the usecase different from hogs?
See Documentation/devicetree/bindings/gpio.txt

There has been extensive discussion about supporting initial values
with something similar to hogs, but I haven't got anything ACKed
by the DT maintainers so it has kind of stalled.

I would make sure to both make it generic, get ACK from the DT
mainatiners, and make sure to implement it in
drivers/gpio/gpiolib-of.c and not locally in drivers.

Yours,
Linus Walleij
