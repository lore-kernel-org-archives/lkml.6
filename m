Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7233C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E1B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="R+s9h54c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391398AbfAOXOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:14:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33423 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfAOXOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:14:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id d15so2683263qkj.0;
        Tue, 15 Jan 2019 15:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TE0RgnW3gqU0OlkU8MUNLqvrL9uNfl6XW2noSA9azQs=;
        b=R+s9h54coXHYdJx8cPfptzIQ6EHyxabE/zalyJeZFNbB8K5zBlEFDNDpvc57P1g3Lo
         nSWBMv9VnM2XyVTCY+DjQgY7+e0H1JmVbIFVKleKd2vQdqmrgoWg7igdhL84hSjg51vF
         CQztl+nbg4qT1IgbHeUtT+OvtFlxTadZWzC98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TE0RgnW3gqU0OlkU8MUNLqvrL9uNfl6XW2noSA9azQs=;
        b=FM06N0RCBaPN+nGrbvBJbcPp1rZQKsST1fEctsGmAwuKZb/jXs4z3amtsmGFmw2CL3
         kGTUn05sueSzwyGuBe9VtQlTclQtjU+NBz9q1u9CfRAoH/FBLnVoXFmUlkUB5ZvY89ZI
         bCQNPSZXZC4xbcbfmkXTJEhHK/LPGaIvf5Wmg8ZFH7dOk9fYGplHwq9ePf8tuXzRNTgs
         EsjUOpGxVy3UiQqHplmBsOc/Zz5IOSiinP5LR6WRU4Tn7UaXfYvRkUniNlNTyeuTjCdU
         txinEvlocbqtbag9MePmDd1onQAFe92CHMNilVlGmZKplFY2Gv0M8gOXC9fUZMHOCOvn
         oyHA==
X-Gm-Message-State: AJcUukfnfXIZ7slJO/yNyytagxPwEjCurQUofChcE6lpFL8wgqGy+Pf0
        CjqRkyKU0LZCl/qBrrbiqndnmoLx526IlXIudPE=
X-Google-Smtp-Source: ALg8bN6Vll7tVbYX6uRv7+fXX12sqYZkOX1xxR7J+sk1OoYRJ4Se2zeybqPn+/dVpT2TSkIIsgAs4YVlPrXLqBuNkYs=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr4656877qkb.25.1547594078546;
 Tue, 15 Jan 2019 15:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-7-jae.hyun.yoo@linux.intel.com> <CACPK8XfMyXfomepZEPJCr=A-cCPw-CVAZ0B2CuKn7oXCNz6LbQ@mail.gmail.com>
 <abaef001-a769-ec5d-45f0-02a994fdbee6@linux.intel.com>
In-Reply-To: <abaef001-a769-ec5d-45f0-02a994fdbee6@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Jan 2019 10:14:26 +1100
Message-ID: <CACPK8XdBSYHB+S8Sp8Y=J0cK9D=coa+coQj3S7TEFs9DJ8Ljxg@mail.gmail.com>
Subject: Re: [PATCH v10 06/12] peci: Add a PECI adapter driver for Aspeed AST24xx/AST25xx
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 at 09:49, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> >> +       /**
> >> +        * We check that the regmap works on this very first access,
> >> +        * but as this is an MMIO-backed regmap, subsequent regmap
> >> +        * access is not going to fail and we skip error checks from
> >> +        * this point.
> >
> > Why do you use a regmap for this driver? AFAICT it has exclusive
> > ownership over the register range it uses, which is sometimes a reason
> > to use a regmap over a mmio region.
> >
> > I'm not sure if you've ever disassembled drivers/base/regmap/regmap.o,
> > but if you do you will find that a single mmio read turns into
> > hundreds of instructions.
> >
>
> No specific reason. regmap makes some overhead as you mentioned but it
> also provides some advantages on access simplification, endianness
> handling and register dump at run time. I would not insist using of
> regmap if you prefer using of raw readl and writel. Do you want replace
> regmap with readl and writel in this driver?

I think that would be best.

You raise some good points about the regmap API, and you're not alone
in using it for these reasons. We should look in to providing a
suitable API without the overhead, or making regmap more efficient for
the mmio case.
