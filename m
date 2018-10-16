Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629ECC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BBA208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBsCNG8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BBA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJPU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPU53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:57:29 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF142145D;
        Tue, 16 Oct 2018 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539695225;
        bh=scN6/EPRlFKv4sLdDNQsmjtVWMzLwhQr9ubP+0B2JI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YBsCNG8hwU5EN4UE5XL2v+eUQ3s+UmUdGPZDUcOeS/P/aAXZjQjnYLnkcaHDGuzl/
         i4Ly5zkc8M4cRXyahbkmLA1HV3F7FbtxXHPcKNKnB5WDR2VeycreB9P6GLVPQvX8C2
         dqQ5+nD3TflbclPSLJEY+Ekawi/QZQHO1M9x5fKU=
Received: by mail-wr1-f49.google.com with SMTP id y16so25451347wrw.3;
        Tue, 16 Oct 2018 06:07:04 -0700 (PDT)
X-Gm-Message-State: ABuFfojP5/uOPjUSCYQtF6trGbyzy083wwqNJpKYUSjgjh4gAM69LgEC
        LJwUpABG9cBlsE5FVAZUzGB/r2wQU5LRbmWA8MY=
X-Google-Smtp-Source: ACcGV61Igj015ki4JqOig05d3k2V86Kbe4M9GolX4MF8VNF8WCGEow+ka8hHXOzcvvXRbGk+yo6F/LCl/1D1UB8qFJc=
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr19802116wrq.189.1539695223198;
 Tue, 16 Oct 2018 06:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51@eucas1p1.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com> <20181015123112.9379-7-m.szyprowski@samsung.com>
In-Reply-To: <20181015123112.9379-7-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 15:06:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfEUVFYCpWiNVWWLydM6pisTEvDPk1OJnY2CC7z7Zt_Cg@mail.gmail.com>
Message-ID: <CAJKOXPfEUVFYCpWiNVWWLydM6pisTEvDPk1OJnY2CC7z7Zt_Cg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: platform: Add enable Exynos Multi-Core
 Timer driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On Exynos SoCs enabling MCT driver is required even if ARM Architected
> Timer driver is used to for managing timer hardware and clock source
> events.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)

Looks okay, I'll take it after this merge window.

In case this was applied directly to arm-soc:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
