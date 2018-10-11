Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF17C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5305320835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="APsNtlpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5305320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJKQ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:56:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37213 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:56:02 -0400
Received: by mail-io1-f65.google.com with SMTP id m16-v6so6078531ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bu+dNDN+pi7r9sR32FybTjRP1hAfyAp8sD32JdpROJo=;
        b=APsNtlpdRxThic+ZmwyxRL02xy6xZIRKREcL5NojTmUvZf39HcNN69h+DWwW+9kNA5
         YqdNvDJjvLVU07JRUkAk3jET5ZWRIZpYa5pv3B9/5M+sytCsH+Y8x4mGZf9b1vREOFiO
         hbOh1zCutjOLm/cSZVV2s6hG4RNppn1p3hFOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bu+dNDN+pi7r9sR32FybTjRP1hAfyAp8sD32JdpROJo=;
        b=saHU+h11L8XnK/XMfB/j9J55JXkrceeTiR9dRCAvxZkU13Yt3VgeW842fmYur42ohk
         Nw/NVel2RyrTnnqDJH6bZh59sfZZICSF+hwiieorcRS6jeQQxjI4xjeR46WCJExRa5sR
         6ebXXrbJ3FOlS54rdOktKIej+cdKPFChu7HkYUHyp0WJa6jNk65dTLBe6tbIMjA84moh
         gkdbAMSsnjH5BtuS9l/LPSJGGxcJIog5EHDPQj85FBYUkNeRFVfsRDNHK5jsfOIIPXEX
         MLnJpJT3PLFNja20wv1tfS7YX9NN6jE0/BgRT8SCFl2MiBKp6gKqnxK8127/i5w0HnYV
         +p3Q==
X-Gm-Message-State: ABuFfogyU46qOIcJNJYX6bmIVTXeuw6kL7jpOnmHUxpUTnKsKBGjGtEq
        AKShfkpGHKAy7QhUhh4fhssma0H0G9lbcDTZXVa/yzdS
X-Google-Smtp-Source: ACcGV60DApxM0ii4n8U8pZ41TNLcFAVg4iasVmlvDXcrS+doERQuWJ0RYAkGmJPQ0MsFSX++fy1VzojEsi9Sa80TQBQ=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr226065iog.175.1539250175617;
 Thu, 11 Oct 2018 02:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org> <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
In-Reply-To: <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 11:29:22 +0200
Message-ID: <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:01 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> I've just noticed that this patch causes regression on Samsung
> Exynos4412-based Trats2 board. Conversion to GPIO descriptor breaks
> operation when regulators used shared GPIO:  sii9234 i2c driver
> is not able to get vcc33mhl regulator (it uses shared GPIO enable
> line with vsil12 regulator).

So I guess this means that this physical GPIO line will enable the
vcc33mhl and the vsil12 regulators at the same time?

> This issue has been already pointed in case of commits:
> 37fa23dbccbd97663acc085bd79246f427e603a1
> d1dae72fab2c377ff463742eefd8ac0f9e99b7b9
> ab4d11e2c2329cf7cb7be31ff22489aae4dee5dc

A big sorry for my ignorance, I guess the information overload
on the mailing list just makes me miss the important points.
I'll try to be better, sadly I constantly fail to keep everything
in mind and constantly break things like this.

> Maybe it would be better to first solve the handling of shared enable
> GPIO in the descriptor-based interface before converting more regulators
> and stepping into this issue again?

I am trying to solve it, but I just don't have systems to reproduce all
kinds of things. It's a bit stressful since this is one of those runtime
things that is hard to test when devising a patch for systems I don't
have.

I am kind of relying on system maintainers to test things.

I was aware of the usecase "several consumers takes the same
GPIO line" (Mark told me several times...) so it was in the back of
my mind, but it's just hard to see when we were gonna run into it.
So it is the fixed regulators, on Samsung boards, I see.

Anyways. Let's try to fix it now then instead of me constantly
hitting this and breaking it. It happens because it is just unintuitive
so I share your frustration.

I don't want to generally make it possible for a gpio line to be
retrieved nonexclusively. We need the semantics to help people
do the right thing.

So I was thinking to introduce
gpiod_get_nonexclusive() to explicitly handle this case for the few
systems that use shared GPIO lines, let me see what I can do.

Yours,
Linus Walleij
