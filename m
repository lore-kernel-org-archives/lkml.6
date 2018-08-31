Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64F820839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FghETT2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeHaSJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbeHaSJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:09:51 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175CE2083D;
        Fri, 31 Aug 2018 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535724133;
        bh=wXWR/0N6aPMf2zN7xOl/ufTjGh2A9v+psYoL7eskn1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FghETT2K2Jvff7n2UU8f5DdzLsx9M2p07Zvca4Gvb3mbKdjONJaavBH0GFWjMGyvL
         UWjCieV/GsfUde5pTrtLJEbsL5yKyd49w2ftDyIBOuoBIKgJ+83xR42sSO06a5tqrp
         ye4jGOYpGehBax8eKb5S5r2wA/WeABFKW7vLyt+w=
Received: by mail-wm0-f45.google.com with SMTP id y139-v6so5336271wmc.2;
        Fri, 31 Aug 2018 07:02:13 -0700 (PDT)
X-Gm-Message-State: APzg51CFRh52fGStPdLepB42SxD3jP0WQ2aoKdODhFeVkEyT7Ck2zzde
        YEygv8xrA6IpkGLaSct4gs+41P5kPIRkLgQysaE=
X-Google-Smtp-Source: ANB0VdaUWt8FJV/g1P0s/6p6Gj0KsYRm51oQmG3NOAJVH47aZFF93VBPeDwz0zHUdzTGNV2JKgn6JE/+VrdSyIPk/04=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4581933wmd.135.1535724131568;
 Fri, 31 Aug 2018 07:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180830180205.18121-1-krzk@kernel.org> <20180831104048.GA6545@jack.zhora.eu>
In-Reply-To: <20180831104048.GA6545@jack.zhora.eu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Aug 2018 16:02:00 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfi8_G9LcjVCJU+N6BNwQSvkVOrBuqeqxsx_EihzU+cpQ@mail.gmail.com>
Message-ID: <CAJKOXPfi8_G9LcjVCJU+N6BNwQSvkVOrBuqeqxsx_EihzU+cpQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
To:     Andi Shyti <andi@etezian.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, arnd@arndb.de, olof@lixom.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 at 13:18, Andi Shyti <andi@etezian.org> wrote:
>
> Hi Krzysztof,
>
> On Thu, Aug 30, 2018 at 08:02:05PM +0200, Krzysztof Kozlowski wrote:
> > Samsung Exynos SoCs and boards related bindings evolved since the initial
> > introduction, but initially the bindings were minimal and a bit incomplete
> > (they never described all the hardware modules available in the SoCs).
> > Since then some significant (not fully compatible) changes have been
> > already committed a few times (like gpio replaced by pinctrl, display ddc,
> > mfc reserved memory, some core clocks added to various hardware modules,
> > added more required nodes).
> >
> > On the other side there are no boards which have device tree embedded in
> > the bootloader. Device tree blob is always compiled from the kernel tree
> > and updated together with the kernel image.
> >
> > Thus to avoid further adding a bunch of workarounds for old/missing
> > bindings, make development of new platforms easier and allow to make
> > cleanup of the existing code and device tree files, lets mark some
> > Samsung Exynos SoC platform bindings as unstable. This means that
> > bindings can may change at any time and users should use the dtb file
>            ^^^^^^^
> you have a typo here, other than that I agree with the patch:
>
> Acked-by: Andi Shyti <andi@etezian.org>

Thanks for spotting this.

Krzysztof
