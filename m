Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B25C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C3E2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3E2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeLNKfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:35:55 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44089 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLNKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:35:55 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so1799010uaq.11;
        Fri, 14 Dec 2018 02:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PT2xx5bbfVQ2MI7g/SJQTQVxkF7aSevt6thEgqA/rrE=;
        b=KLIReJXmZYYUV9OODtULCnvBcImxTKkEV16K942BNkBKD1mPTY10Vnh4CSWYISViaz
         oGhx4CWCcmf00qTeNV3zEbhojiA0p1P/ia0LSHWbq7GE1DqqshfF0aL54EArMW5rqEAE
         SKETcFCYnYOjp0Pew7CYYcNuqGw0z3YD2J3ribbqaAsVO3+KBqJ7efpoTgMRu/u+bdNs
         jn8GUYFC7nyjy0nHqveSTfMZCqx7wo9zI8aNNEAiS8cRI0HVtuasz09YEnZD/KeY+FEN
         lzsRzE6J3SX5EJ54GW0eb95cIF5V22JzKSJNlBCPtt45QnnSHLSffpLz7f7wnttquIlJ
         PlaQ==
X-Gm-Message-State: AA+aEWYew4Ah25tDqbe9vQCyFypGx7Iyz+SonLG9XgEvKvM8gsgO50Vv
        6nqi5tmH9uFUC+g9r6IST7lISg+qnttnHh63vqs=
X-Google-Smtp-Source: AFSGD/V+qYaCThRIH8kBwehaa9ybS1t4ZtY4TvQILABm60K05XzvXr5Q3QPxnLDzPedBIpj9y6KQDtvzP/qP+4QyQjw=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr977271uad.78.1544783753770;
 Fri, 14 Dec 2018 02:35:53 -0800 (PST)
MIME-Version: 1.0
References: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:35:40 +0100
Message-ID: <CAMuHMdU_Kf11jGJB8wUfwdb6MEo=9Hp21GJp4197+BxymxbP1Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas_sdhi: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
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
