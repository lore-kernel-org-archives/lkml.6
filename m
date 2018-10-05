Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F929208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLNadbhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F929208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJFDSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbeJFDSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:18:04 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B273721477;
        Fri,  5 Oct 2018 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538770665;
        bh=wXHxjb3dNmbQaE6qiSSvamR7cFQ2uNWuMGrCoTQUWz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZLNadbhggaBjokNOM7Kyi5My8WdgA0Ut4c6pzrvvCho3dh9KBgxN/G+B/mQtwH+j8
         kGqbdC5EVXtcuIgNXdmhahHbaASDoCUMQmlOFcn8/tcHqJCyXqL5dCsEoeYYtLT41B
         7JArdNK+U13LXZoaIbUTMk9xAt1e4eNn6W2VEhd8=
Received: by mail-qk1-f169.google.com with SMTP id 84-v6so8765247qkf.0;
        Fri, 05 Oct 2018 13:17:45 -0700 (PDT)
X-Gm-Message-State: ABuFfogaENI9iIRuf1zM3kuFp+3dJXv/wbcEEReNa7JNbjbO3Gqz08Pd
        Ujcui0AyQBj6Mwj2UGsZzqqmmVOf8nczgHE4WQ==
X-Google-Smtp-Source: ACcGV634VraUH4eZPqlZp48K+XQYqe1dBj9YcF2lk5x6sA/335AY9GcyslD671l/ct9deob/bGi1xHWOABZMV676mBc=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr10332076qkb.326.1538770664909;
 Fri, 05 Oct 2018 13:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181004090654.32233-1-linus.walleij@linaro.org>
 <20181004105031.GD6412@sirena.org.uk> <CACRpkdZZHYSRXktPLHKRc4Afsegn4q3rOmcPMhXh5chC1jH-JQ@mail.gmail.com>
 <20181004135427.GE6412@sirena.org.uk>
In-Reply-To: <20181004135427.GE6412@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Oct 2018 15:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Dpv1NohnMaLEV3ZMdHYBwMZMaFtftc8z9X1wORCCT3A@mail.gmail.com>
Message-ID: <CAL_Jsq+Dpv1NohnMaLEV3ZMdHYBwMZMaFtftc8z9X1wORCCT3A@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: Use more standard GPIO binding
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 8:54 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 04, 2018 at 01:32:13PM +0200, Linus Walleij wrote:
> > On Thu, Oct 4, 2018 at 12:50 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 04, 2018 at 11:06:54AM +0200, Linus Walleij wrote:
>
> > > >  Optional properties:
> > > > -- gpio: gpio to use for enable control
> > > > +- gpios: gpio to use for enable control
>
> > > Are we supposed to be able to have just plain gpios as a standards
> > > conforming property or would best practice be to call it enable-gpios or
> > > something?
>
> > Oh I didn't think of that really. The gpio-regulator indeed uses
> > enable-gpio for the same thing. But it complicates things codewise,
> > as the GPIO line is also optional. I'm a bit uncertain, I tend
> > to think just "gpios" is fine when the usage is unambigous. but
> > I don't know what the DT maintainers think.
>
> Right, well from my point of view -gpio is perfectly fine also so... :)
> Rob?

Just 'gpios' is fine generally when there's only one (or one group).

Ideally, gpio-regulator would be a superset of fixed-regulator. The
difference would essentially be the voltage control gpios and state
properties. Changing the names though will break forwards
compatibility if dts files are updated and these are widely used. So
probably not worth trying to change unless you want to carry code to
handle both. That applies to gpio -> gpios too if dts files are
updated and older kernels don't handle both cases. But updating just
the documentation should be fine.

BTW, 'enable-active-high' is also a bit strange as that should just be
encoded into 'enable-gpio' flags. We should really deprecate that.

Rob
