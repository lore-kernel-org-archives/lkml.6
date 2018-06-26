Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE18C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DD323DCF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQOcrIwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DD323DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeFZHyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:54:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40264 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeFZHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:54:35 -0400
Received: by mail-io0-f193.google.com with SMTP id t135-v6so1327940iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCUNQZYMAwuauImqsrZXC98vSUS1VcIW1elR3mOgOa0=;
        b=EQOcrIwkqV4QolZFC/WWCpimXzESsDo0wWAMhUxyGaQphkPswSoYsv+g8dFReol/hJ
         PqGZkD7Lx1Kt5IleYGIjTVe/aeLyT0jyHg8ujaTe/wf+L0OAGsaVj4IDoFZQ3Tzt/Dw4
         Iyt0i0qpwdo1lmlXyckYN3E6/p/r6wb2vrn+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCUNQZYMAwuauImqsrZXC98vSUS1VcIW1elR3mOgOa0=;
        b=XlC5H4EgrOyu/UT91zHZTOj2/Zmj7EWStCJ+mid01XczR9YoPmcIVTbunfD9ZuUlD1
         4Q+8CxvigvuxLOBuUzTTlnBR01YEU43G27cDpyJqKIkILCndar5xB6dlA3ioBXrrYxt2
         CYN4BOkdoGebEnOWvcB3WLF6tjtLOYA6yH0SFllm2hqNRUcNaU3X7hiRyvIOvMcXfJLB
         ZlPBjDYdOwoa/7xRPMyw9PIBd4zpiHdk1FjHgccYp0QbQ/vV3BeShrDJTYCCznao9slk
         cMYeLQ4+Rmco4x17Pgx9Gf75EbGHW3SCEFHO1FeUbmMhskBfsip1+5NgGTvCM4A0Bf70
         LDNA==
X-Gm-Message-State: APt69E3L0q8Ga+7cEAPwCaBsr+7BV0L2WXIHL0c1CTZiglCdE4gBWnfq
        5XeQUnGQcHMcmYHMToxR3RFiQ0p140TIeyg8To7fjw==
X-Google-Smtp-Source: AAOMgpcgWwgeFCJPeKTkO0eSCD5TUuzl9/66UxL+Mc7fJpFC2J8VPIeftzrg7XKWB970CsmCKvC0plZDF6XLrEh9IIs=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr345126ioz.304.1529999675264;
 Tue, 26 Jun 2018 00:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com> <e6b215db77c8203704c9d1216a9e8747de1b5779.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <e6b215db77c8203704c9d1216a9e8747de1b5779.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jun 2018 09:54:23 +0200
Message-ID: <CACRpkdb9M7eN6JSk8yz=K90s1+S0cY9OcD_pDBCbQ3GuzfNWGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jianhong Chen <chenjh@rock-chips.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 3:29 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for two subsystems:
> - clk
> - Regulators
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This looks like a clean and nice MFD core driver to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
