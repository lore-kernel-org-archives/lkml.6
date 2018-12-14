Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B372080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B372080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeLNKNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:13:31 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37982 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:13:30 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so1803373uaa.5;
        Fri, 14 Dec 2018 02:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTPTCkq3GfHZRvNIsOK9tCvyfvqbBjLPXGrP4drpZpM=;
        b=d3UTdcMMPPx61IzYFsPvGcgtg02o35d3FcB13TrvuEihtYteJ/AiE1c5xz7d1o2Vo4
         OvqiWW1ErcFco6nf1eOiX4hOPIlvmBdxhiBMlthgNkjK2smkvOZp9Q2aQAmsAKKhbvW6
         bE6NLoNuO2usJsONpZVmLPBVyy2/FoAmBIPOE2q7hj6HeWXQRvYXOfx2R+WILjAiXiJr
         liZYQVh+7VEN/NJAUc8uQX6HrRNUgxy0+ME1PuSbZqPzOF7PmouhOz1QK9d1TAOQroiZ
         jQmaXsZIcj2ok2H7d70L8f/EwGGWsX4Wxs07eUcV6poazLytOCr+sHQSUp2Zf2Gtm85B
         9aRg==
X-Gm-Message-State: AA+aEWafBilHjKAeml2BJTpLfAE8WfmGb2U0FzLWsLytXhQMGOv2XqBD
        b85hH021VT05n0yjcWndwVven2v6V/sVT8qSdC0=
X-Google-Smtp-Source: AFSGD/WKkUmRylajwlShKIcgvVplHFX6G1W70cn8vDw3wv1VhspHLRTwr0a8+GvM+kaCcVLUEg8/nIomtGsZpe+4DRE=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1042242ual.20.1544782409602;
 Fri, 14 Dec 2018 02:13:29 -0800 (PST)
MIME-Version: 1.0
References: <1544732388-6313-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732388-6313-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:13:17 +0100
Message-ID: <CAMuHMdWL6vm56XrKSvwW0HaTJke7JyoFrpp_6g24ci6NOWu2vg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: add R8A774C0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:19 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E SoC (a.k.a. r8a774c0) bindings.
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
