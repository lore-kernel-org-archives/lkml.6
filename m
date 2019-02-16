Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1218C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D54222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eysGb+nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfBPBNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:13:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35590 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfBPBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 20:13:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so19748104otm.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/J++2veKGNq70nHjhGrI31XfrWth14XreBo/zeUPb+U=;
        b=eysGb+nVwWZZfzv3JEXH92iljbM+6DT6EsdbB5vrOcUBdUImmp5udiu+bfmOAm9EGz
         egQhOHxiyHdbmNHALCGtaYC2IJ8PLmb1hGuuDXynejz43TPnshmbut31RAJk8VMNodRZ
         8W+ivG1aeDlSmmNAglgd3lQyUXA9IsaLtQLXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/J++2veKGNq70nHjhGrI31XfrWth14XreBo/zeUPb+U=;
        b=TMeyFXYmHA+5VQeogNM40tXMxG0y5MfGdwd8r/nVBRkf2fIeCeKihlpimbmfpcW3g/
         r0flV1wygG8uMvtVb+HqnKCwcpjcc2EQfrZ80gezYIbZPSy1uhn5AcARvPEub9rNdq8f
         jPwpJx3jU+zrcGsOWisjj4AJMGY9GzgLFzWer+d5G1zd6kgcK6e+v7rEqvqIfUk6/sCU
         SBnaFPBMtbm8nEqn0Lgt/ETfdFHCu2qRWefudbCC7wSdCLH6gr505Xq1VyoE0cq7oa7n
         nYbVAy2rr9YaWiNFefwVHxHbvmQV1hsAj3S0tjzrtCEjC0ifBk8Su6mulIe+vQAzT1Oy
         mpaQ==
X-Gm-Message-State: AHQUAuboM8Xp0hnFF2+wycQVImWt6QLnpcYhEuEQHmzNzE7GX8JgZLs/
        Dh6CHX1owU+Vb9XZupGNLAb3LxGsXWQ=
X-Google-Smtp-Source: AHgI3Ib3Mdf7drMg9G1at6N0b7GjmPBkE22UNkJxx7S7ei3ENMyRu9mGf5KKpKfvN6JvsUSIoQsezw==
X-Received: by 2002:aca:4008:: with SMTP id n8mr7263937oia.161.1550279618805;
        Fri, 15 Feb 2019 17:13:38 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id v20sm2399063oto.31.2019.02.15.17.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 17:13:36 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id m1so19704500otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:13:36 -0800 (PST)
X-Received: by 2002:aca:dac6:: with SMTP id r189mr7790584oig.52.1550279616017;
 Fri, 15 Feb 2019 17:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20190215115150.32299-1-enric.balletbo@collabora.com> <22158501.cNvkU8jGDh@diego>
In-Reply-To: <22158501.cNvkU8jGDh@diego>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Fri, 15 Feb 2019 17:13:25 -0800
X-Gmail-Original-Message-ID: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
Message-ID: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:09 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Enric,
>
> Am Freitag, 15. Februar 2019, 12:51:50 CET schrieb Enric Balletbo i Serra=
:
> > In order to use earlycon, the stdout-path property needs to be set
> > in the chosen node.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> What's the reason for adding this only for the Chromebook variants?
> Uart2 is pretty much the standard output for all devices, so I'd assume
> at least all veyron boards should use uart2 as well, making this ideally
> live in the rk3288-veyron.dtsi instead?

Yep, all veyriants use uart 2, even when they're not chromebooks.
Feel free to put it in the other file instead.

Otherwise it'll make things like the Asus Chromebit (mickey), AOpen
Chromebox mini (fievel), and AOpen Chromebase (tiger) unhappy
while debugging.

The rk3288-veyron-chromebook.dtsi file is more for things that make
a chromebook portable. Ex: built in display, lid switch, cros-ec.

Note how we have no uart2 references either in our tree in the
chromebook specific dtsi:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-=
3.14/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi

Alexandru Stan (amstan)
