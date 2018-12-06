Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04163C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92D208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeLFKhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:37:14 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45969 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeLFKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:37:11 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so8199438uam.12;
        Thu, 06 Dec 2018 02:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNfbB/d2ZD4fXfo0GjreIEblWjPSYEgLVSWDow+fqKw=;
        b=p75NfWpJiNrfiUIMN2UQsxcp/jobz2nM/ANFOK5ZVhxb1ILNY7AvJjhskb0KbiaXJC
         Bb+TDuQjH4JVD5fqMrZxGLuHjHclxteqeBF9YlBK8e6maFbn6oPohKd/05VBVhf2qDCQ
         EhGHU90hav7OJiHQsPq8VJLIvYdJcGbdg4w1+7vhr6CKogPwhHuns/hWzlpkC0H6GWdK
         o9CShjp+enrSOq+CUSeWbK7jhCTMx59EA0Q2WeZhytdqo8+mSG87hWYLyCochyTSgMXt
         Dn5apkfqGPLpB8pEgsna6nWru/DxLtB7/M5DFy+NoWVM8PM7UZffJC93WJzngO/zGH9h
         9QHw==
X-Gm-Message-State: AA+aEWYtTyBNQSbN35x0JCZTEC5Ju8C4vWwRtnQYmmzTasLpiWlpKWVD
        brmPkOr5FmzpYBpwjpAKm8lZ9qnOATAcZSU5CT0LKw==
X-Google-Smtp-Source: AFSGD/V/bqvg/8uBak7uWXhgxLgZM/pyLVHQL+kAnmYuU+tYB0AKxMrFOHbqmYK/9sBu90ienKxwsJVgQtz2VWRUA38=
X-Received: by 2002:ab0:465:: with SMTP id 92mr12732097uav.28.1544092630651;
 Thu, 06 Dec 2018 02:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 11:36:59 +0100
Message-ID: <CAMuHMdX9xZgAiBeXCXxLRSJYMefsFwhH3NGC7=EYteFd6kODMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add generic bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Sun, Nov 11, 2018 at 8:31 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Add generic binding documentation for the RTC subsystem.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for your patch!

> new file mode 100644
> index 000000000000..221b7da50aca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> @@ -0,0 +1,30 @@

> +The following properties may not be supported by all drivers. However, if a
> +driver wants to support one of the below features, it should adapt the bindings
> +below.
> +- trickle-resistor-ohms : Selected resistor for trickle charger. Should be given

Can this resistor be less than 1 ohm?
trickle-resistor-milli-ohms?

> +                          if trickle charger should be enabled
> +- trickle-diode-disable : Do not use internal trickle charger diode Should be
> +                          given if internal trickle charger diode should be
> +                          disabled
> +- wakeup-source :         Enables wake up of host system on alarm

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
