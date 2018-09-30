Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38CBC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A066B20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A066B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeI3TLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:11:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38548 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeI3TLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:11:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so2586535ede.5;
        Sun, 30 Sep 2018 05:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BESZRMiZ8102oyBWuK9JcP6u7A7rJ+WF/I4h32d/LHU=;
        b=oqSgpa5jDruMUqGy3a8h3R+FMLzb5WoLCCwDF/LCxvb8ZZvEPZRwCxaoWz99PKLxDI
         Tto7EtIA4UsXuh72rBylKtR42016+FhICh8qgzMkm11GZM154iKwOBFNJNk3Wm/tDJWr
         9Tg8t/sdcIZeFIITC+ASuFTJrsiSmfkYTP/JEdeN+DRLEy14Tw6OWUPJy83bfyBWMJ9M
         6WKcJiOJwN6A3HM0Po/O5ZHVQ9gd0z063bKm8P8SofOOFPo918+VngljKFX48zE4VIzB
         ktIyNl99ZL0+9rOn1DqjhRoUyBcGroY3lLH2oW5FkuC32VFpEPmFhvBgvvosQQaM3HVc
         Lr5Q==
X-Gm-Message-State: ABuFfogHKCqajBpvbvTCfiRUMDWO5SULZlZE6idsoDz+Y4E9bZ44etL+
        +nzrpRnsL3Adp5VlJ6S/oWg=
X-Google-Smtp-Source: ACcGV61tHn2TA3ZabZVMZRymk8nFtSsGx1+LTg6l4e7K0XKt1qkzK3zoF8Ajm3R+d33XHxw6Fyx2yA==
X-Received: by 2002:a17:906:81c5:: with SMTP id e5-v6mr10423301ejx.138.1538311110794;
        Sun, 30 Sep 2018 05:38:30 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id n20-v6sm1607090eja.41.2018.09.30.05.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 05:38:30 -0700 (PDT)
Date:   Sun, 30 Sep 2018 14:38:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Message-ID: <20180930123828.GA10619@kozik-lap>
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
 <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
 <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
 <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:34:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> 
> On 09/28/2018 03:54 PM, Krzysztof Kozlowski wrote:
> > On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> >>
> >> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> >> config option) is not working properly (debug messages are not
> >> displayed after resume) on Exynos platforms because GPIOs restore
> >> code is not implemented.
> > 
> > AFAIR, it worked properly for the suspend part showing more logs.
> > Unless it changed, the feature looks still useful.
> 
> Yes, it shows few additional messages from mach/plat specific suspend
> code but it breaks the assumption that features (even debug ones)
> work correctly and make you invest time in debugging known broken
> code.

OK, let's remove it. However in such case this change leaves useless
S3C_PMDBG and other s3c_pm_* in Exynos code. They should go away along
with SAMSUNG_PM_DEBUG.

Best regards,
Krzysztof

> 
> In case it is needed/useful (which should be rather rare situation)
> one can always easily revert the commit locally.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
