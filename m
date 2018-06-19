Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6873204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJskukik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6873204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937707AbeFSO5e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:57:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54574 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937514AbeFSO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:57:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so889555wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxSJo08Snu6tXLF3iTCelm40rNOM6I8kpxcV+5Se6a8=;
        b=XJskukikDupoZiqEkeWRNa8KHQQDMFW9em3BFr1mTY6MRetmb0uSERgqNXtWfwJnbW
         SsJEvBi3Hos8HI1iRyL6FGeGWiw8Uf6vCD7ei9JY4Ph+ihd0t6rri4hpZfqmo8xhLYIO
         HN3edwtGXYj0Xo4kxR57Yo8LD0IbMry47guLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxSJo08Snu6tXLF3iTCelm40rNOM6I8kpxcV+5Se6a8=;
        b=GSUgbn/efS8ooDQJJ+k5lg8G1L1kkaGUQx/tbrw18nbRazODsC4qOzNVEJsfdo4e2E
         KCwzKYL2vt/Bp4G9DYjOdhPM8GCOJQlXkjrDvRj0/ZFNc90OjFCZD8dHIpOkox/CSnum
         j51AjK1Rd0LIQgOcmTAPsSID5vl2n1QOu4VRh5mW5om6KnXvXYZ16SohmI2zT/760sNQ
         bmJaM1bNcXASsH+bvxCFxV0NV5amt49n2Byd4q8NuUO5kinbALnHndAIv76aJ9bMYjFo
         xQkRhjHxBQWnbyOzNh4TQdLPRW0fIE+NUMgd6Ve1h3wJLtkI8RFq/NzJJ0OhCQMWP9we
         PqLg==
X-Gm-Message-State: APt69E0zo4z42wmH1SLUyeJA+ygSki95Hq7auyZ7isHu68rB/2p5X5Yi
        bLgIj6cxVNNsBUOyQdXdjSRM/G/QH8bgKiAZdaIk5Q==
X-Google-Smtp-Source: ADUXVKKF1hip/rE0sEXCCu86h71xud9pFIjmCmE76Tg669T5YVB5wl3lMNd9QlVNLlaXgspQQ6HYMVqAo/Vx+/JqpaQ=
X-Received: by 2002:a50:b608:: with SMTP id b8-v6mr15068797ede.255.1529420251601;
 Tue, 19 Jun 2018 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-16-git-send-email-suzuki.poulose@arm.com> <20180619021218.GV16091@dragon>
In-Reply-To: <20180619021218.GV16091@dragon>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 19 Jun 2018 08:57:20 -0600
Message-ID: <CANLsYkx1LFJodeg5npiLMBg9cWf-_PLeB2+RcYErGek_rokzyA@mail.gmail.com>
Subject: Re: [PATCH 15/20] dts: arm: imx7{d,s}: Update coresight binding for
 hardware ports
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>, stefan@agner.ch,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <matt.sealey@arm.com>,
        John Horley <john.horley@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        fabio.estevam@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 at 20:13, Shawn Guo <shawnguo@kernel.org> wrote:
>
> Hi Stefan,
>
> Can you take a look at the patch?  Thanks.
>

These bindings are still being discussed and patches related to them
shouldn't be merged.  The next iteration of this patchset will not
included individual modifications to device tree files, that will be
left for a later time when bindings have been agreed upon.

Thanks,
Mathieu

> Shawn
>
> On Tue, Jun 05, 2018 at 10:43:26PM +0100, Suzuki K Poulose wrote:
> > Switch to the updated coresight bindings.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  arch/arm/boot/dts/imx7d.dtsi |  5 ++++-
> >  arch/arm/boot/dts/imx7s.dtsi | 41 ++++++++++++++++++++++++++++++-----------
> >  2 files changed, 34 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> > index 200714e..5faff17 100644
> > --- a/arch/arm/boot/dts/imx7d.dtsi
> > +++ b/arch/arm/boot/dts/imx7d.dtsi
> > @@ -87,7 +87,9 @@
> >
> >                       port {
> >                               etm1_out_port: endpoint {
> > +                                     direction = <1>;
> >                                       remote-endpoint = <&ca_funnel_in_port1>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >               };
> > @@ -174,8 +176,9 @@
> >       port@1 {
> >               reg = <1>;
> >               ca_funnel_in_port1: endpoint {
> > -                     slave-mode;
> > +                     direction = <0>;
> >                       remote-endpoint = <&etm1_out_port>;
> > +                     coresight,hwid = <1>;
> >               };
> >       };
> >  };
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> > index 4d42335..8e90915 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -151,23 +151,28 @@
> >                       port@0 {
> >                               reg = <0>;
> >                               replicator_out_port0: endpoint {
> > +                                     direction = <1>;
> >                                       remote-endpoint = <&tpiu_in_port>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >
> >                       port@1 {
> >                               reg = <1>;
> >                               replicator_out_port1: endpoint {
> > +                                     direction = <1>;
> >                                       remote-endpoint = <&etr_in_port>;
> > +                                     coresight,hwid = <1>;
> >                               };
> >                       };
> >
> >                       /* replicator input port */
> >                       port@2 {
> > -                             reg = <0>;
> > +                             reg = <2>;
> >                               replicator_in_port0: endpoint {
> > -                                     slave-mode;
> > +                                     direction = <0>;
> >                                       remote-endpoint = <&etf_out_port>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >               };
> > @@ -203,16 +208,19 @@
> >                               port@0 {
> >                                       reg = <0>;
> >                                       ca_funnel_in_port0: endpoint {
> > -                                             slave-mode;
> > +                                             direction = <0>;
> >                                               remote-endpoint = <&etm0_out_port>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >
> >                               /* funnel output port */
> >                               port@2 {
> > -                                     reg = <0>;
> > +                                     reg = <2>;
> >                                       ca_funnel_out_port0: endpoint {
> > +                                             direction = <1>;
> >                                               remote-endpoint = <&hugo_funnel_in_port0>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >
> > @@ -229,7 +237,9 @@
> >
> >                       port {
> >                               etm0_out_port: endpoint {
> > +                                     direction = <1>;
> >                                       remote-endpoint = <&ca_funnel_in_port0>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >               };
> > @@ -248,22 +258,26 @@
> >                               port@0 {
> >                                       reg = <0>;
> >                                       hugo_funnel_in_port0: endpoint {
> > -                                             slave-mode;
> > +                                             direction = <0>;
> >                                               remote-endpoint = <&ca_funnel_out_port0>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >
> >                               port@1 {
> >                                       reg = <1>;
> >                                       hugo_funnel_in_port1: endpoint {
> > -                                             slave-mode; /* M4 input */
> > +                                             direction = <0>; /* M4 input */
> > +                                             coresight,hwid = <1>;
> >                                       };
> >                               };
> >
> >                               port@2 {
> > -                                     reg = <0>;
> > +                                     reg = <2>;
> >                                       hugo_funnel_out_port0: endpoint {
> > +                                             direction = <1>;
> >                                               remote-endpoint = <&etf_in_port>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >
> > @@ -284,15 +298,18 @@
> >                               port@0 {
> >                                       reg = <0>;
> >                                       etf_in_port: endpoint {
> > -                                             slave-mode;
> > +                                             direction = <0>;
> >                                               remote-endpoint = <&hugo_funnel_out_port0>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >
> >                               port@1 {
> > -                                     reg = <0>;
> > +                                     reg = <1>;
> >                                       etf_out_port: endpoint {
> > +                                             direction = <1>;
> >                                               remote-endpoint = <&replicator_in_port0>;
> > +                                             coresight,hwid = <0>;
> >                                       };
> >                               };
> >                       };
> > @@ -306,8 +323,9 @@
> >
> >                       port {
> >                               etr_in_port: endpoint {
> > -                                     slave-mode;
> > +                                     direction = <0>;
> >                                       remote-endpoint = <&replicator_out_port1>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >               };
> > @@ -320,8 +338,9 @@
> >
> >                       port {
> >                               tpiu_in_port: endpoint {
> > -                                     slave-mode;
> > +                                     direction = <0>;
> >                                       remote-endpoint = <&replicator_out_port1>;
> > +                                     coresight,hwid = <0>;
> >                               };
> >                       };
> >               };
> > --
> > 2.7.4
> >
