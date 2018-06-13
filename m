Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29FF3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D32208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKBWEvF9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuHJvk0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D32208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935595AbeFMSaF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:30:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40028 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935540AbeFMSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:30:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so7188036wmc.5;
        Wed, 13 Jun 2018 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DZW/o1qZyEsJ9KrOihKhMlFM+0/5SlT/2aygmRSAreE=;
        b=iKBWEvF9wMpAL0w+NB716FPuD3QfkeUVMbv+KRvp6vLJmDmlTXIEh4Aphut7FCiblB
         wZQpThv5VIJSkoTZQ0WX/1JLd+Nf6GijXkbbuJYFQtuJy6kxcIm5illYIaZVNMeJPThA
         O2SzFN3gF97C5RB5mWPB/GtRqB2GGef62nn/hco6JfkHACs4SYOS1eKY3ZONIaTQ+Rd+
         LzEWTPvjwLF8qIieipxlWfTX/53OU7skXDSAq+BwyF1GVs2/s7rlemFxpfW0Kc1sRxdO
         Rp+TvHJpgWNcd49OioDijU+OSGeg2WiHWduw+Inco0iswBVONPhiJS0kEFzhRs38CSrH
         jP7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DZW/o1qZyEsJ9KrOihKhMlFM+0/5SlT/2aygmRSAreE=;
        b=FuHJvk0a2F++wVsa+xuGB97QAree4VON3vef/trKhSmbUL1GYT0JCzKRiLJPMvh3Sr
         peP488LQMMYpuc1ehPksqiZQSxcjx3HX1q8tNpbwv8DiS3Gd+JE0RJWJp6UNPivWGuxK
         U3jOsmHLUtLPVofF41PdLaNbr8FTMZidsavu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DZW/o1qZyEsJ9KrOihKhMlFM+0/5SlT/2aygmRSAreE=;
        b=Rht66EWcy1mwuPeQVX3hqnN6YtBdJsqE4LUZCKtDbln9Tns7jSEs5bcy+qUx9WWRPB
         v6ubAu+m56e9fXqU4lZo4Zbow4S7g+LN2fUpDPXvRjD6/rPaLAjutS7qVquM5O0osv+2
         GDvNbYbKhaM5l1taXytKbcYLJ6WVUqeKq+oRzyndXxLZLQUIMOn0BHXzciK4/2bEs05W
         d0Zbo3Puw2Qj8Lg2M1x2lZCGB+Kc45j/U9kpIe5nsealLZquvTfVnqjHpV59sL7X1dtA
         PVe7++AE5jUK1ZKykrfD8FtAu8ehy00QJv7uK0hmUiNTyMqDWXgQ1Bg2GPXTaFgHDiqJ
         dfFA==
X-Gm-Message-State: APt69E0xokLf0sYui8dcq6hm0wTfbYS1ZoAY0PR7AR4l+6Zr6R2Ra6Q2
        RsDcbrcSO6FgNS/7TgVD9ugY1pvCsZJiCitbkrc=
X-Google-Smtp-Source: ADUXVKJa8U3jJ7Fa71cbVZrinu+tYwlkPd4l9CO0RYyNtC6i0mV3qMR8d4AGU/YcwBiW6F/wEtScX/9XwjVJpExrzyE=
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr4099487wma.37.1528914601389;
 Wed, 13 Jun 2018 11:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ec56:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 11:30:00
 -0700 (PDT)
In-Reply-To: <20180613151305.17240-1-ryan@edited.us>
References: <20180613151305.17240-1-ryan@edited.us>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Jun 2018 11:30:00 -0700
X-Google-Sender-Auth: Sc_YRdBdtDRNxsyM6-syCPtkOu0
Message-ID: <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
To:     Ryan Grachek <ryan@edited.us>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:13 AM, Ryan Grachek <ryan@edited.us> wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES.
>
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: John Stultz <john.stultz@linaro.org>

Wei Xu: This fixes a functional regression with wifi on the HiKey
board that was introduced in 4.18-rc with commit 60f36637bbbd
("wlcore: sdio: allow pm to handle sdio power").

Could you please be sure to queue this for the 4.18-rc ?

thanks
-john
