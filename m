Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOlXIkkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D6A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIESK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIESK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:10:29 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD842075C;
        Wed,  5 Sep 2018 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536154811;
        bh=6D84v5A8dxPl3LZhy6vmVLz/hJHhVaWVCikCnWxHsTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gOlXIkkZIJ9Qf8vBFc4dv/2OLhS6+5Lbtl6DvEwXe0mSv4f2o196HMUZ5zpDqx0he
         vyLKI9tIJQ53e6ROwU4MP+7Pd3+tMCaohNe5ftrRsDlzEudIRCv9rDnHzTkMkeeW8G
         eF02pj5iZJIgVGOUco8XFlTjHvj6JHeDSbY5lA5A=
Received: by mail-wm0-f48.google.com with SMTP id t25-v6so7764728wmi.3;
        Wed, 05 Sep 2018 06:40:11 -0700 (PDT)
X-Gm-Message-State: APzg51CaAx+CW5VHoQmTCU4S8dYvBtfAwjQwHPqYECH4pauE6XS9RVO2
        RiOtuzgZMiy7F1llSKc/oVmXnN62imhPVpMyS+Y=
X-Google-Smtp-Source: ANB0Vdaw0q1cfJXO5vResh/q0XEEEM6uWKgU/5JCTZzS6AA8sp/tbp3yui5yVCYivQ3d5hv7o8/SyA6e5qmLokaINXk=
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr293475wma.72.1536154809987;
 Wed, 05 Sep 2018 06:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180905115422eucas1p2150fd04724ec667bd8798023a73f1127@eucas1p2.samsung.com>
 <20180905115407.10595-1-m.szyprowski@samsung.com>
In-Reply-To: <20180905115407.10595-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Sep 2018 15:39:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeKsJDHJbiUnKyaXtjZgPtLxsS3BtncMSN6BxWD09uvHQ@mail.gmail.com>
Message-ID: <CAJKOXPeKsJDHJbiUnKyaXtjZgPtLxsS3BtncMSN6BxWD09uvHQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: max8997: Enale irq-wakeup unconditionally
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, myungjoo.ham@samsung.com,
        lee.jones@linaro.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 at 13:54, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> IRQ wake up support for MAX8997 driver was initially configured by
> respective property in pdata. However, after the driver conversion to
> device-tree, setting it was left as 'todo'. Nowadays most of other PMIC MFD
> drivers initialized from device-tree assume that they can be an irq wakeup
> source, so enable it also for MAX8997. This fixes support for wakeup from
> MAX8997 RTC alarm.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> changelog:
> v2:
> - removed pdata->wakeup entry as suggested by Krzysztof Kozlowski
> ---
>  drivers/mfd/max8997.c       | 8 +-------
>  include/linux/mfd/max8997.h | 1 -
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
