Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21BC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282F20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJHUDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:03:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42886 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJHUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:03:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id g20-v6so11938207qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 05:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=En6C8fGHDvbGx4smDE23vdqheUiCDHUkwLwpU1MzuDw=;
        b=jMNbbKl5zuY5AelfWVvWPklVnBC9eHLuZGXp1j16Oh20PJ23kC8mE83wKfyOf9tdJq
         lJ3GOl9zcDylFUX/sy2G/yzz1VYNa7M+6u/L8QLghlKrhQZRzxSr03V1fJuTwDk2NlfO
         CaLG+B3SJCtBtGGzCC90SFpdrtJRyE6zg4KEwskYhZv7XFt5Vf1AB21bTXhrpMe23pRT
         gOIPxbhAq1KABPEL6MHKMn07TvUS5tS7bGGtVAT87qbGF2o4lCRKR4kBKc931WB1/ipn
         3XVIoJdctWLbEQBM1L2FAM/JewzT+2GfR522zJkyqvkHNZdxqr9+wJxQknF+6o9JWZky
         i/zw==
X-Gm-Message-State: ABuFfoiML/EowiwWzTLJuItyvLNx1LxEbIjy0BmwGb99TRDi2UIXiqUH
        NMdN20yFBwdQKSST6JAgfNkPybEl4jvQSQY+oJw=
X-Google-Smtp-Source: ACcGV62criI63I2uWf5dnOle6MnrTWNI14VpZvo7xXiYWCziY2GovngfY6hx2m9kUVp/AgZV+V+sYIhU/Ke3e/tiaIk=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr18698404qkc.291.1539003094314;
 Mon, 08 Oct 2018 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181005193040.28598-1-leoyang.li@nxp.com>
In-Reply-To: <20181005193040.28598-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 14:51:18 +0200
Message-ID: <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
Subject: Re: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take 2
To:     Leo Li <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 9:30 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> ----------------------------------------------------------------
> NXP/FSL SoC drivers updates for v4.20 take 2
>
> - Update qbman driver to better work with CPU hotplug
> - Add Kconfig dependency of 64-bit DMA addressing for qbman driver
> - Use last reponse to determine valid bit for qbman driver
> - Defer bman_portals probe if bman is not probed
> - Add interrupt coalescing APIs to qbman driver

Pulled into next/drivers.

I was a little surprised to see these commits in your branch:

      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
      MAINTAINERS: update the Annapurna Labs maintainer email
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

These are from our earlier 'fixes' branch and they were also part
of your fixes branch that I already pulled, which you had based on
top of the other fixes.

In the future, please don't do this again. Instead, base each branch
on top of a plain -rc unless you have a specific reason to require
something else (like in this case, where you require the fixes to
build on top of).

This time we were lucky because the 'fixes' branch you built on
was also done on top of -rc1, so at least it did not contain any
commits from upstream that were not already part of our
next/drivers.

       Arnd
