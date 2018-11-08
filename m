Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD0CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86B320892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TKQCZlaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86B320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeKIBDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:03:08 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25847 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:03:08 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wA8FQiAf000428;
        Fri, 9 Nov 2018 00:26:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wA8FQiAf000428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541690805;
        bh=HnMQ5RNZo1vHHzF3PXXIqgaO0xFl0dgoXiBrKe+on6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TKQCZlaH3zqdjm8TVLU/5sFwSzRIDOJNpReNiiLadkt1qZG2TMtnxILs/FyWA2mTS
         KLO7iCAraCBrA8oQxaySPLZDQGcIxtxWhAnKGWonEZ4JIBxsl99oySHn5Zb1EqexyE
         UZf9p9OFowPrVkBLvXSjUUI/uWkDibpvGM9x9y0tHcMJoR5TmmNtBF2nz8+xlvMsmu
         5ZkWeytC6edFedLIQwRh3WflxyJZm3xdTZuxK5JeAibu1h6mw/eHFwhB5WUL8Q0vM5
         Lu+0Q1UWv9WfV5dfnuA758rGLSpsJw9LB8b6yolyZaQZQtBmLBpG1cWBleiyMEZ3ah
         u8BuouoRvtJLA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id x3so7317666ual.12;
        Thu, 08 Nov 2018 07:26:45 -0800 (PST)
X-Gm-Message-State: AGRZ1gJSHdVkX1xzjz0xUny4pwwXEN1qyun/PaLt1WB8mKkLgJAAHhwt
        KFGGnPcu7hR6fPi/Zfe9pLn2iUSEgeEhlPlQ20A=
X-Google-Smtp-Source: AJdET5cemjrFP8QSaJgN+FpBspChC5ZRo5DE/bLlB8cYm2Q6+zdverJk7hBX2FyAXu+SMc+1heD+yHfAn2OfnZDNxVE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr2159917uaj.42.1541690803995;
 Thu, 08 Nov 2018 07:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20181107143646.27675-1-robh@kernel.org>
In-Reply-To: <20181107143646.27675-1-robh@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 9 Nov 2018 00:26:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcs4bZv6Q1BEkb+V_SdiBek-fawO1RWKuh68uPN7ymUA@mail.gmail.com>
Message-ID: <CAK7LNATcs4bZv6Q1BEkb+V_SdiBek-fawO1RWKuh68uPN7ymUA@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Fix inclusion of dtbs in debian package
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        nunojpg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:37 PM Rob Herring <robh@kernel.org> wrote:
>
> Commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
> moved the location of 'dtbs_install' target which caused dtbs to not be
> installed when building debian package with 'bindeb-pkg' target. Update
> the builddeb script to use the same logic that determines if there's a
> 'dtbs_install' target which is presence of the arch dts directory. Also,
> use CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF as that's a better
> indication of whether we are building dtbs.
>
> This commit will also have the side effect of installing dtbs on any
> arch that has dts files. Previously, it was dependent on whether the
> arch defined 'dtbs_install'.
>
> Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
> Reported-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to linux-kbuild/fixes.
Thanks!


--=20
Best Regards
Masahiro Yamada
