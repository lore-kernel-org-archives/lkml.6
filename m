Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8FC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3822086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3822086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeLNKFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:05:50 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33661 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:05:50 -0500
Received: by mail-vk1-f195.google.com with SMTP id d201so1154964vka.0;
        Fri, 14 Dec 2018 02:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKCo1QLU8uT7cgPsnRr67cnQq1XRBg+73LhYwBd/plo=;
        b=sdKXaMrULu2tls7V+sRT6t7xTTK4fWCi8IEktG3CfxbN1etjEFlOOyJwOIs93OXrbR
         8ZnAkYE6Nsn4oa7fYe22kzxfDT7q1WNsEkpr0ebH+pQTRuhtyXucmY5W68I4OCJ02VYp
         TF2C5wEdwv5WycuagdVhzUYeqNkDipdjaeXEknEgZELiStnUK4laRJwuBO6cbK9HKWqP
         eS6hNC/6Zj1BLjgCoqABakA2nAnYNm5gwfRC4y5mQgOrYZhGy9gxs/x59rLI249kw2Mm
         2SImvJ0zula8390QSBiVp9gDYuBUGqIHOXpifHcfwvJ/hhg0XnBBlCHKbr+LKuSxJmVY
         DveA==
X-Gm-Message-State: AA+aEWaGfHy5uez45ebZYvLqJsx7uN8KWUcADI9v97wGuoO+Wkd1g/6E
        FeKM7LkKciv75BMQP+fOFhkXRLGh87cEhG/pjXC69T0k
X-Google-Smtp-Source: AFSGD/UFhajYMHxroswsPIWC9fik5vhY+u/0O2r+xb+OU1n0T6bcQDKMEhPYBRhbXHZSs2S+7PmlChsKzr/y9QzIPEQ=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr962098vkd.74.1544781948899;
 Fri, 14 Dec 2018 02:05:48 -0800 (PST)
MIME-Version: 1.0
References: <1544732284-5951-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732284-5951-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:05:37 +0100
Message-ID: <CAMuHMdXq4fjyYy8RE_+oYedoUri_-=CvsdVn_gNbVsDpaOgK8w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:18 PM Fabrizio Castro
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
