Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8401ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFF021486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7yLrrcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFF021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJSPtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:49:15 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB6921486;
        Fri, 19 Oct 2018 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539935061;
        bh=w2gbaeIrTpJOSDqP9WL1y5UOtZLjVo/qbVWPRExqf0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c7yLrrcVLYTUp0HXCFR7ZWDDWGWOBPrTLjtd/PnUMWvdcM41t4nWOmjMlk9mohRJG
         9WZ7V9mp4UZPFrehFfjVSxa7a1jrAxNDGFtA23j3bEyWuagHN1tbljHbJc472HbDKR
         fths4lweD3mZudnGoaPpndoRTOT+v/CQw7FQP2VE=
Received: by mail-lj1-f172.google.com with SMTP id u21-v6so29984136lja.8;
        Fri, 19 Oct 2018 00:44:20 -0700 (PDT)
X-Gm-Message-State: ABuFfogs48pLN8ONMXJiKMQbe53PY+1n4Q3vjuMHg7MSOzVgSerWaATA
        eMymQ23q6kXiYgdS7BFOkrGgACVjbR/8Pr4ZzBY=
X-Google-Smtp-Source: ACcGV63bH2rlLhJRgk8GXa0YKmhxa9BYpJEYw72RwlmcplVJIB89BrvajnvtIW50srOSe5NIKZ5TEciXCRRPMMjavLQ=
X-Received: by 2002:a2e:5d16:: with SMTP id r22-v6mr24106231ljb.89.1539935059188;
 Fri, 19 Oct 2018 00:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9@eucas1p2.samsung.com>
 <20181018095708.1527-1-m.szyprowski@samsung.com> <20181018095708.1527-5-m.szyprowski@samsung.com>
In-Reply-To: <20181018095708.1527-5-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 19 Oct 2018 09:44:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfE9cYZ1Wh1yYWH=utvVWO2YndHO9yY8KLLcJ+A=XkKMw@mail.gmail.com>
Message-ID: <CAJKOXPfE9cYZ1Wh1yYWH=utvVWO2YndHO9yY8KLLcJ+A=XkKMw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 11:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks (global system counter). This patch
> adds a mode of cooperation with arch_timer driver, so kernel can use
> CP15 based timer interface via arch_timer driver, which is mandatory
> on ARM64. In such mode MCT driver only enables its clocks and starts
> global timer. Everything else will be handled by arch_timer driver.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
