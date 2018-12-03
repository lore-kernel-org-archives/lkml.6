Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33328C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED540208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2xTc4dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED540208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLCOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLCOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:25:42 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5452147C;
        Mon,  3 Dec 2018 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543847069;
        bh=8d6A/eGHeNhO5+5OG/m5ZZxRYdvk4qfOI6WRjYjlRGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k2xTc4dxX60qJG6sKGGU8Qs+KPM9eRQ8DJwXkP3zzn2UCx7Dt1oZgSe3YNhaCVyrc
         EtxyBpa4+C7sFmTZ4dy2Ympb4JDxmEB88rw0Nxj0cG8wiGlASjLXvMRZ6a/ierWKz7
         ikSQcH52spry8YBsFWGGBgTtVw8eC2lN+gJr0TnI=
Received: by mail-qk1-f172.google.com with SMTP id o89so7414634qko.0;
        Mon, 03 Dec 2018 06:24:29 -0800 (PST)
X-Gm-Message-State: AA+aEWbC2mMd5c+mi+ovWDyw+zUVIy6ifs4hak2tejQXaiKU6zaM3M4t
        AOhMVNLYuZSq72ZEnxsxwZoPvwT3W76f4/a48g==
X-Google-Smtp-Source: AFSGD/XBzLeYhytEZKv+OGssA8pInF2otOKevKIB4x3x40qwJyrePmSLFFqVh/9zAL5SY2McQdHj3jxWrMzQLoplb4o=
X-Received: by 2002:a37:7682:: with SMTP id r124mr15113528qkc.79.1543847068207;
 Mon, 03 Dec 2018 06:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com> <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
 <20181203124039.GA25097@arm.com>
In-Reply-To: <20181203124039.GA25097@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Dec 2018 08:24:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLC-1VWoErAteugtGOY-Gk87TBHkA94oyibE4Z+Wjq+DA@mail.gmail.com>
Message-ID: <CAL_JsqLC-1VWoErAteugtGOY-Gk87TBHkA94oyibE4Z+Wjq+DA@mail.gmail.com>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
To:     Will Deacon <will.deacon@arm.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tom Rini <trini@konsulko.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        Grant Likely <glikely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:40 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 30, 2018 at 12:00:05PM -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On 05. 10. 18 18:58, Rob Herring wrote:
> > > > Convert ARM CPU binding to DT schema format using json-schema.
> > > >
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-mediatek@lists.infradead.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> > > >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> > > >  2 files changed, 503 insertions(+), 490 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> >
> > [...]
> >
> > > I have take a look at xilinx part of this and try to build it for arm64
> > > platforms and I see errors coming from this cpu description.
> > > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > > cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > > cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> > > unexpected)
> >
> > Thanks for actually giving this a spin!
> >
> > > Based on grep this is used in a lot of places
> > > compatible = "arm,cortex-a53", "arm,armv8";
> > >
> > > Should this be moved to just simple?
> > > compatible = "arm,cortex-a53";
> >
> > I'd normally go with the majority which would be to keep it. However,
> > 'arm,armv8' is of questionable value, isn't actually documented, and
> > doesn't exist for any other version of the architecture. So we should
> > kill it IMO.
>
> I'd prefer to keep it around, since that's what's used to describe the CPUs
> on the fastmodel iirc.

We can and should keep it for that purpose, but do we need it as a
fallback? For real cores though, we have mixture of with and without
and one of those need to be fixed.

Rob
