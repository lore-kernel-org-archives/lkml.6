Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F703C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECF72243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECF72243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeKMGUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:20:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35902 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeKMGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:20:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id a2-v6so8492363edt.3;
        Mon, 12 Nov 2018 12:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NIY2tdVyIPsE6eduVs2bUOxdhUrf9Xkdb76WSFQKcc=;
        b=pehnmvBbiVd/1YQ9mIG0c8XP0eOH1T7Rz4xfAR8SdKX0Lx9yYpz6/wujvdyYveTtQL
         Mlz5/f7+1Re8b5z/ss9eq0nu+mRBXZ8KCb1PcM1FnlEbzQPaIIwbslspGhfqBUgIFKHV
         qiOhv3UQFwo6QCuEnNzX99qoxiXvXAFWyvKI9rB62K3vqO025uFCqJsgUgR6dPuMj46P
         yXs9HonkrK4g7sQR7TgnXQNSZe4woirZcJk7hy9rkGAIj7uR6h24JOhxlh5p/bQU7YJ4
         QgCMon63IhTpIfQY/lLpTQ8wzQSMDBq5g7EUw0LODfVu7z8f7vkYLssMGRHBnCaN7cdZ
         5DxA==
X-Gm-Message-State: AGRZ1gLqGoDN4j2jJZoV2WydUnfWsGeIwd5BkEpJrrUghiYV4pWYiWkK
        0kPGx/4DQrpN/uXa3HdDM10=
X-Google-Smtp-Source: AJdET5e2OyzMpM4ETbW1vhIPY48WS/LlA+IEG2WMTfamD+epeeCAsSu1w+wQCJBBEoNq7RA2kdb9aw==
X-Received: by 2002:a17:906:95c2:: with SMTP id n2-v6mr10013011ejy.205.1542054345819;
        Mon, 12 Nov 2018 12:25:45 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id m90-v6sm4814267ede.58.2018.11.12.12.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 12:25:44 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:25:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Message-ID: <20181112202543.GB25275@kozik-lap>
References: <CGME20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37@eucas1p2.samsung.com>
 <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
 <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPcFnkwZfCg8q429L6HRfNxubTaoa+BRZ-1h3ti3Q2EAxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:04:52PM +0200, Krzysztof Kozlowski wrote:
> On Mon, 15 Oct 2018 at 17:50, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> > config option) is not working properly (debug messages are not
> > displayed after resume) on Exynos platforms because GPIOs restore
> > code is not implemented.
> >
> > Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> > SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> > Then convert Exynos code to not require <plat/pm-common.h>
> > header (use pr_debug() directly instead of S3C_PMDBG() macro and
> > remove redundant s3c_pm_*() calls).
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > v3:
> > - don't move PM to the line below in Kconfig
> >
> > v2:
> > - convert Exynos code to not require <plat/pm-common.h> header
> >
> > Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
> > needed s3c_pm_check_*() calls".
> >
> >  arch/arm/mach-exynos/suspend.c |   14 ++++----------
> >  arch/arm/plat-samsung/Kconfig  |    1 +
> >  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> Thanks. This and the other one (removing s3c_pm_check_*()) look OK
> although it is too late for another pull so this will wait for next
> cycle.

Hi,

This does not longer apply. Probably because of my changes around eint
wakeup mask. Could you rebase?

Best regards,
Krzysztof

