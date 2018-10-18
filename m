Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66B2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/rMHNFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D66B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJRVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbeJRVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:07:37 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4FB22098A;
        Thu, 18 Oct 2018 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539867999;
        bh=/Gu4XAS4GqXJphCRQP38s7N3Z+afaTBLJag1azUZhTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f/rMHNFFXIedTeBrckMsbEsJyho3LV7ayBo6W2X4mZmLiZYCLThv+yPquUaN3GXTA
         2G+LWqTu18jgU35CK9YvnDoW4K+mECz+/zNyZUC3T5beqyP3mfbB2M6orTJ+sVsLO/
         w9S+F27Lmod04pA0HdKVZBLdMuKCvcTpWFvvBj30=
Received: by mail-qk1-f176.google.com with SMTP id m8-v6so18660071qka.12;
        Thu, 18 Oct 2018 06:06:39 -0700 (PDT)
X-Gm-Message-State: ABuFfoglcAlkFsDIgFW6bXOV/xG/ye/++gDfwky3TZ+tcrHc3i0VXSRi
        KmJVbIfr8eYyR1zjIZ4V725PWaxa0TAK0Jf+Vg==
X-Google-Smtp-Source: ACcGV61ld3PDiTXvjHQUARVxaACE73QKLoa9y/fdJqALeMBGPsFPJJgHLlTThFZ3sIFtWdp2hq6iOH8+mHI7hng3Pqc=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr28493604qkb.326.1539867999032;
 Thu, 18 Oct 2018 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
 <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
 <20181017200022.GA14782@bogus> <CAK7LNAQ+j4pRxCorfyf23L8ZRXV_mF-uQd3ab7rwP9vKktsE+Q@mail.gmail.com>
In-Reply-To: <CAK7LNAQ+j4pRxCorfyf23L8ZRXV_mF-uQd3ab7rwP9vKktsE+Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Oct 2018 08:06:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHYbkTYnDHwFDRx8NrwBrMqFD_inN-ZRb9sYnq=F=+rw@mail.gmail.com>
Message-ID: <CAL_JsqJHYbkTYnDHwFDRx8NrwBrMqFD_inN-ZRb9sYnq=F=+rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:12 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> On Thu, Oct 18, 2018 at 5:01 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 12 Oct 2018 13:25:24 +0900, Masahiro Yamada wrote:
> > > Now, the Socionext vendor directory is available at
> > > Documentation/devicetree/bindings/arm/socionext/
> > >
> > > Move cache-uniphier.txt over to it.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > > Changes in v2:
> > >   - New patch
> > >
> > >  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
> > >  1 file changed, 0 insertions(+), 0 deletions(-)
> > >  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
>
> Thanks for your review!
>
> You gave your Reviewed-by twice to 2/2,
> but nothing to 1/2.
>
> Is the first patch under review?
> Or, did you accidentally do that
> instead of replying to each of the two?

Humm, some sort of scripting fail. Yes, you can add my R-by to 1/2 also.

Rob
