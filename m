Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDFBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AC02089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0IaUCnca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC02089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeJATCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:02:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18488 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeJATCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:02:08 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w91COF1R029341;
        Mon, 1 Oct 2018 21:24:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w91COF1R029341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538396656;
        bh=7imcWw06lVx6JT0Y1dRWh4GrAUMT26bnc7/MsrPmKYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0IaUCncamnThbmCrrd875ulLNDeRaHbm9VmeuE4rd0mcwCCVg61B0oGrQ9GZ2rOKm
         oaRTMTtCeqwutrjps3m/49HswsLq6y1RScHvkQ4Am80sLTY3e4jhYp5Ja0Btu3WlIl
         8MXEAcAUVZbyzkTadpKcdPZS6h4HRcvO+02oLrlYMRIgTj0AvL0BK+kUnIWT5HdqSN
         hQUazAZTJ8stgo3XZyK8dfNlHAsUFJTLq/CeRyyo0+1aTs67qK54h3vvYNmCG0B8/X
         PmdO26PVckVnBipJtCrjCfd6nZFxmxBFNRD7NoRoRFy6yp0Xj0qyEdK3aQe/SBSoex
         bgpeVuMFUi8Rw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id z130-v6so7337957vsc.7;
        Mon, 01 Oct 2018 05:24:16 -0700 (PDT)
X-Gm-Message-State: ABuFfoiWEIGdfEa7jLjqsDC7GXA5p4Ubn7zz3eAk7KlLjwzye7UVDs9h
        AXiWGrQw+77Zhl00vHG5OTR58CQJM3jz01Wb0AM=
X-Google-Smtp-Source: ACcGV62J6+qROByNJzHEtb10h6E/2Vhd8qarwR//ddKRnHMiHgnHKitCYKUqsol5dS+wtznTLjcw0TMMEmEktkbN/7s=
X-Received: by 2002:a67:e0cd:: with SMTP id m13-v6mr3794912vsl.181.1538396654884;
 Mon, 01 Oct 2018 05:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 1 Oct 2018 21:23:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsGKSnBmrfEAwgoieizho8WCif_M3NuxtSe3+6Qo6vxg@mail.gmail.com>
Message-ID: <CAK7LNAQsGKSnBmrfEAwgoieizho8WCif_M3NuxtSe3+6Qo6vxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] dmaengine: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,


2018=E5=B9=B49=E6=9C=8813=E6=97=A5(=E6=9C=A8) 9:52 Masahiro Yamada <yamada.=
masahiro@socionext.com>:
>
> 1/2: DT-binding
> 2/2: driver


If there is no more comment,
is this series applicable for v4.20-rc1 ?


>
> Masahiro Yamada (2):
>   dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
>   dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
>
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 ++
>  MAINTAINERS                                        |   1 +
>  drivers/dma/Kconfig                                |  11 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/uniphier-mdmac.c                       | 495 +++++++++++++++=
++++++
>  5 files changed, 533 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dm=
ac.txt
>  create mode 100644 drivers/dma/uniphier-mdmac.c
>
> --
> 2.7.4
>


--=20
Best Regards
Masahiro Yamada
