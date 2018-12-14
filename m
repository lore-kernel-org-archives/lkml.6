Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31016C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B832086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeLNKFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:05:20 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41476 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:05:20 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so3013429vsc.8;
        Fri, 14 Dec 2018 02:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDCY6DNqIj29FTGQx8tc8fWSesV41vfhQ9suywlR+6s=;
        b=hEwOpPRDKYvUumkr4c58rEWPyWO+cY+y1S3uSpccErMB9+vVeu0EAbNOmx7wl5NtHD
         Lwn7WZGIwBs4wzJ2NDIFUVpajb8/az2DYC/lrXCd5msYWDNTAWtdnh4pLgeYmnyeqJnt
         k6HScOwgZXiM2Ovd7VKckyfltlDdRRttYGFsZR0vh0Vlr3ViMy5udP6sL2uLLSfJgY5a
         7ylHL47aAxEyDXrjf95hQ0Jb9tDe7t3FpIUQEio9o+peDly9x7N3sYY83/kU72tXbOcM
         3AS9Ue70vVK3e4g6fnTSjIMsyIvf6CCilnvWJvf2zwvY0sCIEvnMN/JitQ8ZLBnFJ/gz
         NdoA==
X-Gm-Message-State: AA+aEWZ8gaA7c/3ujn2bdWypRh5vhxuG0W4y81VtNp5NDkPKZ5EeaJ0k
        /R/cuXoL1Qv9vdmL6f/WCyg9oehRbL4J9DVi+2g=
X-Google-Smtp-Source: AFSGD/Vuag0ZKIrX/HsKnm8+C+48nwyuvsIL+P1/QqefWtw+ORuQhu5K7LHjyvjjUSKqZA9rHpVvPJwdbRPbealtZAw=
X-Received: by 2002:a67:3885:: with SMTP id n5mr847917vsi.96.1544781919343;
 Fri, 14 Dec 2018 02:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1544732274-5904-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732274-5904-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:05:07 +0100
Message-ID: <CAMuHMdWbBPue+n=Z9GOJVFFKr-stRV4-ozH0sxWjUbRmjDqN6g@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Document r8a774c0 bindings
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:18 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:

dt-bindings: ...

> RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings.
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
