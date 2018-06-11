Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OPo1AJM2HlvXIAAAmS7hNA
	; Mon, 11 Jun 2018 08:47:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4ADC60792; Mon, 11 Jun 2018 08:47:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMmVXlds"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48FA4602FC;
	Mon, 11 Jun 2018 08:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48FA4602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeFKIrD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:47:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39077 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeFKIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:47:01 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so9942134itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkI2wunLcbdl4vTNmZxdLodmrkYxkoL1UrCHhq3SLAU=;
        b=YMmVXldstAfC7pSqAz2P3/3Fg7HGTDOnvZN39ZiAYmR6QlWmQKuxYqFnbOZlE9eBAe
         V/FsTlbKf+ogha1MNMN85OrEqgSM3F55vVCizwmEM/Qa4TvwBSQRmV8kVwkuwK7wuvMq
         Prtf6tXvo3Cv1u3EzDNNO43gBPRD83ggAK8fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkI2wunLcbdl4vTNmZxdLodmrkYxkoL1UrCHhq3SLAU=;
        b=hoYxde3LsXV2ANFBlL/3yx4BewRJX+KTFDolZ4fnsK2RmjcOLrhs8dpG7PukC5d1fA
         zwbF1+DBI7CI2uja9G4MPMwoYeFJTaks1ArWyYzWncfKtYwcslsMIGFUkKvibjprr76F
         AYpFxa0IsTX//2FOGlhtyJE6Ou0g4AE2O9VKpaRQgQ3x3HFnV5OvRFFa2v16bW+ebhTk
         1xJArgeInPBvz9H1J0Ku2n9YwTtL887BGIt6zax28zUb2EWc5JOesGh3FpfQjaPSs+Kj
         KgibOGibFRC+p+In6HzHIX0uqQuMB435x2fJ+hy5GHOfv4w6d5nMzkpxCWPPXa5C0MH3
         lJjg==
X-Gm-Message-State: APt69E2hhQ1NMXOjDU5s6S6cOsb8fVDkMoWsg8iul3optk8dAQOyVAsa
        NnYgOfWZDy8qw/Lq9BL/yUq4Y11a/M7UJhfDuRg9Wg==
X-Google-Smtp-Source: ADUXVKJw0sFTVB8Xv1oySSnJ3wIFK5dKx1sbQjPW/gYC0187Tuhvscoy+Eep6lwqlUtaaY4D8zn/EgedlOAgHW0OfLs=
X-Received: by 2002:a24:f444:: with SMTP id u4-v6mr9980301iti.132.1528706821127;
 Mon, 11 Jun 2018 01:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:46:59
 -0700 (PDT)
In-Reply-To: <84075652e978661247d71f84de46efd827869948.1528697370.git.michal.simek@xilinx.com>
References: <84075652e978661247d71f84de46efd827869948.1528697370.git.michal.simek@xilinx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Jun 2018 10:46:59 +0200
Message-ID: <CACRpkdb=Vfs6R+576+Wjh1cOh8ti-8jkGhj7Pw8zXdOxvHKOCg@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove architecture heart beat code
To: Michal Simek <michal.simek@xilinx.com>, linux-m68k@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 8:09 AM, Michal Simek <michal.simek@xilinx.com> wrote:

> There is no reason to keep this gpio based code in architecture. Use
> ledtrig-heartbeat.c instead which is much more flexible then this
> ancient code.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Maybe the arch maintainers will complain that the corresponding
new heartbeat code is not put in place in the same patch, but I
think the change is so much overdue that I don't see why they
can't do that themselves if they have interest in it.

BTW: m68k has the same kind of luggage, in the middle of it
timekeeping code:
arch/m68k/kernel/time.c

Yours,
Linus Walleij
