Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80638C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4615220811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4615220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeLNKpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:45:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44399 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:45:04 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so1806775uaq.11;
        Fri, 14 Dec 2018 02:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKCo1QLU8uT7cgPsnRr67cnQq1XRBg+73LhYwBd/plo=;
        b=cG7x9FDeR4Jiri/bldP86IX72GOV+HjnBDGNarslGIfrKlEbGnLsTnM4gUX7oNJ8SL
         F7CLBCPPcWIzGaWPcvXRZTdsFOK4nP5YPHqGsUVfsrhmfi/6QOI5Mb2M9kLqAO9dD+ix
         PSIFmydheRJyheyhn2yt55ku9u2sKOK44gPutjWpkW4q0wWESydrKpcfSeMg6CFAJ886
         0AmRFtf0LgYEDDr9p30Tu3KpHVrWUC0q6hNIJSkiuWTJJv9VIQ4ErrGd+FEE5QefrZgC
         RW+1N0fRevOE5xGJt/RLd16YcjrzLE3RcJk6WT1SyxUt1lro0VDuPPh2qdEkC70YS9T6
         /aOw==
X-Gm-Message-State: AA+aEWYN5ZRYFwoFjzIjEVEaiDy4F54NqFKpICybb8F0+icmWogVkDfb
        rn/kjfkrH9m5VE8FU48uREcXhWzp1ibHkIU5zXo=
X-Google-Smtp-Source: AFSGD/XD2lM6iWoddPcuydpSX5N0KZ3lXD9iGPMd69vUwEHBzJYcrKIBBwapfMXMkvUGjJlHAmcKTVrxDpVXLxZwrwM=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr1110676uap.0.1544784303114;
 Fri, 14 Dec 2018 02:45:03 -0800 (PST)
MIME-Version: 1.0
References: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:44:51 +0100
Message-ID: <CAMuHMdUPLux3rDpCN1_eF5XOx4xudN4c+BPd6x0iZ0DvaLz-gw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
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
