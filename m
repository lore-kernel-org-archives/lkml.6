Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19EB218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0dWIfn3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbfAKSvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:51:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33670 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbfAKSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:51:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so7160186plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pitR8L9WmDjBuoydS++yrSyyfQoqz7HyAqmD7cthpYg=;
        b=0dWIfn3CjL8f3ooGjVaCGCDJ+E/gb8q1ofg/8qdVJKhwf8mLPtIKsn2wGgPtnXaKG9
         tA8XuV0wnp9rQ2UGojIGsK70/wZ5JXOrlX51bwFOF5RC+EoLPCJ79yK3pWStXfvxtCYQ
         bxbEMh97oY6sWMH/xZ0/ykXzyLg5vs7F0WKNUBKCodE8YI4A82rntfjkSgWmm2LCOrhB
         7ahAwskWSE226zgL2Sf6O6sr3glfJth7lHY2wuBYiLKjOyZMMRACniWBPpgnJK7b7qOc
         2mRNqxlBwOwp7qyEq1djyQs/dHeBzW9jKUW3VJMb4kkRrp8JIePQJd8PyeB/XlJHKv/I
         JRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pitR8L9WmDjBuoydS++yrSyyfQoqz7HyAqmD7cthpYg=;
        b=s2c8eBW8v1wz9UHddt9vQJgKPhSMfNAeICf3OH5uGLU+huGYMk2M5K0TnsMkbmHYK1
         n+bRHX3J44nTp2jvkmv+29Tw8SOPL6XsRYbsjuwhhp/S2Dh6SfNxDwYBwvMFrcIHAeRt
         aNjDsy6wx95+wp6r4POBJvZqtMoXnMCd9kqHJ9nkAvooAuZZRLPr9IXhPX6bfncxfoDz
         XEHhJ6WP76knNHpr7Vy+c4P6qgEJ7RCOACsKOP7mLtRE6usRCmSd/hkgPx1vZiWhEgKq
         1Qy/5EXK+KJ4pMN21ugdpb7lM78XMFhor8MUnEfo0VJdM5+6G1xTc+r3S5addKFoN+Fe
         yrMw==
X-Gm-Message-State: AJcUukeGxsAmkR2KFxPgDx1iGSs8EuiZFdSH62GLEth9+e1UwEQiJFuv
        sgP/TDewO/rqqsZd5ettmssZbQ==
X-Google-Smtp-Source: ALg8bN61o21eFQRa/93epFy74wP25uFR1S+FUjQQ/w81s8mnjpvgL+E9yh2cFDpF6OuC8FkmIEO2TQ==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr16054674pld.18.1547232670911;
        Fri, 11 Jan 2019 10:51:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id u70sm135770245pfa.176.2019.01.11.10.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 10:51:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator warning
In-Reply-To: <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
References: <20190111092235.28161-1-linux.amoon@gmail.com> <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com> <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
Date:   Fri, 11 Jan 2019 10:51:09 -0800
Message-ID: <7h1s5jowo2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Moon <linux.amoon@gmail.com> writes:

> Hi Neil,
>
> On Fri, 11 Jan 2019 at 19:10, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Anand,
>>
>> On 11/01/2019 10:22, Anand Moon wrote:
>> > Add missing vin-supply 5V regulator node on usb_phy nodes needed
>> > to power usb bus ports. Override the dr_mode from "host" to "peripheral"
>> > for initialization of dwc2 usb0 phy node,changes fix the below
>> > warning for usb initialization.
>>
>> I would have switch the dr_mode to peripheral in another patch,
>> fix the regulator issue in this patch only.
>>
>> Neil
>>
> [snip]
>
> Ok will split this into two patches and send after next dts updates.
>

When you split, please be specific about which part fixes which
problem.  e.g. it appears the dr_mode fixes the WARNING from the
regulator core by itself, and the vin-supply fixes the usb resets,
correct?  It wasn't obvious upon reading the changelog.

In either case, feel free to add:

Tested-by: Kevin Hilman <khilman@baylibre.com>

I tested on meson-gxbb-odroidc2 and it looks good.

Thanks for fixing this,

Kevin

