Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2378C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3E820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3E820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbeGXUsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:48:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39992 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeGXUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:48:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so5117459edq.7;
        Tue, 24 Jul 2018 12:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHngNoi8yEPOv0UGjgZ/YhQVzPnxjxmur2IWna5A8/0=;
        b=I1CgY1OeYNupQX3AX1E9icLeMEYNP3Sdl3u7+hugCT3dYmgJxyjfxfcEFDaEqhhGBD
         2yL9feVIU2b/6W7GcLdAu0AKy1S+GBnTqyUjR8C0KQu2NAWg4ms1ib4FWhysciPa24bn
         4jWKI/Z8nG4FGSmVxPY1KK7TYkplAvq/AfPN9obcm0uT2/WyLtrkAtEVl91406KzuP62
         5L9AB1GqLvQc3GDpDgu65Jf9SDChUryHH8Cfl4OBiPFM9ZiyFQ1YT+q2hzbf/FEg/vzc
         mvC0xJoP5jzAhQe/s0hbrT/0O6eHrows81b6PCAIW23ldjj+GECCp5khiASw44d07ibA
         gZtQ==
X-Gm-Message-State: AOUpUlG/bf9Fu+K46ev8z4SyP2MAOi73r+rTyg2n+UM58Qc3TjcJurJh
        swaZbS9a9sB+Ori9ewTGBAI=
X-Google-Smtp-Source: AAOMgpcaRqvYsn9HtFQ3FNBve5W0/nPI/GOorecMBHqGQZLqKHq8cedNqC/Lr6sSuy8arMiAMUvNhw==
X-Received: by 2002:aa7:c40a:: with SMTP id j10-v6mr20260549edq.134.1532461253703;
        Tue, 24 Jul 2018 12:40:53 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id r5-v6sm5209722edo.75.2018.07.24.12.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:40:52 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:40:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [RFT v2 00/10] pinctrl: samsung: Remove ugly hack for sharing
 eint_wakeup_mask
Message-ID: <20180724194049.fpp5hi7hfy5w5mjj@kozik-lap>
References: <CGME20180723175334epcas5p3e46820b4d356d4f1ea718ec1a6c093a6@epcas5p3.samsung.com>
 <20180723175302.22535-1-krzk@kernel.org>
 <20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l@eucas1p2.samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:18:13AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-07-23 19:52, Krzysztof Kozlowski wrote:
> > Hi All,
> >
> > Changes since v1
> > ================
> > 1. Add Tomasz's ack.
> > 2. Reword description in patch 6/10.
> >
> >
> > Tests
> > =====
> > This is both request for comments and requests for tests. Only basic
> > tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
> > with max7768 RTC wakeup. Please kindly test it with devices capable of
> > suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
> > Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
> > broken however changing external interrupt wakeup mask was not done
> > on Exynos5433.
> 
> Works fine on Exynos5433 TM2 with some additional patches related to
> suspend/resume handling of the PMU. It handles only EINT0..EINT31 pins
> for now. Exynos5433 has more external interrupt wakeup lines: EINT32-63
> located at banks GPF1[0..7], GPF2[0..3], GPF3[0..3], GPF4[0..7] and
> GPF5[0..7]. They can be configured as wakeup sources in
> EXYNOS5433_EINT_WAKEUP_MASK1 (0x062C) PMU register. Handling of them
> can be added later when it will be really needed.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for comments and testing. Indeed support for Exynos5433 has to be
improved.

I would like to push 1-6 (which are needed for the rest) through current
cycle so I applied them to samsung-pinctrl tree.

Since anyway suspend to RAM is mostly broken nowadays... nothing more
should pop up.


Best regards,
Krzysztof

