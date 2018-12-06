Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6927C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544135940;
	bh=VbcGlGAAJz1C5lG5tVujtKGSK3Bzi9ksK0uLYUy4iTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qN+CpqCphQ88/baMBa7JwZhlVeyptDlfQbZnuC/hkzs/wbFbN8B/zPWKTZFZ6fisd
	 b2jMGBI6G1QWs5aRSkD1wE14tlu/AxqfOqA4EBpNSVd0uGET8cGev5ROguWqH6i0Dw
	 boAHbgGbLTU7qUeT6GrukHe2UHKnp2Dhr7a3+of4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6927C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLFWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:38:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFWi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:38:58 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2067120989;
        Thu,  6 Dec 2018 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544135937;
        bh=VbcGlGAAJz1C5lG5tVujtKGSK3Bzi9ksK0uLYUy4iTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwWX3CXUokZ5RG8Lnane13bLAiRnSZecN5UyfBcgcWUuVM9iMuC3c3kkxeutUE8LB
         /4oIpNkh1WUjpscOzImeHx6nRPLRR4J/4GPWvoYFwGGglepAlD73BPhKakTn57nF9o
         FSZpqCXCfPhshg92VJ1ERjAxrWcrMx3ApwFmFEV0=
Received: by mail-qt1-f180.google.com with SMTP id l11so2491673qtp.0;
        Thu, 06 Dec 2018 14:38:57 -0800 (PST)
X-Gm-Message-State: AA+aEWYf3ayype3dTBizMbUEpDwswPNBKuSuUgFRVaEx5hmSIzd8caYb
        kh9S1xRgakjAzURkOIoJ2j6wSfIHctXYCtRVrQ==
X-Google-Smtp-Source: AFSGD/WRcxX6FyCGvj2OcZXNFbrOhz0ZTMGsJJyitoIl5YZ2WGpr7kucAG1ka5etxdncf7t9pJXcHjiB2cB+i17nrWE=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr29359172qvi.90.1544135936338;
 Thu, 06 Dec 2018 14:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-31-robh@kernel.org>
 <20181204085022.GB25962@ulmo>
In-Reply-To: <20181204085022.GB25962@ulmo>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 16:38:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
Message-ID: <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc
 bindings to json-schema
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:50 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 03, 2018 at 03:32:19PM -0600, Rob Herring wrote:
> > Convert Tegra SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-tegra@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/tegra.txt         |  65 -----------
> >  .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++++
> >  2 files changed, 101 insertions(+), 65 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> > deleted file mode 100644
> > index c59b15f64346..000000000000
> > --- a/Documentation/devicetree/bindings/arm/tegra.txt
> > +++ /dev/null
> > @@ -1,65 +0,0 @@
> > -NVIDIA Tegra device tree bindings
> > --------------------------------------------
> > -
> > -SoCs
> > --------------------------------------------
> > -
> > -Each device tree must specify which Tegra SoC it uses, using one of the
> > -following compatible values:
> > -
> > -  nvidia,tegra20
> > -  nvidia,tegra30
> > -  nvidia,tegra114
> > -  nvidia,tegra124
> > -  nvidia,tegra132
> > -  nvidia,tegra210
> > -  nvidia,tegra186
> > -  nvidia,tegra194
> > -
> > -Boards
> > --------------------------------------------
> > -
> > -Each device tree must specify which one or more of the following
> > -board-specific compatible values:
> > -
> > -  ad,medcom-wide
> > -  ad,plutux
> > -  ad,tamonten
> > -  ad,tec
> > -  compal,paz00
> > -  compulab,trimslice
> > -  nvidia,beaver
> > -  nvidia,cardhu
> > -  nvidia,cardhu-a02
> > -  nvidia,cardhu-a04
> > -  nvidia,dalmore
> > -  nvidia,harmony
> > -  nvidia,jetson-tk1
> > -  nvidia,norrin
> > -  nvidia,p2371-0000
> > -  nvidia,p2371-2180
> > -  nvidia,p2571
> > -  nvidia,p2771-0000
> > -  nvidia,p2972-0000
> > -  nvidia,roth
> > -  nvidia,seaboard
> > -  nvidia,tn7
> > -  nvidia,ventana
> > -  toradex,apalis_t30
> > -  toradex,apalis_t30-eval
> > -  toradex,apalis_t30-v1.1
> > -  toradex,apalis_t30-v1.1-eval
> > -  toradex,apalis-tk1
> > -  toradex,apalis-tk1-eval
> > -  toradex,apalis-tk1-v1.2
> > -  toradex,apalis-tk1-v1.2-eval
> > -  toradex,colibri_t20
> > -  toradex,colibri_t20-eval-v3
> > -  toradex,colibri_t20-iris
> > -  toradex,colibri_t30
> > -  toradex,colibri_t30-eval-v3
> > -
> > -Trusted Foundations
> > --------------------------------------------
> > -Tegra supports the Trusted Foundation secure monitor. See the
> > -"tlm,trusted-foundations" binding's documentation for more details.
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
> > new file mode 100644
> > index 000000000000..66493892ffc1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/tegra.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> Could you explain what these are? They give 404, so I assume they are
> more like placeholders and not actually used?

Please read the documentation in patch 2. They are used, but aren't live URLs.

> > +
> > +title: NVIDIA Tegra device tree bindings
> > +
> > +maintainers:
> > +  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > +  - Peter De Schrijver <pdeschrijver@nvidia.com>
>
> Not sure how you got that list, but probably from git history. I think
> it makes sense to replace Marcel and Peter with Jon and myself.

Will do.

> Other than that, looks fine to me. Some of the enumerations below look
> somewhat hard to parse, but I suspect that it will become second nature
> in no time.

We can add descriptions and/or comments if that helps. I didn't add
them if not already there.

> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks.

Rob
