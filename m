Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DF921741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeLTQFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:05:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36543 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeLTQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:05:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so2365336qtn.3;
        Thu, 20 Dec 2018 08:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hno3ZhCttvnOQ3UmgTypd/WYPZP6DDabEhv9cR0+BWk=;
        b=CbbaUnU1KkYXYgOC5HLW+zqkosWSnIlXj57AiVQjJG6zW55w07jtrlz7BJBBe1Upku
         RWayUxnWPDy1CFR15Fx5dzojXGmSO6rfmUGvscdxcChbPeYN/gQo1NqTPzBWbBKo09ZL
         mL5jmz1eVF/LOjI1JLgSvaLsYfwbXncPeak9mVSt6XoGrp1KGDWpXbvC3Kj5F1S3tNTR
         BtPpKIqHW59o/Tb81QbqPP2ypU3DazXyafWfwfC76mTFK7UCVBGYOeFPPugian7WBEkp
         myVnMHGRDhyVmWAXHBhmKBcvJbaHHy+clr4LDfeODDcc1bG8VttMfxRedWBSn86Gwpej
         cZgw==
X-Gm-Message-State: AA+aEWb2s7RfhZlQtY2ke68FBL0EhBfvDOWy2PIr8YeDl2KEbUg786zV
        vx165l/WmKAjBR4dL9lQ76gSiRepaiiMrsBrcJg=
X-Google-Smtp-Source: AFSGD/Ve52DpeKFXrBrhrFFaF1A0MvGMdUmQI290o1b/ObRZQZyAi/VlqGOWM1h6Ksriju699yDG2WIEcPdCH06VjS0=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr26498068qte.212.1545321946894;
 Thu, 20 Dec 2018 08:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20181218201003.12806-1-krzk@kernel.org>
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Dec 2018 17:05:30 +0100
Message-ID: <CAK8P3a1DAGStWYN7_BS6t7ud9_at4nJLWjPtoyDphYXKAjnKXg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 9:10 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
>
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2
>
> for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:
>
>   ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21, part 2
>
> 1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
>    round of fixups).
> 2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

Pulled into next/dt, thanks!

       Arnd
