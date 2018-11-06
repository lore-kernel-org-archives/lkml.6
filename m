Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982F82085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jAeP1WkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982F82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbeKFWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:19 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:39060 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeKFWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:18 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wA6DJqg7016377;
        Tue, 6 Nov 2018 22:19:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wA6DJqg7016377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541510393;
        bh=1TUvKB07A20gsBi7u0nPJzRhM+lGEk0vbtS2MY1D8Yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jAeP1WkMVM9EExoWEjlA2VUVescKJqLTv/hWisRvCG3mZ73ftWRv+hc0vlOUnb/n9
         Ik2npN2xqnY0PgHH+yoCwZeaiOhDkaeUkal6WNzJHygS0vC50TuAOm9FJMM6U4KLXA
         0fR79dLnrMSy+mpGMOM3lGJi0pohxuMxhhGSONW3csNdm6Jr2Jn802DcQ3BM1WcjPp
         pxA1RXFv5CVg02i1GrrPPeV7RdyV2wNZxHJ5EficMq3yJrZ44+8Drv30oSrUZ0nmUK
         UkshtsMeTr3bOweF+NdR8jYGRD2aJwfWaFl0IB5O3Z94HWSYyIa5939NmEsCEXu7TT
         HucTt4BcfHRsw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id s9so7234982vsk.7;
        Tue, 06 Nov 2018 05:19:52 -0800 (PST)
X-Gm-Message-State: AGRZ1gKa/9eBeACiTIHvJ6x3hDbMOz5VTayNZuZo+N0Qc6xLAcEKc0lK
        8HtxUPrupnElTHuDWM7VayiZAzsSQy7qNRsNz3c=
X-Google-Smtp-Source: AJdET5fP+tLdu6qJyu2uLZpbRi11Ucy9AzQwR5rouoj2NY59q06wemF0MSLlN9JmNx4TmeWWsbIv2QbxyzCNT4idPjI=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr10904278vsm.181.1541510391598;
 Tue, 06 Nov 2018 05:19:51 -0800 (PST)
MIME-Version: 1.0
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 6 Nov 2018 22:19:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsbpC53aiQGRdQaukFOLX_ZN09ZOPU1CqF_bsR2u01hQ@mail.gmail.com>
Message-ID: <CAK7LNASsbpC53aiQGRdQaukFOLX_ZN09ZOPU1CqF_bsR2u01hQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 1:42 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 1/2: DT-binding
> 2/2: driver
>


Gentle ping...



> Masahiro Yamada (2):
>   dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
>   dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
>
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 +
>  MAINTAINERS                                        |   1 +
>  drivers/dma/Kconfig                                |  11 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/uniphier-mdmac.c                       | 506 +++++++++++++++++++++
>  5 files changed, 544 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>  create mode 100644 drivers/dma/uniphier-mdmac.c
>
> --
> 2.7.4
>


--
Best Regards
Masahiro Yamada
