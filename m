Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFCBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47863222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pflZjFWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391735AbfBMPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:22:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51734 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390506AbfBMPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:22:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so2916024wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=zCTBS95HOfXoiRWrgEvh7FtEvMXNrSB3FuomsjeF4Kg=;
        b=pflZjFWWDAz/fM+e1VlkgbPbYLDnO0ygiMMDYgv6ga46W2+QUy8S3KXuZ703g9uUhm
         3jfZ0xeqSVL9Dwl7BKPi93fpLcB3G08C+dokFOibYDnFUMW5p0MpkAcbJJxlNLSbCX/0
         9lQGMeVvmLQ5aHDCzua1uRZWLQ1XQmZNitJr/6ANUuGSwOIDIe1LRe2RAWQ77YWCftMl
         /TCDvcoiIrZBDmSw8I+N6gxz83JstFEf2S+PmGUNl/4rrovt3VIw+o5oxiqiTx0Kh9aT
         VycSaU0vpupvUIJ/ZYKZA5QUFkyCYBpksmS7WPbMIcjYWZ50ZRB89nDwAVDumo9tieTY
         +6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=zCTBS95HOfXoiRWrgEvh7FtEvMXNrSB3FuomsjeF4Kg=;
        b=NZDjzyGIbCm9pFoNYh8LUlNGplqWWOSYVhUVL8Hr/629Pen/5kpHXi4LSrnIaB2MHy
         xbY6Xq0s/267uAynHaW9HenZxTqKJN87CSXUUWssSNeus/G6ioeCwwFbhXojN4ebE4Bg
         nxDjpI+r4bHnY0kyug2eG8tv3KAS8IqEiKfSlehKLzMpFeo1GLVOFcnHyEGLBAFOBaC0
         Q7dVaAxZz5SHFN/USE+7sD6t3ejy8+hnDYv8kQnLYrK2CExesIHaa6DYOivka449uNm9
         hClFQ8CszZQNulbJwQggMp4pDLmt8QpxHfwQeVZXgmYjKNVGhHGNQdOmaNCPd5oushA6
         EwVA==
X-Gm-Message-State: AHQUAub2IxreGQSzLQB0PRMegTDLQVsPvvS5yU+Vi6QboKxzeHaIZOsi
        BL8Qj6VfSYvIVsOOYJUnNrX0tw==
X-Google-Smtp-Source: AHgI3Ia0hwslWfHZSw4X5NkH0y6KRX9SyiTgQVjvvivQf6Mr8gWhRHhp/1Q4bQf04fh3UtNFwlhDUg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr733736wmb.148.1550071337998;
        Wed, 13 Feb 2019 07:22:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:4505])
        by smtp.gmail.com with ESMTPSA id u184sm17675746wmg.45.2019.02.13.07.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:22:17 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com> <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <86mun2v27r.fsf@baylibre.com>
Date:   Wed, 13 Feb 2019 16:22:14 +0100
Message-ID: <86sgwrsogp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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
    >>> >> +Required properties (I2C):
>>> >> +- reg		: I2C slave address
>>> >> +
>>> >> +Required properties (SPI):
>>> >> +- reg		: SPI chip select address
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

Loys
>
>> Johan


-- 
-L
