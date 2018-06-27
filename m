Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2E820693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOA5ngrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2E820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965760AbeF0Rdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:33:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40175 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965055AbeF0Rde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:33:34 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so8583510ita.5;
        Wed, 27 Jun 2018 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6r0qlNlWsEUOXQR5YP03k0EXSg/TDJJAt4SQye4ALE=;
        b=aOA5ngrg19VkFSaNF8Cv8wIcO7D/0vRQfwdd2pmbTjhf+ZMPNDj++s8nHU5xgqrKjc
         l9e5ZR33gU7B9nHa0ypZ0XBj55/g79HYjv/sGY8l7hBv5NhMO5N1i7RzK/ipmZUTTNn4
         85bScTU/Sb2OcFw8PaOtryF8eu2P5PsO1iVApn0vQTTTfhQHpP2q5pclLNSN31ryKKZc
         mImqepwYpt3fb2bXLQWUAxP5t1N4t+QAkHdkf8df62kxp3bb+aaJ2/UzcGvijrArY8lI
         HpMBe65xZOQc5C3g5yXEUPXiAKb7e4fLuqsvSaYwyn5VHesALVnjc3cRQYuyh1MHohsl
         jSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6r0qlNlWsEUOXQR5YP03k0EXSg/TDJJAt4SQye4ALE=;
        b=MfNRhJbsdplNHM55BVdZHKtRowpGaVFLZxngckPJpR/vqSxUJLz1xw6hlba+4FeLZO
         Pbro0fN7TttPoh0MYhd4eL3vHb+oC+JaELv+vopBzkPQhAOJX/RugHKSoiNQpDkZJZf9
         oprwtzIHUcRPxRdIrrbwYKzKCuZv9uZAbgK7Vlk4PzBOXa7aR3uGbXVha6fScMwv1pcg
         lmwknU2YNtI0W/hK1Hax3PQwNE6xvGWucWbELNqCWaadKLzIB8P2zJfrTkrSJbql0X3a
         /Lm6F0x5CR0Qy10z5iVJjcpmYJrRqsL7T9I/ENyG8m8io1Cw8zdh8uSUODf+HJMNxqj7
         pijQ==
X-Gm-Message-State: APt69E11/8KDWFU0RLSn/RjLYZQZMgE/Y6f4JrZo5VoyE9cPaxKILJZJ
        XRXuH75A1WFp6duVS0q9hhL3QuVl99e5C/xXcUE=
X-Google-Smtp-Source: ADUXVKLdn7GXc8U8XA/3lGo6/stpQJH2apQRcZxpRpsK/rF9CuG7JwDeEDNXXwNnxuz1hT6lpurm6xTGsgQQtKBt8jk=
X-Received: by 2002:a24:1448:: with SMTP id 69-v6mr5633285itg.143.1530120813537;
 Wed, 27 Jun 2018 10:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru> <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
 <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
In-Reply-To: <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 27 Jun 2018 10:33:22 -0700
Message-ID: <CAHQ1cqGxXg5QYMTxbSsNDDr=ot0h0XWW98hHNVnf+SQhrjoL=g@mail.gmail.com>
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 9:59 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
>
> > There are three boards that share that configuration almost to a T,
> > with the only difference is the particular GPIOs used. Putting it into
> > a common file avoids repeating the boilerplate and makes it explicit
> > to the reader that those settings are shared.
>
> I'd agree if that boilerplate was 100 lines.
>

OK, so your threshold is 100 lines, mine is 3. Agree to disagree?

> But here it is small, and mostly containing lines that are required for
> any i2c-gpio definition. It does not any value of itself.
>
> Saving 5 lines at cost of loose of integrity is not something I agree with.
>

Can we maybe tone it down and not make this sound like a struggle of
"good vs. evil"?

> > There are at least two boards that use that UART2 as is. Same as above
> > this was done to reduce boilerplate.
>
> Here have choice between two logical blocks - definitions of uart2 in
> two boards that use them, and two logical blocks - definition in dtsi
> and undo in board that does not use it.
>
> You trade a couple of saved dts lines against keeping things consistent.

That's your POV, mine is that I save a couple of lines and things are
still consistent.

>
> Nikita
>
> P.S.
> In case of these zii boards I doubt that dtsi worths at all. Despite of
> all being imx51 boards from ZII, these boards don't seem to have large
> common logical blocks. Perhaos RDU1 and babbage have more in common - so
> what, create a dtsi for them?

Nope, that slippery slope doesn't exist at all. We have a clear
boundary/decision criteria of common vendor.

As I said, let's leave this decision up to the maintainers and avoid
continuing having this argument where neither party convinces another.

Thanks,
Andrey Smirnov
