Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06B208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK+3Cll4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C06B208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756696AbeFOV71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756592AbeFOV7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:59:25 -0400
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A0B208E0;
        Fri, 15 Jun 2018 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529099964;
        bh=ClrAHZqlNLlBAgvVi//2XI/loP2Dy7ssKs8lTvCNtO4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FK+3Cll4U5I4W2KlRUzUpdeinuMssv0E0o61T7EZbPx1We9TSpitLQ8qpAmo3i9+N
         rgQHSnzCdP6hYipX09KfKWPAqdAmOZxp7o8k/mtZRorZqzxSh93fPCqSUjjcUJ28lv
         KR9IbAwwaGC0bJPetPTF8SGNXQItVw2Ank2lKesk=
Received: by mail-it0-f53.google.com with SMTP id k17-v6so6269181ita.0;
        Fri, 15 Jun 2018 14:59:24 -0700 (PDT)
X-Gm-Message-State: APt69E11yfrT6+X0PxxGVLl+3XczoGHq2HabLYarQxUaplcZNcql90pj
        3EoSfju92B1NRxlwdETNjKMeHnkDJapPbbF6Ng==
X-Google-Smtp-Source: ADUXVKJi9NzKVjQO/xDVYBvbbeCGseTawmj5CrcUlLBc9c8FYvLhVhHoGCzIHbpZYuFAFwkHpfctmOu+9hm5Yxxg798=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr2790652iti.106.1529099964079;
 Fri, 15 Jun 2018 14:59:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 14:59:03
 -0700 (PDT)
In-Reply-To: <baedcf46084db730e4db94e714632399a568b255.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com> <baedcf46084db730e4db94e714632399a568b255.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Jun 2018 15:59:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6nfqDpG9g_Wk-X2DsKpD+xAzFTEmkRmGBEAkLaayEnw@mail.gmail.com>
Message-ID: <CAL_JsqJ6nfqDpG9g_Wk-X2DsKpD+xAzFTEmkRmGBEAkLaayEnw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jianhong Chen <chenjh@rock-chips.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 7:30 AM, Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

Looks good now. :)

Reviewed-by: Rob Herring <robh@kernel.org>
