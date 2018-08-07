Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5700921527
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV6ZEvzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5700921527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbeHGToR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:44:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41066 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeHGToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:44:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so12211000lfe.8;
        Tue, 07 Aug 2018 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQ+TL2Ch38Nf7XtlVYEKkAG6/IiKQiL1mHgYtceo7c4=;
        b=LV6ZEvzH1YMU+h/VJBUFOxIjQwpDJ4WpjAyHioq0ZL7jk1Jpz6xXHRgbu1sN6BtI3L
         Fm7Pk6Vq9MoNz+FWTMcqfh+ndPjlTNAIRlHvRTdELZtwtEZ6lvKCCfcQvOAwNgG2yC5E
         rSeNVH+Jn7yb3V6LIBWXzpXAuedBr4SCErVOSEXxcp87aQl8Ev3hMlQ9KBiv1eD8850M
         wFAcynmpZBD2BQwGP8/CS2gLnaZbbWpEGPZx3nZB279aN+Ma68GWALwzLlYkmmnsjKhj
         P61cZCQRzXAxFR8ke8wUAXYLWgzP+RT3hc7/OJTaqyJK8x/jEUerSCwwBFuyl8PT1s6o
         PbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQ+TL2Ch38Nf7XtlVYEKkAG6/IiKQiL1mHgYtceo7c4=;
        b=BCP1i3D74nypzpoIaniMpys5D0OEslWO43j2ewXlSlU3io9SPVcCp41yngPNCe1nNH
         Z7OwYBjw2Dcm+FGXvvL/uBeYm4GhWFAutvrORgXGdafnTrXbAtzJ5vWIegdVxOzq7cx7
         FsEduMC8y9oV7n0m2Pe4Whby8/GH7me3cs9KOKSkSppJwnP6QIm3EFZVh4NBF9a15Db5
         6phSdIy2fqqB7FqwqMM/k7IxReOD6n9btBh1LjJWrzXODIOe8vtpV/2l/Dhi1PU5JgHd
         LyIZ8y1RMgAIq59Qx99XrPiBTtE7qfmR7g+L8ewZjRajlqDTvkE893pq5wDE/X0Kzjpn
         hc8g==
X-Gm-Message-State: AOUpUlHvW46KI5Pkks/Hk0gpy8cZfLCpy0y3ZHWrWwkfrHfFNHDUEmDW
        u72kjpJ3s1FuOELu1vlp/NQ=
X-Google-Smtp-Source: AAOMgpdlmY/b4tPeOh2/meNrkmmczHF6PJIv2XiV9/u0PRxWhWVwC9mu+cqvu/gFhNlOFDoq0uTe8w==
X-Received: by 2002:a19:26d2:: with SMTP id m201-v6mr14305454lfm.43.1533662934002;
        Tue, 07 Aug 2018 10:28:54 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id x23-v6sm326484ljj.86.2018.08.07.10.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:28:53 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
Date:   Tue, 07 Aug 2018 19:29:53 +0200
Message-ID: <11711552.OvaP4pOjBH@z50>
In-Reply-To: <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-13-jmkrzyszt@gmail.com> <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 7, 2018 1:43:56 AM CEST Linus Walleij wrote:
> On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
> 
> Hi Janusz!
> 
> > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > information on a single GPIO chip driving array member pins in hardware
> > order.  In such cases, bitmaps of values can be passed directly to the
> > chip callback functions without wasting time on iterations.
> >
> > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> I think it would be disappointing to leave all the users of the old
> array API without the performance improvement. I think we need to
> deal with this in a way such that everyone can benefit from it.

There are a few issues to be resolved:

1) array size limited by bitmap size:
    - are we ready to limit array size to a single bitmap for all users?
    - if not, how can we pass a bitmap of an arbitrary size?
    - if as an array of bitmaps, is that still clear enough and easy to use?
    - other ideas?

2) arbitrary array support:
     - are we ready to drop that?
     - if not, do we agree to require all users to pack their arbitrary arrays 
        inside the gpio_descs structure?

Maybe more.

> Also it is kludgy if users (consumers) would need to handle the case
> where all lines are on the same chip separately, through the bitmap
> API.

Not true as long as array size fits (arbitrary arrays can be packed by users), 
but I see your point.

> What we need is an API that:
> 
> - All drivers handling arrays can use (including current users).
> 
> - Enables speed-up if the lines are all on the same chip/register.
> 
> - Doesn't require consumers to know if they are all on the same
>   chip or not.
> 
> This means a deep API with a small surface.
> 
> How do we achieve this the best way?

I think widely accepted solutions to those two issues I've mentioned above can 
give the answer.

Thanks,
Janusz


