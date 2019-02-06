Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33957218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWZmzo1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBFIO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:14:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42612 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBFIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:14:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so4655009lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 00:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzjpXElKQBdM56kmVWeTXpt5kVUsG7R3DiJdxJ0/xOM=;
        b=iWZmzo1uB4hraokSvpYhm4EUzoSAVrnW7SVqm46L06bMYZnJQkJ3Z79JMaIH3XFYMI
         zuAcHvYZmhpIhum9uOS5AnJvr2jejwgUkTvcX3PIrhvMa3DnIcrF70osLySNA7MFLT5J
         gW9c7JOYjMV1D1rE/OU4ql79zttC92uo8+J+ElOsjU74Z+bEHDOScitovq7wdo8CLuvM
         /5jr1BRo6wrTbFvBMr7zwIGyZw7HYh+faz/IjKw1j7Lcn+xF1N9tzjxBJBPQ/X4gqR+V
         EM+KQX5z9XO2hTnkRhcjiSoiSx1kgfGcUdo1OJLWGsYbOMaU34PfpRRh+BFYl9v8MHQp
         Ro1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzjpXElKQBdM56kmVWeTXpt5kVUsG7R3DiJdxJ0/xOM=;
        b=YiGJ2eONv9d7iEMFCkghdpAAJFHZBVL/02URuxywRb99p5rEGYhA6mJdPjNog3ov/M
         VwoB2r1LgMaLv9Nc3t1hAlSuvd2hHt8dnGmj0eRO58A9yDioZHMSz0xz9Mxg/ii2cPsY
         fajz2pLLnhtbeYbhchxbZ59LsrsJafkUOs5oarANP9JP2eAjL97kVBRxlXB0y6W/QfGo
         bbqtp+pDNu86fwvXIVlFscArFvuBI7UuBCmAHCJDqDjEv8lnKyozidWsO04JpWk65bOm
         MOC6CobaNW7Q9E2I4vBasgbsz08AXRM+CDrxpyp7YGD0MsVD3IkpjXhJ3jUIYPwmrPtW
         wGMw==
X-Gm-Message-State: AHQUAuYehwy9jAqPt8B7FNYMxELR+qqW9ABM77q6FO4fYQ00k8U4WNfL
        bTGkRd+Kpht/vu7YwF/8i+vNJt9SgJ2Ipj+VxIQEyQ==
X-Google-Smtp-Source: AHgI3IYxdckRquvcYP1Vfc3ApUor4WMg9sOYbQ3rWimmr3y8hJfGNl67dGVdlfRgHZ+Cd6rXIm+AfKL6eKQ52sL1y1Y=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr5997882lfc.27.1549440864049;
 Wed, 06 Feb 2019 00:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org> <20190206033239.3619-2-wens@csie.org>
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 09:14:11 +0100
Message-ID: <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on A80
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> settings would make the affected peripherals inoperable in some cases,
> such as Ethernet RGMII signals biased at 2.5V with the settings still
> at 3.3V. However low speed signals such as MDIO on the same group of
> pins seem to be unaffected.
>
> Previously there was no way to know what the actual voltage used was,
> short of hard-coding a value in the device tree. With the new pin bank
> regulator supply support in place, the driver can now query the
> regulator for its voltage, and if it's valid (as opposed to being the
> dummy regulator), set the bias voltage setting accordingly.
>
> Add a quirk to denote the presence of the configuration registers, and
> a function to set the correct setting based on the voltage read back
> from the regulator.
>
> This is only done when the regulator is first acquired and enabled.
> While it would be nice to have a notifier on the regulator so that when
> the voltage changes, the driver can update the setting, in practice no
> board currently supports dynamic changing of the I/O voltages.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Hi Chen-Yu,

thanks for the patch! I tried to apply it on the pinctrl devel branch
(for v5.1) but it failed to apply, I assume because it depends on
the fixes that I just sent to Torvalds.

Shall we proceed like this that I merge v5.0-rc6 as soon as it is
out and then try to apply this on top of that instead, so we get
rid of this conflict?

Yours,
Linus Walleij
