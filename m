Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85DCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54C62173C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuEpMvIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfBQUip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 15:38:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBQUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 15:38:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so17103105qtb.4;
        Sun, 17 Feb 2019 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NH2pOdkehstcvqJYaDe1Ufk9vUWZdsIpYEk5ecaQcA=;
        b=LuEpMvIVduCJmyhjCB9niToJqhjS9JJ9Prwu5uBf2cNcg2gA+ZA4JsuTMGptaf2Nf7
         niYyvuptb6q8ogzJJgl0Lfv1L6BvCMssOoadxvzfKeUjhn/OPXG725UStO6bhBvQVqIk
         OogvVzazD9aw8FPdl9n4Ee0y2TO0z2SUgeB+RHkq/gvQ8GnURRaEr+XlYmc7ZQru++/F
         RPQk7jmCVsgdIXINbz64ixLZydEWdVfbF/fKLYuFeIuXmfRHZRaPMJETXA49xo2F0sJ8
         UKx6P2GExhgFb1NozTveTgzeq0gxLhXuFc9EtCEwU4NHDzOczroQtC5jXTPJ6Gv093wK
         BNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NH2pOdkehstcvqJYaDe1Ufk9vUWZdsIpYEk5ecaQcA=;
        b=oDX4spOt7mu+16GmvsGTloyW0zjHe9PccQbybIPT0lLvXeCJb41HbTsQNw/AiHEeBZ
         YHDgmBxMD594MUe4kteu0AQHm4gFSZUebL7Qq9WcGgvKq1eXSfHghRNk34izE1h6POQE
         nr5M2EFpWzdBa9zRShk8B3fW3qSXzIQXQBdGzUiZwGg3+Tngs1hZjn+Xj3cPCYz5SKyJ
         x9L4W2N/umuHD24XQ9NuCPeAObUcOWjNuyXOPb/tY4Gd+wrsVvxslGYbrmMhlOE/mz/H
         OS9owuxHaNlusX0eSP/VEzkm5XvnjRYFcGVe0Upqa/DXZwA4cG85YCtTjEVkXN+eZ4K1
         8Zog==
X-Gm-Message-State: AHQUAubWiB2zTHtZ4JQCLRIW6UH2Um0kQeHV39Dq7hcR2dHkNavFJYrq
        JjfRSv08MW+WhJzJ9ceioIr9VvsDLDBiG2Cy23A=
X-Google-Smtp-Source: AHgI3IbnlIHrgzKp9v+TFG/nPCbt/kEAUx+mvBUVqpGQiFNEtsy6LkUaMa49FCQLbxegblIkl1uAbg5MDRDKzWqI9Ew=
X-Received: by 2002:ac8:34eb:: with SMTP id x40mr15606664qtb.389.1550435923397;
 Sun, 17 Feb 2019 12:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20190215115150.32299-1-enric.balletbo@collabora.com>
 <22158501.cNvkU8jGDh@diego> <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
 <2105716.Hge0YL7z4n@phil>
In-Reply-To: <2105716.Hge0YL7z4n@phil>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Sun, 17 Feb 2019 21:38:32 +0100
Message-ID: <CAFqH_50ydkQWYbgRZX=nYMb-Goe5mT30yUbKNisqmQcj=-tOSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Heiko Stuebner <heiko@sntech.de> del dia ds., 16 de febr.
2019 a les 21:28:
>
> Am Samstag, 16. Februar 2019, 02:13:25 CET schrieb Alexandru M Stan:
> > On Fri, Feb 15, 2019 at 3:09 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Hi Enric,
> > >
> > > Am Freitag, 15. Februar 2019, 12:51:50 CET schrieb Enric Balletbo i S=
erra:
> > > > In order to use earlycon, the stdout-path property needs to be set
> > > > in the chosen node.
> > > >
> > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> > >
> > > What's the reason for adding this only for the Chromebook variants?
> > > Uart2 is pretty much the standard output for all devices, so I'd assu=
me
> > > at least all veyron boards should use uart2 as well, making this idea=
lly
> > > live in the rk3288-veyron.dtsi instead?
> >
> > Yep, all veyriants use uart 2, even when they're not chromebooks.
> > Feel free to put it in the other file instead.
> >
> > Otherwise it'll make things like the Asus Chromebit (mickey), AOpen
> > Chromebox mini (fievel), and AOpen Chromebase (tiger) unhappy
> > while debugging.
> >
> > The rk3288-veyron-chromebook.dtsi file is more for things that make
> > a chromebook portable. Ex: built in display, lid switch, cros-ec.
> >
> > Note how we have no uart2 references either in our tree in the
> > chromebook specific dtsi:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-3.14/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
>
> thanks for the confirmation :-) .
>
> I've moved the choosen node over to veyron.dtsi and applied the result
> for 5.1
>

Perfect thanks, I was unsure about the non-chromebooks devices.


> Thanks
> Heiko
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
