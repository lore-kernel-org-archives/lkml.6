Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB95F2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiXs7o7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB95F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeK3Mqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeK3Mqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:46:47 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE8921479;
        Fri, 30 Nov 2018 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543541954;
        bh=F3N6mzqAIsTQY1d4N+nGuJmQrNxtxosRAnlVCd8SXWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fiXs7o7TnBHJaMP3KZzFvmHp131yKVzoNTFSnFS2scGqHHo7AQ1X2fMlEX4fvTWiz
         U1A7OjRZ3oV3BCneDDXTJcCOCnqrwhBx6/hLW0NWP6vBOPwG0h7Nt4qwrh6DyY/9tf
         kyxNHyNPdj0m9TYvVYkYiENJAnRVwpa/b5vfWN/k=
Received: by mail-qt1-f178.google.com with SMTP id n32so4292326qte.11;
        Thu, 29 Nov 2018 17:39:14 -0800 (PST)
X-Gm-Message-State: AA+aEWa7QU6cw2cj6Ip/H1SO2MfNU0PVn1sv2w+6XECgFR4FfHkQYdm9
        E968A2ST9gtqse/1GYb9T7BGtSLzhhJoTvVUqw==
X-Google-Smtp-Source: AFSGD/UwH73JoISAGAYHLjJXHrnPHz9X14/x5LY6T/YAzCG/sW5ve+xE3QghgutXDp4Wc/7eNGPIHBlIpnpLc1MkwRE=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr3669407qtd.257.1543541953208;
 Thu, 29 Nov 2018 17:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-7-TheSven73@googlemail.com> <20181126220804.GA23069@bogus>
 <CAGngYiWBBe7P80ASQJnS8woe6SKLgNUmqKxOHMeyV1fGSCpY_w@mail.gmail.com>
 <CAL_JsqK--6UE9N2je3mkoxf_0+i5fTYqYpmTF2bpzFf-KRjhaQ@mail.gmail.com> <CAGngYiXFag-C9-0XvGxVVWs5AxL2qn0UhU2W1Ds9LE+BJYgvDQ@mail.gmail.com>
In-Reply-To: <CAGngYiXFag-C9-0XvGxVVWs5AxL2qn0UhU2W1Ds9LE+BJYgvDQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Nov 2018 19:39:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEDvs0Ktr2aoyS9-aCeybjHFcVv6L+fQMsvd8Hy88ong@mail.gmail.com>
Message-ID: <CAL_JsqLEDvs0Ktr2aoyS9-aCeybjHFcVv6L+fQMsvd8Hy88ong@mail.gmail.com>
Subject: Re: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document
 devicetree binding
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 2:59 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Rob,
>
> Eliminating the 'compatible' property for the anybus gives me an interesting
> devicetree problem.
>
> The imx-weim code naively loops through all subnodes, applying timing settings
> to the CS in the first reg entry.
> In the example below, WEIM CS0 is programmed with the settings in
> fsl,weim-cs-timing, because the CS part of reg is 0:
>
>
> weim: weim@21b8000 {
>         compatible = "fsl,imx6q-weim";
>         reg = <0x021b8000 0x4000>;
>         clocks = <&clks 196>;
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <0 0 0x08000000 0x08000000>;
>         fsl,weim-cs-gpr = <&gpr>;
>
>         nor@0,0 {
>                 compatible = "cfi-flash";
>                 reg = <0 0 0x02000000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 bank-width = <2>;
>                 fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
>                                 0x0000c000 0x1404a38e 0x00000000>;
>         };
> };
>
> The problem is that my 'anybus controller' hardware spans chip selects.
> It requires access to various memory areas. In the example below, CS1
> will not be programmed with timing settings:
>
> weim {
>         controller@0 {
>                 compatible = "arcx,anybus-controller";
>                 reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
>                 fsl,weim-cs-timing = ...;
>         };
> };
>
> I've coped with this in the past by creating a 'dummy' subnode, without a
> compatible property. But it's ugly:
>
> weim {
>         controller@0 {
>                 compatible = "arcx,anybus-controller";
>                 reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
>                 fsl,weim-cs-timing = ...;
>         };
>         dummy@1 { /* this works ! */
>                 reg = <1 0 0>;
>                 fsl,weim-cs-timing = ...;
>         };
> };
>
> Is there a better way? I've looked and looked, but can't find anything that's
> similar.
>
> Or should I extend the imx-weim driver to cope?

Yes, I think it should iterate on child reg properties not just nodes.
Hopefully, you don't need different timing for each CS though.

Rob
