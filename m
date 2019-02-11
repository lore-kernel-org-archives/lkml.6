Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570B0222B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="chJGF9Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfBKOKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:10:48 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:58600 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBKOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:10:47 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1BEAGAm001111;
        Mon, 11 Feb 2019 23:10:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1BEAGAm001111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549894217;
        bh=Ddm3RVPs+99BTjqrALyXAj1R7WQCUvTiXfq5LNFNpd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=chJGF9XdmsH8ZCxYlcpQ7Cw/QIl2foerTD5Q1MlSAQWITcJRWAUIUQA/HJr+tyg+G
         H6X63NWnReRrk5eLO7HeOnRTVL1Nm96pf/JagyUXGHUlrynU5Vw81/tdy27FAjcrK7
         a3RA4ddRVHqZ1bWpjnqKMhUVyb+CRie3Dky6seX8GkXxiZqYkAiee3GDS3B33DOqci
         1yBGx/PjeLGTtZtSaBxETKRKeZpmgOFTDUWa7XUPT2OfRIWYyvJmkVpmVsAr302rMq
         50txzTA+sX9tHYgFLpNZD+yTUZoY+MSUdvQ7Mh8zLabantKClQ+314tK5ME7t1D+/b
         kPXMaA8d092XA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id s16so6301698vsk.4;
        Mon, 11 Feb 2019 06:10:16 -0800 (PST)
X-Gm-Message-State: AHQUAuZaNZ93zKZS7N5TwgpfI6HB0I4SJcQ18RdQd6Sq7PbJc7WYKBOP
        WI+Y/3Kl+pBi/H3qAvlu1uR7w8ks4weXRZ3g5ZA=
X-Google-Smtp-Source: AHgI3IZqdzRTG6E3sfZ1JwMvMHMlytVdk21phNy5hgAKmioNsAos9rOoPGu9X2q51/W7DH91fHNU4WMGOxDALQAloGU=
X-Received: by 2002:a67:3e97:: with SMTP id a23mr1027719vsi.181.1549894215478;
 Mon, 11 Feb 2019 06:10:15 -0800 (PST)
MIME-Version: 1.0
References: <1549628897-32345-1-git-send-email-sugaya.taichi@socionext.com> <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
In-Reply-To: <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 11 Feb 2019 23:09:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQx1Ee7a5CAhbaxKv8wiiuX_aP4ie7+_BqBSGh-dmchPQ@mail.gmail.com>
Message-ID: <CAK7LNAQx1Ee7a5CAhbaxKv8wiiuX_aP4ie7+_BqBSGh-dmchPQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Feb 8, 2019 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Sugaya,
>
> thank you for the patch!
>
> Since Masahiro has previously added the Uniphier pin control driver
> I would like him to provide a review of this patch, if possible. I also
> want to make sure that the hardware is different enough from the
> existing Uniphier pin control so that it really needs a new
> driver, else I suppose it should be refactored to be part of
> the pinctrl/uniphier drivers (we can of course rename it
> pinctrl/socionext if only naming is an issue).


Milbeaut and UniPhier are totally different platforms,
so no code is shareable.

At most, they could share the directory,
drivers/pinctrl/socionext/, if you like.

I know you prefer grouping by SoC-family
instead of by vendor-name as you stated in the
"Moving ARM dts files" discussion.



-- 
Best Regards
Masahiro Yamada
