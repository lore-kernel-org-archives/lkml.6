Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E70AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FBD206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbeLQQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:08:25 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40968 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:08:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so7999007vsc.8;
        Mon, 17 Dec 2018 08:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPjILAC2gZ51cWXfJFJJTrPxbjf7fwfC2WhFq/WWvak=;
        b=AuzBFk9OzGojEvhX+uCaZaLkXd6TfnqT4r+8w10ODgp+s4phABna6JiaXibz844KqK
         nhBxwDF9xb+Z2/7ifxFVQepzCrBZRFBf/lC4N5xY9X2nk0pT1+C8CpXNuQKMut7XYsqG
         76TSvOcAUrIXaL0jznnH4VEJWQM2A68B6PTXzOte/Cc67y+xrvl8oEiQGpfBHqIE8gCB
         VVmWDFrMzvABXMliimJF4Tdr75xInGMUskAc103mKz9gch4G17kHZLoGGbTgq1h0BBZM
         GfhAJVOjKplCsBk95kAEXUI7zX0wSIppISMdfWp6btEnQSFO+haomRbP1gvbzr4Ze1p9
         zL6g==
X-Gm-Message-State: AA+aEWbzFu4ZatjtR+DcfoOLiC+hvwQfBJgJI3Slnx3W8YlMXQ47UvD8
        zPUe8yVA6JklFoN/IDsHVBZnWmNbr6bdQya5Fqc=
X-Google-Smtp-Source: AFSGD/UjKE+yFiA/rN63jtFaHqyOseJAaJIF2k3WBnRoFT8gx3I8/pjKKrOnyLbe8VbCCUTNS3PW1RxPHvjqFF8U8Wo=
X-Received: by 2002:a67:f43:: with SMTP id 64mr6660118vsp.166.1545062903787;
 Mon, 17 Dec 2018 08:08:23 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-10-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-10-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:08:11 +0100
Message-ID: <CAMuHMdV8shJvksgeCXgfVWKPvecyQRBs_rC9jQ5iXtanetC9Tg@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU core
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:10 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add a device node for the second Cortex-A53 CPU core on the Renesas
> RZ/G2E (a.k.a r8a774c0) SoC, and adjust the interrupt delivery masks
> for the ARM Generic Interrupt Controller and Architectured Timer.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
