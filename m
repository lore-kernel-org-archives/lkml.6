Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19739C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBD321B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894111;
	bh=7pcpsUkNnrefLY6tTYXwgHKjJIvwDaq7CDKki+HaJUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EhCCot/UPz2X/vOSscshI8jvsakRnw2hla/6wgsE2U9v5WCdYWI2A01DyzJW1in9m
	 Jjw6g1pmLIs8c+kzC749g5vW8i+4kIeftWGjIlUt4IMIn7t8iuf4puHCr6ETpDyqHx
	 4rLPv1NVUnqHYCNmaaLKiXKBACkUeUJCp4YkWJDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBKOI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfBKOI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:08:29 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BE1222B7;
        Mon, 11 Feb 2019 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894108;
        bh=7pcpsUkNnrefLY6tTYXwgHKjJIvwDaq7CDKki+HaJUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AVrSRPM24goMf34V1K8mUyLbbfeW/WFx5XTBX8tbpvuUQvODUNl/2szLiANvnzay4
         uZHEZADPKvW/Ohn+9ncLR6Crrf9cD7mEpBGzxyymM5dJXBuCMLD22cxUZqEEvovoiT
         /V+XmIAPEbtG22no6K62Bdf32/RNSeZ+c7waLla8=
Received: by mail-lf1-f42.google.com with SMTP id q12so7873097lfm.0;
        Mon, 11 Feb 2019 06:08:28 -0800 (PST)
X-Gm-Message-State: AHQUAuaSrdxqKzl4fwJBOpVfekgXVxMBvifU6xRgPabWK/7sibDeMtPP
        kEAT1UPd6i9Z35gzxgQ0L9yFgu8h4Bnxq7Nxb0Y=
X-Google-Smtp-Source: AHgI3IYyQjdwGur2to9yvvyWGYwFWogfpYJmS09H11XU4hFoRbyQlMPB9lvN9QQuhCPO2mX+nZkMtFQ7Rdqd6DuUZBc=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr21296913lfe.137.1549894106454;
 Mon, 11 Feb 2019 06:08:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170244epcas1p3f0037d3a98ed63b71e8daf14090befe3@epcas1p3.samsung.com>
 <20190207170218.851-1-s.nawrocki@samsung.com>
In-Reply-To: <20190207170218.851-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 15:08:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdKdROOSuHROEf9-aUY-vTrf9rcb=tZUKWWTNJUOZ-i5g@mail.gmail.com>
Message-ID: <CAJKOXPdKdROOSuHROEf9-aUY-vTrf9rcb=tZUKWWTNJUOZ-i5g@mail.gmail.com>
Subject: Re: [PATCH 21/22] ARM: dts: exynos5422-odroidxu3: Add support for
 secondary DAI
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:02, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch extends DAPM routing and adds secondary CPU DAI entry
> to support the secondary audio PCM interface on Odroid XU3.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Looks okay, is there dependency on the driver?
I think you need to update the bindings (samsung,audio-routing).

Best regards,
Krzysztof
