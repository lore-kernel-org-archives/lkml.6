Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D5521525
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVNqPjvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D5521525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeHWOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:14:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53222 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeHWOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:14:41 -0400
Received: by mail-it0-f68.google.com with SMTP id g18-v6so1623276itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dfwHG6Mr8oyCmdcmP/mEIoezgxbKGdHCiXGrBk82bc=;
        b=WVNqPjvQvhvd3VdhwlArH3xN4hbgqWDmTE+ExW8oGNdhq0j/0s2p5TQZO1UnIe/46c
         eQKDMo92sBD29+E5OmtETwZQJokmGEbrZIKwNjDT8ktQIfh3cK64+fwPmP/svyqSn2VL
         LsHF59k4OnAdtL0CC9gzfwrfdY2oXQxhIkS9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dfwHG6Mr8oyCmdcmP/mEIoezgxbKGdHCiXGrBk82bc=;
        b=W35fV9Bbcm5SKoXDQblv9tBMYwCdFHmjCT0Uqk1DXG067auSJ07734FF3g3yrq3gD3
         84/7xcboAJdtlEO+/koqzWE0PlPDuH+1WK0gHqeLMaz4rZ2rf0FDA571h8i4H2OslxJM
         g7QIbQXqAK4nTLEtIT3bQYj+2BjLIOcScYV8FLuaNHOLCmhG4gBNeTfP3rib8UFYRoPf
         eq8GXu+0Ouduia8ihHXMoEsgCHZMcqmtAh5umHoW7Lbu+AmPIvyK/n38CfqvbPn+VWVp
         Y1PTK7nQiF7WB5k7xcyI3wn14Hg8C7rADm86Qi0R/tlA4941cNkzOAsew1/VL6ydlZCo
         uiAA==
X-Gm-Message-State: AOUpUlG2zAmbO7Ho/1lj1o31w2qab0Jr5EAnlKM5rFNimGK/HVDehgKq
        QtXtKvjIfyVi/91N4NhWHknO7UAmtetLED3zNw6t9Q==
X-Google-Smtp-Source: AA+uWPxiaDHdAXRxz65WE8Y+HDXmKDqnk+HKJHTMIfPnu1WxfCTqt8Z80wgIynFbgLrrw2z9duEc4IDK2KcFJdTrcCk=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr51344060jag.112.1535021134712;
 Thu, 23 Aug 2018 03:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-4-jmkrzyszt@gmail.com>
In-Reply-To: <20180820181333.2527-4-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Aug 2018 12:45:22 +0200
Message-ID: <CACRpkdb5B14Z-hnqxtkE_KaAAAT0EWwC_1ogZBBzHHtBfck-jg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: OMAP1: ams-delta: register MODEM device earlier
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Amstrad Delta MODEM device used to be initialized at arch_initcall
> before it was once moved to late_initcall by commit f7519d8c8290 ("ARM:
> OMAP1: ams-delta: register latch dependent devices later"). The purpose
> of that change was to postpone initialization of devices which depended
> on latch2 pins until latch2 converted to GPIO device was ready.
>
> After recent fixes to GPIO handling, it was possible to moove
> registration of most of those device back to where they were before.
> The same can be safely done with the MODEM device as initialization
> of GPIO pins it depends on was moved to machine_init by preceding
> patch.
>
> Move registration of the MODEM device to arch_initcall_sync, not to
> arch_initcall, so it is never exposed to potential conflictinh
> registration order hazard against OMAP serial ports.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
