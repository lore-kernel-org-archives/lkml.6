Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B90C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A67206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXQ0b5Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A67206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbeGSSRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731832AbeGSSRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:17:07 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C582086D;
        Thu, 19 Jul 2018 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532021576;
        bh=GbffjDWP2HB/Y1stXFjJ3ln6fEQMXRPv+ESx3mFpHxo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jXQ0b5CkEk+LChpwxz4GoE6duxiGTFKO21TKbeZ1aNrPgBLn5DO53lecF63lsrqTE
         kDerkHA0WgB6yKRx8XFv0egUCzXHautX5J1eI+t93h3dqqROnajxKoNOfYeITuvZr+
         PMIk/RKjPMnaEm27KbH3oh7xNys80Maq9pUsvpsg=
Received: by mail-wm0-f44.google.com with SMTP id a19-v6so7195158wmb.2;
        Thu, 19 Jul 2018 10:32:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlElo7jGgNgm3ek5QYFBp/Nqv0Ftio2ePRfvttfC1MxrZrnB6ta6
        /VREjlzDkngxDrKxXNLgvd9WP+PtkHmHYOAgatM=
X-Google-Smtp-Source: AAOMgpch/elP+ww+UvhPCvXDfTLsus67T62XyCxbYOKDa/wssItfAU0uX8bTxIVlT7DOetp2xbNGmLfGFP0cxlJSE2o=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr4930416wma.72.1532021574533;
 Thu, 19 Jul 2018 10:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 10:32:54
 -0700 (PDT)
In-Reply-To: <CAOFm3uFPGDKBjr2TKmsqZKdCLSU8YY+mprNe0ozGzkORXbHYSg@mail.gmail.com>
References: <20180718194824.3704-1-krzk@kernel.org> <20180718194824.3704-2-krzk@kernel.org>
 <CAOFm3uFPGDKBjr2TKmsqZKdCLSU8YY+mprNe0ozGzkORXbHYSg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 19 Jul 2018 19:32:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcT1r5FOo-q-ye8R1tvJfYsCkkUr8XYwEi=NFJdcptrDw@mail.gmail.com>
Message-ID: <CAJKOXPcT1r5FOo-q-ye8R1tvJfYsCkkUr8XYwEi=NFJdcptrDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: tegra: apalis-tk1: Add SPDX license (GPL-2.0 OR
 X11) identifiers
To:     Philippe Ombredanne <pombredanne@nexb.com>
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

On 19 July 2018 at 18:44, Philippe Ombredanne <pombredanne@nexb.com> wrote:
> Hi Krzysztof,
>
> On Wed, Jul 18, 2018 at 9:48 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Three files dual-licensed were missing the SPDX license identifiers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  arch/arm/boot/dts/tegra124-apalis-emc.dtsi | 38 +-----------------------------
>>  arch/arm/boot/dts/tegra124-apalis-eval.dts | 38 +-----------------------------
>>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 38 +-----------------------------
>>  3 files changed, 3 insertions(+), 111 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
>> index ca2c3a557895..cdbbb3562fb9 100644
>> --- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
>> +++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
>> @@ -1,42 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR X11
>>  /*
>>   * Copyright 2016 Toradex AG
>> - *
>> - * This file is dual-licensed: you can use it either under the terms
>> - * of the GPL or the X11 license, at your option. Note that this dual
>> - * licensing only applies to this file, and not this project as a
>> - * whole.
>
> This is weirdly enough not what is called an X11 license [1] even
> though it is named this way here... but this is an  MIT license [2]
> with a small variation. (See below)

Indeed... I checked the text just briefly and in 90% these licenses
are the same.

>> - *
>> - *  a) This file is free software; you can redistribute it and/or
>> - *     modify it under the terms of the GNU General Public License
>> - *     version 2 as published by the Free Software Foundation.
>> - *
>> - *     This file is distributed in the hope that it will be useful
>> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - *     GNU General Public License for more details.
>> - *
>> - * Or, alternatively
>> - *
>> - *  b) Permission is hereby granted, free of charge, to any person
>> - *     obtaining a copy of this software and associated documentation
>> - *     files (the "Software"), to deal in the Software without
>> - *     restriction, including without limitation the rights to use
>> - *     copy, modify, merge, publish, distribute, sublicense, and/or
>> - *     sell copies of the Software, and to permit persons to whom the
>> - *     Software is furnished to do so, subject to the following
>> - *     conditions:
>> - *
>> - *     The above copyright notice and this permission notice shall be
>> - *     included in all copies or substantial portions of the Software.
>> - *
>> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>
> The MIT standard text [2] has a few extra commas and states instead:
>
> THE SOFTWARE IS PROVIDED "AS IS",
>
> Here "AS IS" is omitted. I am not sure this is material but IMHO it
> would be good to get Toradex signoff on this.
>
>> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> - *     OTHER DEALINGS IN THE SOFTWARE.
>>   */
>
> <snip>
>
>
> With all this said, I think that your expression should be this
> instead (and this applies to other places too):
>
> SPDX-License-Identifier: GPL-2.0 OR MIT

Right, Marcel from Toradex already replied that he tries to switch to
MIT license. Since this is already MIT-like license then maybe
relicensing will not be needed and could be done fast (e.g. without
signs of all involved people).

In such case let's skip this patch.

Best regards,
Krzysztof
