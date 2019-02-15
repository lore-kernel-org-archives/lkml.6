Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D393FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F7421900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c49xcXTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394657AbfBOMKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:10:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41737 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393033AbfBOMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:10:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so7753163eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=tL2ffv1V8sAnBnW7dhYpnxhuR62iC/h7erMqMK8Fj9M=;
        b=c49xcXTpD+KdV/RUUUxEg/dnd9h3qPOI2A/tvJfHSyeLe4U/kh6fsNmYJI8ES2jH9t
         8IFMa3i3IckxYpMu1dZxuqmykwvoEN9DID0bGGrgYxUcaMiYnmjjEtlveOWiHHximSnr
         Avzw5JVguxjq0XcKsxDwKIP0WLpZEQA5liPqJFJZ/Ki3g5InymHuxJKRXvNsudF+2Vkx
         40NYxNDCwrwbw92mAeMaAfr1qUYPeYIGjW5K7Wpqor5+lGLfyGcIAuP8BtIeZCbsbooN
         7BYcTMxFvPmGsj/CwhmISu7WXvbTmgHbBhWtdR8M3ROHmu/+NUptPpZ+rVIKq9tg92YS
         1pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=tL2ffv1V8sAnBnW7dhYpnxhuR62iC/h7erMqMK8Fj9M=;
        b=HBKs89bbtR7tEi/C9JVS7qPpZ689Dm+I1/JgUd7nrHZCDydZQ3NL8NWSkZ+fs+yJ/D
         ayRewYnWNzigYx7q6sJNfrbuJU5HCdXyCghABvBNB/9gkeR9tIyDzscSCiSsYdU8LcMa
         xboo0Beqc6lVjZ9NZngoknZmywBLPJjOfFkL9nepIYlOKAKM80IEFmn8Jdp9fRiRdmKh
         PTlKIv5Pe/pouooPlxympnb47aW2CXUAGhqa3xyvR9GIsKntU16K4geuk2g8uSkqeEUH
         81OjEQkoOWcsLbKFLQTRAzgEDGdrZXWDw8hx+DDMKsJUpW7ytlM8mWlrG7fXYwF7pJOm
         A9xA==
X-Gm-Message-State: AHQUAuZzG6rd8vHLnB0RMMvX1l0LxksUj2ASSKgUkV+gwOix0a1TE5XP
        18UithzccCtjPWHprIbAIgOCUQ==
X-Google-Smtp-Source: AHgI3Ibo+UUOXahAe+emIXgt+1BXKHGn8Isgb0YeuLfpyClDYzSD8m3L/UVIj3oskProlq5otWKfww==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr7127378edj.244.1550232639501;
        Fri, 15 Feb 2019 04:10:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2b])
        by smtp.gmail.com with ESMTPSA id d31sm1475619edd.84.2019.02.15.04.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:10:38 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com> <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com> <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com> <20190214091121.GI28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        "moderated list\:ARM\/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190214091121.GI28278@localhost>
Date:   Fri, 15 Feb 2019 13:10:35 +0100
Message-ID: <86ef89fe10.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 14 Feb 2019 at 09:11, Johan Hovold <johan@kernel.org> wrote:

> On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
>> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
>> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
>
>> >> Right, but please do look around for other receivers using this chipset
>> >> so that we can make the binding generic enough to cover those as well
>> >> (e.g. by choosing representative resource names).
>> >>
>> > OK will have a look.
>> 
>> The only mt3339-based receivers I have found are:
>> - [0] Globaltop
>> - [1] Locosys / Pololu
>> They both only provide the UART interface and do not list the I2C/SPI
>> interfaces.
>> 
>> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
>> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf
>
> I found tree more:
>
Ah nice.

>  - Globaltop PA6C
>
>    - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf
>
>  - Linx RM series
>    - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf

This is a different chip: MT3337; Apparently this chip only provides an
UART interface: https://labs.mediatek.com/en/chipset/MT3337
However it looks interesting. I'll look for a sample to test it in the
future :)
>
>  - ublox IT530
>    - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf
>
> All with uart-interface only and similar pins names, although the ublox
> device do have some additional features we can worry about later.
>
> As all but the ublox device use VBACKUP for the backup supply, do you
> mind if I change the binding to use "vbackup-supply" instead of
> "v-bckp-supply" (which is a ublox-ism) when applying?

I don't mind. You can go ahead and change the binding.
For reference, the v4 patch serie:
https://lkml.kernel.org/r/1550070569-18588-1-git-send-email-lollivier@baylibre.com

Thanks,
Loys

>
> Thanks,
> Johan


-- 
-L
