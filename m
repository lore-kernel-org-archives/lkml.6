Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20325ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B8921470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PwIA/TiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B8921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJRLKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:10:51 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63125 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJRLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:10:51 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9I3BwZm015995;
        Thu, 18 Oct 2018 12:11:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9I3BwZm015995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539832319;
        bh=D1Qqu6RByi0+Y4WCzVJVY4a/hm/zwksYVcB7A3ELLaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PwIA/TiTaDn5zvcSr2lXaZKGx7EKl90Z0MB44TgKob3mnPEc8knyU+Eflg4wCjmWD
         fdKsEP4E/o47m3wn0ZDLL6lS6Ozc8pcNd5105ZeCu9FtNLRSH/qYq3mBEX34t2S3jM
         YMcF7V3KIP2UpwQJTriPvzbkTpsrA6JcPKHP8FssT720tJd4TRC2dHFkmanKQph6Qt
         tbnJwbVejC5Hj7+aGG7F7SveXY31EKylzI6ZzTVR5UIv08c0giiwGRmdiG1IuAhGhw
         dSXP4R3/XX7wUxWiL5A+Amhw+OL12epFU5N4xDb0yP7KdzPWMS9z86alNaCer+luW0
         9FBlmuJi45afA==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id a202so22159080vsd.5;
        Wed, 17 Oct 2018 20:11:58 -0700 (PDT)
X-Gm-Message-State: ABuFfogjAxUoat39c8HltoYM27fkVcAMsTuvR3pamzkfAqd64sPwa+WK
        d/bGyoz61jPynRAq6fax0fSMLAXgh9QfPt6f7ok=
X-Google-Smtp-Source: ACcGV61MFUIcm6ZtfZLN5sgJzD+VsH3PcxfTqauBKakKBur14dgWJ7OvICKxzDSk20xHxRmpBQk37nydXaHSh0h+PCM=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr11546890vsm.181.1539832317741;
 Wed, 17 Oct 2018 20:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
 <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com> <20181017200022.GA14782@bogus>
In-Reply-To: <20181017200022.GA14782@bogus>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Oct 2018 12:11:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+j4pRxCorfyf23L8ZRXV_mF-uQd3ab7rwP9vKktsE+Q@mail.gmail.com>
Message-ID: <CAK7LNAQ+j4pRxCorfyf23L8ZRXV_mF-uQd3ab7rwP9vKktsE+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Thu, Oct 18, 2018 at 5:01 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 12 Oct 2018 13:25:24 +0900, Masahiro Yamada wrote:
> > Now, the Socionext vendor directory is available at
> > Documentation/devicetree/bindings/arm/socionext/
> >
> > Move cache-uniphier.txt over to it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >   - New patch
> >
> >  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks for your review!

You gave your Reviewed-by twice to 2/2,
but nothing to 1/2.

Is the first patch under review?
Or, did you accidentally do that
instead of replying to each of the two?


-- 
Best Regards
Masahiro Yamada
