Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="adbqyHn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeIELy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:54:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38359 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIELy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:54:56 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so8245520ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NmqZIjN96Gtpl3wUQt91yEWdbs11AgOpZJOFw1gpWPA=;
        b=adbqyHn9nTusoZMx4V/MGXDF+3tIcVssRXqUj0WobTTdU81UeXh0gOZrIT4WvYsydL
         CEiNR3U70OrgecxSuu2ncz7ZZ/PsAL84iMHEG+ipfAksl48Oa0Ls73PJklGYGgfkHbw7
         RbE22X/73XgerXgdHhp03Gj2pZENR6Vkghim0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NmqZIjN96Gtpl3wUQt91yEWdbs11AgOpZJOFw1gpWPA=;
        b=Z0gbIsgUTFYt1ow2VgbWHvKiuAa/6aXvUCf/Wk1E8OSIfDL8IiyH/VumVNRi8/ve2r
         yfPhmJ+L6DbwB49mgyeFXh60DMmf06crS72IfFz1m7f/jxwCDrV258He9rIlu2I6RBzr
         ZQUHyCXPwlY9aoBanxpbA8X0/qb0n+Po01K0P8U/KVrCXKbBxXVBdJ/nFIGLWFHxh3Ul
         hRqXuSFCY/A0lm/jC78fXWlR/5uL3hd2nS/9zCk/JljF/qHlZKq3f7eSqPfGwbyWdDnR
         4PSxozv1n9eAc8/4hhVPAwwoIVas04eUAHoewmAKEDe2ZZyzy4Xw1VXShmE+AOsOIhx1
         VcXQ==
X-Gm-Message-State: APzg51DIcZmGPS0lwh5MfvjZS5zBSj2fq64/NFAXdjp4tm/n4TqrUnJD
        RRSC3UBqwdtEjMlzvYZpP0lfpeSnneoOwWO5idzvgw==
X-Google-Smtp-Source: ANB0VdYTF/JLd9dNujoh0ubK9Ed2EMf25xlV7hLTMs//eE8Y5VpmRt8OTxpIdoWpYJ8wW553oivhGd5ScdOfhGT6LYw=
X-Received: by 2002:a24:21d6:: with SMTP id e205-v6mr3253787ita.52.1536132364537;
 Wed, 05 Sep 2018 00:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:26:03 -0700 (PDT)
In-Reply-To: <20180904044053.15425-12-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-12-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 12:56:03 +0530
Message-ID: <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> Enable all necessary device tree nodes and add connector node to device
> trees for all supported A64 boards with HDMI.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: squash all board patches altogether and change supply name]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Rebase some device trees.
> Changes in v3,1:
> - Squash all enablement patches altogether.
> - Change supply name to match DT binding & driver change.
> Changes for v3:
> - Enable all pipeline components
> Changes for v2:
> - none
>
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>  6 files changed, 204 insertions(+)

Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
A64-Olinuxino, NPI-A64

Pine64 boards look unable by saying
[drm] Cannot find any crtc or sizes

May be someone can confirm, it.
