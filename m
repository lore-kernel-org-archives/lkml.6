Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0D320881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a45F7tKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfAaIPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:15:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40291 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbfAaIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:15:13 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so2656227ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uq3TRTrUXfl0cDjfs8DfVsJIE+G5Ir5lbXpmTlw3Ahs=;
        b=a45F7tKBMhcFAW9npg6QC9B/9WfOAHI8L5Y99Oscwp9D6nv0dZ6F6KlnzmTgJx809z
         6t/JDLGF+efh8eWlnznoE/b9OeAd7gpjfs7TEgIlU0i9oymdV3+sn4yWGT/dKuUrDlpz
         c4uMk78rhXo8SpMNijiY5ZqEmWVjtyEne/yNHHlauY4CZp7Y7McuatDVPsXRL269Gs2D
         mO5IV0FAxJsHCGa1XJ1AYofsCTuaJVherB6xbfLswy6R3Bgegt2CfbSv5HbKycKD6AvR
         Oz0u9LxmTsjiiKAg457piQcE6TIKvkSH3Zhvwdr6gEf7u7VNPv0uyYvCFDMkbN1JtPmo
         65gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uq3TRTrUXfl0cDjfs8DfVsJIE+G5Ir5lbXpmTlw3Ahs=;
        b=GUyfgrHaF8c2jihGdR3NKauW1O6Xrg8mCeKO/qE09doBaejlWEY5NMHMkWrRP8kdhP
         kDGSpl+ZoCYKFSbkxCzTOU2msW+3ed9onplguX7NVV1rDsWI+CJPL1yhfYlPIzWlkBMS
         6yjfoWsHgwjrWjPxAlpK3iV3f5dWGl1UbL2JE3YhkwhdVFrMH0o1qIeXJ0vF+XBZVgr6
         tkCfzT26YQiPzxjbOwRWnqhb/SbWrmF1ICX2LK00cwYL2v1FNwAPzWTdWTEr4qaagObf
         zuFim6VagBocDEYuw4x/xqtLnyIxKfEs4wMB5Eohy+2mPNDxHstzIgkGmb7ELxBkcI88
         UO0Q==
X-Gm-Message-State: AJcUukfLC2izjEfBeP6JxsGLOGa0vrLjZp4lzMRB+VqQVtpwAv8FucLO
        qMzmEQQ2YR3UhXDjixJdgynu35mJkuwrMsmy8kmpCA==
X-Google-Smtp-Source: ALg8bN4mRAdhO9g4fRYxgFfmeh8c7OuoosZSUn4xytLR8tgmYzMW5I6gwMqdoGqIkvMHNQwrkwTPtINEmXRzNnY39OY=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr20802174jaj.24.1548922512108;
 Thu, 31 Jan 2019 00:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws>
In-Reply-To: <20190130185328.GA149208@dtor-ws>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 31 Jan 2019 09:15:01 +0100
Message-ID: <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 30 sty 2019 o 19:53 Dmitry Torokhov <dmitry.torokhov@gmail.com> n=
apisa=C5=82(a):
>
> On Tue, Jan 29, 2019 at 02:35:44PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add support for the push- and slide-button events for max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Please feel free to merge with other patches (MFD tree I suppose?).
>

Hi Dmitry,

I'm not sure what the policy is on merging MFD drivers, but I'm seeing
that Mark Brown has already picked up the regulator part into his tree
(including the binding document). I think you can just pick up the
input patches and it will simply not show up in Kconfig until the core
mfd module is upstream.

@Mark: could you please confirm it?

Best regards,
Bartosz Golaszewski
