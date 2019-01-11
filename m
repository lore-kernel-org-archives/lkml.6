Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD610C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5882133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zVrA6T/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAKAxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:53:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36620 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAKAxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:53:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so5959230plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d+X9gpNYVSva8N2u0I5OWMv9xuzeEIgVw0AyDjUxoJI=;
        b=zVrA6T/FKuIYh9Kgg9FkzvDQWkQZpyopoZp/bD8sGDhCyLF7rBXVZmjgLnzToTccZL
         7jeXqAtmHxb+h490SSFuLdr4qRR+dSqtcY8jqTqxXfdYn8/CiP5HOOaDkyDOxezpjp1C
         aJw6X9eZpvufQJr6oyXRJiQ/E3809djtMJcU2+bRno4ZJeN9JoAU7ixWVtcPNTDWCkmQ
         wahduqkLpNWKv56/6uX7DZew2jegvYq48aJ4nOO3v4aaSpCnNpQx+bwCYqlxKH2Dnbjh
         Av2iZ1h5dJwplzsq07mbeMkqUtoD4LcK8KoxNGiH8hvwepZVGnB17NiVtMkmsWI+vW56
         h+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d+X9gpNYVSva8N2u0I5OWMv9xuzeEIgVw0AyDjUxoJI=;
        b=XgJ0yQqHDUi/MrHX/2D/3m8UnSjpCJWgwhfCup/GX43cXIkxQIHEaki7LJubtDFU6H
         7hDcTN1lCeYZ5wUZK7kQKKkH5A/X7BIb8clqLYwD9C5+547r3F+4joK8eSk73jFiJE2z
         ZYXzIeMD1cOg/UGZoJR2h4lOmBgbGLGqS1JrYN5eVt6ZgJ/v20wM82XdOhA8HYJAo+wn
         YPiCY9lK6GEHtauh7nSVzkY7hfCfOVEAAX/fwL3gnCPivuo1RM2OyMqJVnoIHB59NWKm
         abiuRGdJ6njTMCS/tNiIVpQRzjagV6Dzdc0/C3kI+xWp0upuljRnvSF7aAS2ZxdwcYNd
         R/5Q==
X-Gm-Message-State: AJcUukdN+q4h+UAnuO6+6bBsqxjAcBGGzVt7deCag0gJutTT4taHMJVQ
        pqTbSy57wBpxRGb9fWm5gySudv90ziQ=
X-Google-Smtp-Source: ALg8bN7kf17ouikPbX3kwEK63xd10riC0IV86qLI8Pb2l50tpM/h5j+1Iao91I9mV4FU97dcAQhi2A==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr12707258plr.25.1547168016422;
        Thu, 10 Jan 2019 16:53:36 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id m65sm136399873pfg.180.2019.01.10.16.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:53:35 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
In-Reply-To: <f4fa4226a508d563d1a77eaafa5590fd84577c15.camel@baylibre.com>
References: <20181220161037.23756-1-jbrunet@baylibre.com> <20181220161037.23756-3-jbrunet@baylibre.com> <CAFBinCBQkpLxUZYp2NQoXEA=8t_XCJMHauM+DwTz-p0FA57CrA@mail.gmail.com> <f4fa4226a508d563d1a77eaafa5590fd84577c15.camel@baylibre.com>
Date:   Thu, 10 Jan 2019 16:53:35 -0800
Message-ID: <7h5zuwqak0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sat, 2018-12-22 at 18:01 +0100, Martin Blumenstingl wrote:
>> Hi Jerome,
>> 
>> On Thu, Dec 20, 2018 at 5:11 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> > While some 3.3v eMMC 4.0 are available from libretech, the default
>> > option for the aml-s905x-cc seems to 1.8v 5.0 modules.
>> nit-pick:
>> can you please state which module (storage size) you used for testing?
>> you probably still remember that we had some confusion on Odroid-C2
>> which eMMC module works and which doesn't, so let's be explicit here
>> 
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > ---
>> >  .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 9 +++++----
>> >  1 file changed, 5 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> > b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> > index daad007fac1f..d0d202cf7161 100644
>> > --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> > @@ -118,8 +118,8 @@
>> >         vddio_boot: regulator-vddio_boot {
>> >                 compatible = "regulator-fixed";
>> >                 regulator-name = "VDDIO_BOOT";
>> > -               regulator-min-microvolt = <3300000>;
>> > -               regulator-max-microvolt = <3300000>;
>> > +               regulator-min-microvolt = <1800000>;
>> > +               regulator-max-microvolt = <1800000>;
>> is there a 3.3V -> 1.8V regulator on the eMMC module?
>> I'm not sure about the schematics but it seems to be that the board
>> itself supplies only 3.3V to the eMMC connector, so I'm not sure where
>> 1.8V come from in this case
>
> The module is indeed fed by 3.3v only but it has embedded LDOs add will feed
> back the supply of the BOOT gpio bank.
>
> I tried the following modules:
> * 8 GB samsung - v1.0-170420
> * 32 GB toshiba - v1.0-170421
>
> I think you can't get them here [0].
>
> In theory, these 4.x modules [1] could also work. They don't have the LDOs and
> are directly feeding back the 3.3v to the BOOT bank. Since the modules are
> advertised as being compatible with the Allwinner boards only, and not the AML
> ones, it should not be the default option.
>
> [0] : 
> https://www.loverpi.com/collections/libre-computer-project/products/libre-computer-board-emmc-5-x-module?variant=4173557729
> [1] : 
> https://www.loverpi.com/collections/libre-computer-project/products/libre-computer-board-emmc-4-x-module?variant=761282232333
>
>> can you please add a comment to the .dts about this?
>
> Sure
>

OK, I'll wait for a v2 of this series.

Kevin
