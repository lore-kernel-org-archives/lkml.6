Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99400C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6181F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6181F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeLNKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:37:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38770 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:37:49 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so3082732vsa.5;
        Fri, 14 Dec 2018 02:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENn4Za+creVJyn2I1BgReQ+tzZBxG6cSghe70QpF7Ts=;
        b=oDS0d6Mw3GHVS/BnmwjwhC4zALbefG01p2iQ7dTy3avBlD7b18dCd9FGw6e4Qog8Zr
         GFMNw7J+Vl+pScANnNVnj4i3cnOUi5sU9ClIiXpJy9e2PAGSenvIvXWpIj+122iw8QhH
         IjtB2mbLTdpemy6o1tZqvXJePfQ5YDIR7ZsdOZlWreeSH5y6CWISnpXEFzM9DmRZZcNr
         sf2Svz+brV0q5h6jBGjJ65g3ndxskjpax7d6O9njeI4f5XZipuoSfH+OaQuKUAydnzJf
         3OvR48oXObZ7AkvX5DIsjlh/+N0zqS203YIBcSkp4coZbsQNHQPr0RorZIzkL5zMfiVt
         nPvw==
X-Gm-Message-State: AA+aEWbuKpmlkDPJZfN61bhbTtjctNB7y38qPupAWh7mKL2ee97UlEYp
        BLtvTO0j+RAdwIcfqj4TjROwUbyDbubuNevJ/PI=
X-Google-Smtp-Source: AFSGD/UETcpoIn2Qj04r9RGe1PD5AcnOPWcRLhohFFfd5/ItsHsw085ahcz/5TnsMVlZpazlzj/Qg4UHqN+mACSoR/0=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1043181vsp.166.1544783868584;
 Fri, 14 Dec 2018 02:37:48 -0800 (PST)
MIME-Version: 1.0
References: <1544732547-7094-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732547-7094-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:37:36 +0100
Message-ID: <CAMuHMdW3_MAFbue0T2sosKQ_YbsLWsw8PXhqc6dbiuo52eyBUw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> From: Biju Das <biju.das@bp.renesas.com>
>
> We need r8a774c0 to be whitelisted for SDHI to work on the RZ/G2E,
> but we don't care about the revision of the SoC, so just whitelist
> the generic part number.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
