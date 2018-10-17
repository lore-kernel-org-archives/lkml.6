Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AEBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC9E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="szEEhFND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC9E21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeJQV15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJQV14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:27:56 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B84B22152B;
        Wed, 17 Oct 2018 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539783132;
        bh=cDxso2ybIDvj3ysX+6MFjavaEqSlvI4wOXmJNcBz1Q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szEEhFNDMNWmMg/KZMa2sZrIZid7fCpJ6YjUFb2ERPx8Svj17SbQg+cHgE6O2+BPO
         7yEjT5O7EvTg4GaCOaO6QJbQ+hOWyISXP4KMXd5JGFOFJ5+DYz9PFCqDJBEg8N9Kjx
         nYDYvCy3pRjA5UKfmjZSGmOa2t1aU5erGV2RFN/c=
Received: by mail-qk1-f173.google.com with SMTP id 23-v6so16412923qkh.8;
        Wed, 17 Oct 2018 06:32:12 -0700 (PDT)
X-Gm-Message-State: ABuFfoghzMgPyqcUf5y0uHE3pzxyUmqIa9oODtoERPaSlIGHnDZFy1s0
        aG5Sm8YZ2bexsS+5en6oZVMU9WEA5a+nDIyrWQ==
X-Google-Smtp-Source: ACcGV61cwdF+T2/Kjnyltljmf94QyZgN0NbCXSlzIRZUuF2wlttT0Ya9lh3IL41DLVgf2u9KjXn6TajIVfJofYnQFQE=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr23739687qku.184.1539783131947;
 Wed, 17 Oct 2018 06:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181005153638.1886-1-digetx@gmail.com> <20181005153638.1886-6-digetx@gmail.com>
 <20181017132703.GA26895@bogus>
In-Reply-To: <20181017132703.GA26895@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Oct 2018 08:31:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKr6ag8JOPjkyjyxJ6mf37h4pukGM5ZGkqru1+bqF+B+Q@mail.gmail.com>
Message-ID: <CAL_JsqKr6ag8JOPjkyjyxJ6mf37h4pukGM5ZGkqru1+bqF+B+Q@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:27 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri,  5 Oct 2018 18:36:32 +0300, Dmitry Osipenko wrote:
> > Redefine binding for regulator-coupled-max-spread property in a way that
> > max-spread values are defined per regulator couple instead of defining
> > single max-spread for the whole group of coupled regulators.
> >
> > With that change the following regulators coupling configuration will be
> > possible:
> >
> > regA: regulatorA {
> >       regulator-coupled-with = <&regB &regC>;
> >       regulator-coupled-max-spread = <100000 300000>;
> > };
> >
> > regB: regulatorB {
> >       regulator-coupled-with = <&regA &regC>;
> >       regulator-coupled-max-spread = <100000 200000>;
> > };
> >
> > regC: regulatorC {
> >       regulator-coupled-with = <&regA &regB>;
> >       regulator-coupled-max-spread = <300000 200000>;
> > };
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Sent this by mistake. Disregard as I have questions.

Rob
