Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77912083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfBFKXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:23:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35291 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfBFKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:23:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id b17so1260923eds.2;
        Wed, 06 Feb 2019 02:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkK/rFiYpvS6KDVcBk/aBDujWnLAQbpRrcx/qdDdK7o=;
        b=Sqo7+mvEP7OhJ+SUAMqt+054ljGQl8jUZvZx42RgIHC2TIw14zoaxqVdPEDJZ1qqVe
         OTavDsD61GughdY8znkUED/LjitXqmCqDJwDz4fdoU4EvDGsvy53WaS1IBkw7tKK0zbZ
         kEr5IZ4T9fKLscFvn9+o2O8FCeWr+7v6hPnsYEI0eOzWyweQc9Q75Quj0UHyzwcSFLXe
         nPxrXG8YVTyQMGfR7p2pg+ug1418QEaHLCXLGqPcmtbKLnmXupRsR8XOLO6FU9eIBlIt
         qEQNyBU+tzf2uFNXrpDqR4uExSMTaIJDx5GQZIqwjPOcMyJr0NnTM3CPdbWz+DfO9zYq
         wIEg==
X-Gm-Message-State: AHQUAuYXHFlgLyA3JqNXwyAY7bKF/vXUOk/OctNGsrg/IWh9Zlx9I1PO
        lUtCZCAajzBwwgm2U6gVh5ueW4CY6Wk=
X-Google-Smtp-Source: AHgI3IY16k8sUwucIWZsuQx+lwTh2JbsdEtEtuxdV7ZrtS2u60OF6XHeoOe3pSmSGHoFKkl4r79P5w==
X-Received: by 2002:a50:da43:: with SMTP id a3mr7842592edk.62.1549448578911;
        Wed, 06 Feb 2019 02:22:58 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id z19sm3391341ejm.47.2019.02.06.02.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 02:22:58 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id m22so2021072wml.3;
        Wed, 06 Feb 2019 02:22:58 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr2285328wmf.99.1549448577699;
 Wed, 06 Feb 2019 02:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org> <20190206033239.3619-2-wens@csie.org>
 <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
In-Reply-To: <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Feb 2019 18:22:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67m_yO42VrivTf9x3JvAE3DL4nUZzzXt2BMU_Xb=ZHDtg@mail.gmail.com>
Message-ID: <CAGb2v67m_yO42VrivTf9x3JvAE3DL4nUZzzXt2BMU_Xb=ZHDtg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias
 voltage setting on A80
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Wed, Feb 6, 2019 at 4:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> > The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> > settings would make the affected peripherals inoperable in some cases,
> > such as Ethernet RGMII signals biased at 2.5V with the settings still
> > at 3.3V. However low speed signals such as MDIO on the same group of
> > pins seem to be unaffected.
> >
> > Previously there was no way to know what the actual voltage used was,
> > short of hard-coding a value in the device tree. With the new pin bank
> > regulator supply support in place, the driver can now query the
> > regulator for its voltage, and if it's valid (as opposed to being the
> > dummy regulator), set the bias voltage setting accordingly.
> >
> > Add a quirk to denote the presence of the configuration registers, and
> > a function to set the correct setting based on the voltage read back
> > from the regulator.
> >
> > This is only done when the regulator is first acquired and enabled.
> > While it would be nice to have a notifier on the regulator so that when
> > the voltage changes, the driver can update the setting, in practice no
> > board currently supports dynamic changing of the I/O voltages.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Hi Chen-Yu,
>
> thanks for the patch! I tried to apply it on the pinctrl devel branch
> (for v5.1) but it failed to apply, I assume because it depends on
> the fixes that I just sent to Torvalds.
>
> Shall we proceed like this that I merge v5.0-rc6 as soon as it is
> out and then try to apply this on top of that instead, so we get
> rid of this conflict?

Sure. That sounds like a good plan.

ChenYu
