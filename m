Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D75C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFC021A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QhR58r5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbeLVRBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLVRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so7882193ota.12;
        Sat, 22 Dec 2018 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymXbQn4yh640Md6ALwIiwWx/ogGOI+5wQMm4YP9kOu4=;
        b=QhR58r5R7kwV9P3mQBtR3YCduxyw9gz2mKx6PepVhPV1lQkGoIAsg7ekUHcLCcVIZt
         fYNc83pspJbYeA+hJxUZ2xkZz+jtJu/nKwvx7at3dK+3Cwm/04L5CYcHIPuwcqyUGcAo
         wLS6Qhz0Vzrv7riGc3vB+8m3+Ot5GsvR+BD1pYbO/2J4ZhOdDED/Jp813hPUP69V2ZYD
         azPT3+HDztPbZBdxOQkRfAISQCQroto6LALGYyk1t+zTj1MStFrPDaTdGTAFnJrL9RRd
         ln4S48VtxwADhLNAym85muotDdIjpcaJK5zuYpjNq0rNxcgQVO+HyOccZOj0298ZY/qH
         ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymXbQn4yh640Md6ALwIiwWx/ogGOI+5wQMm4YP9kOu4=;
        b=IeK29f77BorMq7kjqqIsYa1rCnk3dD2kuKg0EFFN1AJ/XTQ6Qz9OT3XJ0rDgMHuzQz
         Po9sFoyyYn9M7wvEUR/WlpNX3iba4FxxlFtZB3zmBIzu2og+cWCdNyz3tIeRMDpsYPXM
         cxiVLLiXZt3ABpV2GpEQiyBMnDo3C1i7IISARZmICaMGjElUbW8gVBYqZ4gfpVOB2CtF
         xa5GeriyfI9mSEnAybiet/HEupzz59mhNbsnj97fuZSmoVixOxFZJT+t9yAXyDKBnCAN
         5+0OvTg5Zdz5VgIHTWHYuCH8CV3xk+cr4/O3JexgEyjeYOjF2S13PZ/Q3nZUXPj5JJLi
         qCzg==
X-Gm-Message-State: AJcUukcZfsQIPcBEU1Krh5J+P/ztLbQjYdwqh2hK94qIJdvJ/cqZytI8
        FmquJIRPzl5qpdE/07hfDP2y852kfB1XQ6Mo9CU=
X-Google-Smtp-Source: ALg8bN5WJlgaCIiYvli3IBWCIDt7q0Fi5ozCsUYwacVpePPnpbdn09bZRuOVuNV8/ayz411Ne11XKoIQx4y20ydUYCo=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr4971581otl.342.1545498089169;
 Sat, 22 Dec 2018 09:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20181220161037.23756-1-jbrunet@baylibre.com> <20181220161037.23756-3-jbrunet@baylibre.com>
In-Reply-To: <20181220161037.23756-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Dec 2018 18:01:18 +0100
Message-ID: <CAFBinCBQkpLxUZYp2NQoXEA=8t_XCJMHauM+DwTz-p0FA57CrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Dec 20, 2018 at 5:11 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> While some 3.3v eMMC 4.0 are available from libretech, the default
> option for the aml-s905x-cc seems to 1.8v 5.0 modules.
nit-pick:
can you please state which module (storage size) you used for testing?
you probably still remember that we had some confusion on Odroid-C2
which eMMC module works and which doesn't, so let's be explicit here

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index daad007fac1f..d0d202cf7161 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -118,8 +118,8 @@
>         vddio_boot: regulator-vddio_boot {
>                 compatible = "regulator-fixed";
>                 regulator-name = "VDDIO_BOOT";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
is there a 3.3V -> 1.8V regulator on the eMMC module?
I'm not sure about the schematics but it seems to be that the board
itself supplies only 3.3V to the eMMC connector, so I'm not sure where
1.8V come from in this case
can you please add a comment to the .dts about this?


Regards
Martin
