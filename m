Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC8AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b="VGZD1ZLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbeGSR2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:28:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46137 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:28:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so8696744wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DKCGvDfeS2a05PRZ8U6lpVfvSbBOzQ7/mKC7tExNxcc=;
        b=VGZD1ZLBELWC+cx+judDlh6wK28Z/DHvnhU1vubYuiPxcHR7hyZJUS4Y37CLsJPpmD
         xsPAEaKHgaTP+guHifopXpjPydje8SS759TH4Sihsj16KUWCN0yVO+qoycwF5A4Ihhby
         YQ1VGM/UmgXC+gk+BEWI7MgH4Dvt8XOjL0c5bdl6Zu6IzvcIX0OlfYGYy/SQJiNg0IzT
         NlsCEOjpjDpB3mSXA6OJeqehKOYjVZqTwYDJCPtayhyHOgvxyzn35BhgxAJJOxwxdX7E
         +RqaogeKSsHCY67E8RLqfKSkk1GDVmR5bbb1pjaVelW/e/RaaOUHXSGyh5p8VUb0hBzm
         1gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DKCGvDfeS2a05PRZ8U6lpVfvSbBOzQ7/mKC7tExNxcc=;
        b=omFdZZIEvM4G3tegpFrFWynDxhPaCCcPSif9gvOSqnS/2qPijO6rO6VFLLPZScsAv8
         WsOzb/2gDK9EZCijVkAcsOWI8auWS+2y2l4LYsrXq91UTAmSzOnwUMmnUakypvkjjNDx
         tELPXmgbTWt80xy3xj4sx6HyBMjurCH8RMzC/3qH3HlAsOk0IpWtu8rX9H2zN/FnLxqs
         gz56AmRM3qvsURqe0VwWx9J819Y0HanixRXJ3fdQj6J5G1HaZELgepUB6kmGMmpipdts
         gZ6seqR+U/5/krjw5j9dasUdV/s0beh+n3gfVWfw7BUOoFkCcJXrN9kAhtjoahwDI4mm
         5Xwg==
X-Gm-Message-State: AOUpUlE5a/qoTWlsOAC2AlywNO6SQTQrM4LDiV5N4vwYkyO0kWwxn1Yx
        AOsY+hNuTU08PHT8JefUlkEOZJepbJCzDZCKqT/3lA==
X-Google-Smtp-Source: AAOMgpeAme5xBzKYDQRK2p3AKkCADaFfqqoaASWT/CuSbGDFU66Ck/hfP7gGJ+LRqDhiuzw6Uojszsiqv6QJwuyRdu8=
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr8283039wrt.37.1532018691624;
 Thu, 19 Jul 2018 09:44:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:50d1:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 09:44:11
 -0700 (PDT)
In-Reply-To: <20180718194824.3704-2-krzk@kernel.org>
References: <20180718194824.3704-1-krzk@kernel.org> <20180718194824.3704-2-krzk@kernel.org>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Thu, 19 Jul 2018 18:44:11 +0200
Message-ID: <CAOFm3uFPGDKBjr2TKmsqZKdCLSU8YY+mprNe0ozGzkORXbHYSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: tegra: apalis-tk1: Add SPDX license (GPL-2.0 OR
 X11) identifiers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 18, 2018 at 9:48 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Three files dual-licensed were missing the SPDX license identifiers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/tegra124-apalis-emc.dtsi | 38 +-----------------------------
>  arch/arm/boot/dts/tegra124-apalis-eval.dts | 38 +-----------------------------
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 38 +-----------------------------
>  3 files changed, 3 insertions(+), 111 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> index ca2c3a557895..cdbbb3562fb9 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> +++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
>  /*
>   * Copyright 2016 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.

This is weirdly enough not what is called an X11 license [1] even
though it is named this way here... but this is an  MIT license [2]
with a small variation. (See below)

> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND

The MIT standard text [2] has a few extra commas and states instead:

THE SOFTWARE IS PROVIDED "AS IS",

Here "AS IS" is omitted. I am not sure this is material but IMHO it
would be good to get Toradex signoff on this.

> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */

<snip>


With all this said, I think that your expression should be this
instead (and this applies to other places too):

SPDX-License-Identifier: GPL-2.0 OR MIT

[1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/other/X11?h=v4.18-rc5
[2]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred/MIT?h=v4.18-rc5

-- 
Cordially
Philippe Ombredanne
