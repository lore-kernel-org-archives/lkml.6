Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3882C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0F21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549613718;
	bh=XOLF9xV4M15uvNkhw+DCkMazl2OsiS1cGhHcsyThPrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KbIxylUgntJit9niqUN/Nw1bjqHc0wOCKLWGoK/SC5i9Hh2b8+iF8aWrllHStYINs
	 ALH9d6f18RoIE19n0TEjmk3QPGLhDcgzi1XGIyNEHJFLR9+unRSaxV0vR7jC0ZQp2n
	 22I8y0aqiikgLTBykpYBAtpEOICehPUOitaM81TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBHIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfBHIPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:15:16 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1185721925;
        Fri,  8 Feb 2019 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549613715;
        bh=XOLF9xV4M15uvNkhw+DCkMazl2OsiS1cGhHcsyThPrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MCYYlb8wLlhpT2rCX3kishdPZ1r3mTUFGGRFR+1H8I9qr00jaFrqJhXQU3OYEZ6eH
         xh7e1PhontCEFstc1Pc9NZD+GxSgFJ3NDkqV6dK35l8Aa9WNEiFV7HFVbNtVQhzky9
         +eRntSCzN8aVDmw/jwZk4nM7Jx2b6+d5N7sNRlcc=
Received: by mail-lf1-f50.google.com with SMTP id j15so1892187lfh.5;
        Fri, 08 Feb 2019 00:15:14 -0800 (PST)
X-Gm-Message-State: AHQUAuYfvu8Sc615MAEwDqtZDQWhZCk0BaZya8yjJrahYBDWiFvQ9cdu
        rxHKi1JfDQXwFlh+qLAb5n4yEPsRBGirJv/IMmk=
X-Google-Smtp-Source: AHgI3IaJVJsD3NixG45D0R51aHwHYz6l70pi+46b6gTAPlFDhPB6+YCoF03aHzaiKhcvyfsYPC80xFbLY7tEkdXL1SI=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr12221134lfe.137.1549613713228;
 Fri, 08 Feb 2019 00:15:13 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164723eucas1p1ec009489584e1c85fd0d62270796e003@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 8 Feb 2019 09:15:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf5_0eXt45eRmiXCvVhmKTOFwTFpJ4SkP=yG=5_qc8sMw@mail.gmail.com>
Message-ID: <CAJKOXPf5_0eXt45eRmiXCvVhmKTOFwTFpJ4SkP=yG=5_qc8sMw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] ARM: exynos_defconfig: enable DMC driver
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Enable driver for Dynamic Memory Controller dynamic frequency and
> voltage scaling in Exynos5422 SoCs.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Looks good for me. I will take it after driver gets accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

Best regards,
Krzysztof
