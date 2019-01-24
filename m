Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9594BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1FF20854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfAXJHK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:07:10 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46276 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:07:09 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so1713456uap.13;
        Thu, 24 Jan 2019 01:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SiOBLixYntQVxi4BmtnVqXhqkmatSilfo/c722lN5Jg=;
        b=jbXsg4j6ddF92MgUH8hK9Ij3T/x992fbfiiAd0fU33P2T+CMTQdRO1zQZVx8bnbiKy
         J9Pi6QolQ2YRE9Xc9WA5QsuxBHAEK8oIYZPyisZvwgQ/f3n002xBrvD4l+cm3eJTHZjC
         +iHOkOIpkG9uS+BhH6SYB4kJNnnTpr6Cbiv9iWyKmI0V6GVshqggtFiEv0k9PnIJs9XV
         M/3/+PBtFPJkuZ2KEEHpHwXsxm1doSVoCBkJZIDrCEjJlFxXtq5KgvRvWRWnnibUX+/Y
         DcmCd0yjIcIt+i/mhf1GGYYWEhz+Soc/aBT/4WvUqwHUYIDEJxvv20XLmOg0eeTPKO8N
         V7vg==
X-Gm-Message-State: AJcUukcWjO//fV6cx4TROHq7S1grBsII5W0dmsMQXAXHS/x1aQaMZWvO
        30T9h6BlLtOsJqG/EKKNBGGDqy8husNx4cNnDTs=
X-Google-Smtp-Source: ALg8bN6zTt8NdDaMU/zkhxCaT3x/anX6iMtmzaBq3+qRrNdJ3qsXt5EXEtGXIvDbBa6pAwlkPAG6UanEQ4ISHlXz+oU=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr2259728uad.78.1548320828032;
 Thu, 24 Jan 2019 01:07:08 -0800 (PST)
MIME-Version: 1.0
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
 <ba02ea43-83ce-7e3c-6910-73f2e78f51cf@gmail.com> <OFB904EE00.27B08F2C-ON4825838C.000D6846-4825838C.000E90F7@mxic.com.tw>
In-Reply-To: <OFB904EE00.27B08F2C-ON4825838C.000D6846-4825838C.000E90F7@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Jan 2019 10:06:56 +0100
Message-ID: <CAMuHMdUqprbwvO=VaoyY__nOoNhowEZ8A-i+Tb+2iBe8-p=_Hg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Thu, Jan 24, 2019 at 3:39 AM <masonccyang@mxic.com.tw> wrote:
> > "Marek Vasut" <marek.vasut@gmail.com>
> > 2019/01/24 上午 09:54
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
> > rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > new file mode 100644
> > > index 0000000..305bd10
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > @@ -0,0 +1,46 @@
> > > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> > > +--------------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: should be an SoC-specific compatible value, followed by
> > > +      "renesas,rcar-gen3-rpc" as a fallback, i.e.,
> > > +      "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
> > > +      "renesas,r8a7795-rpc"   (R-Car H3)
> > > +      "renesas,r8a7796-rpc"   (R-Car M3-W)
> > > +      "renesas,r8a77965-rpc"   (R-Car M3-N)
> > > +      "renesas,r8a77970-rpc"   (R-Car V3M)
> > > +      "renesas,r8a77980-rpc"   (R-Car V3H)
> > > +      "renesas,r8a77990-rpc"   (R-Car E3)
> > > +      "renesas,r8a77995-rpc"   (R-Car D3)
> >
> > Was it tested on all of those SoCs and do we already handle all the
> > quirks of those ?
>
> These are R-Car Gen3 series and I list these by Geert's comments,
> or I misunderstand Geert's comments ?

I think you misunderstood. Typically we only list the SoC-specific
compatible values for SoCs that have been tested with the driver.
So for now I'd go with:

    - compatible: should be an SoC-specific compatible value, followed by
                  "renesas,rcar-gen3-rpc" as a fallback.
                  Supported SoC-specific values are:
                    - "renesas,r8a77995-rpc"   (R-Car D3)

The list can be extended when the driver has been tested/enhanced to
support more SoC types.

Does that sound OK?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
