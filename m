Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9A4223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToCURU0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9A4223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHJMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:40:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55602 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeHJMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:40:05 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so1890772itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1XSGgD2g/h71miz+mtYUCYJBOw3XFpuXRf52kOZ7vM=;
        b=ToCURU0avAFZujog3YX3NS/5wlPF8Z1A2ThdeaQlWxcG1XMBjXRcFXOVJK9l9pUqAJ
         aQRff1wmlIpB5BvZZScELO73kORlzn+XIkjlHeR3JA8Xe8/oRSdDxEazJ+LXuD5EVaZu
         igNnVvXJH6E7fTklmT2WxQ9REBTt3DvZlQprA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1XSGgD2g/h71miz+mtYUCYJBOw3XFpuXRf52kOZ7vM=;
        b=OJtshn/YMAtgmuHIwU3Sng5to7uLB96wnwk84H68s4PvLXx+Nv8MEtoJg5xyjaEpYc
         yYyEaVC8f4I6gQ3kXqEcXfIjS3/Qa0p8mtRY6i8l2O/3AAVzC2iSTQgGN6V2tCkFwTXO
         TXMMstfXot67zB9EQZToyLyg5J5tfGs+e4eaNbbJgLXSoojZXNcen5Hq4lvcF6ZymDYU
         sexY/muyIVoZ0Qw1N5H5bMSOzWnz2jniedWJNEpR4mmlTLSFU9M9difBrS+aEEUeoDGq
         eOSgEW89tiF+wnuF5VyrV52628mQZRtryQB9KcomQuv/BsONPQPTcJytuouJekbsJzlt
         M3SQ==
X-Gm-Message-State: AOUpUlHcAfagySi3X2Yskv+X4DZluwFrQVBYokNIrGTKramBIRxJiAoZ
        dt06CHyvmuPjocR7t6dEGBAfG16fDffcHoDW4Nu4vQ==
X-Google-Smtp-Source: AA+uWPwKsc+VVvT1ZtveGYEMArDQXZ+ddcOFrCDKJk/NAoNxJyDzmQjDkk+EsYFQROGWzoqnAPf2Sd3E3NWDX6V4u1Q=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr1558725itb.38.1533895853368;
 Fri, 10 Aug 2018 03:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-4-jmkrzyszt@gmail.com>
In-Reply-To: <20180806222918.12644-4-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 12:10:41 +0200
Message-ID: <CACRpkdaeVRy9XDptCZcTHLo7gs55uQx=6A9HnoQgRP-qnBCqUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup
 table for NAND data port
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
> device, already under control of gpio-omap driver.  The NAND driver
> gets access to the port by ioremapping it and performs read/write
> operations.  That is done without any proteciton from other users
> legally manipulating the port pins over GPIO API.
>
> The plan is to convert the driver to access the port over GPIO consumer
> API.  Before that is implemented, the driver can already obtain
> exclusive access to the port by requesting an array of its GPIO
> descriptors.
>
> Add respective entries to the NAND GPIO lookup table.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
