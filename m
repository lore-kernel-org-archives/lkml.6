Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE71C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogDpR9hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfAPKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:04:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41755 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfAPKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:04:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so3390394qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdRJ//Al+7TrpSHqfgXJa9IQ9Wno7RlwX5/uoypigaE=;
        b=ogDpR9hjHUkL9ki0B3c+nx3Aum6eJbEz3z5kPph1GVnzZW49vE82rLVUKnco6n/BUt
         Oxy/ygWmzFfCn7vpQ+lU1WIENPBHVC1HZRBlgO1YemQ1AFelm0q8q5ObJjiTr7s5pDp+
         THUniQ7848PSuN/lTB9pQrNFO6iaHSvQmur91Otp3MRcwcA9kRn/kJXrDptcnHhD0kS4
         HlANwezIjrrFaPSpDHNeH58eT82lLbz9F6qxTQzzleYngCGt/RUxDO9ld/N+RbruJ4oE
         CoKCvvofnMNQhv6ccIW3O0hl9+JVfXTMS/gSU/ddOedW/bHdPL8pf0r+ygmAllWICg6O
         bFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdRJ//Al+7TrpSHqfgXJa9IQ9Wno7RlwX5/uoypigaE=;
        b=ly3NoJnbeQlB2u3lEgbaAifdNtrFxOscxVEr/76E2YL0/+egC/M2RQAwthmaxSCo/v
         q3NcLU40vPTZscqr8QT09DS+FPetRRRc5X9MnNaFt5MlIlJrMj66D4oykiG/UbBRhZzz
         3oaP5WISdaSWUu1jc9xUmNwwlblnZ+diGYihZWQ6SI0Fbh3j28OGUa+7jT6Ng2CQiWOc
         FY2PMKxH4+iw4QF2V/F7uS2gNwkfFZ0v1oy3fdD4bH7Ib2n6XDdUmOrCiSDwNYBdHtub
         ZD2+h88qIIPDp9xk42el/HnHyqd6C7Q9AAM23QwY1Y/iGG7wzhGEWOas8zJORCKHGyU4
         V7sg==
X-Gm-Message-State: AJcUukcDb/Vi5ECydiOpjp04s7PWJOZu85kRSfvn2+K3hjI2Za/ALL3d
        eNjfrRFM1AZ/ioH4MDcRG8nmuxlUzpIQqYGnnng=
X-Google-Smtp-Source: ALg8bN6A9T3bU1dtHUmI5aKbuXFGUonsRZUuII6/cTSUgeBm227/Rsi4Mx59hzAgKoCnPwR3/2mG0ufGZ52MUh5T9ic=
X-Received: by 2002:a37:6442:: with SMTP id y63mr6009160qkb.119.1547633079483;
 Wed, 16 Jan 2019 02:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109171415.9954-1-enric.balletbo@collabora.com>
 <5125335.cuvu72hbmo@phil> <8a0ea28a-961f-130b-bd76-9dbda42ea417@ti.com>
In-Reply-To: <8a0ea28a-961f-130b-bd76-9dbda42ea417@ti.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 16 Jan 2019 11:04:28 +0100
Message-ID: <CAFqH_52gy8oUUAy61O+gMycd08Q22ZS1mqh6fm6TXzKfO1CgyQ@mail.gmail.com>
Subject: Re: [PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the
 utmi-avalid property
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kieran.bingham@ideasonboard.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Kishon Vijay Abraham I <kishon@ti.com> del dia dc., 16 de
gen. 2019 a les 9:46:
>
> Hi,
>
> On 10/01/19 5:56 PM, Heiko Stuebner wrote:
> > Am Mittwoch, 9. Januar 2019, 18:14:15 CET schrieb Enric Balletbo i Serra:
> >> That property is no used in mainline and is not documented. The only
> >> board using that property is the rk33-99-evb-rev1 and -rev2 in the
> >> vendor kernel. The existence of a further -rev3 (which also looks way
> >> better cared for compared rev1+2) indicates that the older ones are
> >> probably some sort of preproduction models, where some wiring (on the soc
> >> or board) may have gone wrong.
> >>
> >> It is also not clear why this is a hardware-description or a DT
> >> property, so, as noboby seems to care of this just drop reading that
> >> property.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> For some reason, I don't seem to have the original patch in the inbox. Can you
> resend it please?
>
Yes, seems that for some reason my script to add the maintainers
failed, sorry about that. I'll resend the last three patches.

> Thanks
> Kishon
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
