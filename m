Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B70C222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yqJpqGvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfBKORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:17:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45591 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBKORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:17:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so4849383wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=puv3gC+Nk3BQy/pOka+RnqNUGH1wGRY9YNG6l/8aQic=;
        b=yqJpqGvSf5YixOGoEcFDrKq5ChskDq62jsL5L3y5M7thAP0oQTeMKOpDimNZuBVE9E
         +QMfyTbR0AhLVdlPtWQyYEJWjcZjbaB+K6C/SbGWg8vyGUMHHuvHVVyjz2g51gLEuTUe
         Pl+Y+t1MIh/zK6U4Bq9tiDqPy4ltj07oAUNZX82Y0HXHCZy88to3r+N1M4C0tYAg+Nav
         lYWfkD7TFIfWN3akMIYJcbnvFGPuZG/9Tyty2+JDqYfixssDX9OUl+8nmvkugWIiO3wb
         r2uYYRZ8Smuv/6oCYEqY60HUPvsVfyHr9iiloT/Cry8s6du1lfpU4pN+zGAg0EzcaxuQ
         gA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=puv3gC+Nk3BQy/pOka+RnqNUGH1wGRY9YNG6l/8aQic=;
        b=ApEgNmqmsKor3v7muTACFQNyOjUitiLlRVxJfTbRk/uxDxKcb2ox1WPCxlM4y11mdk
         m0j0fB/pHtWtFtg9DgmRqFDWGOBOLxPevDqoJXIXUhJ0utEitjqgweoqWkvZVL8f/MxF
         0TmiXNfOH3BH8xkdbnaNlz44VghIhiBJONpX0eTMlD9iXdcnlLXrDY9tFswa3d/uiX16
         C+yNNVSWwAdIBl+68yaXjvFbmp26e2w4UQyQ7LuZzWmrkyZ50URrEF9udpBefWXBbxpj
         P4w9NKvfMKHs60cBYFXI9V2KH1hr9HV85PzCSMSEfxHa6hRANUc86mDIlKSr9l4DdrkJ
         Ys4w==
X-Gm-Message-State: AHQUAuaWLwm4VBocsBRANMu3jzfSpGBU/xOtz8KzkSDE4GJW8g9RVPi4
        px60CcUFdOeMQs8Vidvv8oyeiQ==
X-Google-Smtp-Source: AHgI3Ib/CPu+ZVEuPdcvWu+xqlLLULGHwy4ZWV9srPnleOSXHl+Ub8ku+HZuh37LDIVAyXxqsOxi4A==
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr7013674wrf.83.1549894667289;
        Mon, 11 Feb 2019 06:17:47 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:7e84])
        by smtp.gmail.com with ESMTPSA id t199sm55863947wmt.1.2019.02.11.06.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:17:46 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com> <20190211083349.GU4686@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190211083349.GU4686@localhost>
Date:   Mon, 11 Feb 2019 15:17:44 +0100
Message-ID: <86mun2v27r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:

> On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
>> 
>> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
>> 
>> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
>> >> Add binding for Mediatek-based GNSS receivers.
>> >> 
>> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> >> ---
>> >> 
>> >> v2:
>> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> >> Moved current-speed as an optional propertie.
>> >> Removed the status line in the example.
>> >> Added "mediatek,mt3339" compatible.
>
>> >> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> >> @@ -0,0 +1,39 @@
>> >> +Mediatek-based GNSS Receiver DT binding
>> >> +
>> >> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>> >> +vendors and can use UART, SPI or I2C interfaces.
>> >> +
>> >> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> >> +properties.
>> >> +
>> >> +Required properties:
>> >> +
>> >> +- compatible	: Must be one of
>> >> +
>> >> +			"globaltop,pa6h"
>> >> +			"mediatek,mt3339"
>> >
>> > I'm not sure it makes sense to add the GPS chip itself as it cannot be
>> > used stand-alone AFAIU, and either not way would require a lot more
>> > resources to be defined than what you add to this binding.
>> 
>> OK, I find it a bit confusing to have Mediatek bindings but no
>> compatible Mediatek SoCs.
>> But it is true that it can't be used stand-alone. I will remove this
>> reference and also remove it from the mtk.c driver code from this patch
>> serie.
>
>> >> +Required properties (I2C):
>> >> +- reg		: I2C slave address
>> >> +
>> >> +Required properties (SPI):
>> >> +- reg		: SPI chip select address
>> >
>> > While the mt3339 appears to support these interfaces, the globaltop one
>> > does not.
>> >
>> > Have you looked around for a small sample of mt3339-based receivers, to
>> > see whether anyone actually provides these?
>> 
>> Again I'm confused by the fact that it is the Mediatek bindings.
>> Hence why I have added it and why it was not present in the v1 that was
>> only for Globaltop.
>
> This is no different from the sirfstar driver for receivers based on
> those chipsets but manufactured by various other vendors.
>
Indeed.

>> I find it odd mentionning the chipset but not all its interfaces.
>> I will remove these sections and only list supported interfaces (i.e.
>> UART). Other interfaces can be added afterward if one finds a board that
>> provides them.
>
> Right, but please do look around for other receivers using this chipset
> so that we can make the binding generic enough to cover those as well
> (e.g. by choosing representative resource names).
>
OK will have a look.

> Johan


-- 
-L
