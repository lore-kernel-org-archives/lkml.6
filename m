Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3163B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kLei3CGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391840AbfBMPYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:24:14 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42217 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfBMPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:24:14 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so890174uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iepFje/MEMhk/3E4cnIjUK1NAURKmM59l2Ai+HFgl3Q=;
        b=kLei3CGVOLhHwdFp1cFntXYHYuZ7JDpvOc97rUFvIW4okfi7bSlE+J1u5TNs0A99Vq
         fJApk6VcQdqiToVxuzeZEunO5jlSdcikTUEc/aixA4IUjtSB0tb7HQMT47wHtJ+u582g
         iFeJctncDS2ZpIdUgwxsJqZ61pye1jL6q3cnBTAqFs8p4zuaWj3GiVmW+PWz6oActyCQ
         S/2dOc7XrKh7cZ78Q3V/BEtLluvmJLJouta4AkRhEpH5R+dcJwBRSWUmCqzAMewVzCFC
         OIsgFXBtW+ANZVs0p4n7n9Mwi1FhUbbbD5ySEaUTMQ8mPu6z5sMFp2/bAPI+pdOfesgx
         2I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iepFje/MEMhk/3E4cnIjUK1NAURKmM59l2Ai+HFgl3Q=;
        b=j+9IAcNc9GsAdo5LftlbKm/BEoaaDbZbxvXCwHL2dyoWW2lEhoFDrFocfuob9rAL3H
         IzrDwdMwiffaYCb0jZFvE2UvYuEyakPCBf6LfclcJ18IXg1O6om3lBT6FVNvkktiAqOB
         l5ZABzW++x5ZdkWEjJxcqrhAg1G5hIdBNM4bfCnnaE/wDjJ9qavKDggsGI+ht08vRlkt
         z65sARlojkHLD1Gpe7WjihmCHUgVUrXRIpGqSZ433aE9dw0deK/8AZUUEmCV5tLP64pq
         khf2lN3NoTmXtqOH0L3vsVCeaFbD77QVmz3XY1OFiLjuN0uboBWbUSdwIa+RMOuCv7eg
         WnSQ==
X-Gm-Message-State: AHQUAuYt7jodw8wuwl4LGIdpCb9ZxS2Q+F3TA4a4DMvgBfwps5sdAya8
        o0Lp5d+6vHnI7A1MGPMMwzRzYWIBaMmixftNicH0Lg==
X-Google-Smtp-Source: AHgI3IaFe/NYA9tBN4Y21pnU9ZVr/OXvkJenpt1XaNeKjFdFt2/TxkkTnQrYZqdO2ACGL7o+i01j2wOp/oNYdeVv8g0=
X-Received: by 2002:ab0:2b93:: with SMTP id q19mr388945uar.130.1550071451959;
 Wed, 13 Feb 2019 07:24:11 -0800 (PST)
MIME-Version: 1.0
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
In-Reply-To: <86mun2v27r.fsf@baylibre.com>
From:   Loys Ollivier <lollivier@baylibre.com>
Date:   Wed, 13 Feb 2019 16:24:00 +0100
Message-ID: <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:

> On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
>
>> On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
>>>
>>> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
>>>
>>> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
>>> >> Add binding for Mediatek-based GNSS receivers.
>>> >>
>>> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>>> >> ---
>>> >>
>>> >> v2:
>>> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>>> >> Moved current-speed as an optional propertie.
>>> >> Removed the status line in the example.
>>> >> Added "mediatek,mt3339" compatible.
>>
>>> >> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>>> >> @@ -0,0 +1,39 @@
>>> >> +Mediatek-based GNSS Receiver DT binding
>>> >> +
>>> >> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>>> >> +vendors and can use UART, SPI or I2C interfaces.
>>> >> +
>>> >> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>>> >> +properties.
>>> >> +
>>> >> +Required properties:
>>> >> +
>>> >> +- compatible    : Must be one of
>>> >> +
>>> >> +                        "globaltop,pa6h"
>>> >> +                        "mediatek,mt3339"
>>> >
>>> > I'm not sure it makes sense to add the GPS chip itself as it cannot be
>>> > used stand-alone AFAIU, and either not way would require a lot more
>>> > resources to be defined than what you add to this binding.
>>>
>>> OK, I find it a bit confusing to have Mediatek bindings but no
>>> compatible Mediatek SoCs.
>>> But it is true that it can't be used stand-alone. I will remove this
>>> reference and also remove it from the mtk.c driver code from this patch
>>> serie.
>>
>>> >> +Required properties (I2C):
>>> >> +- reg           : I2C slave address
>>> >> +
>>> >> +Required properties (SPI):
>>> >> +- reg           : SPI chip select address
>>> >
>>> > While the mt3339 appears to support these interfaces, the globaltop one
>>> > does not.
>>> >
>>> > Have you looked around for a small sample of mt3339-based receivers, to
>>> > see whether anyone actually provides these?
>>>
>>> Again I'm confused by the fact that it is the Mediatek bindings.
>>> Hence why I have added it and why it was not present in the v1 that was
>>> only for Globaltop.
>>
>> This is no different from the sirfstar driver for receivers based on
>> those chipsets but manufactured by various other vendors.
>>
> Indeed.
>
>>> I find it odd mentionning the chipset but not all its interfaces.
>>> I will remove these sections and only list supported interfaces (i.e.
>>> UART). Other interfaces can be added afterward if one finds a board that
>>> provides them.
>>
>> Right, but please do look around for other receivers using this chipset
>> so that we can make the binding generic enough to cover those as well
>> (e.g. by choosing representative resource names).
>>
> OK will have a look.

The only mt3339-based receivers I have found are:
- [0] Globaltop
- [1] Locosys / Pololu
They both only provide the UART interface and do not list the I2C/SPI
interfaces.

[0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
[1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf

>
>> Johan



--
-L
